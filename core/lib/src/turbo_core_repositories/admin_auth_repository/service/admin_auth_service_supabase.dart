import 'dart:async';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// 🔐 Servicio de Autenticación Administrativa para Supabase
///
/// Versión simplificada que maneja autenticación básica de administradores
class AdminAuthServiceSupabase {
  AdminAuthServiceSupabase({
    SupabaseClient? supabaseClient,
  }) : _supabase = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabase;

  /// 🆔 Generador de IDs únicos
  static const _uuid = Uuid();

  /// 🔄 Stream del estado de autenticación
  Stream<AdminUser?> get authStateChanges {
    return _supabase.auth.onAuthStateChange.asyncMap((data) async {
      final user = data.session?.user;
      if (user == null) return null;
      return await getAdminUserByUid(user.id);
    });
  }

  /// 👤 Obtiene el usuario administrativo actual
  Future<AdminUser?> getCurrentAdminUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    return getAdminUserByUid(user.id);
  }

  /// 🔍 Obtiene un usuario administrativo por su UID de autenticación
  Future<AdminUser?> getAdminUserByUid(String uid) async {
    try {
      final response = await _supabase
          .from('admin_users')
          .select('*')
          .eq('uid', uid)
          .maybeSingle();

      if (response == null) return null;

      return _adminUserFromSupabase(response);
    } catch (e) {
      print('Error al obtener usuario administrativo: $e');
      return null;
    }
  }

  /// 🔐 Inicia sesión de administrador
  Future<AdminUser?> signInAdmin({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (response.user != null) {
        final adminUser = await getAdminUserByUid(response.user!.id);
        if (adminUser == null) {
          // Si el usuario autenticado no es admin, cerrar sesión
          await _supabase.auth.signOut();
          throw Exception('Usuario no autorizado como administrador');
        }
        return adminUser;
      }
      return null;
    } catch (e) {
      throw Exception('Error al iniciar sesión de administrador: $e');
    }
  }

  /// 👥 Obtiene todos los usuarios administrativos
  Future<List<AdminUser>> getAllAdminUsers() async {
    try {
      final response = await _supabase
          .from('admin_users')
          .select('*')
          .order('created_at', ascending: false);

      return response
          .map<AdminUser>((data) => _adminUserFromSupabase(data))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener usuarios administrativos: $e');
    }
  }

  /// ➕ Crea un nuevo usuario administrativo
  Future<AdminUser> createAdminUser({
    required String email,
    required String password,
    required String displayName,
    required AdminRole role,
    List<String> ownedPlaceIds = const [],
  }) async {
    try {
      // Crear usuario en auth
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Error al crear usuario de autenticación');
      }

      // Crear perfil de admin
      final adminUser = AdminUser(
        uid: authResponse.user!.id,
        email: email,
        displayName: displayName,
        role: role,
        isActive: true,
        ownedPlaceIds: ownedPlaceIds,
        createdAt: DateTime.now(),
      );

      final adminData = _adminUserToSupabase(adminUser);
      await _supabase.from('admin_users').insert(adminData);

      return adminUser;
    } catch (e) {
      throw Exception('Error al crear usuario administrativo: $e');
    }
  }

  /// 🚪 Cerrar sesión
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  /// Converts Supabase data to AdminUser model
  AdminUser _adminUserFromSupabase(Map<String, dynamic> data) {
    return AdminUser(
      uid: data['uid'] as String? ?? '',
      email: data['email'] as String? ?? '',
      displayName: data['display_name'] as String?,
      role: AdminRole.values.firstWhere(
        (role) => role.name == data['role'],
        orElse: () => AdminRole.placeOwner,
      ),
      isActive: data['is_active'] as bool? ?? true,
      ownedPlaceIds: List<String>.from(data['owned_place_ids'] as List? ?? []),
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String)
          : DateTime.now(),
      lastLogin: data['last_login'] != null
          ? DateTime.parse(data['last_login'] as String)
          : null,
    );
  }

  /// Converts AdminUser model to Supabase data
  Map<String, dynamic> _adminUserToSupabase(AdminUser adminUser) {
    return {
      'uid': adminUser.uid,
      'email': adminUser.email,
      'display_name': adminUser.displayName,
      'role': adminUser.role.name,
      'is_active': adminUser.isActive,
      'owned_place_ids': adminUser.ownedPlaceIds,
      'created_at': adminUser.createdAt.toIso8601String(),
      'last_login': adminUser.lastLogin?.toIso8601String(),
    };
  }
}
