import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/models/admin_user.dart';
import 'package:firebase_auth/firebase_auth.dart';

/// 🔐 Servicio de Autenticación Administrativa
///
/// Maneja toda la lógica de autenticación y autorización específica
/// para usuarios administrativos del Admin Panel de Turbo
class AdminAuthService {
  AdminAuthService({
    required FirebaseFirestore firestore,
    required FirebaseAuth firebaseAuth,
  }) : _firestore = firestore,
       _firebaseAuth = firebaseAuth;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _firebaseAuth;

  /// 📚 Referencia a la colección de usuarios administrativos
  CollectionReference<Map<String, dynamic>> get _adminUsersRef =>
      _firestore.collection('admin_users');

  /// 🔄 Stream del estado de autenticación
  Stream<AdminUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return await getAdminUserByUid(user.uid);
    });
  }

  /// 👤 Obtiene el usuario administrativo actual
  Future<AdminUser?> getCurrentAdminUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return await getAdminUserByUid(user.uid);
  }

  /// 🔍 Obtiene un usuario administrativo por UID
  Future<AdminUser?> getAdminUserByUid(String uid) async {
    try {
      final doc = await _adminUsersRef.doc(uid).get();

      if (!doc.exists) return null;

      final data = doc.data()!;
      return AdminUser.fromFirestore(data);
    } catch (e) {
      throw AdminAuthException('Error obteniendo usuario: $e');
    }
  }

  /// 🔐 Inicia sesión con email y contraseña
  Future<AdminUser> signInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      // 1. Autenticar con Firebase Auth
      final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw AdminAuthException('Error en autenticación');
      }

      // 2. Verificar que existe en admin_users
      final adminUser = await getAdminUserByUid(firebaseUser.uid);
      if (adminUser == null) {
        // Cerrar sesión si no es usuario administrativo
        await _firebaseAuth.signOut();
        throw AdminAuthException('Usuario no autorizado para admin panel');
      }

      // 3. Verificar que está activo
      if (!adminUser.isActive) {
        await _firebaseAuth.signOut();
        throw AdminAuthException('Cuenta desactivada');
      }

      // 4. Actualizar último login
      await _updateLastLogin(adminUser.uid);

      return adminUser.copyWith(lastLogin: DateTime.now());
    } on FirebaseAuthException catch (e) {
      throw AdminAuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AdminAuthException('Error de autenticación: $e');
    }
  }

  /// 📝 Registra un nuevo usuario administrativo
  Future<AdminUser> signUpWithEmailAndPassword({
    required String email,
    required String password,
    required String displayName,
    required List<String> ownedPlaceIds,
    AdminRole role = AdminRole.placeOwner,
    String? createdByUid, // UID del super admin que lo crea
  }) async {
    try {
      // 1. Verificar permisos del creador (si aplica)
      if (createdByUid != null) {
        final creator = await getAdminUserByUid(createdByUid);
        if (creator?.role != AdminRole.superAdmin) {
          throw AdminAuthException(
            'Solo super administradores pueden crear usuarios',
          );
        }
      }

      // 2. Crear usuario en Firebase Auth
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      final firebaseUser = userCredential.user;
      if (firebaseUser == null) {
        throw AdminAuthException('Error creando usuario');
      }

      // 3. Actualizar perfil de Firebase
      await firebaseUser.updateDisplayName(displayName);

      // 4. Crear documento en admin_users
      final adminUser = AdminUser(
        uid: firebaseUser.uid,
        email: email,
        displayName: displayName,
        role: role,
        ownedPlaceIds: ownedPlaceIds,
        permissions: _generateDefaultPermissions(ownedPlaceIds, role),
        createdAt: DateTime.now(),
        isActive: true,
      );

      await _adminUsersRef.doc(firebaseUser.uid).set(adminUser.toFirestore());

      return adminUser;
    } on FirebaseAuthException catch (e) {
      throw AdminAuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AdminAuthException('Error en registro: $e');
    }
  }

  /// 🚪 Cerrar sesión
  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
    } catch (e) {
      throw AdminAuthException('Error cerrando sesión: $e');
    }
  }

  /// 📧 Enviar email de recuperación de contraseña
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw AdminAuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AdminAuthException('Error enviando email: $e');
    }
  }

  /// 🏢 Actualiza lugares asignados a un usuario
  Future<void> updateOwnedPlaces(
    String userId,
    List<String> placeIds, {
    String? updatedByUid,
  }) async {
    try {
      // Verificar permisos del actualizador
      if (updatedByUid != null) {
        final updater = await getAdminUserByUid(updatedByUid);
        if (updater?.role != AdminRole.superAdmin) {
          throw AdminAuthException(
            'Solo super administradores pueden modificar lugares',
          );
        }
      }

      final currentUser = await getAdminUserByUid(userId);
      if (currentUser == null) {
        throw AdminAuthException('Usuario no encontrado');
      }

      // Generar nuevos permisos para los lugares actualizados
      final newPermissions = _generateDefaultPermissions(
        placeIds,
        currentUser.role,
      );

      await _adminUsersRef.doc(userId).update({
        'ownedPlaceIds': placeIds,
        'permissions': newPermissions.map(
          (placeId, perms) =>
              MapEntry(placeId, perms.map((p) => p.name).toList()),
        ),
      });
    } catch (e) {
      throw AdminAuthException('Error actualizando lugares: $e');
    }
  }

  /// 🔑 Actualiza permisos específicos de un usuario
  Future<void> updatePermissions(
    String userId,
    Map<String, List<Permission>> permissions, {
    String? updatedByUid,
  }) async {
    try {
      // Verificar permisos del actualizador
      if (updatedByUid != null) {
        final updater = await getAdminUserByUid(updatedByUid);
        if (updater?.role != AdminRole.superAdmin) {
          throw AdminAuthException(
            'Solo super administradores pueden modificar permisos',
          );
        }
      }

      await _adminUsersRef.doc(userId).update({
        'permissions': permissions.map(
          (placeId, perms) =>
              MapEntry(placeId, perms.map((p) => p.name).toList()),
        ),
      });
    } catch (e) {
      throw AdminAuthException('Error actualizando permisos: $e');
    }
  }

  /// 🔄 Cambiar estado activo/inactivo de usuario
  Future<void> toggleUserStatus(
    String userId,
    bool isActive, {
    String? updatedByUid,
  }) async {
    try {
      // Verificar permisos del actualizador
      if (updatedByUid != null) {
        final updater = await getAdminUserByUid(updatedByUid);
        if (updater?.role != AdminRole.superAdmin) {
          throw AdminAuthException(
            'Solo super administradores pueden cambiar estado',
          );
        }
      }

      await _adminUsersRef.doc(userId).update({'isActive': isActive});
    } catch (e) {
      throw AdminAuthException('Error actualizando estado: $e');
    }
  }

  /// 🏢 Obtiene administradores de un lugar específico
  Future<List<AdminUser>> getAdminsByPlaceId(String placeId) async {
    try {
      final query =
          await _adminUsersRef
              .where('ownedPlaceIds', arrayContains: placeId)
              .where('isActive', isEqualTo: true)
              .get();

      return query.docs
          .map((doc) => AdminUser.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      throw AdminAuthException('Error obteniendo administradores: $e');
    }
  }

  /// 👥 Obtiene todos los usuarios administrativos (solo superAdmin)
  Future<List<AdminUser>> getAllAdmins({String? requestedByUid}) async {
    try {
      // Verificar permisos
      if (requestedByUid != null) {
        final requester = await getAdminUserByUid(requestedByUid);
        if (requester?.role != AdminRole.superAdmin) {
          throw AdminAuthException(
            'Solo super administradores pueden ver todos los usuarios',
          );
        }
      }

      final query = await _adminUsersRef.get();

      return query.docs
          .map((doc) => AdminUser.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      throw AdminAuthException('Error obteniendo usuarios: $e');
    }
  }

  /// 📊 Obtiene estadísticas de usuarios administrativos
  Future<AdminUsersStats> getAdminUsersStats({String? requestedByUid}) async {
    try {
      // Verificar permisos
      if (requestedByUid != null) {
        final requester = await getAdminUserByUid(requestedByUid);
        if (requester?.role != AdminRole.superAdmin) {
          throw AdminAuthException(
            'Solo super administradores pueden ver estadísticas',
          );
        }
      }

      final query = await _adminUsersRef.get();
      final users =
          query.docs.map((doc) => AdminUser.fromFirestore(doc.data())).toList();

      return AdminUsersStats.fromUsers(users);
    } catch (e) {
      throw AdminAuthException('Error obteniendo estadísticas: $e');
    }
  }

  // ================== MÉTODOS PRIVADOS ==================

  /// 🕐 Actualiza la fecha de último login
  Future<void> _updateLastLogin(String uid) async {
    await _adminUsersRef.doc(uid).update({
      'lastLogin': Timestamp.fromDate(DateTime.now()),
    });
  }

  /// 🔑 Genera permisos por defecto según rol y lugares
  Map<String, List<Permission>> _generateDefaultPermissions(
    List<String> placeIds,
    AdminRole role,
  ) {
    final defaultPerms = role.defaultPermissions.toList();

    return Map.fromEntries(
      placeIds.map((placeId) => MapEntry(placeId, defaultPerms)),
    );
  }

  /// 📝 Convierte códigos de error de Firebase a mensajes legibles
  String _getAuthErrorMessage(String code) {
    switch (code) {
      case 'user-not-found':
        return 'Usuario no encontrado';
      case 'wrong-password':
        return 'Contraseña incorrecta';
      case 'email-already-in-use':
        return 'El email ya está en uso';
      case 'weak-password':
        return 'La contraseña es muy débil';
      case 'invalid-email':
        return 'Email inválido';
      case 'user-disabled':
        return 'Usuario deshabilitado';
      case 'too-many-requests':
        return 'Demasiados intentos, intenta más tarde';
      default:
        return 'Error de autenticación: $code';
    }
  }
}

/// 📊 Estadísticas de usuarios administrativos
class AdminUsersStats {
  const AdminUsersStats({
    required this.totalUsers,
    required this.activeUsers,
    required this.placeOwners,
    required this.superAdmins,
    required this.usersCreatedThisMonth,
    required this.lastLoginStats,
  });

  final int totalUsers;
  final int activeUsers;
  final int placeOwners;
  final int superAdmins;
  final int usersCreatedThisMonth;
  final Map<String, int> lastLoginStats; // 'today', 'week', 'month', 'older'

  factory AdminUsersStats.fromUsers(List<AdminUser> users) {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
    final startOfDay = DateTime(now.year, now.month, now.day);

    var usersCreatedThisMonth = 0;
    var todayLogins = 0;
    var weekLogins = 0;
    var monthLogins = 0;
    var olderLogins = 0;

    for (final user in users) {
      // Contar usuarios creados este mes
      if (user.createdAt.isAfter(startOfMonth)) {
        usersCreatedThisMonth++;
      }

      // Contar últimos logins
      final lastLogin = user.lastLogin;
      if (lastLogin != null) {
        if (lastLogin.isAfter(startOfDay)) {
          todayLogins++;
        } else if (lastLogin.isAfter(startOfWeek)) {
          weekLogins++;
        } else if (lastLogin.isAfter(startOfMonth)) {
          monthLogins++;
        } else {
          olderLogins++;
        }
      }
    }

    return AdminUsersStats(
      totalUsers: users.length,
      activeUsers: users.where((u) => u.isActive).length,
      placeOwners: users.where((u) => u.role == AdminRole.placeOwner).length,
      superAdmins: users.where((u) => u.role == AdminRole.superAdmin).length,
      usersCreatedThisMonth: usersCreatedThisMonth,
      lastLoginStats: {
        'today': todayLogins,
        'week': weekLogins,
        'month': monthLogins,
        'older': olderLogins,
      },
    );
  }
}

/// ⚠️ Excepción personalizada para errores de autenticación administrativa
class AdminAuthException implements Exception {
  const AdminAuthException(this.message);

  final String message;

  @override
  String toString() => 'AdminAuthException: $message';
}
