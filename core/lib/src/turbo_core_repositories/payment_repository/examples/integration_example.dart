import 'package:dio/dio.dart';
import 'package:core/core.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/config/tropipay_config.dart';

/// Ejemplo de integración del PaymentRepository en la aplicación Turbo
class PaymentIntegrationExample {
  late PaymentRepository _paymentRepository;

  /// Configuración inicial del sistema de pagos
  Future<void> setupPaymentSystem() async {
    print('🔧 Configurando sistema de pagos...');

    // 1. Verificar configuración
    if (!TropipayConfig.isValid) {
      throw Exception(
        'Configuración de Tropipay inválida. Verifica las variables de entorno.',
      );
    }

    TropipayConfig.printConfig();

    // 2. Configurar cliente HTTP
    final dio = Dio();
    dio.options.connectTimeout = const Duration(seconds: 30);
    dio.options.receiveTimeout = const Duration(seconds: 30);
    dio.options.headers['User-Agent'] = TropipayConstants.userAgent;

    // 3. Crear servicios
    final tropipayService = TropipayService(
      dio: dio,
      clientId: TropipayConfig.clientId,
      clientSecret: TropipayConfig.clientSecret,
      baseUrl: TropipayConfig.baseUrl,
      webhookSecret: TropipayConfig.webhookSecret,
    );

    final paymentService = PaymentService(tropipayService: tropipayService);

    // 4. Crear repositorio
    _paymentRepository = PaymentRepository(paymentService: paymentService);

    // 5. Verificar conectividad
    final isConnected = await _paymentRepository.verifyTropipayConfiguration();
    if (!isConnected) {
      throw Exception(
        'No se pudo conectar con Tropipay. Verifica las credenciales.',
      );
    }

    print('✅ Sistema de pagos configurado exitosamente');
  }

  /// Ejemplo: Procesar pago de reserva de restaurante
  Future<void> processRestaurantReservationPayment() async {
    print('\n🍽️ Procesando pago de reserva de restaurante...');

    try {
      final paymentRequest = TropipayPaymentRequest.fromPayment(
        amount: 2000.0, // 2000 CUP por reserva
        description:
            'Reserva en Restaurante El Buen Sabor - Mesa para 4 personas',
        userId: 'user_12345',
        placeId: 'restaurant_67890',
        reservationId: 'reservation_abc123',
        returnUrl:
            '${TropipayConfig.defaultReturnUrl}?type=reservation&id=reservation_abc123',
        cancelUrl:
            '${TropipayConfig.defaultCancelUrl}?type=reservation&id=reservation_abc123',
        metadata: {
          'restaurant_name': 'El Buen Sabor',
          'table_number': '12',
          'party_size': 4,
          'reservation_date': '2024-01-15T19:00:00Z',
          'special_requests': 'Mesa cerca de la ventana',
          'customer_phone': '+53 5 123 4567',
        },
      );

      final result = await _paymentRepository.processPayment(paymentRequest);

      if (result.success) {
        print('✅ Pago creado exitosamente:');
        print('   📋 Transaction ID: ${result.transactionId}');
        print(
          '   💰 Monto: ${result.payment?.amount} ${result.payment?.currency}',
        );
        print('   📊 Estado: ${result.payment?.status.value}');
        print('   📅 Creado: ${result.payment?.createdAt}');
        print('   ⏰ Expira: ${result.payment?.expiresAt}');

        if (result.requiresRedirect) {
          print('   🔗 URL de pago: ${result.preferredRedirectUrl}');
          // En la app real, aquí abrirías la URL en el navegador
          print('   📱 [En la app real] Abrir URL de pago en navegador');
        }
      } else {
        print('❌ Error procesando pago:');
        print('   🚨 Código: ${result.errorCode}');
        print('   📝 Detalles: ${result.errorDetails}');
        print('   💬 Mensaje: ${result.userFriendlyMessage}');
      }
    } catch (e) {
      print('💥 Error inesperado: $e');
    }
  }

