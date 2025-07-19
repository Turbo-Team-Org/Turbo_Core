import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:core/src/monorepo_utils/environments.dart';

/// Configuración híbrida para Firebase + Supabase con soporte para entornos dinámicos
///
/// **Configuración por entorno:**
/// - **Development (dev)**: Firebase como principal
/// - **Staging**: Supabase como principal
/// - **Production**: Configurable (por defecto Supabase)
///
/// **Uso híbrido específico:**
/// - Firebase: Google Maps APIs, Places, Geocoding (siempre)
/// - Supabase: Business logic, Auth, Database principal (en staging/prod)
class HybridDatabaseConfig {
  static FirebaseFirestore? _firestore;
  static SupabaseClient? _supabase;
  static bool _isInitialized = false;
  static TurboEnvironment? _currentEnvironment;
  static DatabaseProvider? _currentProvider;

  // =====================================================
  // GETTERS PRINCIPALES
  // =====================================================

  /// Firestore instance (siempre disponible para Google APIs)
  static FirebaseFirestore get firestore {
    if (!_isInitialized) {
      throw Exception('HybridDatabaseConfig no ha sido inicializado');
    }
    if (_firestore == null) {
      throw Exception('Firebase no está configurado en este entorno');
    }
    return _firestore!;
  }

  /// Supabase client (disponible en staging/prod)
  static SupabaseClient get supabase {
    if (!_isInitialized) {
      throw Exception('HybridDatabaseConfig no ha sido inicializado');
    }
    if (_supabase == null) {
      throw Exception('Supabase no está configurado en este entorno');
    }
    return _supabase!;
  }

  /// Verificar si está inicializado
  static bool get isInitialized => _isInitialized;

  /// Entorno actual
  static TurboEnvironment? get currentEnvironment => _currentEnvironment;

  /// Proveedor de BD actual
  static DatabaseProvider? get currentProvider => _currentProvider;

  /// Verificar si Firebase está disponible
  static bool get isFirebaseAvailable => _firestore != null;

  /// Verificar si Supabase está disponible
  static bool get isSupabaseAvailable => _supabase != null;

  // =====================================================
  // INICIALIZACIÓN DINÁMICA
  // =====================================================

  /// Inicializar configuración basada en variables de entorno
  static Future<void> initializeFromEnvironment() async {
    print('🔧 Inicializando configuración desde variables de entorno...');

    final environment = Env.environment;
    final provider = Env.databaseProvider;

    print('📱 Entorno detectado: ${environment.name}');
    print('🗄️ Proveedor de BD: ${provider.name}');

    await initialize(
      environment: environment,
      primaryProvider: provider,
      // Configuraciones desde .env
      supabaseUrl: Env.supabaseUrl,
      supabaseAnonKey: Env.supabaseAnonKey,
      firebaseProjectId: Env.firebaseProjectId,
    );
  }

  /// Inicializar configuración híbrida con parámetros específicos
  static Future<void> initialize({
    required TurboEnvironment environment,
    required DatabaseProvider primaryProvider,
    String? supabaseUrl,
    String? supabaseAnonKey,
    String? firebaseProjectId,
    bool enableDebugLogs = false,
  }) async {
    try {
      print('🚀 Inicializando HybridDatabaseConfig...');
      print('   Entorno: ${environment.name}');
      print('   Proveedor principal: ${primaryProvider.name}');

      _currentEnvironment = environment;
      _currentProvider = primaryProvider;

      // 1. SIEMPRE inicializar Firebase (para Google APIs)
      await _initializeFirebase(firebaseProjectId, enableDebugLogs);

      // 2. Inicializar Supabase solo si está configurado
      if (primaryProvider == DatabaseProvider.supabase ||
          environment != TurboEnvironment.dev) {
        await _initializeSupabase(
            supabaseUrl, supabaseAnonKey, enableDebugLogs);
      }

      _isInitialized = true;

      _printSuccessMessage();
    } catch (e) {
      throw Exception('Error inicializando configuración híbrida: $e');
    }
  }

  // =====================================================
  // INICIALIZACIÓN INDIVIDUAL
  // =====================================================

  /// Inicializar Firebase
  static Future<void> _initializeFirebase(String? projectId, bool debug) async {
    try {
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      _firestore = FirebaseFirestore.instance;

      if (debug) {
        print('✅ Firebase inicializado - Proyecto: ${projectId ?? "default"}');
      }
    } catch (e) {
      print('⚠️ Firebase no pudo ser inicializado: $e');
      // Firebase es opcional para algunos flujos
    }
  }

