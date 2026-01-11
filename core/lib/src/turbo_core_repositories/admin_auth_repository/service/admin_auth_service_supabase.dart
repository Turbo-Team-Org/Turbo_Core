import 'dart:async';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_role.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/auth_result.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_registration_result.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_request.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_users_stats.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/permission.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/interface/admin_auth_interface.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart'
    as core_auth;
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// 🔐 Servicio de Autenticación Administrativa para Supabase
class AdminAuthServiceSupabase implements AdminAuthInterface {
  AdminAuthServiceSupabase({
    SupabaseClient? supabaseClient,
  }) : _supabase = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabase;
  static const _uuid = Uuid();

  // ==================== MÉTODOS AUXILIARES ====================

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

  BusinessOwnerRequest _businessOwnerRequestFromSupabase(
      Map<String, dynamic> data) {
    return BusinessOwnerRequest(
      id: data['id'] as String? ?? '',
      userId: data['user_id'] as String? ?? '',
      email: data['email'] as String? ?? '',
      displayName: data['display_name'] as String? ?? '',
      businessName: data['business_name'] as String? ?? '',
      businessDescription: data['business_description'] as String? ?? '',
      businessAddress: data['business_address'] as String? ?? '',
      phoneNumber: data['phone_number'] as String?,
      website: data['website'] as String?,
      status: BusinessOwnerRequestStatus.values.firstWhere(
        (status) => status.name == data['status'],
        orElse: () => BusinessOwnerRequestStatus.pending,
      ),
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'] as String)
          : DateTime.now(),
      businessMetadata:
          Map<String, dynamic>.from(data['business_metadata'] as Map? ?? {}),
      contactInfo:
          Map<String, dynamic>.from(data['contact_info'] as Map? ?? {}),
    );
  }

  Map<String, dynamic> _businessOwnerRequestToSupabase(
      BusinessOwnerRequest request) {
    return {
      'id': request.id,
      'user_id': request.userId,
      'email': request.email,
      'display_name': request.displayName,
      'business_name': request.businessName,
      'business_description': request.businessDescription,
      'business_address': request.businessAddress,
      'phone_number': request.phoneNumber,
      'website': request.website,
      'status': request.status.name,
      'created_at': request.createdAt.toIso8601String(),
      'business_metadata': request.businessMetadata,
      'contact_info': request.contactInfo,
    };
  }

  // ==================== IMPLEMENTACIÓN DE INTERFAZ ====================

  @override
  Stream<AdminUser?> get authStateChanges {
    return _supabase.auth.onAuthStateChange.asyncMap((data) async {
      final user = data.session?.user;
      if (user == null) return null;
      return await getAdminUserByUid(user.id);
    });
  }

