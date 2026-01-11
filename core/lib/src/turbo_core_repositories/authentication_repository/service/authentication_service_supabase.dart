import 'package:core/src/turbo_core_repositories/authentication_repository/interface/authentication_interface.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart'
    as core_models;
import 'package:core/src/turbo_core_repositories/authentication_repository/models/user_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service responsible for handling authentication logic using Supabase.
class AuthenticationServiceSupabase implements AuthenticationInterface {
  /// Creates an [AuthenticationServiceSupabase] with optional custom Supabase client
  AuthenticationServiceSupabase({
    SupabaseClient? supabaseClient,
  }) : _supabase = supabaseClient ?? Supabase.instance.client;

  /// Supabase client instance.
  final SupabaseClient _supabase;

  /// Signs in a user with email and password.
  ///
  /// Returns an [AuthUser] if successful, or `null` otherwise.
  @override
  Future<core_models.AuthUser?> signInWithEmail({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        return await _userFromSupabase(response.user!);
      }
      return null;
    } catch (e) {
      throw Exception('Error signing in with email: $e');
    }
  }

  /// Registers a new user with email and password.
  ///
  /// Returns an [AuthUser] if successful, or `null` otherwise.
  @override
  Future<core_models.AuthUser?> signUpWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    try {
      final response = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: displayName != null ? {'display_name': displayName} : null,
      );

      if (response.user != null) {
        // Create user profile in users table
        await _createUserProfile(response.user!, displayName);
        return await _userFromSupabase(response.user!);
      }
      return null;
    } catch (e) {
      throw Exception('Error signing up with email: $e');
    }
  }

  /// Signs in with Google.
  ///
  /// Returns an [AuthUser] if successful, or `null` otherwise.
  @override
  Future<core_models.AuthUser?> signInWithGoogle() async {
    try {
      final response = await _supabase.auth.signInWithOAuth(
        OAuthProvider.google,
        redirectTo: 'io.supabase.flutterquickstart://login-callback/',
      );

      if (response) {
        final user = _supabase.auth.currentUser;
        if (user != null) {
          return await _userFromSupabase(user);
        }
      }
      return null;
    } catch (e) {
      throw Exception('Error signing in with Google: $e');
    }
  }

  /// Signs out the current user.
  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Error signing out: $e');
    }
  }

  /// Changes the password for the current authenticated user.
  @override
  Future<void> changePassword({
    required String currentPassword,
    required String newPassword,
  }) async {
    try {
      await _supabase.auth.updateUser(
        UserAttributes(password: newPassword),
      );
    } catch (e) {
      throw Exception('Error changing password: $e');
    }
  }

  /// Sends a password reset email to the specified email address.
  @override
  Future<void> sendPasswordResetEmail({required String email}) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Error sending password reset email: $e');
    }
  }

  /// Stream of the authentication state.
  @override
  Stream<core_models.AuthUser?> get authStateChanges {
    return _supabase.auth.onAuthStateChange.asyncMap((data) async {
      final user = data.session?.user;
      if (user != null) {
        return await _userFromSupabase(user);
      }
      return null;
    });
  }

  /// Creates a user profile in the users table.
  Future<void> _createUserProfile(User user, String? displayName) async {
    try {
      await _supabase.from('users').upsert({
        'id': user.id,
        'email': user.email,
        'display_name': displayName ?? user.userMetadata?['display_name'],
        'photo_url': user.userMetadata?['avatar_url'],
        'phone_number': user.phone,
        'auth_provider': 'email',
        'role': UserRole.regular.name,
        'favorites': <int>[],
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      // Log error but don't throw to avoid blocking authentication
      print('Error creating user profile: $e');
    }
  }

  /// Converts a Supabase User to an AuthUser.
  Future<core_models.AuthUser?> _userFromSupabase(User user) async {
    try {
      // Fetch user profile from users table
      final response = await _supabase
          .from('users')
          .select()
          .eq('id', user.id)
          .maybeSingle();

      if (response != null) {
        return core_models.AuthUser(
          uid: user.id,
          email: user.email ?? '',
          displayName: response['display_name'] as String?,
          photoUrl: response['photo_url'] as String?,
          phoneNumber: response['phone_number'] as String?,
          authProvider: response['auth_provider'] as String? ?? 'email',
          favorites: List<int>.from((response['favorites'] as List?) ?? []),
          role: UserRole.values.firstWhere(
            (role) => role.name == response['role'],
            orElse: () => UserRole.regular,
          ),
          createdAt: DateTime.parse(response['created_at'] as String),
        );
      } else {
        // Create basic user if profile doesn't exist
        return core_models.AuthUser(
          uid: user.id,
          email: user.email ?? '',
          displayName: user.userMetadata?['display_name'] as String?,
          photoUrl: user.userMetadata?['avatar_url'] as String?,
          phoneNumber: user.phone,
          authProvider: 'email',
          favorites: const [],
          role: UserRole.regular,
          createdAt: DateTime.now(),
        );
      }
    } catch (e) {
      print('Error converting user from Supabase: $e');
      return null;
    }
  }
}
