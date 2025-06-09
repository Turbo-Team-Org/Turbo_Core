// 🏛️ Admin Authentication Repository - Clean Architecture
//
// Maneja usuarios administrativos para el Admin Panel de Turbo Platform
// con separación clara entre usuarios regulares y administrativos

import 'dart:async';

import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/business_owner_request.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/service/admin_auth_service.dart';
import 'package:dartz/dartz.dart';

export 'models/admin_user.dart';
export 'models/business_owner_request.dart';
export 'service/admin_auth_service.dart';

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
}

/// 🛠️ Implementación concreta del repositorio
class AdminAuthRepositoryImpl implements AdminAuthRepository {
  AdminAuthRepositoryImpl({required AdminAuthService adminAuthService})
    : _adminAuthService = adminAuthService;

  final AdminAuthService _adminAuthService;

  @override
  Stream<Either<AdminAuthFailure, AdminUser?>> get authStateChanges {
    return _adminAuthService.authStateChanges
        .map<Either<AdminAuthFailure, AdminUser?>>((user) => Right(user))
        .transform(_errorToLeftTransformer<AdminAuthFailure, AdminUser?>());
  }

  /// StreamTransformer que convierte errores en eventos Left en lugar de errores
  StreamTransformer<Either<F, T>, Either<F, T>>
  _errorToLeftTransformer<F, T>() {
    return StreamTransformer<Either<F, T>, Either<F, T>>.fromHandlers(
      handleData: (Either<F, T> data, EventSink<Either<F, T>> sink) {
        sink.add(data);
      },
      handleError: (
        Object error,
        StackTrace stackTrace,
        EventSink<Either<F, T>> sink,
      ) {
        // Convierte el error en un evento Left y lo emite como dato
        final failure = _mapExceptionToFailure(error) as F;
        sink.add(Left<F, T>(failure));
      },
    );
  }

