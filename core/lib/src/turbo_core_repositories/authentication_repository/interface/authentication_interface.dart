import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';

/// Interface for the authentication repository.
abstract class AuthenticationInterface {
  // ==================== AUTHENTICATION OPERATIONS ====================

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

  // ==================== PASSWORD OPERATIONS ====================

  /// Changes the password for the current authenticated user.
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  });

  /// Sends a password reset email to the specified email address.
  Future<void> sendPasswordResetEmail({required String email});

  // ==================== STATE OPERATIONS ====================

  /// Stream of the authentication state.
  Stream<AuthUser?> get authStateChanges;

  // ==================== PROFILE OPERATIONS ====================

  /// Latest persisted profile for the current session user (e.g. `users` row).
  Future<AuthUser?> getCurrentProfile();

  /// Updates display name and/or avatar URL in persistence and returns fresh profile.
  Future<AuthUser> updateUserProfile({
    String? displayName,
    String? photoUrl,
  });
}
