import 'package:core/src/turbo_core_repositories/admin_auth_repository/admin_auth_repository_imports.dart';
import 'package:dartz/dartz.dart';

/// 🏛️ Repositorio de Autenticación Administrativa - Domain Layer
///
/// Abstrae el acceso a datos y proporciona una interfaz limpia
/// para el manejo de usuarios administrativos en Turbo Platform
abstract class AdminAuthRepository {
  // ==================== AUTENTICACIÓN ====================

  /// 🔄 Stream del estado de autenticación del usuario actual
  Stream<Either<AdminAuthFailure, AdminUser?>> get authStateChanges;

  /// 👤 Obtiene el usuario administrativo actualmente autenticado
  Future<Either<AdminAuthFailure, AdminUser?>> getCurrentAdminUser();

  /// 🔐 Inicia sesión con email y contraseña
  Future<Either<AdminAuthFailure, AdminUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  });

  /// 🎯 Login unificado que determina el tipo de usuario automáticamente
  Future<Either<AdminAuthFailure, AuthResult>> signInUnified({
    required String email,
    required String password,
  });

  /// 📝 Registra un nuevo usuario administrativo
  Future<Either<AdminAuthFailure, AdminUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required List<String> ownedPlaceIds,
    AdminRole role = AdminRole.placeOwner,
    String? createdByUid,
  });

  /// 🚪 Cerrar sesión del usuario actual
  Future<Either<AdminAuthFailure, Unit>> signOut();

  /// 📧 Enviar email de recuperación de contraseña
  Future<Either<AdminAuthFailure, Unit>> sendPasswordResetEmail(String email);

  // ==================== GESTIÓN DE PERMISOS ====================

  /// 🏢 Actualiza los lugares asignados a un usuario
  Future<Either<AdminAuthFailure, Unit>> updateOwnedPlaces(
    String userId,
    List<String> placeIds, {
    String? updatedByUid,
  });

  /// 🔑 Actualiza permisos específicos de un usuario
  Future<Either<AdminAuthFailure, Unit>> updatePermissions(
    String userId,
    Map<String, List<Permission>> permissions, {
    String? updatedByUid,
  });

  /// 🔄 Cambia el estado activo/inactivo de un usuario
  Future<Either<AdminAuthFailure, Unit>> toggleUserStatus(
    String userId,
    bool isActive, {
    String? updatedByUid,
  });

  // ==================== CONSULTAS ====================

  /// 🏢 Obtiene administradores de un lugar específico
  Future<Either<AdminAuthFailure, List<AdminUser>>> getAdminsByPlaceId(
    String placeId,
  );

  /// 👥 Obtiene todos los usuarios administrativos (solo superAdmin)
  Future<Either<AdminAuthFailure, List<AdminUser>>> getAllAdmins({
    String? requestedByUid,
  });

  /// 📊 Obtiene estadísticas de usuarios administrativos
  Future<Either<AdminAuthFailure, AdminUsersStats>> getAdminUsersStats({
    String? requestedByUid,
  });

  /// 🔍 Busca usuarios administrativos por criterios
  Future<Either<AdminAuthFailure, List<AdminUser>>> searchAdminUsers({
    String? email,
    String? displayName,
    AdminRole? role,
    bool? isActive,
    String? requestedByUid,
  });

  // ==================== AUTO-REGISTRO DE BUSINESS OWNERS ====================

  /// 🔐 Inicia sesión con email y contraseña para business owners
  Future<Either<AdminAuthFailure, BusinessOwnerRequest>>
  signInWithEmailAndPasswordBusinessOwner({
    required String email,
    required String password,
  });

  /// 🆕 Enviar solicitud de registro como business owner
  Future<Either<AdminAuthFailure, BusinessOwnerRequest>>
  submitBusinessOwnerRequest({
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
  Future<Either<AdminAuthFailure, AdminUser>> approveBusinessOwnerRequest({
    required String requestId,
    required String approvedByUid,
    List<String>? initialPlaceIds,
    String? approvalNotes,
  });

  /// ❌ Rechazar solicitud de business owner
  Future<Either<AdminAuthFailure, Unit>> rejectBusinessOwnerRequest({
    required String requestId,
    required String rejectedByUid,
    required String rejectionReason,
  });

  /// 🔄 Actualizar estado de solicitud
  Future<Either<AdminAuthFailure, Unit>> updateRequestStatus({
    required String requestId,
    required String updatedByUid,
    required BusinessOwnerRequestStatus newStatus,
    String? notes,
  });

  /// 📋 Obtener todas las solicitudes de business owners
  Future<Either<AdminAuthFailure, List<BusinessOwnerRequest>>>
  getAllBusinessOwnerRequests({
    String? requestedByUid,
    BusinessOwnerRequestStatus? filterByStatus,
  });

  /// 📊 Obtener estadísticas de solicitudes
  Future<Either<AdminAuthFailure, BusinessOwnerRequestStats>>
  getBusinessOwnerRequestStats({String? requestedByUid});

  /// 🔍 Obtener solicitud por ID
  Future<Either<AdminAuthFailure, BusinessOwnerRequest?>>
  getBusinessOwnerRequestById(String requestId, {String? requestedByUid});

  // ==================== FLUJO COMPLETO BUSINESS OWNER ====================

  /// 🚀 Registra usuario nuevo y envía solicitud de business owner en un solo flujo
  ///
  /// Maneja todo el proceso para usuarios sin cuenta:
  /// 1. Registra usuario en authentication
  /// 2. Inmediatamente envía solicitud de business owner
  /// 3. Retorna resultado unificado
  Future<Either<AdminAuthFailure, BusinessOwnerRegistrationResult>>
  registerAndRequestBusinessOwner({
    // Datos de usuario
    required String email,
    required String password,
    required String displayName,
    // Datos de negocio
    required String businessName,
    required String businessDescription,
    required String businessAddress,
    String? phoneNumber,
    String? website,
    Map<String, dynamic>? businessMetadata,
    Map<String, dynamic>? contactInfo,
  });
}
