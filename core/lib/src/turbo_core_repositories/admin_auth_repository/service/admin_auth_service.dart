// ignore_for_file: public_member_api_docs

import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/admin_auth_repository/admin_auth_repository_imports.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/service/authentication_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uuid/uuid.dart';

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

  /// 📝 Referencia a la colección de solicitudes de business owners
  CollectionReference<Map<String, dynamic>> get _businessOwnerRequestsRef =>
      _firestore.collection('business_owner_requests');

  /// 🆔 Generador de IDs únicos
  static const _uuid = Uuid();

  /// 🔄 Stream del estado de autenticación
  Stream<AdminUser?> get authStateChanges {
    return _firebaseAuth.authStateChanges().asyncMap((user) async {
      if (user == null) return null;
      return await getAdminUserByUidField(user.uid);
    });
  }

  /// 👤 Obtiene el usuario administrativo actual
  Future<AdminUser?> getCurrentAdminUser() async {
    final user = _firebaseAuth.currentUser;
    if (user == null) return null;

    return getAdminUserByUidField(user.uid);
  }

  /// 🔍 Obtiene un usuario administrativo por UID (busca por document ID)
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

  /// 🔍 Obtiene un usuario administrativo buscando por campo 'uid' en la colección
  Future<AdminUser?> getAdminUserByUidField(String uid) async {
    try {
      final query =
          await _adminUsersRef.where('uid', isEqualTo: uid).limit(1).get();

      if (query.docs.isEmpty) return null;

      final data = query.docs.first.data();
      return AdminUser.fromFirestore(data);
    } catch (e) {
      throw AdminAuthException('Error obteniendo usuario por campo uid: $e');
    }
  }

  /// 🔐 Login unificado que determina el tipo de usuario automáticamente
  Future<AuthResult> signInUnified({
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
        throw const AdminAuthException('Error en autenticación');
      }

      // 2. Verificar en orden de prioridad:

      // A. ¿Es Super Admin o Admin aprobado? (Buscar por campo uid)
      final adminUser = await getAdminUserByUidField(firebaseUser.uid);
      if (adminUser != null) {
        return AuthResult.admin(adminUser.copyWith(lastLogin: DateTime.now()));
      }

      // B. ¿Es Business Owner (con solicitud)?
      final businessOwnerRequest = await getBusinessOwnerById(firebaseUser.uid);
      if (businessOwnerRequest != null) {
        return AuthResult.businessOwner(
          businessOwnerRequest.copyWith(lastLogin: DateTime.now()),
        );
      }

      // C. Usuario no autorizado para admin panel
      await _firebaseAuth.signOut();
      throw const AdminAuthException('Usuario no autorizado para admin panel');
    } on FirebaseAuthException catch (e) {
      throw AdminAuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AdminAuthException('Error de autenticación: $e');
    }
  }

  /// 🔐 Inicia sesión con email y contraseña (solo para admins aprobados)
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
        throw const AdminAuthException('Error en autenticación');
      }

      // 2. Verificar que sea un admin aprobado (Buscar por campo uid)
      final adminUser = await getAdminUserByUidField(firebaseUser.uid);
      if (adminUser == null) {
        await _firebaseAuth.signOut();
        throw const AdminAuthException(
          'Usuario no autorizado para admin panel',
        );
      }

      // 3. Verificar que esté activo
      if (!adminUser.isActive) {
        await _firebaseAuth.signOut();
        throw const AdminAuthException('Cuenta inactiva');
      }

      // 4. Actualizar último login
      await _updateLastLogin(_adminUsersRef, adminUser.uid);

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
          throw const AdminAuthException(
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
        throw const AdminAuthException('Error creando usuario');
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
          throw const AdminAuthException(
            'Solo super administradores pueden modificar lugares',
          );
        }
      }

      final currentUser = await getAdminUserByUid(userId);
      if (currentUser == null) {
        throw const AdminAuthException('Usuario no encontrado');
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
          throw const AdminAuthException(
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
          throw const AdminAuthException(
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
          throw const AdminAuthException(
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
          throw const AdminAuthException(
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

  // ==================== AUTO-REGISTRO DE BUSINESS OWNERS ====================
  /// 🆕 Solicitar registro como business owner (usuario ya registrado)
  Future<BusinessOwnerRequest> submitBusinessOwnerRequest({
    required String userId, // UID del usuario ya registrado
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
      // 1. Verificar que el usuario existe y está autenticado
      final currentUser = _firebaseAuth.currentUser;
      if (currentUser == null || currentUser.uid != userId) {
        throw const AdminAuthException(
          'Usuario no autenticado o ID no coincide',
        );
      }

      // 2. Verificar que no es ya un usuario administrativo
      final existingAdmin = await getAdminUserByUidField(userId);
      if (existingAdmin != null) {
        throw const AdminAuthException('El usuario ya es un administrador');
      }

      // 3. Verificar que no hay solicitud pendiente para este usuario
      final existingRequestQuery =
          await _businessOwnerRequestsRef
              .where('userId', isEqualTo: userId)
              .where(
                'status',
                whereIn: [
                  BusinessOwnerRequestStatus.pending.name,
                  BusinessOwnerRequestStatus.reviewing.name,
                  BusinessOwnerRequestStatus.needsMoreInfo.name,
                ],
              )
              .get();

      if (existingRequestQuery.docs.isNotEmpty) {
        throw const AdminAuthException(
          'Ya tienes una solicitud pendiente para convertirte en propietario',
        );
      }

      // 4. Crear la solicitud de registro
      final requestId = _uuid.v4();
      final request = BusinessOwnerRequest(
        id: requestId,
        userId: userId, // Nuevo campo para el UID del usuario
        email: currentUser.email ?? '',
        displayName: displayName,
        businessName: businessName,
        businessDescription: businessDescription,
        businessAddress: businessAddress,
        phoneNumber: phoneNumber,
        website: website,
        // ignore: avoid_redundant_argument_values
        status: BusinessOwnerRequestStatus.pending,
        createdAt: DateTime.now(),
        businessMetadata: businessMetadata ?? {},
        contactInfo: contactInfo ?? {},
      );

      // 5. Guardar en Firestore
      await _businessOwnerRequestsRef.doc(requestId).set(request.toFirestore());

      // 6. Notificar a super administradores
      // await _notifySuperAdminsNewRequest(request);

      return request;
    } catch (e) {
      throw AdminAuthException('Error enviando solicitud: $e');
    }
  }

  /// 🔐 Inicia sesión con email y contraseña para business owners
  Future<BusinessOwnerRequest> signInWithEmailAndPasswordBusinessOwner({
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
        throw const AdminAuthException('Error en autenticación');
      }

      // 2. Verificar que existe en business_owner_requests
      final businessOwnerRequest = await getBusinessOwnerById(firebaseUser.uid);
      if (businessOwnerRequest == null) {
        // Cerrar sesión si no es usuario administrativo
        await _firebaseAuth.signOut();
        throw const AdminAuthException(
          'Usuario no autorizado para business owner',
        );
      }

      // 4. Actualizar último login
      await _updateLastLogin(_businessOwnerRequestsRef, firebaseUser.uid);

      return businessOwnerRequest.copyWith(lastLogin: DateTime.now());
    } on FirebaseAuthException catch (e) {
      throw AdminAuthException(_getAuthErrorMessage(e.code));
    } catch (e) {
      throw AdminAuthException('Error de autenticación: $e');
    }
  }

  /// 🔍 Obtener solicitud por userId (uid del usuario)
  Future<BusinessOwnerRequest?> getBusinessOwnerById(String userId) async {
    try {
      // Buscar en la colección por la propiedad userId
      final query =
          await _businessOwnerRequestsRef
              .where('userId', isEqualTo: userId)
              .limit(1)
              .get();

      if (query.docs.isEmpty) return null;

      final data = query.docs.first.data();
      return BusinessOwnerRequest.fromFirestore(data);
    } catch (e) {
      throw AdminAuthException('Error obteniendo solicitud por userId: $e');
    }
  }

  /// ✅ Aprobar solicitud de business owner
  Future<AdminUser> approveBusinessOwnerRequest({
    required String requestId,
    required String approvedByUid,
    List<String>? initialPlaceIds,
    String? approvalNotes,
  }) async {
    try {
      // 1. Verificar permisos del aprobador
      final approver = await getAdminUserByUidField(approvedByUid);
      if (approver?.role != AdminRole.superAdmin) {
        throw const AdminAuthException(
          'Solo super administradores pueden aprobar solicitudes',
        );
      }

      // 2. Obtener la solicitud
      final requestDoc = await _businessOwnerRequestsRef.doc(requestId).get();
      if (!requestDoc.exists) {
        throw const AdminAuthException('Solicitud no encontrada');
      }

      final request = BusinessOwnerRequest.fromFirestore(requestDoc.data()!);

      // 3. Verificar que está pendiente
      if (!request.isPending &&
          request.status != BusinessOwnerRequestStatus.reviewing) {
        throw const AdminAuthException(
          'La solicitud no está pendiente de aprobación',
        );
      }

      // 4. Verificar que el usuario original aún existe
      final userDoc =
          await _firestore.collection('users').doc(request.userId).get();
      if (!userDoc.exists) {
        throw const AdminAuthException('El usuario original ya no existe');
      }

      // 5. Crear usuario administrativo (convertir usuario regular en admin)
      final adminUser = AdminUser(
        uid: request.userId, // Usar el UID del usuario existente
        email: request.email,
        displayName: request.displayName,
        role: AdminRole.placeOwner,
        ownedPlaceIds: initialPlaceIds ?? [],
        permissions: _generateDefaultPermissions(
          initialPlaceIds ?? [],
          AdminRole.placeOwner,
        ),
        createdAt: DateTime.now(),
        isActive: true,
        phoneNumber: request.phoneNumber,
        metadata: {
          'approvedBy': approvedByUid,
          'approvedAt': DateTime.now().toIso8601String(),
          'originalRequestId': requestId,
          'businessName': request.businessName,
          'businessMetadata': request.businessMetadata,
          'convertedFromUserId': request.userId,
        },
      );

      // 6. Guardar usuario administrativo
      await _adminUsersRef.doc(request.userId).set(adminUser.toFirestore());

      // 7. Actualizar estado de solicitud
      await _businessOwnerRequestsRef.doc(requestId).update({
        'status': BusinessOwnerRequestStatus.approved.name,
        'reviewedAt': Timestamp.fromDate(DateTime.now()),
        'reviewedBy': approvedByUid,
        'approvalNotes': approvalNotes,
      });

      // 9. Notificar al business owner sobre la aprobación
      await _notifyBusinessOwnerApproval(request);

      return adminUser;
    } catch (e) {
      throw AdminAuthException('Error aprobando solicitud: $e');
    }
  }

  /// ❌ Rechazar solicitud de business owner
  Future<void> rejectBusinessOwnerRequest({
    required String requestId,
    required String rejectedByUid,
    required String rejectionReason,
  }) async {
    try {
      // 1. Verificar permisos del rechazador
      final rejector = await getAdminUserByUid(rejectedByUid);
      if (rejector?.role != AdminRole.superAdmin) {
        throw const AdminAuthException(
          'Solo super administradores pueden rechazar solicitudes',
        );
      }

      // 2. Obtener la solicitud
      final requestDoc = await _businessOwnerRequestsRef.doc(requestId).get();
      if (!requestDoc.exists) {
        throw const AdminAuthException('Solicitud no encontrada');
      }

      final request = BusinessOwnerRequest.fromFirestore(requestDoc.data()!);

      // 3. Verificar que puede ser rechazada
      if (request.isApproved || request.isRejected) {
        throw const AdminAuthException('La solicitud ya fue procesada');
      }

      // 4. Actualizar estado de solicitud
      await _businessOwnerRequestsRef.doc(requestId).update({
        'status': BusinessOwnerRequestStatus.rejected.name,
        'reviewedAt': Timestamp.fromDate(DateTime.now()),
        'reviewedBy': rejectedByUid,
        'rejectionReason': rejectionReason,
      });

      // 5. Notificar al business owner sobre el rechazo
      await _notifyBusinessOwnerRejection(request, rejectionReason);
    } catch (e) {
      throw AdminAuthException('Error rechazando solicitud: $e');
    }
  }

  /// 🔄 Cambiar estado de solicitud (a reviewing o needsMoreInfo)
  Future<void> updateRequestStatus({
    required String requestId,
    required String updatedByUid,
    required BusinessOwnerRequestStatus newStatus,
    String? notes,
  }) async {
    try {
      // 1. Verificar permisos
      final updater = await getAdminUserByUid(updatedByUid);
      if (updater?.role != AdminRole.superAdmin) {
        throw const AdminAuthException(
          'Solo super administradores pueden actualizar solicitudes',
        );
      }

      // 2. Verificar que el estado es válido para actualización
      if (newStatus == BusinessOwnerRequestStatus.approved ||
          newStatus == BusinessOwnerRequestStatus.rejected) {
        throw const AdminAuthException(
          'Use métodos específicos para aprobar/rechazar',
        );
      }

      // 3. Actualizar estado
      await _businessOwnerRequestsRef.doc(requestId).update({
        'status': newStatus.name,
        'reviewedAt': Timestamp.fromDate(DateTime.now()),
        'reviewedBy': updatedByUid,
        'approvalNotes': notes,
      });
    } catch (e) {
      throw AdminAuthException('Error actualizando estado: $e');
    }
  }

  /// 📋 Obtener todas las solicitudes de business owners
  Future<List<BusinessOwnerRequest>> getAllBusinessOwnerRequests({
    String? requestedByUid,
    BusinessOwnerRequestStatus? filterByStatus,
  }) async {
    try {
      // Verificar permisos
      if (requestedByUid != null) {
        final requester = await getAdminUserByUid(requestedByUid);
        if (requester?.role != AdminRole.superAdmin) {
          throw const AdminAuthException(
            'Solo super administradores pueden ver solicitudes',
          );
        }
      }

      Query<Map<String, dynamic>> query = _businessOwnerRequestsRef.orderBy(
        'createdAt',
        descending: true,
      );

      // Aplicar filtro por estado si se especifica
      if (filterByStatus != null) {
        query = query.where('status', isEqualTo: filterByStatus.name);
      }

      final snapshot = await query.get();

      return snapshot.docs
          .map((doc) => BusinessOwnerRequest.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      throw AdminAuthException('Error obteniendo solicitudes: $e');
    }
  }

  /// 📊 Obtener estadísticas de solicitudes
  Future<BusinessOwnerRequestStats> getBusinessOwnerRequestStats({
    String? requestedByUid,
  }) async {
    try {
      // Verificar permisos
      if (requestedByUid != null) {
        final requester = await getAdminUserByUid(requestedByUid);
        if (requester?.role != AdminRole.superAdmin) {
          throw const AdminAuthException(
            'Solo super administradores pueden ver estadísticas',
          );
        }
      }

      final requests = await getAllBusinessOwnerRequests(
        requestedByUid: requestedByUid,
      );

      return BusinessOwnerRequestStats.fromRequests(requests);
    } catch (e) {
      throw AdminAuthException('Error obteniendo estadísticas: $e');
    }
  }

  /// 🔍 Obtener solicitud por ID
  Future<BusinessOwnerRequest?> getBusinessOwnerRequestById(
    String requestId, {
    String? requestedByUid,
  }) async {
    try {
      // Verificar permisos
      if (requestedByUid != null) {
        final requester = await getAdminUserByUid(requestedByUid);
        if (requester?.role != AdminRole.superAdmin) {
          throw const AdminAuthException(
            'Solo super administradores pueden ver solicitudes',
          );
        }
      }

      final doc = await _businessOwnerRequestsRef.doc(requestId).get();
      if (!doc.exists) return null;

      return BusinessOwnerRequest.fromFirestore(doc.data()!);
    } catch (e) {
      throw AdminAuthException('Error obteniendo solicitud: $e');
    }
  }

  /// 🚀 Registra usuario y solicita business owner en un solo flujo
  Future<BusinessOwnerRegistrationResult> registerAndRequestBusinessOwner({
    required String email,
    required String password,
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
      // 1. Crear instancia de AuthenticationService
      final authService = AuthenticationService(
        firebaseAuth: _firebaseAuth,
        firestore: _firestore,
      );

      // 2. Registrar usuario normal
      final newUser = await authService.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );

      if (newUser == null) {
        throw const AdminAuthException('Error registrando usuario');
      }

      // 3. Crear solicitud de business owner directamente
      final requestId = _uuid.v4();
      final request = BusinessOwnerRequest(
        id: requestId,
        userId: newUser.uid,
        email: newUser.email,
        displayName: displayName,
        businessName: businessName,
        businessDescription: businessDescription,
        businessAddress: businessAddress,
        phoneNumber: phoneNumber,
        website: website,
        // ignore: avoid_redundant_argument_values
        status: BusinessOwnerRequestStatus.pending,
        createdAt: DateTime.now(),
        businessMetadata: businessMetadata ?? {},
        contactInfo: contactInfo ?? {},
      );

      // 4. Guardar solicitud en Firestore
      await _businessOwnerRequestsRef.doc(requestId).set(request.toFirestore());

      // 5. Retornar resultado
      return BusinessOwnerRegistrationResult(
        user: newUser,
        request: request,
        success: true,
        message: 'Usuario registrado y solicitud enviada exitosamente',
      );
    } catch (e) {
      throw AdminAuthException('Error en registro completo: $e');
    }
  }

  // ================== MÉTODOS PRIVADOS ==================

  /// 🕐 Actualiza la fecha de último login
  Future<void> _updateLastLogin(
    CollectionReference<Map<String, dynamic>> collection,
    String uid,
  ) async {
    try {
      // Usar set con merge: true para crear la propiedad si no existe
      await collection.doc(uid).set({
        'lastLogin': Timestamp.fromDate(DateTime.now()),
      }, SetOptions(merge: true));
    } catch (e) {
      // Si falla con set, intentar con update como respaldo
      try {
        await collection.doc(uid).update({
          'lastLogin': Timestamp.fromDate(DateTime.now()),
        });
      } catch (updateError) {
        throw AdminAuthException(
          'Error actualizando último login: $updateError',
        );
      }
    }
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

  // ================== MÉTODOS DE NOTIFICACIÓN ==================

  /// 📧 Notificar a super administradores sobre nueva solicitud
  Future<void> _notifySuperAdminsNewRequest(
    BusinessOwnerRequest request,
  ) async {
    try {
      // TODO: Implementar notificación real (email, push notification, etc.)
      // Por ahora, solo logging
      print('🔔 Nueva solicitud de business owner:');
      print('   📧 Email: ${request.email}');
      print('   🏢 Negocio: ${request.businessName}');
      print('   📅 Fecha: ${request.createdAt}');

      // Aquí podrías integrar:
      // - Envío de emails usando algún servicio
      // - Push notifications
      // - Webhooks
      // - Slack/Discord notifications

      // Opcional: Crear documento de notificación en Firestore
      await _firestore.collection('notifications').add({
        'type': 'business_owner_request',
        'requestId': request.id,
        'title': 'Nueva solicitud de Business Owner',
        'message':
            '${request.displayName} (${request.businessName}) ha solicitado registro',
        'createdAt': FieldValue.serverTimestamp(),
        'targetRole': 'superAdmin',
        'isRead': false,
        'metadata': {
          'email': request.email,
          'businessName': request.businessName,
        },
      });
    } catch (e) {
      // No fallar el proceso principal por errores de notificación
      print('⚠️ Error enviando notificación: $e');
    }
  }

  /// ✅ Notificar aprobación al business owner
  Future<void> _notifyBusinessOwnerApproval(
    BusinessOwnerRequest request,
  ) async {
    try {
      // TODO: Implementar notificación real
      print('✅ Solicitud aprobada para: ${request.email}');
      print('   🏢 Negocio: ${request.businessName}');

      // Aquí implementarías:
      // - Envío de email con credenciales
      // - Instrucciones de acceso al Admin Panel
      // - Enlaces de primeros pasos

      // Opcional: Crear notificación en Firestore
      await _firestore.collection('notifications').add({
        'type': 'business_owner_approved',
        'requestId': request.id,
        'title': '¡Solicitud Aprobada!',
        'message': 'Tu solicitud para ${request.businessName} ha sido aprobada',
        'createdAt': FieldValue.serverTimestamp(),
        'targetEmail': request.email,
        'isRead': false,
        'metadata': {
          'businessName': request.businessName,
          'nextSteps': [
            'Inicia sesión en el Admin Panel',
            'Configura tu primer lugar',
          ],
        },
      });
    } catch (e) {
      print('⚠️ Error enviando notificación de aprobación: $e');
    }
  }

  /// ❌ Notificar rechazo al business owner
  Future<void> _notifyBusinessOwnerRejection(
    BusinessOwnerRequest request,
    String rejectionReason,
  ) async {
    try {
      // TODO: Implementar notificación real
      print('❌ Solicitud rechazada para: ${request.email}');
      print('   🏢 Negocio: ${request.businessName}');
      print('   📝 Razón: $rejectionReason');

      // Aquí implementarías:
      // - Envío de email con razón del rechazo
      // - Posibilidad de nueva solicitud
      // - Recursos de ayuda

      // Opcional: Crear notificación en Firestore
      await _firestore.collection('notifications').add({
        'type': 'business_owner_rejected',
        'requestId': request.id,
        'title': 'Solicitud No Aprobada',
        'message': 'Tu solicitud para ${request.businessName} no fue aprobada',
        'createdAt': FieldValue.serverTimestamp(),
        'targetEmail': request.email,
        'isRead': false,
        'metadata': {
          'businessName': request.businessName,
          'rejectionReason': rejectionReason,
          'canReapply': true,
        },
      });
    } catch (e) {
      print('⚠️ Error enviando notificación de rechazo: $e');
    }
  }
}
