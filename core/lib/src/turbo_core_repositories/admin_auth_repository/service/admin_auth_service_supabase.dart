import 'dart:async';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_request.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_role.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// 🔐 Servicio de Autenticación Administrativa para Supabase
///
/// Maneja toda la lógica de autenticación y autorización específica
/// para usuarios administrativos del Admin Panel de Turbo
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
      return await getAdminUserByUidField(user.id);
    });
  }

  /// 👤 Obtiene el usuario administrativo actual
  Future<AdminUser?> getCurrentAdminUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    return getAdminUserByUidField(user.id);
  }

  /// 🔍 Obtiene un usuario administrativo por su UID de autenticación
  Future<AdminUser?> getAdminUserByUidField(String uid) async {
    try {
      final response = await _supabase
          .from('admin_users')
          .select('*')
          .eq('auth_uid', uid)
          .maybeSingle();

      if (response == null) return null;

      return _adminUserFromSupabase(response);
    } catch (e) {
      throw Exception('Error al obtener usuario administrativo: $e');
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
        final adminUser = await getAdminUserByUidField(response.user!.id);
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

  /// 📝 Crea una nueva solicitud de business owner
  Future<String> createBusinessOwnerRequest(
    BusinessOwnerRequest request,
  ) async {
    try {
      final requestId = _uuid.v4();
      final requestData = _businessOwnerRequestToSupabase(request.copyWith(id: requestId));

      await _supabase.from('business_owner_requests').insert(requestData);
      return requestId;
    } catch (e) {
      throw Exception('Error al crear solicitud de business owner: $e');
    }
  }

  /// 📋 Obtiene todas las solicitudes de business owner pendientes
  Future<List<BusinessOwnerRequest>> getPendingBusinessOwnerRequests() async {
    try {
      final response = await _supabase
          .from('business_owner_requests')
          .select('*')
          .eq('status', 'pending')
          .order('created_at', ascending: false);

      return response.map<BusinessOwnerRequest>((data) => 
        _businessOwnerRequestFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error al obtener solicitudes pendientes: $e');
    }
  }

  /// ✅ Aprueba una solicitud de business owner
  Future<void> approveBusinessOwnerRequest(String requestId) async {
    try {
      await _supabase
          .from('business_owner_requests')
          .update({
            'status': 'approved',
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', requestId);
    } catch (e) {
      throw Exception('Error al aprobar solicitud: $e');
    }
  }

  /// ❌ Rechaza una solicitud de business owner
  Future<void> rejectBusinessOwnerRequest(String requestId, String reason) async {
    try {
      await _supabase
          .from('business_owner_requests')
          .update({
            'status': 'rejected',
            'rejection_reason': reason,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', requestId);
    } catch (e) {
      throw Exception('Error al rechazar solicitud: $e');
    }
  }

  /// 👥 Obtiene todos los usuarios administrativos
  Future<List<AdminUser>> getAllAdminUsers() async {
    try {
      final response = await _supabase
          .from('admin_users')
          .select('*')
          .order('created_at', ascending: false);

      return response.map<AdminUser>((data) => _adminUserFromSupabase(data)).toList();
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
    List<String> placeIds = const [],
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
      final adminId = _uuid.v4();
      final adminUser = AdminUser(
        id: adminId,
        authUid: authResponse.user!.id,
        email: email,
        displayName: displayName,
        role: role,
        isActive: true,
        placeIds: placeIds,
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
      id: data['id'] ?? '',
      authUid: data['auth_uid'] ?? '',
      email: data['email'] ?? '',
      displayName: data['display_name'] ?? '',
      role: AdminRole.values.firstWhere(
        (role) => role.name == data['role'],
        orElse: () => AdminRole.businessOwner,
      ),
      isActive: data['is_active'] ?? true,
      placeIds: List<String>.from(data['place_ids'] ?? []),
      createdAt: data['created_at'] != null 
          ? DateTime.parse(data['created_at']) 
          : DateTime.now(),
      lastLogin: data['last_login'] != null 
          ? DateTime.parse(data['last_login']) 
          : null,
    );
  }

  /// Converts AdminUser model to Supabase data
  Map<String, dynamic> _adminUserToSupabase(AdminUser adminUser) {
    return {
      'id': adminUser.id,
      'auth_uid': adminUser.authUid,
      'email': adminUser.email,
      'display_name': adminUser.displayName,
      'role': adminUser.role.name,
      'is_active': adminUser.isActive,
      'place_ids': adminUser.placeIds,
      'created_at': adminUser.createdAt.toIso8601String(),
      'last_login': adminUser.lastLogin?.toIso8601String(),
    };
  }

  /// Converts Supabase data to BusinessOwnerRequest model
  BusinessOwnerRequest _businessOwnerRequestFromSupabase(Map<String, dynamic> data) {
    return BusinessOwnerRequest(
      id: data['id'] ?? '',
      businessName: data['business_name'] ?? '',
      ownerName: data['owner_name'] ?? '',
      email: data['email'] ?? '',
      phone: data['phone'] ?? '',
      address: data['address'] ?? '',
      description: data['description'] ?? '',
      status: data['status'] ?? 'pending',
      createdAt: data['created_at'] != null 
          ? DateTime.parse(data['created_at']) 
          : DateTime.now(),
      updatedAt: data['updated_at'] != null 
          ? DateTime.parse(data['updated_at']) 
          : null,
      rejectionReason: data['rejection_reason'],
    );
  }

  /// Converts BusinessOwnerRequest model to Supabase data
  Map<String, dynamic> _businessOwnerRequestToSupabase(BusinessOwnerRequest request) {
    return {
      'id': request.id,
      'business_name': request.businessName,
      'owner_name': request.ownerName,
      'email': request.email,
      'phone': request.phone,
      'address': request.address,
      'description': request.description,
      'status': request.status,
      'created_at': request.createdAt.toIso8601String(),
      'updated_at': request.updatedAt?.toIso8601String(),
      'rejection_reason': request.rejectionReason,
    };
  }
}