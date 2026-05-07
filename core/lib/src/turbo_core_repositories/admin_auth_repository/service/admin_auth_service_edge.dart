import 'dart:async';

import 'package:core/src/turbo_core_repositories/admin_auth_repository/interface/admin_auth_interface.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_role.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_users_stats.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/auth_result.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_registration_result.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_request.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/permission.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';
import 'package:dio/dio.dart';

class AdminAuthServiceEdge implements AdminAuthInterface {
  AdminAuthServiceEdge({required this.baseUrl, required this.httpClient})
    : _authStateController = StreamController<AdminUser?>.broadcast();

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  final StreamController<AdminUser?> _authStateController;

  String _url(String path) => '$baseUrl$path';

  @override
  Stream<AdminUser?> get authStateChanges => _authStateController.stream;

  @override
  Future<AdminUser?> getCurrentAdminUser() async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(_url('/admin_auth_current_user'));
    final data = res.data;
    return data == null ? null : AdminUser.fromJson(data);
  }

  @override
  Future<AdminUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_auth_sign_in'),
          data: {'email': email, 'password': password},
        );
    final user = AdminUser.fromJson(res.data ?? <String, dynamic>{});
    _authStateController.add(user);
    return user;
  }

  @override
  Future<AuthResult> signInUnified({
    required String email,
    required String password,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_auth_sign_in_unified'),
          data: {'email': email, 'password': password},
        );
    final data = res.data ?? <String, dynamic>{};
    // Edge devuelve tipo: { kind: 'admin'|'businessOwner', payload: {...} }
    final kind = data['kind'] as String?;
    if (kind == 'admin') {
      final user = AdminUser.fromJson(
        (data['payload'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      );
      _authStateController.add(user);
      return AuthResult.admin(user);
    } else {
      final request = BusinessOwnerRequest.fromJson(
        (data['payload'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      );
      return AuthResult.businessOwner(request);
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
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_auth_sign_up'),
          data: {
            'email': email,
            'password': password,
            'displayName': displayName,
            'ownedPlaceIds': ownedPlaceIds,
            'role': role.name,
            if (createdByUid != null) 'createdByUid': createdByUid,
          },
        );
    final user = AdminUser.fromJson(res.data ?? <String, dynamic>{});
    _authStateController.add(user);
    return user;
  }

  @override
  Future<void> signOut() async {
    await httpClient.post<void>(_url('/admin_auth_sign_out'));
    _authStateController.add(null);
  }

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await httpClient.post<void>(
      _url('/admin_auth_password_reset'),
      data: {'email': email},
    );
  }

  @override
  Future<void> updateOwnedPlaces(
    String userId,
    List<String> placeIds, {
    String? updatedByUid,
  }) async {
    await httpClient.post<void>(
      _url('/admin_auth_update_owned_places'),
      data: {
        'userId': userId,
        'placeIds': placeIds,
        if (updatedByUid != null) 'updatedByUid': updatedByUid,
      },
    );
  }

  @override
  Future<void> updatePermissions(
    String userId,
    Map<String, List<Permission>> permissions, {
    String? updatedByUid,
  }) async {
    await httpClient.post<void>(
      _url('/admin_auth_update_permissions'),
      data: {
        'userId': userId,
        'permissions': permissions.map(
          (k, v) => MapEntry(k, v.map((p) => p.name).toList()),
        ),
        if (updatedByUid != null) 'updatedByUid': updatedByUid,
      },
    );
  }

  @override
  Future<void> toggleUserStatus(
    String userId,
    bool isActive, {
    String? updatedByUid,
  }) async {
    await httpClient.post<void>(
      _url('/admin_auth_toggle_status'),
      data: {
        'userId': userId,
        'isActive': isActive,
        if (updatedByUid != null) 'updatedByUid': updatedByUid,
      },
    );
  }

  @override
  Future<List<AdminUser>> getAdminsByPlaceId(String placeId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_auth_get_admins_by_place'),
      queryParameters: {'placeId': placeId},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => AdminUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<AdminUser>> getAllAdmins({String? requestedByUid}) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_auth_get_all_admins'),
      queryParameters: {
        if (requestedByUid != null) 'requestedByUid': requestedByUid,
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => AdminUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<AdminUsersStats> getAdminUsersStats({String? requestedByUid}) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_auth_get_users_stats'),
          queryParameters: {
            if (requestedByUid != null) 'requestedByUid': requestedByUid,
          },
        );
    // Adaptador: si Edge devuelve stats directos
    final data = res.data ?? <String, dynamic>{};
    return AdminUsersStats(
      totalUsers: (data['totalUsers'] as int?) ?? 0,
      activeUsers: (data['activeUsers'] as int?) ?? 0,
      placeOwners: (data['placeOwners'] as int?) ?? 0,
      superAdmins: (data['superAdmins'] as int?) ?? 0,
      usersCreatedThisMonth: (data['usersCreatedThisMonth'] as int?) ?? 0,
      lastLoginStats: (data['lastLoginStats'] as Map<String, dynamic>? ?? {})
          .map((k, v) => MapEntry(k, (v as num?)?.toInt() ?? 0)),
    );
  }

  @override
  Future<List<AdminUser>> searchAdminUsers({
    String? email,
    String? displayName,
    AdminRole? role,
    bool? isActive,
    String? requestedByUid,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_auth_search_admins'),
      queryParameters: {
        if (email != null) 'email': email,
        if (displayName != null) 'displayName': displayName,
        if (role != null) 'role': role.name,
        if (isActive != null) 'isActive': isActive,
        if (requestedByUid != null) 'requestedByUid': requestedByUid,
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => AdminUser.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ==================== BUSINESS OWNER FLOW ====================
  @override
  Future<BusinessOwnerRequest> signInWithEmailAndPasswordBusinessOwner({
    required String email,
    required String password,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/bo_auth_sign_in'),
          data: {'email': email, 'password': password},
        );
    return BusinessOwnerRequest.fromJson(res.data ?? <String, dynamic>{});
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
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/bo_request_submit'),
          data: {
            'userId': userId,
            'displayName': displayName,
            'businessName': businessName,
            'businessDescription': businessDescription,
            'businessAddress': businessAddress,
            if (phoneNumber != null) 'phoneNumber': phoneNumber,
            if (website != null) 'website': website,
            if (businessMetadata != null) 'businessMetadata': businessMetadata,
            if (contactInfo != null) 'contactInfo': contactInfo,
          },
        );
    return BusinessOwnerRequest.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<AdminUser> approveBusinessOwnerRequest({
    required String requestId,
    required String approvedByUid,
    List<String>? initialPlaceIds,
    String? approvalNotes,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/bo_request_approve'),
          data: {
            'requestId': requestId,
            'approvedByUid': approvedByUid,
            if (initialPlaceIds != null) 'initialPlaceIds': initialPlaceIds,
            if (approvalNotes != null) 'approvalNotes': approvalNotes,
          },
        );
    return AdminUser.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<void> rejectBusinessOwnerRequest({
    required String requestId,
    required String rejectedByUid,
    required String rejectionReason,
  }) async {
    await httpClient.post<void>(
      _url('/bo_request_reject'),
      data: {
        'requestId': requestId,
        'rejectedByUid': rejectedByUid,
        'rejectionReason': rejectionReason,
      },
    );
  }

  @override
  Future<void> updateRequestStatus({
    required String requestId,
    required String updatedByUid,
    required BusinessOwnerRequestStatus newStatus,
    String? notes,
  }) async {
    await httpClient.post<void>(
      _url('/bo_request_update_status'),
      data: {
        'requestId': requestId,
        'updatedByUid': updatedByUid,
        'newStatus': newStatus.name,
        if (notes != null) 'notes': notes,
      },
    );
  }

  @override
  Future<List<BusinessOwnerRequest>> getAllBusinessOwnerRequests({
    String? requestedByUid,
    BusinessOwnerRequestStatus? filterByStatus,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/bo_request_get_all'),
      queryParameters: {
        if (requestedByUid != null) 'requestedByUid': requestedByUid,
        if (filterByStatus != null) 'status': filterByStatus.name,
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => BusinessOwnerRequest.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<BusinessOwnerRequestStats> getBusinessOwnerRequestStats({
    String? requestedByUid,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/bo_request_stats'),
          queryParameters: {
            if (requestedByUid != null) 'requestedByUid': requestedByUid,
          },
        );
    final data = res.data ?? <String, dynamic>{};
    return BusinessOwnerRequestStats(
      totalRequests: (data['totalRequests'] as int?) ?? 0,
      pendingRequests: (data['pendingRequests'] as int?) ?? 0,
      approvedRequests: (data['approvedRequests'] as int?) ?? 0,
      rejectedRequests: (data['rejectedRequests'] as int?) ?? 0,
      reviewingRequests: (data['reviewingRequests'] as int?) ?? 0,
      needsMoreInfoRequests: (data['needsMoreInfoRequests'] as int?) ?? 0,
      urgentRequests: (data['urgentRequests'] as int?) ?? 0,
      requestsThisWeek: (data['requestsThisWeek'] as int?) ?? 0,
      requestsThisMonth: (data['requestsThisMonth'] as int?) ?? 0,
      averageResponseTimeDays:
          (data['averageResponseTimeDays'] as num?)?.toDouble() ?? 0.0,
    );
  }

  @override
  Future<BusinessOwnerRequest?> getBusinessOwnerRequestById(
    String requestId, {
    String? requestedByUid,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/bo_request_get_by_id'),
          queryParameters: {
            'requestId': requestId,
            if (requestedByUid != null) 'requestedByUid': requestedByUid,
          },
        );
    final data = res.data;
    return data == null ? null : BusinessOwnerRequest.fromJson(data);
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
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/bo_register_and_request'),
          data: {
            'email': email,
            'password': password,
            'displayName': displayName,
            'businessName': businessName,
            'businessDescription': businessDescription,
            'businessAddress': businessAddress,
            if (phoneNumber != null) 'phoneNumber': phoneNumber,
            if (website != null) 'website': website,
            if (businessMetadata != null) 'businessMetadata': businessMetadata,
            if (contactInfo != null) 'contactInfo': contactInfo,
          },
        );
    final data = res.data ?? <String, dynamic>{};
    return BusinessOwnerRegistrationResult(
      user: AuthUser.fromJson(
        (data['user'] as Map?)?.cast<String, dynamic>() ?? <String, dynamic>{},
      ),
      request: BusinessOwnerRequest.fromJson(
        (data['request'] as Map?)?.cast<String, dynamic>() ??
            <String, dynamic>{},
      ),
      success: (data['success'] as bool?) ?? false,
      message: (data['message'] as String?) ?? '',
    );
  }
}
