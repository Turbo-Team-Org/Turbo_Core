import 'dart:async';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/auth_result.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_role.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_registration_result.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_request.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_users_stats.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/permission.dart';

/// Interfaz común para servicios de autenticación administrativa
abstract class AdminAuthInterface {
  // ==================== AUTENTICACIÓN ====================

  /// 🔄 Stream del estado de autenticación del usuario actual
  Stream<AdminUser?> get authStateChanges;

  /// 👤 Obtiene el usuario administrativo actualmente autenticado
  Future<AdminUser?> getCurrentAdminUser();

  /// 🔐 Inicia sesión con email y contraseña
  Future<AdminUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// 🎯 Login unificado que determina el tipo de usuario automáticamente
  Future<AuthResult> signInUnified({
    required String email,
    required String password,
  });

  /// 📝 Registra un nuevo usuario administrativo
  Future<AdminUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required List<String> ownedPlaceIds,
    AdminRole role = AdminRole.placeOwner,
    String? createdByUid,
  });

  /// 🚪 Cerrar sesión del usuario actual
  Future<void> signOut();

  /// 📧 Enviar email de recuperación de contraseña
  Future<void> sendPasswordResetEmail(String email);

  // ==================== GESTIÓN DE PERMISOS ====================

  /// 🏢 Actualiza los lugares asignados a un usuario
  Future<void> updateOwnedPlaces(
    String userId,
    List<String> placeIds, {
    String? updatedByUid,
  });

  /// 🔑 Actualiza permisos específicos de un usuario
  Future<void> updatePermissions(
    String userId,
    Map<String, List<Permission>> permissions, {
    String? updatedByUid,
  });

  /// 🔄 Cambia el estado activo/inactivo de un usuario
  Future<void> toggleUserStatus(
    String userId,
    bool isActive, {
    String? updatedByUid,
  });

  // ==================== CONSULTAS ====================

  /// 🏢 Obtiene administradores de un lugar específico
  Future<List<AdminUser>> getAdminsByPlaceId(String placeId);

  /// 👥 Obtiene todos los usuarios administrativos (solo superAdmin)
  Future<List<AdminUser>> getAllAdmins({String? requestedByUid});

  /// 📊 Obtiene estadísticas de usuarios administrativos
  Future<AdminUsersStats> getAdminUsersStats({String? requestedByUid});

  /// 🔍 Busca usuarios administrativos por criterios
  Future<List<AdminUser>> searchAdminUsers({
    String? email,
    String? displayName,
    AdminRole? role,
    bool? isActive,
    String? requestedByUid,
  });

  // ==================== AUTO-REGISTRO DE BUSINESS OWNERS ====================

  /// 🔐 Inicia sesión con email y contraseña para business owners
  Future<BusinessOwnerRequest> signInWithEmailAndPasswordBusinessOwner({
    required String email,
    required String password,
  });

  /// 🆕 Enviar solicitud de registro como business owner
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
  });

  /// ✅ Aprobar solicitud de business owner
  Future<AdminUser> approveBusinessOwnerRequest({
    required String requestId,
    required String approvedByUid,
    List<String>? initialPlaceIds,
    String? approvalNotes,
  });

  /// ❌ Rechazar solicitud de business owner
  Future<void> rejectBusinessOwnerRequest({
    required String requestId,
    required String rejectedByUid,
    required String rejectionReason,
  });

  /// 🔄 Actualizar estado de solicitud
  Future<void> updateRequestStatus({
    required String requestId,
    required String updatedByUid,
    required BusinessOwnerRequestStatus newStatus,
    String? notes,
  });

  /// 📋 Obtener todas las solicitudes de business owners
  Future<List<BusinessOwnerRequest>> getAllBusinessOwnerRequests({
    String? requestedByUid,
    BusinessOwnerRequestStatus? filterByStatus,
  });

  /// 📊 Obtener estadísticas de solicitudes
  Future<BusinessOwnerRequestStats> getBusinessOwnerRequestStats({
    String? requestedByUid,
  });

  /// 🔍 Obtener solicitud por ID
  Future<BusinessOwnerRequest?> getBusinessOwnerRequestById(
    String requestId, {
    String? requestedByUid,
  });

  // ==================== FLUJO COMPLETO BUSINESS OWNER ====================

  /// 🚀 Registra usuario nuevo y envía solicitud de business owner en un solo flujo
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
  });
}