  /// Ejemplo: Procesar pago de evento
  Future<void> processEventPayment() async {
    print('\n🎉 Procesando pago de evento...');

    try {
      final paymentRequest = TropipayPaymentRequest.fromPayment(
        amount: 1500.0, // 1500 CUP por entrada
        description: 'Entrada para Concierto de Jazz en Casa de la Música',
        userId: 'user_67890',
        placeId: 'venue_12345',
        returnUrl:
            '${TropipayConfig.defaultReturnUrl}?type=event&id=event_jazz_2024',
        cancelUrl:
            '${TropipayConfig.defaultCancelUrl}?type=event&id=event_jazz_2024',
        metadata: {
          'event_name': 'Concierto de Jazz',
          'venue': 'Casa de la Música',
          'event_date': '2024-01-20T20:00:00Z',
          'ticket_type': 'General',
          'quantity': 2,
          'customer_name': 'María González',
          'event_id': 'event_jazz_2024',
        },
      );

      final result = await _paymentRepository.processPayment(paymentRequest);

      if (result.success) {
        print('✅ Entrada comprada exitosamente:');
        print('   🎫 Transaction ID: ${result.transactionId}');
        print(
          '   💰 Total: ${result.payment?.amount} ${result.payment?.currency}',
        );
        print('   📅 Evento: ${paymentRequest.metadata['event_date']}');
        print(
          '   👥 Cantidad: ${paymentRequest.metadata['quantity']} entradas',
        );
      } else {
        print('❌ Error comprando entrada: ${result.userFriendlyMessage}');
      }
    } catch (e) {
      print('💥 Error inesperado: $e');
    }
  }

  /// Ejemplo: Verificar estado de pago
  Future<void> checkPaymentStatus() async {
    print('\n🔍 Verificando estado de pago...');

    try {
      // En la app real, este ID vendría de la base de datos o de la URL
      const transactionId = 'transaction_12345';

      final result = await _paymentRepository.getPaymentStatus(transactionId);

      if (result.success) {
        final payment = result.payment!;
        print('📊 Estado del pago:');
        print('   🆔 ID: ${payment.id}');
        print('   📊 Estado: ${payment.status.value}');
        print('   💰 Monto: ${payment.amount} ${payment.currency}');
        print('   📅 Procesado: ${payment.processedAt}');

        if (payment.status.isSuccessful) {
          print('   ✅ ¡Pago completado exitosamente!');
          print('   🎯 Acción: Confirmar reserva/evento');
        } else if (payment.status == const PaymentStatus.failed()) {
          print('   ❌ Pago falló');
          print('   🔍 Razón: ${payment.failureReason}');
          print('   🎯 Acción: Permitir reintento');
        } else if (payment.status == const PaymentStatus.expired()) {
          print('   ⏰ Pago expirado');
          print('   🎯 Acción: Crear nuevo pago');
        }
      } else {
        print('❌ Error verificando estado: ${result.userFriendlyMessage}');
      }
    } catch (e) {
      print('💥 Error inesperado: $e');
    }
  }

  /// Ejemplo: Procesar reembolso
  Future<void> processRefund() async {
    print('\n💰 Procesando reembolso...');

    try {
      // En la app real, este ID vendría de la base de datos
      const transactionId = 'transaction_12345';

      final result = await _paymentRepository.processRefund(
        transactionId,
        amount: 1000.0, // Reembolsar 1000 CUP de 2000 CUP
        reason:
            'Cancelación de reserva por parte del cliente - 24 horas antes del evento',
      );

      if (result.success) {
        print('✅ Reembolso procesado exitosamente:');
        print('   💰 Monto reembolsado: 1000.0 CUP');
        print('   📊 Estado: ${result.payment?.status.value}');
        print('   📅 Procesado: ${result.payment?.processedAt}');
        print('   📝 Razón: Cancelación del cliente');
      } else {
        print('❌ Error procesando reembolso: ${result.userFriendlyMessage}');
      }
    } catch (e) {
      print('💥 Error inesperado: $e');
    }
  }

