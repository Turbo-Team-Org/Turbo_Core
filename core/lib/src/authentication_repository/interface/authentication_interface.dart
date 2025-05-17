import 'package:core/src/authentication_repository/models/auth_user.dart';

abstract class AuthenticationInterface {
  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  });
  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  });
  Future<AuthUser?> signInWithGoogle();
  Future<void> signOut();
  Stream<AuthUser?> get authStateChanges;
}
