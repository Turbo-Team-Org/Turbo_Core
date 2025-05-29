import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_user.freezed.dart';
part 'admin_user.g.dart';

/// 🏢 Modelo de Usuario Administrativo para Turbo Platform
///
/// Representa usuarios que pueden gestionar lugares específicos
/// en el Admin Panel (propietarios) o tener acceso global (superAdmin)
@freezed
sealed class AdminUser with _$AdminUser {
  const AdminUser._();

  const factory AdminUser({
    required String uid,
    required String email,
    String? displayName,
    @Default(AdminRole.placeOwner) AdminRole role,
    @Default([]) List<String> ownedPlaceIds,
    @Default({}) Map<String, List<Permission>> permissions,
    required DateTime createdAt,
    DateTime? lastLogin,
    @Default(true) bool isActive,
    String? photoUrl,
    String? phoneNumber,
    @Default({}) Map<String, dynamic> metadata,
  }) = _AdminUser;

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);

  /// 🔍 Verifica si puede administrar un lugar específico
  bool canManagePlace(String placeId) {
    // Super administradores pueden gestionar cualquier lugar
    if (role == AdminRole.superAdmin) return true;

    // Propietarios solo pueden gestionar sus lugares asignados
    return ownedPlaceIds.contains(placeId);
  }

  /// 🔑 Verifica si tiene un permiso específico para un lugar
  bool hasPermission(String placeId, Permission permission) {
    // Super administradores tienen todos los permisos
    if (role == AdminRole.superAdmin) return true;

    // Verificar si puede gestionar el lugar primero
    if (!canManagePlace(placeId)) return false;

    // Verificar permisos específicos para el lugar
    final placePermissions = permissions[placeId] ?? [];
    return placePermissions.contains(permission);
  }

  /// 📋 Obtiene lista de lugares que puede administrar
  List<String> getManageablePlaceIds() {
    return role == AdminRole.superAdmin
        ? [] // Los super admins manejan todos, lista vacía significa "todos"
        : ownedPlaceIds;
  }

  /// 🎯 Verifica si tiene permisos globales (super admin)
  bool get hasGlobalAccess => role == AdminRole.superAdmin;

  /// 📊 Obtiene permisos totales únicos
  Set<Permission> get allPermissions {
    if (role == AdminRole.superAdmin) {
      return Permission.values.toSet();
    }

    return permissions.values.expand((perms) => perms).toSet();
  }

  /// 🕐 Verifica si el usuario está activo y puede acceder
  bool get canAccess => isActive;

  /// 📈 Convierte a Map para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'role': role.name,
      'ownedPlaceIds': ownedPlaceIds,
      'permissions': permissions.map(
        (placeId, perms) =>
            MapEntry(placeId, perms.map((p) => p.name).toList()),
      ),
      'createdAt': Timestamp.fromDate(createdAt),
      'lastLogin': lastLogin != null ? Timestamp.fromDate(lastLogin!) : null,
      'isActive': isActive,
      'photoUrl': photoUrl,
      'phoneNumber': phoneNumber,
      'metadata': metadata,
    };
  }

  /// 📥 Crea desde documento de Firestore
  factory AdminUser.fromFirestore(Map<String, dynamic> data) {
    return AdminUser(
      uid: data['uid'] as String,
      email: data['email'] as String,
      displayName: data['displayName'] as String?,
      role: AdminRole.values.firstWhere(
        (r) => r.name == data['role'],
        orElse: () => AdminRole.placeOwner,
      ),
      ownedPlaceIds: List<String>.from(
        data['ownedPlaceIds'] as List<dynamic>? ?? [],
      ),
      permissions: _parsePermissions(
        data['permissions'] as Map<String, dynamic>? ?? {},
      ),
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      lastLogin:
          data['lastLogin'] != null
              ? (data['lastLogin'] as Timestamp).toDate()
              : null,
      isActive: data['isActive'] as bool? ?? true,
      photoUrl: data['photoUrl'] as String?,
      phoneNumber: data['phoneNumber'] as String?,
      metadata: Map<String, dynamic>.from(
        data['metadata'] as Map<dynamic, dynamic>? ?? {},
      ),
    );
  }

  /// 🔧 Helper para parsear permisos desde Firestore
  static Map<String, List<Permission>> _parsePermissions(
    Map<String, dynamic> data,
  ) {
    return data.map((placeId, perms) {
      final permissionsList =
          (perms as List<dynamic>)
              .map(
                (p) => Permission.values.firstWhere(
                  (permission) => permission.name == p,
                  orElse: () => Permission.readPlace,
                ),
              )
              .toList();
      return MapEntry(placeId, permissionsList);
    });
  }
}

/// 👑 Roles disponibles para usuarios administrativos
enum AdminRole {
  /// 🏢 Propietario de lugar - puede gestionar solo sus lugares asignados
  placeOwner,

  /// 👑 Super Administrador - acceso global a toda la plataforma
  superAdmin,
}

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