  @override
  Future<AdminUser?> getCurrentAdminUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;
    return getAdminUserByUid(user.id);
  }

  @override
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

  @override
  Future<AdminUser> signInWithEmailAndPassword({
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
          await _supabase.auth.signOut();
          throw Exception('Usuario no autorizado como administrador');
        }
        return adminUser;
      }
      throw Exception('Error en autenticación');
    } catch (e) {
      throw Exception('Error al iniciar sesión de administrador: $e');
    }
  }

  @override
  Future<AuthResult> signInUnified({
    required String email,
    required String password,
  }) async {
    try {
      final adminUser = await signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return AuthResult.admin(adminUser);
    } catch (e) {
      throw Exception('Error en login unificado: $e');
    }
  }

  @override
  Future<AdminUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required List<String> ownedPlaceIds,
    AdminRole role = AdminRole.placeOwner,
    String? createdByUid,
  }) async {
    try {
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Error al crear usuario de autenticación');
      }

      final adminUser = AdminUser(
        uid: authResponse.user!.id,
        email: email,
        displayName: displayName,
        role: role,
        isActive: true,
        ownedPlaceIds: ownedPlaceIds,
        createdAt: DateTime.now(),
      );

      await _supabase
          .from('admin_users')
          .insert(_adminUserToSupabase(adminUser));
      return adminUser;
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _supabase.auth.signOut();
    } catch (e) {
      throw Exception('Error al cerrar sesión: $e');
    }
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _supabase.auth.resetPasswordForEmail(email);
    } catch (e) {
      throw Exception('Error al enviar email de recuperación: $e');
    }
  }

  @override
  Future<void> updateOwnedPlaces(
    String userId,
    List<String> placeIds, {
    String? updatedByUid,
  }) async {
    try {
      await _supabase.from('admin_users').update({
        'owned_place_ids': placeIds,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('uid', userId);
    } catch (e) {
      throw Exception('Error al actualizar lugares: $e');
    }
  }

  @override
  Future<void> updatePermissions(
    String userId,
    Map<String, List<Permission>> permissions, {
    String? updatedByUid,
  }) async {
    try {
      final permissionsJson = permissions.map(
        (key, value) => MapEntry(key, value.map((p) => p.name).toList()),
      );

      await _supabase.from('admin_users').update({
        'permissions': permissionsJson,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('uid', userId);
    } catch (e) {
      throw Exception('Error al actualizar permisos: $e');
    }
  }

  @override
  Future<void> toggleUserStatus(
    String userId,
    bool isActive, {
    String? updatedByUid,
  }) async {
    try {
      await _supabase.from('admin_users').update({
        'is_active': isActive,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('uid', userId);
    } catch (e) {
      throw Exception('Error al cambiar estado: $e');
    }
  }

  @override
  Future<List<AdminUser>> getAdminsByPlaceId(String placeId) async {
    try {
      final response = await _supabase
          .from('admin_users')
          .select('*')
          .contains('owned_place_ids', [placeId]).eq('is_active', true);

      return response
          .map<AdminUser>((data) => _adminUserFromSupabase(data))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener admins por lugar: $e');
    }
  }

  @override
  Future<List<AdminUser>> getAllAdmins({String? requestedByUid}) async {
    try {
      final response = await _supabase
          .from('admin_users')
          .select('*')
          .order('created_at', ascending: false);

      return response
          .map<AdminUser>((data) => _adminUserFromSupabase(data))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener todos los admins: $e');
    }
  }

  @override
  Future<AdminUsersStats> getAdminUsersStats({String? requestedByUid}) async {
    try {
      final response = await _supabase
          .from('admin_users')
          .select('role, is_active, created_at, last_login');

      final totalUsers = response.length;
      final activeUsers =
          response.where((user) => user['is_active'] == true).length;
      final placeOwners =
          response.where((user) => user['role'] == 'placeOwner').length;
      final superAdmins =
          response.where((user) => user['role'] == 'superAdmin').length;

      final now = DateTime.now();
      final startOfMonth = DateTime(now.year, now.month, 1);
      final usersCreatedThisMonth = response.where((user) {
        final createdAt = user['created_at'] as String?;
        if (createdAt == null) return false;
        final createdDate = DateTime.tryParse(createdAt);
        return createdDate?.isAfter(startOfMonth) ?? false;
      }).length;

      final startOfDay = DateTime(now.year, now.month, now.day);
      final startOfWeek = now.subtract(Duration(days: now.weekday - 1));

      var todayLogins = 0;
      var weekLogins = 0;
      var monthLogins = 0;
      var olderLogins = 0;

      for (final user in response) {
        final lastLoginStr = user['last_login'] as String?;
        if (lastLoginStr != null) {
          final lastLogin = DateTime.tryParse(lastLoginStr);
          if (lastLogin != null) {
            if (lastLogin.isAfter(startOfDay)) {
              todayLogins++;
            } else if (lastLogin.isAfter(startOfWeek)) {
              weekLogins++;
            } else if (lastLogin.isAfter(startOfMonth)) {
              monthLogins++;
            } else {
              olderLogins++;
            }
          }
        }
      }

      return AdminUsersStats(
        totalUsers: totalUsers,
        activeUsers: activeUsers,
        placeOwners: placeOwners,
        superAdmins: superAdmins,
        usersCreatedThisMonth: usersCreatedThisMonth,
        lastLoginStats: {
          'today': todayLogins,
          'week': weekLogins,
          'month': monthLogins,
          'older': olderLogins,
        },
      );
    } catch (e) {
      throw Exception('Error al obtener estadísticas: $e');
    }
  }

  @override
  Future<List<AdminUser>> searchAdminUsers({
    String? email,
    String? displayName,
    AdminRole? role,
    bool? isActive,
    String? requestedByUid,
  }) async {
    try {
      var query = _supabase.from('admin_users').select('*');

      if (email != null && email.isNotEmpty) {
        query = query.ilike('email', '%$email%');
      }

      if (displayName != null && displayName.isNotEmpty) {
        query = query.ilike('display_name', '%$displayName%');
      }

      if (role != null) {
        query = query.eq('role', role.name);
      }

      if (isActive != null) {
        query = query.eq('is_active', isActive);
      }

      final response = await query.order('created_at', ascending: false);

      return response
          .map<AdminUser>((data) => _adminUserFromSupabase(data))
          .toList();
    } catch (e) {
      throw Exception('Error al buscar usuarios: $e');
    }
  }

  @override
  Future<BusinessOwnerRequest> signInWithEmailAndPasswordBusinessOwner({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _supabase
          .from('business_owner_requests')
          .select('*')
          .eq('email', email)
          .maybeSingle();

      if (response == null) {
        throw Exception('Solicitud de business owner no encontrada');
      }

      return _businessOwnerRequestFromSupabase(response);
    } catch (e) {
      throw Exception('Error al iniciar sesión como business owner: $e');
    }
  }

  @override
  Future<BusinessOwnerRequest> submitBusinessOwnerRequest({
    required String userId,
    required String displayName,
    required String businessName,
    required String businessDescription,
    required String businessAddress,
    String? phoneNumber,
    String? website,
    Map<String, dynamic>? businessMetadata,
    Map<String, dynamic>? contactInfo,
  }) async {
    try {
      final request = BusinessOwnerRequest(
        id: _uuid.v4(),
        userId: userId,
        email: '', // Se obtendrá del usuario
        displayName: displayName,
        businessName: businessName,
        businessDescription: businessDescription,
        businessAddress: businessAddress,
        phoneNumber: phoneNumber,
        website: website,
        status: BusinessOwnerRequestStatus.pending,
        createdAt: DateTime.now(),
        businessMetadata: businessMetadata ?? {},
        contactInfo: contactInfo ?? {},
      );

      await _supabase
          .from('business_owner_requests')
          .insert(_businessOwnerRequestToSupabase(request));

      return request;
    } catch (e) {
      throw Exception('Error al enviar solicitud: $e');
    }
  }

  @override
  Future<AdminUser> approveBusinessOwnerRequest({
    required String requestId,
    required String approvedByUid,
    List<String>? initialPlaceIds,
    String? approvalNotes,
  }) async {
    try {
      final requestResponse = await _supabase
          .from('business_owner_requests')
          .select('*')
          .eq('id', requestId)
          .maybeSingle();

      if (requestResponse == null) {
        throw Exception('Solicitud no encontrada');
      }

      final request = _businessOwnerRequestFromSupabase(requestResponse);

      final adminUser = AdminUser(
        uid: request.userId,
        email: request.email,
        displayName: request.displayName,
        role: AdminRole.placeOwner,
        isActive: true,
        ownedPlaceIds: initialPlaceIds ?? [],
        createdAt: DateTime.now(),
      );

      await _supabase
          .from('admin_users')
          .insert(_adminUserToSupabase(adminUser));

      await _supabase.from('business_owner_requests').update({
        'status': BusinessOwnerRequestStatus.approved.name,
        'approved_by': approvedByUid,
        'approved_at': DateTime.now().toIso8601String(),
        'approval_notes': approvalNotes,
      }).eq('id', requestId);

      return adminUser;
    } catch (e) {
      throw Exception('Error al aprobar solicitud: $e');
    }
  }

  @override
  Future<void> rejectBusinessOwnerRequest({
    required String requestId,
    required String rejectedByUid,
    required String rejectionReason,
  }) async {
    try {
      await _supabase.from('business_owner_requests').update({
        'status': BusinessOwnerRequestStatus.rejected.name,
        'rejected_by': rejectedByUid,
        'rejected_at': DateTime.now().toIso8601String(),
        'rejection_reason': rejectionReason,
      }).eq('id', requestId);
    } catch (e) {
      throw Exception('Error al rechazar solicitud: $e');
    }
  }

  @override
  Future<void> updateRequestStatus({
    required String requestId,
    required String updatedByUid,
    required BusinessOwnerRequestStatus newStatus,
    String? notes,
  }) async {
    try {
      await _supabase.from('business_owner_requests').update({
        'status': newStatus.name,
        'updated_by': updatedByUid,
        'updated_at': DateTime.now().toIso8601String(),
        'status_notes': notes,
      }).eq('id', requestId);
    } catch (e) {
      throw Exception('Error al actualizar estado: $e');
    }
  }

  @override
  Future<List<BusinessOwnerRequest>> getAllBusinessOwnerRequests({
    String? requestedByUid,
    BusinessOwnerRequestStatus? filterByStatus,
  }) async {
    try {
      var query = _supabase.from('business_owner_requests').select('*');

      if (filterByStatus != null) {
        query = query.eq('status', filterByStatus.name);
      }

      final response = await query.order('created_at', ascending: false);

      return response
          .map<BusinessOwnerRequest>(
              (data) => _businessOwnerRequestFromSupabase(data))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener solicitudes: $e');
    }
  }

  @override
  Future<BusinessOwnerRequestStats> getBusinessOwnerRequestStats(
      {String? requestedByUid}) async {
    try {
      final response =
          await _supabase.from('business_owner_requests').select('status');

      final totalRequests = response.length;
      final pendingRequests =
          response.where((req) => req['status'] == 'pending').length;
      final approvedRequests =
          response.where((req) => req['status'] == 'approved').length;
      final rejectedRequests =
          response.where((req) => req['status'] == 'rejected').length;

      return BusinessOwnerRequestStats(
        totalRequests: totalRequests,
        pendingRequests: pendingRequests,
        approvedRequests: approvedRequests,
        rejectedRequests: rejectedRequests,
        reviewingRequests: 0,
        needsMoreInfoRequests: 0,
        urgentRequests: 0,
        requestsThisWeek: 0,
        requestsThisMonth: 0,
        averageResponseTimeDays: 0.0,
      );
    } catch (e) {
      throw Exception('Error al obtener estadísticas de solicitudes: $e');
    }
  }

  @override
  Future<BusinessOwnerRequest?> getBusinessOwnerRequestById(
    String requestId, {
    String? requestedByUid,
  }) async {
    try {
      final response = await _supabase
          .from('business_owner_requests')
          .select('*')
          .eq('id', requestId)
          .maybeSingle();

      if (response == null) return null;

      return _businessOwnerRequestFromSupabase(response);
    } catch (e) {
      throw Exception('Error al obtener solicitud: $e');
    }
  }

  @override
  Future<BusinessOwnerRegistrationResult> registerAndRequestBusinessOwner({
    required String email,
    required String password,
    required String displayName,
    required String businessName,
    required String businessDescription,
    required String businessAddress,
    String? phoneNumber,
    String? website,
    Map<String, dynamic>? businessMetadata,
    Map<String, dynamic>? contactInfo,
  }) async {
    try {
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw Exception('Error al crear usuario de autenticación');
      }

      final request = await submitBusinessOwnerRequest(
        userId: authResponse.user!.id,
        displayName: displayName,
        businessName: businessName,
        businessDescription: businessDescription,
        businessAddress: businessAddress,
        phoneNumber: phoneNumber,
        website: website,
        businessMetadata: businessMetadata,
        contactInfo: contactInfo,
      );

      // Crear un AuthUser temporal para el resultado
      final tempAuthUser = core_auth.AuthUser(
        uid: authResponse.user!.id,
        email: email,
        createdAt: DateTime.now(),
      );

      return BusinessOwnerRegistrationResult(
        user: tempAuthUser,
        request: request,
        success: true,
        message: 'Usuario registrado y solicitud enviada exitosamente',
      );
    } catch (e) {
      throw Exception('Error en registro completo: $e');
    }
  }
}
