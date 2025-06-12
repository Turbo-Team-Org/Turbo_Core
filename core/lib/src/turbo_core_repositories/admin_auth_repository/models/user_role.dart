import 'package:freezed_annotation/freezed_annotation.dart';

/// 🎭 Roles globales de usuario en Turbo Platform
enum UserRole {
  /// 👤 Usuario regular de la app móvil
  @JsonValue('regular')
  regular('regular', 'Usuario Regular'),

  /// 🏢 Propietario de negocio (acceso al panel admin)
  @JsonValue('business_owner')
  businessOwner('business_owner', 'Propietario de Negocio'),

  /// 🔑 Super administrador (acceso completo)
  @JsonValue('super_admin')
  superAdmin('super_admin', 'Super Administrador');

  const UserRole(this.value, this.displayName);

  final String value;
  final String displayName;

  /// 🔍 Obtener rol desde string
  static UserRole fromString(String value) {
    return UserRole.values.firstWhere(
      (role) => role.value == value,
      orElse: () => UserRole.regular,
    );
  }

  /// 🎯 Verificar si tiene acceso al panel admin
  bool get hasAdminAccess => this != UserRole.regular;

  /// 🔑 Verificar si es super admin
  bool get isSuperAdmin => this == UserRole.superAdmin;

  /// 🏢 Verificar si es business owner
  bool get isBusinessOwner => this == UserRole.businessOwner;
}
