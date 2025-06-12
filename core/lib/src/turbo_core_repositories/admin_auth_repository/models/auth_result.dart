import 'package:freezed_annotation/freezed_annotation.dart';
import 'admin_user.dart';
import 'business_owner_request.dart';

part 'auth_result.freezed.dart';

/// 🎯 Resultado de autenticación unificada
///
/// Permite manejar diferentes tipos de usuarios que pueden
/// acceder al sistema administrativo
@freezed
sealed class AuthResult with _$AuthResult {
  /// 👑 Usuario administrador (Super Admin o Place Owner aprobado)
  const factory AuthResult.admin(AdminUser user) = AuthResultAdmin;

  /// 🏢 Business Owner (con solicitud en cualquier estado)
  const factory AuthResult.businessOwner(BusinessOwnerRequest request) =
      AuthResultBusinessOwner;
}

/// 🎭 Extensiones útiles para AuthResult
extension AuthResultExtensions on AuthResult {
  /// 🔍 Verificar si es administrador
  bool get isAdmin => this is AuthResultAdmin;

  /// 🏢 Verificar si es business owner
  bool get isBusinessOwner => this is AuthResultBusinessOwner;

  /// 👤 Obtener email del usuario
  String get email => switch (this) {
    AuthResultAdmin(user: final user) => user.email,
    AuthResultBusinessOwner(request: final request) => request.email,
  };

  /// 📛 Obtener nombre para mostrar
  String get displayName => switch (this) {
    AuthResultAdmin(user: final user) => user.displayName ?? 'Admin',
    AuthResultBusinessOwner(request: final request) => request.displayName,
  };

  /// 🆔 Obtener UID del usuario
  String get uid => switch (this) {
    AuthResultAdmin(user: final user) => user.uid,
    AuthResultBusinessOwner(request: final request) => request.userId,
  };
}
