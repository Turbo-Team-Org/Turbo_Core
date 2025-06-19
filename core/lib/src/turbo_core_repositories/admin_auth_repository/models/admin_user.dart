// ignore_for_file: public_member_api_docs

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/admin_auth_repository_imports.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin_user.freezed.dart';
part 'admin_user.g.dart';

/// 🏢 Modelo de Usuario Administrativo para Turbo Platform
///
/// Representa usuarios que pueden gestionar lugares específicos
/// en el Admin Panel (propietarios) o tener acceso global (superAdmin)
@freezed
sealed class AdminUser with _$AdminUser {
  const factory AdminUser({
    required String uid,
    required String email,
    required DateTime createdAt,
    String? displayName,
    @Default(AdminRole.placeOwner) AdminRole role,
    @Default([]) List<String> ownedPlaceIds,
    @Default({}) Map<String, List<Permission>> permissions,
    DateTime? lastLogin,
    @Default(true) bool isActive,
    String? photoUrl,
    String? phoneNumber,
    @Default({}) Map<String, dynamic> metadata,
  }) = _AdminUser;

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
  const AdminUser._();

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