  @override
  Future<Either<AdminAuthFailure, AdminUser?>> getCurrentAdminUser() async {
    try {
      final user = await _adminAuthService.getCurrentAdminUser();
      return Right(user);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, AdminUser>> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      final user = await _adminAuthService.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return Right(user);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, AdminUser>> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required List<String> ownedPlaceIds,
    AdminRole role = AdminRole.placeOwner,
    String? createdByUid,
  }) async {
    try {
      final user = await _adminAuthService.signUpWithEmailAndPassword(
        email: email,
        password: password,
        displayName: displayName,
        ownedPlaceIds: ownedPlaceIds,
        role: role,
        createdByUid: createdByUid,
      );
      return Right(user);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, Unit>> signOut() async {
    try {
      await _adminAuthService.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, Unit>> sendPasswordResetEmail(
    String email,
  ) async {
    try {
      await _adminAuthService.sendPasswordResetEmail(email);
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, Unit>> updateOwnedPlaces(
    String userId,
    List<String> placeIds, {
    String? updatedByUid,
  }) async {
    try {
      await _adminAuthService.updateOwnedPlaces(
        userId,
        placeIds,
        updatedByUid: updatedByUid,
      );
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, Unit>> updatePermissions(
    String userId,
    Map<String, List<Permission>> permissions, {
    String? updatedByUid,
  }) async {
    try {
      await _adminAuthService.updatePermissions(
        userId,
        permissions,
        updatedByUid: updatedByUid,
      );
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, Unit>> toggleUserStatus(
    String userId,
    bool isActive, {
    String? updatedByUid,
  }) async {
    try {
      await _adminAuthService.toggleUserStatus(
        userId,
        isActive,
        updatedByUid: updatedByUid,
      );
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, List<AdminUser>>> getAdminsByPlaceId(
    String placeId,
  ) async {
    try {
      final admins = await _adminAuthService.getAdminsByPlaceId(placeId);
      return Right(admins);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, List<AdminUser>>> getAllAdmins({
    String? requestedByUid,
  }) async {
    try {
      final admins = await _adminAuthService.getAllAdmins(
        requestedByUid: requestedByUid,
      );
      return Right(admins);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, AdminUsersStats>> getAdminUsersStats({
    String? requestedByUid,
  }) async {
    try {
      final stats = await _adminAuthService.getAdminUsersStats(
        requestedByUid: requestedByUid,
      );
      return Right(stats);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, List<AdminUser>>> searchAdminUsers({
    String? email,
    String? displayName,
    AdminRole? role,
    bool? isActive,
    String? requestedByUid,
  }) async {
    try {
      // Obtener todos los usuarios primero (con verificación de permisos)
      final allAdmins = await _adminAuthService.getAllAdmins(
        requestedByUid: requestedByUid,
      );

      // Aplicar filtros
      var filteredAdmins =
          allAdmins.where((admin) {
            if (email != null &&
                !admin.email.toLowerCase().contains(email.toLowerCase())) {
              return false;
            }
            if (displayName != null &&
                (admin.displayName?.toLowerCase().contains(
                      displayName.toLowerCase(),
                    ) !=
                    true)) {
              return false;
            }
            if (role != null && admin.role != role) {
              return false;
            }
            if (isActive != null && admin.isActive != isActive) {
              return false;
            }
            return true;
          }).toList();

      return Right(filteredAdmins);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
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
  }) async {
    try {
      final request = await _adminAuthService.submitBusinessOwnerRequest(
        userId: userId,
        displayName: displayName,
        businessName: businessName,
        businessDescription: businessDescription,
        businessAddress: businessAddress,
        phoneNumber: phoneNumber,
        website: website,
        businessMetadata: businessMetadata,
        contactInfo: contactInfo,
      );
      return Right(request);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, AdminUser>> approveBusinessOwnerRequest({
    required String requestId,
    required String approvedByUid,
    List<String>? initialPlaceIds,
    String? approvalNotes,
  }) async {
    try {
      final user = await _adminAuthService.approveBusinessOwnerRequest(
        requestId: requestId,
        approvedByUid: approvedByUid,
        initialPlaceIds: initialPlaceIds,
        approvalNotes: approvalNotes,
      );
      return Right(user);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, Unit>> rejectBusinessOwnerRequest({
    required String requestId,
    required String rejectedByUid,
    required String rejectionReason,
  }) async {
    try {
      await _adminAuthService.rejectBusinessOwnerRequest(
        requestId: requestId,
        rejectedByUid: rejectedByUid,
        rejectionReason: rejectionReason,
      );
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, Unit>> updateRequestStatus({
    required String requestId,
    required String updatedByUid,
    required BusinessOwnerRequestStatus newStatus,
    String? notes,
  }) async {
    try {
      await _adminAuthService.updateRequestStatus(
        requestId: requestId,
        updatedByUid: updatedByUid,
        newStatus: newStatus,
        notes: notes,
      );
      return const Right(unit);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, List<BusinessOwnerRequest>>>
  getAllBusinessOwnerRequests({
    String? requestedByUid,
    BusinessOwnerRequestStatus? filterByStatus,
  }) async {
    try {
      final requests = await _adminAuthService.getAllBusinessOwnerRequests(
        requestedByUid: requestedByUid,
        filterByStatus: filterByStatus,
      );
      return Right(requests);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, BusinessOwnerRequestStats>>
  getBusinessOwnerRequestStats({String? requestedByUid}) async {
    try {
      final stats = await _adminAuthService.getBusinessOwnerRequestStats(
        requestedByUid: requestedByUid,
      );
      return Right(stats);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  @override
  Future<Either<AdminAuthFailure, BusinessOwnerRequest?>>
  getBusinessOwnerRequestById(
    String requestId, {
    String? requestedByUid,
  }) async {
    try {
      final request = await _adminAuthService.getBusinessOwnerRequestById(
        requestId,
        requestedByUid: requestedByUid,
      );
      return Right(request);
    } catch (e) {
      return Left(_mapExceptionToFailure(e));
    }
  }

  // ================== MÉTODOS PRIVADOS ==================

  /// 🗺️ Mapea excepciones a fallos específicos del dominio
  AdminAuthFailure _mapExceptionToFailure(dynamic exception) {
    if (exception is AdminAuthException) {
      return AdminAuthFailure.custom(exception.message);
    }

    // Mapear excepciones específicas
    final message = exception.toString().toLowerCase();

    if (message.contains('network') || message.contains('connection')) {
      return const AdminAuthFailure.networkError();
    }

    if (message.contains('permission') || message.contains('unauthorized')) {
      return const AdminAuthFailure.insufficientPermissions();
    }

    if (message.contains('not found')) {
      return const AdminAuthFailure.userNotFound();
    }

    if (message.contains('invalid email')) {
      return const AdminAuthFailure.invalidEmail();
    }

    if (message.contains('weak password')) {
      return const AdminAuthFailure.weakPassword();
    }

    if (message.contains('email already in use')) {
      return const AdminAuthFailure.emailAlreadyInUse();
    }

    if (message.contains('wrong password')) {
      return const AdminAuthFailure.wrongPassword();
    }

    if (message.contains('too many requests')) {
      return const AdminAuthFailure.tooManyRequests();
    }

    // Fallo genérico para casos no manejados
    return AdminAuthFailure.custom('Error inesperado: ${exception.toString()}');
  }
}

/// 🚨 Tipos de fallos en autenticación administrativa
abstract class AdminAuthFailure {
  const AdminAuthFailure();

  // Errores de autenticación
  const factory AdminAuthFailure.invalidEmail() = InvalidEmailFailure;
  const factory AdminAuthFailure.weakPassword() = WeakPasswordFailure;
  const factory AdminAuthFailure.emailAlreadyInUse() = EmailAlreadyInUseFailure;
  const factory AdminAuthFailure.userNotFound() = UserNotFoundFailure;
  const factory AdminAuthFailure.wrongPassword() = WrongPasswordFailure;
  const factory AdminAuthFailure.userDisabled() = UserDisabledFailure;
  const factory AdminAuthFailure.tooManyRequests() = TooManyRequestsFailure;

  // Errores de autorización
  const factory AdminAuthFailure.insufficientPermissions() =
      InsufficientPermissionsFailure;
  const factory AdminAuthFailure.accountInactive() = AccountInactiveFailure;
  const factory AdminAuthFailure.notAuthorizedForAdminPanel() =
      NotAuthorizedForAdminPanelFailure;

  // Errores de red y sistema
  const factory AdminAuthFailure.networkError() = NetworkErrorFailure;
  const factory AdminAuthFailure.serverError() = ServerErrorFailure;
  const factory AdminAuthFailure.custom(String message) = CustomFailure;
}

// Implementaciones específicas de fallos
class InvalidEmailFailure extends AdminAuthFailure {
  const InvalidEmailFailure();
  @override
  String toString() => 'Email inválido';
}

class WeakPasswordFailure extends AdminAuthFailure {
  const WeakPasswordFailure();
  @override
  String toString() => 'La contraseña es muy débil';
}

class EmailAlreadyInUseFailure extends AdminAuthFailure {
  const EmailAlreadyInUseFailure();
  @override
  String toString() => 'El email ya está en uso';
}

class UserNotFoundFailure extends AdminAuthFailure {
  const UserNotFoundFailure();
  @override
  String toString() => 'Usuario no encontrado';
}

class WrongPasswordFailure extends AdminAuthFailure {
  const WrongPasswordFailure();
  @override
  String toString() => 'Contraseña incorrecta';
}

class UserDisabledFailure extends AdminAuthFailure {
  const UserDisabledFailure();
  @override
  String toString() => 'Cuenta deshabilitada';
}

class TooManyRequestsFailure extends AdminAuthFailure {
  const TooManyRequestsFailure();
  @override
  String toString() => 'Demasiados intentos, intenta más tarde';
}

class InsufficientPermissionsFailure extends AdminAuthFailure {
  const InsufficientPermissionsFailure();
  @override
  String toString() => 'Permisos insuficientes';
}

class AccountInactiveFailure extends AdminAuthFailure {
  const AccountInactiveFailure();
  @override
  String toString() => 'Cuenta inactiva';
}

class NotAuthorizedForAdminPanelFailure extends AdminAuthFailure {
  const NotAuthorizedForAdminPanelFailure();
  @override
  String toString() => 'No autorizado para admin panel';
}

class NetworkErrorFailure extends AdminAuthFailure {
  const NetworkErrorFailure();
  @override
  String toString() => 'Error de conexión';
}

class ServerErrorFailure extends AdminAuthFailure {
  const ServerErrorFailure();
  @override
  String toString() => 'Error del servidor';
}

class CustomFailure extends AdminAuthFailure {
  const CustomFailure(this.message);
  final String message;

  @override
  String toString() => message;
}
