import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';

/// Interface for the authentication repository.
abstract class AuthenticationInterface {
  /// Signs in with email.
  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  });

  /// Signs up with email.
  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });

  /// Signs in with Google.
  Future<AuthUser?> signInWithGoogle();

  /// Signs out.
  Future<void> signOut();

  /// Stream of the authentication state.
  Stream<AuthUser?> get authStateChanges;
}
