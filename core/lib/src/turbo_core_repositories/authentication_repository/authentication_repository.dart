import 'package:core/src/turbo_core_repositories/authentication_repository/interface/authentication_interface.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';

/// Repository responsible for user authentication and account management.
///
/// This repository provides a clean interface for authentication-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to user authentication, password management, and session handling.
class AuthenticationRepository implements AuthenticationInterface {
  /// Creates an instance of [AuthenticationRepository] with the provided
  /// authentication service.
  AuthenticationRepository({required this.authService});

  /// Authentication service used by the repository (now accepts interface for environment flexibility).
  final AuthenticationInterface authService;

  // ==================== AUTHENTICATION OPERATIONS ====================

  /// Signs in using email and password.
  ///
  /// [email] The user's email address.
  /// [password] The user's password.
  ///
  /// Returns an [AuthUser] if authentication is successful, or `null` otherwise.
  /// Throws an exception if the operation fails.
  @override
  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      return await authService.signInWithEmail(
        email: email,
        password: password,
      );
    } catch (e) {
      throw Exception('Error al iniciar sesión con email: $e');
    }
  }

  /// Signs in using Google authentication.
  ///
  /// Returns an [AuthUser] if authentication is successful, or `null` otherwise.
  /// Throws an exception if the operation fails.
  Future<AuthUser?> signInWithGoogle() async {
    try {
      return await authService.signInWithGoogle();
    } catch (e) {
      throw Exception('Error al iniciar sesión con Google: $e');
    }
  }

  /// Registers a new user using email and password.
  ///
  /// [email] The user's email address.
  /// [password] The user's password.
  /// [displayName] Optional display name for the user.
  ///
  /// Returns an [AuthUser] if registration is successful, or `null` otherwise.
  /// Throws an exception if the operation fails.
  @override
  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      return await authService.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }

  /// Signs out the current user from all authentication providers.
  ///
  /// Throws an exception if the operation fails.
  @override
  Future<void> signOut() async {
    try {
      await authService.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  // ==================== PASSWORD OPERATIONS ====================

  /// Changes the password for the current authenticated user.
  ///
  /// [currentPassword] The user's current password for verification.
  /// [newPassword] The new password to set.
  ///
  /// Requires the user to be authenticated and provide their current password
  /// for security verification before setting the new password.
  /// Throws an exception if the operation fails or if passwords don't meet requirements.
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      // Validate new password strength
      _validatePasswordStrength(newPassword);

      await authService.changePassword(
        currentPassword: currentPassword,
        newPassword: newPassword,
      );
    } catch (e) {
      throw Exception('Error al cambiar contraseña: $e');
    }
  }

  /// Sends a password reset email to the specified email address.
  ///
  /// [email] The email address to send the password reset link to.
  ///
  /// The user will receive an email with instructions to reset their password.
  /// Throws an exception if the operation fails.
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      // Validate email format
      _validateEmailFormat(email);

      await authService.sendPasswordResetEmail(email: email);
    } catch (e) {
      throw Exception('Error al enviar email de recuperación: $e');
    }
  }

  // ==================== STATE OPERATIONS ====================

  /// Emits authentication state changes as a stream of [AuthUser].
  ///
  /// This stream will emit:
  /// - `null` when the user is not authenticated
  /// - An [AuthUser] object when the user is authenticated
  @override
  Stream<AuthUser?> get authStateChanges => authService.authStateChanges;

  // ==================== UTILITY OPERATIONS ====================

  /// Gets the current authenticated user.
  ///
  /// Returns the current [AuthUser] if authenticated, or `null` otherwise.
  Future<AuthUser?> getCurrentUser() async {
    try {
      return await authStateChanges.first;
    } catch (e) {
      throw Exception('Error al obtener usuario actual: $e');
    }
  }

  /// Checks if a user is currently authenticated.
  ///
  /// Returns `true` if a user is authenticated, `false` otherwise.
  Future<bool> isAuthenticated() async {
    try {
      final user = await getCurrentUser();
      return user != null;
    } catch (e) {
      return false;
    }
  }

  /// Updates the display name of the current authenticated user.
  ///
  /// [displayName] The new display name to set.
  ///
  /// Throws an exception if no user is authenticated or if the operation fails.
  Future<void> updateDisplayName(String displayName) async {
    try {
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('No hay usuario autenticado');
      }

      // This would require additional implementation in the service
      // For now, we'll throw an exception indicating it's not implemented
      throw Exception('Actualización de nombre no implementada aún');
    } catch (e) {
      throw Exception('Error al actualizar nombre: $e');
    }
  }

  /// Deletes the current user account.
  ///
  /// This is a destructive operation that cannot be undone.
  /// Throws an exception if no user is authenticated or if the operation fails.
  Future<void> deleteAccount() async {
    try {
      final user = await getCurrentUser();
      if (user == null) {
        throw Exception('No hay usuario autenticado');
      }

      // This would require additional implementation in the service
      // For now, we'll throw an exception indicating it's not implemented
      throw Exception('Eliminación de cuenta no implementada aún');
    } catch (e) {
      throw Exception('Error al eliminar cuenta: $e');
    }
  }

  // ==================== PRIVATE VALIDATION METHODS ====================

  /// Validates password strength requirements.
  void _validatePasswordStrength(String password) {
    if (password.length < 6) {
      throw Exception('La contraseña debe tener al menos 6 caracteres');
    }

    if (password.length > 128) {
      throw Exception('La contraseña no puede tener más de 128 caracteres');
    }

    // Additional password strength requirements can be added here
    // For example: uppercase, lowercase, numbers, special characters
  }

  /// Validates email format.
  void _validateEmailFormat(String email) {
    final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+$');
    if (!emailRegex.hasMatch(email)) {
      throw Exception('El formato del email es inválido');
    }
  }

  // ==================== LEGACY METHODS ====================

  /// Legacy method for Google sign-in (kept for backward compatibility).
  ///
  /// Use [signInWithGoogle] instead.
  @Deprecated('Use signInWithGoogle() instead')
  Future<AuthUser?> sigInWithGoogle() async {
    return signInWithGoogle();
  }

  /// Legacy method for signing out (kept for backward compatibility).
  ///
  /// Use [signOut] instead.
  @Deprecated('Use signOut() instead')
  Future<void> logOut() async {
    return signOut();
  }
}
