import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';
import 'package:core/src/turbo_core_repositories/common/config/hybrid_database_config.dart';
import 'package:core/src/monorepo_utils/environments.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_it/get_it.dart';

/// Initialize dependencies based on environment configuration
/// Supports dynamic switching between Firebase (dev) and Supabase (staging/prod)
///
/// [environment] - Environment passed from the app/admin panel
/// [sl] - GetIt service locator instance
/// [firebaseApp] - Optional Firebase app instance
/// [enableDebugLogs] - Enable detailed logging
Future<void> initCoreDependencies({
  required GetIt sl,
  TurboEnvironment? environment,
  FirebaseApp? firebaseApp,
  bool enableDebugLogs = false,
}) async {
  print('🔧 Inicializando dependencias Turbo Core...');

  // 1. Initialize hybrid database configuration
  if (environment != null) {
    // Use environment passed from app
    await _initializeWithPassedEnvironment(environment, enableDebugLogs);
  } else {
    // Fallback to environment variables
    await HybridDatabaseConfig.initializeFromEnvironment();
  }

  if (enableDebugLogs) {
    HybridDatabaseConfig.printConfigInfo();
  }

  // 2. Register database clients
  await _registerDatabaseClients(sl, firebaseApp);

  // 3. Register authorization interface
  _registerAuthorizationInterface(sl);

  // 4. Register basic services based on current environment
  await _registerBasicServices(sl);

  print('✅ Dependencias Turbo Core inicializadas correctamente\n');
}

/// Initialize with environment passed from app/admin panel
Future<void> _initializeWithPassedEnvironment(
    TurboEnvironment environment, bool enableDebugLogs) async {
  print(
      '📱 Inicializando con entorno pasado desde la app: ${environment.name}');

  // Determine database provider based on environment
  final provider = _getProviderForEnvironment(environment);

  // Get configuration for the environment
  final config = _getConfigurationForEnvironment(environment);

  await HybridDatabaseConfig.initialize(
    environment: environment,
    primaryProvider: provider,
    supabaseUrl: config['supabaseUrl'],
    supabaseAnonKey: config['supabaseAnonKey'],
    firebaseProjectId: config['firebaseProjectId'],
    enableDebugLogs: enableDebugLogs,
  );
}

/// Get database provider for environment
DatabaseProvider _getProviderForEnvironment(TurboEnvironment environment) {
  switch (environment) {
    case TurboEnvironment.dev:
      return DatabaseProvider.firebase;
    case TurboEnvironment.staging:
      return DatabaseProvider.supabase;
    case TurboEnvironment.prod:
      return DatabaseProvider.supabase;
  }
}

/// Get configuration for environment
Map<String, String?> _getConfigurationForEnvironment(
    TurboEnvironment environment) {
  switch (environment) {
    case TurboEnvironment.dev:
      return {
        'firebaseProjectId': 'turbo-16770',
        'supabaseUrl': null,
        'supabaseAnonKey': null,
      };
    case TurboEnvironment.staging:
    case TurboEnvironment.prod:
      return {
        'firebaseProjectId': null,
        'supabaseUrl': 'https://oiugslxvekwnoubljrde.supabase.co',
        'supabaseAnonKey':
            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Im9pdWdzbHh2ZWt3bm91YmxqcmRlIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzU2NTUzMTYsImV4cCI6MjA1MTIzMTMxNn0.lFJgh2SM9uq4sBUgkLCxtw_A9dW661N',
      };
  }
}

/// Register database clients (Firebase and/or Supabase)
Future<void> _registerDatabaseClients(
    GetIt sl, FirebaseApp? firebaseApp) async {
  // Register Firebase services if available
  if (HybridDatabaseConfig.isFirebaseAvailable) {
    if (!sl.isRegistered<FirebaseFirestore>()) {
      sl.registerLazySingleton<FirebaseFirestore>(
        () => firebaseApp != null
            ? FirebaseFirestore.instanceFor(app: firebaseApp)
            : HybridDatabaseConfig.firestore,
      );
    }

    if (!sl.isRegistered<FirebaseAuth>()) {
      sl.registerSingleton<FirebaseAuth>(
        firebaseApp != null
            ? FirebaseAuth.instanceFor(app: firebaseApp)
            : FirebaseAuth.instance,
      );
    }

    print('✅ Firebase services registrados');
  }

  // Register Supabase client if available
  if (HybridDatabaseConfig.isSupabaseAvailable) {
    if (!sl.isRegistered<SupabaseClient>()) {
      sl.registerLazySingleton<SupabaseClient>(
        () => HybridDatabaseConfig.supabase,
      );
    }

    print('✅ Supabase client registrado');
  }
}

/// Register authorization interface with default implementation
void _registerAuthorizationInterface(GetIt sl) {
  if (!sl.isRegistered<PlaceAuthorizationInterface>()) {
    sl.registerLazySingleton<PlaceAuthorizationInterface>(
      () => const DefaultPlaceAuthorization(),
    );
  }
}

/// Register basic services based on current environment
Future<void> _registerBasicServices(GetIt sl) async {
  final environment = HybridDatabaseConfig.currentEnvironment;
  final provider = HybridDatabaseConfig.currentProvider;

  print('📦 Registrando servicios básicos para:');
  print('   Entorno: ${environment?.name ?? 'unknown'}');
  print('   Proveedor: ${provider?.name ?? 'unknown'}');

  // Register services based on provider
  if (provider == DatabaseProvider.firebase &&
      HybridDatabaseConfig.isFirebaseAvailable) {
    await _registerFirebaseServices(sl);
  } else if (provider == DatabaseProvider.supabase &&
      HybridDatabaseConfig.isSupabaseAvailable) {
    await _registerSupabaseServices(sl);
  }

  print('✅ Servicios básicos registrados\n');
}

