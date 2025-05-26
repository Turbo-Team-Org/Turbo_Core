import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/interface/authentication_interface.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

/// Service responsible for handling authentication logic using Firebase.
class AuthenticationService implements AuthenticationInterface {
  /// Creates an [AuthenticationService] with optional custom Firebase instances
  AuthenticationService({
    FirebaseAuth? firebaseAuth,
    FirebaseFirestore? firestore,
  }) : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance,
       firestore = firestore ?? FirebaseFirestore.instance;

  /// Firebase authentication instance.
  final FirebaseAuth _firebaseAuth;

  /// Firestore instance for user data.
  final FirebaseFirestore firestore;

  /// Signs in a user with email and password.
  ///
  /// Returns an [AuthUser] if successful, or `null` otherwise.
  @override
  Future<AuthUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
    return _userFromFirestore(userCredential.user);
  }

  /// Registers a new user with email and password.
  ///
  /// Returns an [AuthUser] if successful, or `null` otherwise.
  @override
  Future<AuthUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    final user = userCredential.user;
    if (user != null) {
      final newUser = AuthUser(
        uid: user.uid,
        email: user.email!,
        displayName: displayName,
        photoUrl: user.photoURL,
        favorites: [],
        createdAt: DateTime.now(),
      );
      await firestore.collection('users').doc(user.uid).set(newUser.toJson());
      return newUser;
    }
    return null;
  }

  /// Signs in a user using Google authentication.
  ///
  /// Returns an [AuthUser] if successful, or `null` otherwise.
  @override
  Future<AuthUser?> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final userCredential = await _firebaseAuth.signInWithCredential(credential);
    return _userFromFirestore(userCredential.user);
  }

  /// Signs out the current user from all authentication providers.
  @override
  Future<void> signOut() async {
    await _firebaseAuth.signOut();
    await GoogleSignIn().signOut();
  }

  /// Changes the password for the current authenticated user.
  ///
  /// Requires the user to be authenticated and provide their current password
  /// for security verification before setting the new password.
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    final user = _firebaseAuth.currentUser;
    if (user == null) {
      throw Exception('No hay usuario autenticado');
    }

    if (user.email == null) {
      throw Exception('Usuario no tiene email asociado');
    }

    try {
      // Re-authenticate the user with their current password for security
      final credential = EmailAuthProvider.credential(
        email: user.email!,
        password: currentPassword,
      );

      await user.reauthenticateWithCredential(credential);

      // Update the password
      await user.updatePassword(newPassword);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'wrong-password':
          throw Exception('La contraseña actual es incorrecta');
        case 'weak-password':
          throw Exception('La nueva contraseña es muy débil');
        case 'requires-recent-login':
          throw Exception(
            'Se requiere autenticación reciente. Inicia sesión nuevamente',
          );
        default:
          throw Exception('Error al cambiar contraseña: ${e.message}');
      }
    } catch (e) {
      throw Exception('Error inesperado al cambiar contraseña: $e');
    }
  }

  /// Sends a password reset email to the specified email address.
  ///
  /// The user will receive an email with instructions to reset their password.
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      switch (e.code) {
        case 'user-not-found':
          throw Exception('No existe una cuenta con este email');
        case 'invalid-email':
          throw Exception('El formato del email es inválido');
        default:
          throw Exception(
            'Error al enviar email de recuperación: ${e.message}',
          );
      }
    } catch (e) {
      throw Exception('Error inesperado al enviar email: $e');
    }
  }

  /// Emits authentication state changes as a stream of [AuthUser].
  @override
  Stream<AuthUser?> get authStateChanges =>
      _firebaseAuth.authStateChanges().asyncMap(_userFromFirestore);

  /// Retrieves the [AuthUser] from Firestore or creates a new one if not found.
  Future<AuthUser?> _userFromFirestore(User? user) async {
    if (user == null) {
      return null;
    }

    try {
      final doc = await firestore.collection('users').doc(user.uid).get();

      if (doc.exists) {
        final data = doc.data();
        if (data != null) {
          try {
            return AuthUser.fromJson(data);
          } catch (_) {
            // If conversion fails, create a new user document.
            final newUser = AuthUser(
              uid: user.uid,
              email: user.email!,
              displayName: user.displayName,
              photoUrl: user.photoURL,
              favorites: [],
              createdAt: DateTime.now(),
            );
            await firestore
                .collection('users')
                .doc(user.uid)
                .set(newUser.toJson());
            return newUser;
          }
        }
      }

      // If user document does not exist, create a new one.
      final newUser = AuthUser(
        uid: user.uid,
        email: user.email!,
        displayName: user.displayName,
        photoUrl: user.photoURL,
        favorites: [],
        createdAt: DateTime.now(),
      );
      await firestore.collection('users').doc(user.uid).set(newUser.toJson());
      return newUser;
    } catch (_) {
      // In case of error, return a basic user.
      return AuthUser(
        uid: user.uid,
        email: user.email ?? '',
        displayName: user.displayName,
        photoUrl: user.photoURL,
        favorites: [],
        createdAt: DateTime.now(),
      );
    }
  }
}
