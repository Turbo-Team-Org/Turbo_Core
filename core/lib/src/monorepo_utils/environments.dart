import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Enum para definir los entornos disponibles
enum TurboEnvironment {
  dev, // Development con Firebase
  staging, // Staging con Supabase
  prod, // Production (futuro)
}

/// Enum para definir el proveedor de base de datos
enum DatabaseProvider {
  firebase,
  supabase,
}

/// Utility class for accessing environment variables.
class Env {
  /// Environment actual (dev, staging, prod)
  static TurboEnvironment get environment {
    final envString = dotenv.env['ENVIRONMENT'] ?? 'dev';
    switch (envString.toLowerCase()) {
      case 'staging':
        return TurboEnvironment.staging;
      case 'prod':
      case 'production':
        return TurboEnvironment.prod;
      case 'dev':
      case 'development':
      default:
        return TurboEnvironment.dev;
    }
  }

  /// Database provider según el entorno
  static DatabaseProvider get databaseProvider {
    final providerString = dotenv.env['DATABASE_PROVIDER'];
    if (providerString != null) {
      switch (providerString.toLowerCase()) {
        case 'supabase':
          return DatabaseProvider.supabase;
        case 'firebase':
          return DatabaseProvider.firebase;
      }
    }

    // Fallback basado en el entorno
    switch (environment) {
      case TurboEnvironment.dev:
        return DatabaseProvider.firebase;
      case TurboEnvironment.staging:
        return DatabaseProvider.supabase;
      case TurboEnvironment.prod:
        return DatabaseProvider.supabase; // O el que decidas para prod
    }
  }

  /// Returns the current environment string (e.g., 'dev', 'staging', 'prod').
  static String get env => dotenv.env['ENV'] ?? 'dev';

  /// Returns the Firebase environment (e.g., 'dev', 'prod').
  static String get firebaseEnv => dotenv.env['FIREBASE_ENV'] ?? 'dev';

  /// Verificar si estamos usando Firebase
  static bool get isUsingFirebase =>
      databaseProvider == DatabaseProvider.firebase;

  /// Verificar si estamos usando Supabase
  static bool get isUsingSupabase =>
      databaseProvider == DatabaseProvider.supabase;

  // =====================================================
  // FIREBASE CONFIGURATION
  // =====================================================

  /// Firebase API Key
  static String get firebaseApiKey => dotenv.env['FIREBASE_API_KEY'] ?? '';

  /// Firebase App ID
  static String get firebaseAppId => dotenv.env['FIREBASE_APP_ID'] ?? '';

  /// Firebase Messaging Sender ID
  static String get firebaseSenderId => dotenv.env['FIREBASE_SENDER_ID'] ?? '';

  /// Firebase Project ID
  static String get firebaseProjectId =>
      dotenv.env['FIREBASE_PROJECT_ID'] ?? '';

  /// Firebase Auth Domain (opcional, para web)
  static String get firebaseAuthDomain =>
      dotenv.env['FIREBASE_AUTH_DOMAIN'] ?? '';

  /// Firebase Storage Bucket (opcional)
  static String get firebaseStorageBucket =>
      dotenv.env['FIREBASE_STORAGE_BUCKET'] ?? '';

  /// Firebase Measurement ID (opcional, para analytics)
  static String get firebaseMeasurementId =>
      dotenv.env['FIREBASE_MEASUREMENT_ID'] ?? '';

  // =====================================================
  // SUPABASE CONFIGURATION
  // =====================================================

  /// Supabase Project URL
  static String get supabaseUrl => dotenv.env['SUPABASE_URL'] ?? '';

  /// Supabase Anonymous Key
  static String get supabaseAnonKey => dotenv.env['SUPABASE_ANON_KEY'] ?? '';

  /// Supabase Service Role Key (para operaciones admin)
  static String get supabaseServiceRoleKey =>
      dotenv.env['SUPABASE_SERVICE_ROLE_KEY'] ?? '';

  // =====================================================
  // VALIDATION METHODS
  // =====================================================

  /// Verificar si la configuración de Firebase está completa
  static bool get isFirebaseConfigured {
    return firebaseApiKey.isNotEmpty &&
        firebaseAppId.isNotEmpty &&
        firebaseSenderId.isNotEmpty &&
        firebaseProjectId.isNotEmpty;
  }

  /// Verificar si la configuración de Supabase está completa
  static bool get isSupabaseConfigured {
    return supabaseUrl.isNotEmpty && supabaseAnonKey.isNotEmpty;
  }

  /// Verificar si la configuración actual es válida
  static bool get isCurrentConfigurationValid {
    switch (databaseProvider) {
      case DatabaseProvider.firebase:
        return isFirebaseConfigured;
      case DatabaseProvider.supabase:
        return isSupabaseConfigured;
    }
  }

  /// Obtener configuración de debug
  static Map<String, dynamic> get debugInfo {
    return {
      'environment': environment.name,
      'databaseProvider': databaseProvider.name,
      'isFirebaseConfigured': isFirebaseConfigured,
      'isSupabaseConfigured': isSupabaseConfigured,
      'isValidConfiguration': isCurrentConfigurationValid,
      'firebaseProjectId':
          firebaseProjectId.isNotEmpty ? firebaseProjectId : 'NOT_SET',
      'supabaseUrl': supabaseUrl.isNotEmpty
          ? supabaseUrl.split('.')[0] + '...'
          : 'NOT_SET',
    };
  }
}