/// Register Firebase services
Future<void> _registerFirebaseServices(GetIt sl) async {
  // Authentication Service
  if (!sl.isRegistered<AuthenticationInterface>()) {
    sl.registerLazySingleton<AuthenticationInterface>(
      () => AuthenticationService(
        firebaseAuth: sl<FirebaseAuth>(),
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    print('   ✅ AuthenticationService (Firebase)');
  }

  // Place Service (requiere AnalyticsService)
  if (!sl.isRegistered<PlaceInterface>()) {
    // Registrar AnalyticsService primero si no existe
    if (!sl.isRegistered<AnalyticsService>()) {
      sl.registerLazySingleton<AnalyticsService>(
        () => AnalyticsService(firestore: sl<FirebaseFirestore>()),
      );
    }

    sl.registerLazySingleton<PlaceInterface>(
      () => PlaceService(
        firestore: sl<FirebaseFirestore>(),
        analyticsService: sl<AnalyticsService>(),
        authorization: sl<PlaceAuthorizationInterface>(),
      ),
    );
    print('   ✅ PlaceService (Firebase)');
  }

  // Review Service
  if (!sl.isRegistered<ReviewInterface>()) {
    sl.registerLazySingleton<ReviewInterface>(
      () => ReviewService(
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    print('   ✅ ReviewService (Firebase)');
  }

  // Category Service
  if (!sl.isRegistered<CategoryInterface>()) {
    sl.registerLazySingleton<CategoryInterface>(
      () => CategoryService(
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    print('   ✅ CategoryService (Firebase)');
  }

  // Event Service
  if (!sl.isRegistered<EventInterface>()) {
    sl.registerLazySingleton<EventInterface>(
      () => EventService(
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    print('   ✅ EventService (Firebase)');
  }

  // Favorite Service
  if (!sl.isRegistered<FavoriteInterface>()) {
    sl.registerLazySingleton<FavoriteInterface>(
      () => FavoriteService(
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    print('   ✅ FavoriteService (Firebase)');
  }

  // Location Service
  if (!sl.isRegistered<LocationInterface>()) {
    sl.registerLazySingleton<LocationInterface>(
      () => LocationService(
        firestore: sl<FirebaseFirestore>(),
      ),
    );
    print('   ✅ LocationService (Firebase)');
  }
}

/// Register Supabase services
Future<void> _registerSupabaseServices(GetIt sl) async {
  // Authentication Service
  if (!sl.isRegistered<AuthenticationInterface>()) {
    sl.registerLazySingleton<AuthenticationInterface>(
      () => AuthenticationServiceSupabase(
        supabaseClient: sl<SupabaseClient>(),
      ),
    );
    print('   ✅ AuthenticationServiceSupabase');
  }

  // Review Service
  if (!sl.isRegistered<ReviewInterface>()) {
    sl.registerLazySingleton<ReviewInterface>(
      () => ReviewServiceSupabase(
        supabaseClient: sl<SupabaseClient>(),
      ),
    );
    print('   ✅ ReviewServiceSupabase');
  }

  // Category Service
  if (!sl.isRegistered<CategoryInterface>()) {
    sl.registerLazySingleton<CategoryInterface>(
      () => CategoryServiceSupabase(
        supabaseClient: sl<SupabaseClient>(),
      ),
    );
    print('   ✅ CategoryServiceSupabase');
  }

  // Event Service
  if (!sl.isRegistered<EventInterface>()) {
    sl.registerLazySingleton<EventInterface>(
      () => EventServiceSupabase(
        supabaseClient: sl<SupabaseClient>(),
      ),
    );
    print('   ✅ EventServiceSupabase');
  }

  // Favorite Service
  if (!sl.isRegistered<FavoriteInterface>()) {
    sl.registerLazySingleton<FavoriteInterface>(
      () => FavoriteServiceSupabase(
        supabaseClient: sl<SupabaseClient>(),
      ),
    );
    print('   ✅ FavoriteServiceSupabase');
  }

  // Location Service
  if (!sl.isRegistered<LocationInterface>()) {
    sl.registerLazySingleton<LocationInterface>(
      () => LocationServiceSupabase(
        supabaseClient: sl<SupabaseClient>(),
      ),
    );
    print('   ✅ LocationServiceSupabase');
  }

  // TODO: Place, Analytics y Admin Auth services requieren más configuración
  print('   ⏳ Place, Analytics y Admin Auth services pendientes');
}

/// Utility function to check if a specific repository is available in current environment
bool isRepositoryAvailable<T extends Object>() {
  final sl = GetIt.instance;
  return sl.isRegistered<T>();
}

/// Get environment information for debugging
Map<String, dynamic> getDependencyInfo() {
  return {
    'hybridConfig': HybridDatabaseConfig.debugInfo,
    'registeredServices': {
      'Firebase': HybridDatabaseConfig.isFirebaseAvailable,
      'Supabase': HybridDatabaseConfig.isSupabaseAvailable,
    },
    'environment': Env.debugInfo,
  };
}
