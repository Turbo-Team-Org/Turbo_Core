import 'package:dio/dio.dart';
import 'package:core/core.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/config/tropipay_config.dart';

/// Ejemplo de uso del PaymentRepository con Tropipay
class PaymentUsageExample {
  late PaymentRepository _paymentRepository;

  /// Inicializa el repositorio de pagos
  Future<void> initializePaymentRepository() async {
    // Configurar Dio para las requests HTTP
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);

    // Crear el servicio de Tropipay
    final tropipayService = TropipayService(
      dio: dio,
      clientId: TropipayConfig.clientId,
      clientSecret: TropipayConfig.clientSecret,
      baseUrl: TropipayConfig.baseUrl,
      webhookSecret: TropipayConfig.webhookSecret,
    );

    // Crear el servicio de pagos
    final paymentService = PaymentService(tropipayService: tropipayService);

    // Crear el repositorio
    _paymentRepository = PaymentRepository(paymentService: paymentService);
  }

  /// Ejemplo: Procesar pago de reserva
  Future<void> processReservationPayment() async {
    try {
      // Crear request de pago
      final paymentRequest = TropipayPaymentRequest.fromPayment(
        amount: 1500.0, // 1500 CUP
        description: 'Pago de reserva en Restaurante El Buen Sabor',
        userId: 'user_123',
        placeId: 'place_456',
        reservationId: 'reservation_789',
        returnUrl: 'https://turboapp.com/payment/success',
        cancelUrl: 'https://turboapp.com/payment/cancel',
        metadata: {
          'reservation_date': '2024-01-15',
          'party_size': 4,
          'table_number': '12',
        },
      );

      // Procesar el pago
      final result = await _paymentRepository.processPayment(paymentRequest);

      if (result.success) {
        print('✅ Pago creado exitosamente:');
        print('  - Transaction ID: ${result.transactionId}');
        print('  - Amount: ${result.payment?.amount} CUP');
        print('  - Status: ${result.payment?.status.value}');

        if (result.requiresRedirect) {
          print('  - Redirect URL: ${result.preferredRedirectUrl}');
          // Redirigir al usuario a la URL de pago
        }
      } else {
        print('❌ Error procesando pago:');
        print('  - Error Code: ${result.errorCode}');
        print('  - Error Details: ${result.errorDetails}');
        print('  - Message: ${result.userFriendlyMessage}');
      }
    } catch (e) {
      print('💥 Error inesperado: $e');
    }
  }

  /// Ejemplo: Verificar estado de pago
  Future<void> checkPaymentStatus(String transactionId) async {
    try {
      final result = await _paymentRepository.getPaymentStatus(transactionId);

      if (result.success) {
        print('📊 Estado del pago:');
        print('  - Transaction ID: ${result.transactionId}');
        print('  - Status: ${result.payment?.status.value}');
        print('  - Amount: ${result.payment?.amount} CUP');
        print('  - Created: ${result.payment?.createdAt}');

        if (result.payment?.status.isSuccessful == true) {
          print('  - ✅ Pago completado exitosamente');
        } else if (result.payment?.status == const PaymentStatus.failed()) {
          print('  - ❌ Pago falló: ${result.payment?.failureReason}');
        }
      } else {
        print('❌ Error verificando estado: ${result.userFriendlyMessage}');
      }
    } catch (e) {
      print('💥 Error inesperado: $e');
    }
  }

  /// Ejemplo: Obtener historial de pagos
  Future<void> getPaymentHistory() async {
    try {
      final transactions = await _paymentRepository.getPaymentHistory(
        'user_123',
        limit: 10,
      );

      print('📋 Historial de pagos:');
      for (final transaction in transactions) {
        print('  - ID: ${transaction.id}');
        print('    Amount: ${transaction.amount} CUP');
        print('    Status: ${transaction.status.value}');
        print('    Date: ${transaction.transactionDate}');
        print('    Type: ${transaction.type.value}');
        print('    ---');
      }
    } catch (e) {
      print('💥 Error obteniendo historial: $e');
    }
  }

  /// Ejemplo: Procesar reembolso
  Future<void> processRefund(String transactionId) async {
    try {
      final result = await _paymentRepository.processRefund(
        transactionId,
        amount: 750.0, // Reembolsar la mitad
        reason: 'Cancelación de reserva por parte del cliente',
      );

      if (result.success) {
        print('✅ Reembolso procesado exitosamente:');
        print('  - Transaction ID: ${result.transactionId}');
        print('  - Amount: ${result.payment?.amount} CUP');
        print('  - Status: ${result.payment?.status.value}');
      } else {
        print('❌ Error procesando reembolso: ${result.userFriendlyMessage}');
      }
    } catch (e) {
      print('💥 Error inesperado: $e');
    }
  }

  /// Ejemplo: Obtener estadísticas de pagos
  Future<void> getPaymentStats() async {
    try {
      // Estadísticas del lugar
      final placeStats = await _paymentRepository.getPlacePaymentStats(
        'place_456',
      );
      print('📊 Estadísticas del lugar:');
      print('  - Total transacciones: ${placeStats['total_transactions']}');
      print(
        '  - Transacciones completadas: ${placeStats['completed_transactions']}',
      );
      print('  - Monto total: ${placeStats['total_amount']} CUP');
      print('  - Comisiones totales: ${placeStats['total_fees']} CUP');
      print('  - Monto neto: ${placeStats['net_amount']} CUP');
      print(
        '  - Tasa de éxito: ${(placeStats['success_rate'] * 100).toStringAsFixed(1)}%',
      );

      // Estadísticas del usuario
      final userStats = await _paymentRepository.getUserPaymentStats(
        'user_123',
      );
      print('\n👤 Estadísticas del usuario:');
      print('  - Total transacciones: ${userStats['total_transactions']}');
      print(
        '  - Transacciones completadas: ${userStats['completed_transactions']}',
      );
      print('  - Monto total: ${userStats['total_amount']} CUP');
      print('  - Último pago: ${userStats['last_payment_date']}');
    } catch (e) {
      print('💥 Error obteniendo estadísticas: $e');
    }
  }

  /// Ejemplo: Verificar configuración de Tropipay
  Future<void> verifyConfiguration() async {
    try {
      final isValid = await _paymentRepository.verifyTropipayConfiguration();

      if (isValid) {
        print('✅ Configuración de Tropipay válida');
      } else {
        print('❌ Configuración de Tropipay inválida');
        print('Verifica las credenciales en el archivo .env');
      }
    } catch (e) {
      print('💥 Error verificando configuración: $e');
    }
  }

  /// Ejemplo: Obtener métodos de pago disponibles
  Future<void> getAvailablePaymentMethods() async {
    try {
      final methods = await _paymentRepository.getAvailablePaymentMethods();

      print('💳 Métodos de pago disponibles:');
      for (final method in methods) {
        final paymentMethod = PaymentMethodExtension.fromString(method);
        print('  - ${paymentMethod.displayName}');
      }
    } catch (e) {
      print('💥 Error obteniendo métodos de pago: $e');
    }
  }

  /// Ejemplo completo de flujo de pago
  Future<void> completePaymentFlow() async {
    print('🚀 Iniciando flujo completo de pago...\n');

    // 1. Verificar configuración
    print('1️⃣ Verificando configuración...');
    await verifyConfiguration();
    print('');

    // 2. Obtener métodos de pago
    print('2️⃣ Obteniendo métodos de pago...');
    await getAvailablePaymentMethods();
    print('');

    // 3. Procesar pago
    print('3️⃣ Procesando pago...');
    await processReservationPayment();
    print('');

    // 4. Obtener estadísticas
    print('4️⃣ Obteniendo estadísticas...');
    await getPaymentStats();
    print('');

    // 5. Obtener historial
    print('5️⃣ Obteniendo historial...');
    await getPaymentHistory();
    print('');

    print('✅ Flujo de pago completado');
  }
}
