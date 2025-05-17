import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Utility class for accessing environment variables.
class Env {
  /// Returns the current environment (e.g., 'dev', 'prod').
  static String get env => dotenv.env['ENV'] ?? 'dev';

  /// Returns the Firebase environment (e.g., 'dev', 'prod').
  static String get firebaseEnv => dotenv.env['FIREBASE_ENV'] ?? 'dev';

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
}
