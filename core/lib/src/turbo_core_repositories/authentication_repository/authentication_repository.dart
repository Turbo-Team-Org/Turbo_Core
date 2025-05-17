import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';

import 'package:core/src/turbo_core_repositories/authentication_repository/service/authentication_service.dart';

/// Repository responsible for user authentication.
class AuthenticationRepository {
  /// Creates an instance of [AuthenticationRepository] with the provided
  ///  authentication service.
  AuthenticationRepository({required this.authService});

  /// Authentication service used by the repository.
  final AuthenticationService authService;

  /// Signs in using email and password.
  ///
  /// Returns an [AuthUser] if authentication is successful,
  ///  or `null` otherwise.
  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final user = await authService.signInWithEmail(
      email: email,
      password: password,
    );
    return user;
  }

  /// Signs in using Google authentication.
  ///
  /// Returns an [AuthUser] if authentication is successful,
  ///  or `null` otherwise.
  Future<AuthUser?> sigInWithGoogle() async {
    return authService.signInWithGoogle();
  }

  /// Registers a new user using email and password.
  ///
  /// Returns an [AuthUser] if registration is successful,
  /// or `null` otherwise.
  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    return authService.signUpWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );
  }

  /// Changes the password for the user with the given [userId].
  ///
  /// This method is not yet implemented.
  Future<void> changePassword({
    required int userId,
    required String newPassword,
  }) async {
    //  await authService.(userId: userId, newPassword: newPassword);
  }

  /// Emits authentication state changes as a stream of [AuthUser].
  Stream<AuthUser?> get authStateChanges => authService.authStateChanges;

  /// Signs out the current user.
  Future<void> logOut() async => authService.signOut();
}
