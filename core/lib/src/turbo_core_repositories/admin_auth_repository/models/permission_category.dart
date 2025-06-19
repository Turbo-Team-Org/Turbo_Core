// ignore_for_file: public_member_api_docs

/// 📂 Categorías de permisos para mejor organización en UI
enum PermissionCategory {
  place,
  events,
  reviews,
  analytics,
  offers,
  media,
  system,
}

extension PermissionCategoryExtensions on PermissionCategory {
  String get displayName {
    switch (this) {
      case PermissionCategory.place:
        return 'Gestión de Lugar';
      case PermissionCategory.events:
        return 'Eventos';
      case PermissionCategory.reviews:
        return 'Reseñas';
      case PermissionCategory.analytics:
        return 'Analytics';
      case PermissionCategory.offers:
        return 'Ofertas';
      case PermissionCategory.media:
        return 'Multimedia';
      case PermissionCategory.system:
        return 'Sistema';
    }
  }
}