  /// Inicializar Supabase
  static Future<void> _initializeSupabase(
      String? url, String? anonKey, bool debug) async {
    if (url == null || url.isEmpty || anonKey == null || anonKey.isEmpty) {
      print('⚠️ Supabase no configurado - URL o ANON_KEY faltantes');
      return;
    }

    try {
      await Supabase.initialize(
        url: url,
        anonKey: anonKey,
        debug: debug,
      );
      _supabase = Supabase.instance.client;

      if (debug) {
        print('✅ Supabase inicializado - URL: ${url.split('.')[0]}...');
      }
    } catch (e) {
      print('⚠️ Supabase no pudo ser inicializado: $e');
      throw Exception('Error crítico: Supabase es requerido para este entorno');
    }
  }

  // =====================================================
  // MÉTODOS DE UTILIDAD
  // =====================================================

  /// Obtener el cliente principal según el entorno
  static dynamic get primaryClient {
    switch (_currentProvider) {
      case DatabaseProvider.firebase:
        return firestore;
      case DatabaseProvider.supabase:
        return supabase;
      case null:
        throw Exception('No hay proveedor configurado');
    }
  }

  /// Verificar configuración para un repositorio específico
  static bool isConfiguredFor(String repositoryName) {
    final requiredProvider = RepositoryConfig.getProviderFor(repositoryName);

    switch (requiredProvider) {
      case DatabaseProvider.firebase:
        return isFirebaseAvailable;
      case DatabaseProvider.supabase:
        return isSupabaseAvailable;
    }
  }

  /// Obtener información de debug
  static Map<String, dynamic> get debugInfo {
    return {
      'isInitialized': _isInitialized,
      'environment': _currentEnvironment?.name ?? 'NOT_SET',
      'primaryProvider': _currentProvider?.name ?? 'NOT_SET',
      'firebaseAvailable': isFirebaseAvailable,
      'supabaseAvailable': isSupabaseAvailable,
      'environmentConfig': Env.debugInfo,
    };
  }

  /// Imprimir información de configuración
  static void printConfigInfo() {
    print('\n📊 CONFIGURACIÓN TURBO CORE:');
    print('════════════════════════════════════════');
    final info = debugInfo;
    info.forEach((key, value) {
      print('   $key: $value');
    });
    print('════════════════════════════════════════\n');
  }

  /// Limpiar recursos
  static Future<void> dispose() async {
    if (_isInitialized) {
      // Supabase se limpia automáticamente
      // Firebase mantiene conexión para Google APIs
      _isInitialized = false;
      _currentEnvironment = null;
      _currentProvider = null;
      print('🧹 HybridDatabaseConfig limpiado');
    }
  }

  /// Imprimir mensaje de éxito
  static void _printSuccessMessage() {
    print('\n✅ Configuración híbrida inicializada correctamente');

    if (isFirebaseAvailable) {
      print('🔥 Firebase: ✅ Disponible (Google APIs)');
    } else {
      print('🔥 Firebase: ❌ No disponible');
    }

    if (isSupabaseAvailable) {
      print('💚 Supabase: ✅ Disponible (Lógica principal)');
    } else {
      print('💚 Supabase: ❌ No disponible');
    }

    print('🎯 Proveedor principal: ${_currentProvider?.name ?? 'NO_SET'}');
    print('🌍 Entorno: ${_currentEnvironment?.name ?? 'NO_SET'}\n');
  }
}

/// Configuración específica por repositorio (actualizada)
class RepositoryConfig {
  // Repositories que usan Supabase (lógica de negocio)
  static const Set<String> supabaseRepositories = {
    'PlaceRepository',
    'UserRepository',
    'ReviewRepository',
    'ReservationRepository',
    'CategoryRepository',
    'EventRepository',
    'OfferRepository',
    'AnalyticsRepository',
    'AuthRepository',
    'FavoriteRepository',
    'AdminAuthRepository',
    'PlaceCategoryRepository',
  };

  // Repositories que usan Firebase (solo Google APIs)
  static const Set<String> firebaseRepositories = {
    'GoogleMapsRepository',
    'GeocodingRepository',
    'LocationCacheRepository',
  };

  /// Determinar qué base de datos usar según el repositorio
  static DatabaseProvider getProviderFor(String repositoryName) {
    if (supabaseRepositories.contains(repositoryName)) {
      return DatabaseProvider.supabase;
    } else if (firebaseRepositories.contains(repositoryName)) {
      return DatabaseProvider.firebase;
    } else {
      // Por defecto usar el proveedor actual del entorno
      return HybridDatabaseConfig._currentProvider ?? DatabaseProvider.supabase;
    }
  }

  /// Verificar si un repositorio está soportado en el entorno actual
  static bool isRepositorySupported(String repositoryName) {
    return HybridDatabaseConfig.isConfiguredFor(repositoryName);
  }
}
