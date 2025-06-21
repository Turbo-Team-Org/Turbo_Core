// ignore_for_file: public_member_api_docs

import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/permission.dart';

/// 👑 Roles disponibles para usuarios administrativos
enum AdminRole {
  /// 🏢 Propietario de lugar - puede gestionar solo sus lugares asignados
  placeOwner,

  /// 👑 Super Administrador - acceso global a toda la plataforma
  superAdmin,
}

/// 🎯 Extensiones útiles para AdminRole
extension AdminRoleExtensions on AdminRole {
  /// 📋 Permisos por defecto según el rol
  Set<Permission> get defaultPermissions {
    switch (this) {
      case AdminRole.placeOwner:
        return {
          Permission.readPlace,
          Permission.editPlace,
          Permission.manageEvents,
          Permission.viewReviews,
          Permission.moderateReviews,
          Permission.viewAnalytics,
          Permission.manageOffers,
          Permission.manageMedia,
        };
      case AdminRole.superAdmin:
        return Permission.values.toSet();
    }
  }

  /// 🏷️ Nombre legible del rol
  String get displayName {
    switch (this) {
      case AdminRole.placeOwner:
        return 'Propietario de Lugar';
      case AdminRole.superAdmin:
        return 'Super Administrador';
    }
  }

  /// 🎨 Color representativo del rol
  String get colorHex {
    switch (this) {
      case AdminRole.placeOwner:
        return '#2196F3'; // Azul
      case AdminRole.superAdmin:
        return '#FF5722'; // Rojo/Naranja
    }
  }
}
