// ignore_for_file: public_member_api_docs

import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/permission_category.dart';

/// 🔑 Permisos granulares para cada lugar
enum Permission {
  /// 👁️ Ver información básica del lugar
  readPlace,

  /// ✏️ Editar información del lugar
  editPlace,

  /// 🗑️ Eliminar lugar (solo super admin)
  deletePlace,

  /// 🎯 Gestionar eventos del lugar
  manageEvents,

  /// 📖 Ver reviews del lugar
  viewReviews,

  /// 🛡️ Moderar reviews (aprobar/rechazar)
  moderateReviews,

  /// 📊 Ver analytics del lugar
  viewAnalytics,

  /// 📈 Ver analytics detallados (tráfico, conversiones)
  viewDetailedAnalytics,

  /// 🏷️ Gestionar ofertas del lugar
  manageOffers,

  /// 📸 Gestionar imágenes del lugar
  manageMedia,

  /// 👥 Gestionar usuarios (solo super admin)
  manageUsers,

  /// ⚙️ Configuración avanzada (solo super admin)
  systemConfiguration,
}

/// 🔑 Extensiones útiles para Permission
extension PermissionExtensions on Permission {
  /// 🏷️ Nombre legible del permiso
  String get displayName {
    switch (this) {
      case Permission.readPlace:
        return 'Ver lugar';
      case Permission.editPlace:
        return 'Editar lugar';
      case Permission.deletePlace:
        return 'Eliminar lugar';
      case Permission.manageEvents:
        return 'Gestionar eventos';
      case Permission.viewReviews:
        return 'Ver reseñas';
      case Permission.moderateReviews:
        return 'Moderar reseñas';
      case Permission.viewAnalytics:
        return 'Ver analytics';
      case Permission.viewDetailedAnalytics:
        return 'Analytics detallados';
      case Permission.manageOffers:
        return 'Gestionar ofertas';
      case Permission.manageMedia:
        return 'Gestionar multimedia';
      case Permission.manageUsers:
        return 'Gestionar usuarios';
      case Permission.systemConfiguration:
        return 'Configuración del sistema';
    }
  }

  /// 📝 Descripción del permiso
  String get description {
    switch (this) {
      case Permission.readPlace:
        return 'Permite ver la información básica del lugar';
      case Permission.editPlace:
        return 'Permite modificar la información del lugar';
      case Permission.deletePlace:
        return 'Permite eliminar el lugar permanentemente';
      case Permission.manageEvents:
        return 'Permite crear, editar y eliminar eventos';
      case Permission.viewReviews:
        return 'Permite ver las reseñas de los usuarios';
      case Permission.moderateReviews:
        return 'Permite aprobar, rechazar o eliminar reseñas';
      case Permission.viewAnalytics:
        return 'Permite ver métricas básicas del lugar';
      case Permission.viewDetailedAnalytics:
        return 'Permite ver analytics avanzados y reportes';
      case Permission.manageOffers:
        return 'Permite crear y gestionar ofertas especiales';
      case Permission.manageMedia:
        return 'Permite subir y gestionar imágenes y videos';
      case Permission.manageUsers:
        return 'Permite gestionar otros usuarios administrativos';
      case Permission.systemConfiguration:
        return 'Permite modificar configuraciones del sistema';
    }
  }

  /// 🚨 Indica si es un permiso peligroso
  bool get isDangerous {
    return [
      Permission.deletePlace,
      Permission.manageUsers,
      Permission.systemConfiguration,
    ].contains(this);
  }

  /// 🎯 Categoría del permiso
  PermissionCategory get category {
    switch (this) {
      case Permission.readPlace:
      case Permission.editPlace:
      case Permission.deletePlace:
        return PermissionCategory.place;
      case Permission.manageEvents:
        return PermissionCategory.events;
      case Permission.viewReviews:
      case Permission.moderateReviews:
        return PermissionCategory.reviews;
      case Permission.viewAnalytics:
      case Permission.viewDetailedAnalytics:
        return PermissionCategory.analytics;
      case Permission.manageOffers:
        return PermissionCategory.offers;
      case Permission.manageMedia:
        return PermissionCategory.media;
      case Permission.manageUsers:
      case Permission.systemConfiguration:
        return PermissionCategory.system;
    }
  }
}