  /// Ejemplo: Obtener estadísticas de pagos
  Future<void> getPaymentStatistics() async {
    print('\n📊 Obteniendo estadísticas de pagos...');

    try {
      // Estadísticas del lugar
      const placeId = 'restaurant_67890';
      final placeStats = await _paymentRepository.getPlacePaymentStats(placeId);

      print('🏢 Estadísticas del lugar ($placeId):');
      print('   📈 Total transacciones: ${placeStats['total_transactions']}');
      print(
        '   ✅ Transacciones completadas: ${placeStats['completed_transactions']}',
      );
      print(
        '   ❌ Transacciones fallidas: ${placeStats['failed_transactions']}',
      );
      print('   💰 Monto total: ${placeStats['total_amount']} CUP');
      print('   💸 Comisiones totales: ${placeStats['total_fees']} CUP');
      print('   💵 Monto neto: ${placeStats['net_amount']} CUP');
      print(
        '   📊 Tasa de éxito: ${(placeStats['success_rate'] * 100).toStringAsFixed(1)}%',
      );
      print(
        '   📈 Promedio por transacción: ${placeStats['average_transaction']} CUP',
      );

      // Estadísticas del usuario
      const userId = 'user_12345';
      final userStats = await _paymentRepository.getUserPaymentStats(userId);

      print('\n👤 Estadísticas del usuario ($userId):');
      print('   📈 Total transacciones: ${userStats['total_transactions']}');
      print(
        '   ✅ Transacciones completadas: ${userStats['completed_transactions']}',
      );
      print('   💰 Monto total gastado: ${userStats['total_amount']} CUP');
      print(
        '   📈 Promedio por transacción: ${userStats['average_transaction']} CUP',
      );
      print('   📅 Último pago: ${userStats['last_payment_date']}');
    } catch (e) {
      print('💥 Error obteniendo estadísticas: $e');
    }
  }

  /// Ejemplo: Obtener historial de pagos
  Future<void> getPaymentHistory() async {
    print('\n📋 Obteniendo historial de pagos...');

    try {
      // Historial del usuario
      const userId = 'user_12345';
      final userHistory = await _paymentRepository.getPaymentHistory(
        userId,
        limit: 5,
      );

      print('👤 Últimos 5 pagos del usuario ($userId):');
      for (int i = 0; i < userHistory.length; i++) {
        final transaction = userHistory[i];
        print('   ${i + 1}. 🆔 ${transaction.id}');
        print(
          '      💰 ${transaction.amount} CUP - ${transaction.status.value}',
        );
        print('      📅 ${transaction.transactionDate}');
        print('      🔄 ${transaction.type.displayName}');
        print('');
      }

      // Historial del lugar
      const placeId = 'restaurant_67890';
      final placeHistory = await _paymentRepository.getPlacePaymentHistory(
        placeId,
        limit: 3,
      );

      print('🏢 Últimos 3 pagos del lugar ($placeId):');
      for (int i = 0; i < placeHistory.length; i++) {
        final transaction = placeHistory[i];
        print('   ${i + 1}. 🆔 ${transaction.id}');
        print(
          '      💰 ${transaction.amount} CUP - ${transaction.status.value}',
        );
        print('      📅 ${transaction.transactionDate}');
        print('      💸 Comisión: ${transaction.fee ?? 0} CUP');
        print('');
      }
    } catch (e) {
      print('💥 Error obteniendo historial: $e');
    }
  }

  /// Ejemplo: Obtener métodos de pago disponibles
  Future<void> getAvailablePaymentMethods() async {
    print('\n💳 Métodos de pago disponibles...');

    try {
      final methods = await _paymentRepository.getAvailablePaymentMethods();

      print('💳 Métodos soportados por Tropipay:');
      for (final methodString in methods) {
        final method = PaymentMethodExtension.fromString(methodString);
        print('   ✅ ${method.displayName}');
        print(
          '      🔧 Soporte online: ${method.requiresOnlineProcessing ? 'Sí' : 'No'}',
        );
        print('      🎯 Icono: ${method.iconName}');
        print('');
      }
    } catch (e) {
      print('💥 Error obteniendo métodos: $e');
    }
  }

  /// Ejecutar todos los ejemplos
  Future<void> runAllExamples() async {
    print('🚀 Iniciando ejemplos de integración de pagos...\n');

    try {
      // 1. Configurar sistema
      await setupPaymentSystem();

      // 2. Obtener métodos disponibles
      await getAvailablePaymentMethods();

      // 3. Procesar pago de reserva
      await processRestaurantReservationPayment();

      // 4. Procesar pago de evento
      await processEventPayment();

      // 5. Verificar estado de pago
      await checkPaymentStatus();

      // 6. Procesar reembolso
      await processRefund();

      // 7. Obtener estadísticas
      await getPaymentStatistics();

      // 8. Obtener historial
      await getPaymentHistory();

      print('\n✅ Todos los ejemplos ejecutados exitosamente');
      print('🎯 El sistema de pagos está listo para usar en producción');
    } catch (e) {
      print('\n💥 Error ejecutando ejemplos: $e');
      print('🔧 Verifica la configuración de Tropipay');
    }
  }
}

/// Función principal para ejecutar los ejemplos
Future<void> main() async {
  final example = PaymentIntegrationExample();
  await example.runAllExamples();
}
