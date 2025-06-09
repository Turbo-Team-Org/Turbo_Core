// 🏢 Flujo Completo: Usuario Sin Cuenta → Business Owner
//
// Demuestra el flujo completo donde un usuario sin cuenta se registra
// y solicita convertirse en business owner en un solo proceso

import 'package:core/src/turbo_core_repositories/admin_auth_repository/admin_auth_repository.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/authentication_repository.dart';
import 'package:core/src/turbo_core_repositories/authentication_repository/models/auth_user.dart';
import 'package:get_it/get_it.dart';

/// 🎯 FLUJO COMPLETO: Sin Cuenta → Usuario → Business Owner Request
class BusinessOwnerRegistrationFlow {
  final AuthenticationRepository _authRepo;
  final AdminAuthRepository _adminAuthRepo;

  BusinessOwnerRegistrationFlow({
    required AuthenticationRepository authRepo,
    required AdminAuthRepository adminAuthRepo,
  }) : _authRepo = authRepo,
       _adminAuthRepo = adminAuthRepo;

  /// 🚀 Método Unificado: Registro + Solicitud Business Owner
  ///
  /// Este método maneja todo el flujo en una sola llamada:
  /// 1. Registra usuario nuevo
  /// 2. Inmediatamente envía solicitud de business owner
  /// 3. Retorna tanto el usuario como la solicitud creada
  Future<BusinessOwnerRegistrationResult> registerAndRequestBusinessOwner({
    // Datos de usuario
    required String email,
    required String password,
    required String displayName,
    // Datos de negocio
    required String businessName,
    required String businessDescription,
    required String businessAddress,
    String? phoneNumber,
    String? website,
    Map<String, dynamic>? businessMetadata,
    Map<String, dynamic>? contactInfo,
  }) async {
    try {
      // PASO 1: Registrar usuario normal
      print('🔐 PASO 1: Registrando nuevo usuario...');
      final newUser = await _authRepo.signUpWithEmail(
        email: email,
        password: password,
        displayName: displayName,
      );

      if (newUser == null) {
        throw Exception('Error al registrar usuario');
      }

      print('✅ Usuario registrado: ${newUser.uid}');

      // PASO 2: Enviar solicitud de business owner inmediatamente
      print('📝 PASO 2: Enviando solicitud de business owner...');
      final requestResult = await _adminAuthRepo.submitBusinessOwnerRequest(
        userId: newUser.uid,
        displayName: displayName,
        businessName: businessName,
        businessDescription: businessDescription,
        businessAddress: businessAddress,
        phoneNumber: phoneNumber,
        website: website,
        businessMetadata: businessMetadata,
        contactInfo: contactInfo,
      );

      return requestResult.fold(
        (failure) => throw Exception('Error en solicitud: $failure'),
        (request) {
          print('✅ Solicitud enviada: ${request.id}');
          return BusinessOwnerRegistrationResult(
            user: newUser,
            request: request,
            success: true,
            message: 'Usuario registrado y solicitud enviada exitosamente',
          );
        },
      );
    } catch (e) {
      return BusinessOwnerRegistrationResult(
        user: null,
        request: null,
        success: false,
        message: 'Error en el proceso: $e',
      );
    }
  }
}

/// 📊 Resultado del Registro Completo
class BusinessOwnerRegistrationResult {
  final AuthUser? user;
  final BusinessOwnerRequest? request;
  final bool success;
  final String message;

  BusinessOwnerRegistrationResult({
    required this.user,
    required this.request,
    required this.success,
    required this.message,
  });

  bool get hasUser => user != null;
  bool get hasRequest => request != null;
}
