import 'package:core/src/turbo_core_repositories/payment_repository/service/tropipay_service.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/interface/payment_interface.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_result.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_transaction.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/tropipay_payment_request.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_method.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_status.dart';

/// Servicio principal de pagos que implementa PaymentInterface
class PaymentService implements PaymentInterface {
  final TropipayService _tropipayService;

  PaymentService({required TropipayService tropipayService})
    : _tropipayService = tropipayService;

  @override
  Future<PaymentResult> processPayment(TropipayPaymentRequest request) async {
    try {
      // Validar que el método de pago esté soportado por Tropipay
      if (!request.paymentMethod.isTropipaySupported) {
        return PaymentResult.error(
          errorCode: 'unsupported_payment_method',
          errorDetails:
              'El método de pago ${request.paymentMethod.displayName} no está soportado por Tropipay',
        );
      }

      // Procesar el pago con Tropipay
      return await _tropipayService.createPayment(request);
    } catch (e) {
      return PaymentResult.error(
        errorCode: 'payment_processing_error',
        errorDetails: 'Error procesando pago: $e',
      );
    }
  }

  @override
  Future<PaymentResult> getPaymentStatus(String transactionId) async {
    try {
      return await _tropipayService.getPaymentStatus(transactionId);
    } catch (e) {
      return PaymentResult.error(
        errorCode: 'status_check_error',
        errorDetails: 'Error verificando estado del pago: $e',
      );
    }
  }

  @override
  Future<List<PaymentTransaction>> getPaymentHistory(
    String userId, {
    int? limit,
  }) async {
    try {
      return await _tropipayService.getPaymentHistory(
        userId: userId,
        limit: limit ?? 50,
      );
    } catch (e) {
      throw PaymentServiceException('Error obteniendo historial de pagos: $e');
    }
  }

  @override
  Future<List<PaymentTransaction>> getPlacePaymentHistory(
    String placeId, {
    int? limit,
  }) async {
    try {
      return await _tropipayService.getPaymentHistory(
        placeId: placeId,
        limit: limit ?? 50,
      );
    } catch (e) {
      throw PaymentServiceException('Error obteniendo historial del lugar: $e');
    }
  }

  @override
  Future<PaymentResult> cancelPayment(String transactionId) async {
    try {
      return await _tropipayService.cancelPayment(transactionId);
    } catch (e) {
      return PaymentResult.error(
        errorCode: 'cancel_error',
        errorDetails: 'Error cancelando pago: $e',
      );
    }
  }

  @override
  Future<PaymentResult> processRefund(
    String transactionId, {
    double? amount,
    String? reason,
  }) async {
    try {
      return await _tropipayService.processRefund(
        transactionId,
        amount: amount,
        reason: reason,
      );
    } catch (e) {
      return PaymentResult.error(
        errorCode: 'refund_error',
        errorDetails: 'Error procesando reembolso: $e',
      );
    }
  }

  @override
  Future<bool> verifyTropipayConfiguration() async {
    try {
      return await _tropipayService.verifyConfiguration();
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<String>> getAvailablePaymentMethods() async {
    // Métodos de pago soportados por Tropipay
    return ['card', 'bank_transfer', 'mobile_transfer'];
  }

  /// Método de conveniencia para crear un pago de reserva
  Future<PaymentResult> processReservationPayment({
    required String userId,
    required String placeId,
    required String reservationId,
    required double amount,
    String? description,
    String? returnUrl,
    String? cancelUrl,
    Map<String, dynamic>? metadata,
  }) async {
    final request = TropipayPaymentRequest.fromPayment(
      amount: amount,
      description: description ?? 'Pago de reserva #$reservationId',
      userId: userId,
      placeId: placeId,
      reservationId: reservationId,
      returnUrl: returnUrl,
      cancelUrl: cancelUrl,
      metadata: {
        ...?metadata,
        'type': 'reservation_payment',
        'reservation_id': reservationId,
      },
    );

    return await processPayment(request);
  }

  /// Método de conveniencia para crear un pago de evento
  Future<PaymentResult> processEventPayment({
    required String userId,
    required String placeId,
    required String eventId,
    required double amount,
    String? description,
    String? returnUrl,
    String? cancelUrl,
    Map<String, dynamic>? metadata,
  }) async {
    final request = TropipayPaymentRequest.fromPayment(
      amount: amount,
      description: description ?? 'Pago de evento #$eventId',
      userId: userId,
      placeId: placeId,
      returnUrl: returnUrl,
      cancelUrl: cancelUrl,
      metadata: {...?metadata, 'type': 'event_payment', 'event_id': eventId},
    );

    return await processPayment(request);
  }

  /// Obtiene estadísticas de pagos para un lugar
  Future<Map<String, dynamic>> getPlacePaymentStats(String placeId) async {
    try {
      final transactions = await getPlacePaymentHistory(placeId, limit: 1000);

      final completedPayments = transactions
          .where((t) => t.status.isSuccessful)
          .toList();

      final totalAmount = completedPayments.fold(
        0.0,
        (sum, t) => sum + t.amount,
      );

      final totalFees = completedPayments.fold(
        0.0,
        (sum, t) => sum + (t.fee ?? 0.0),
      );

      final netAmount = totalAmount - totalFees;

      return {
        'total_transactions': transactions.length,
        'completed_transactions': completedPayments.length,
        'failed_transactions': transactions.length - completedPayments.length,
        'total_amount': totalAmount,
        'total_fees': totalFees,
        'net_amount': netAmount,
        'average_transaction': transactions.isEmpty
            ? 0.0
            : totalAmount / transactions.length,
        'success_rate': transactions.isEmpty
            ? 0.0
            : completedPayments.length / transactions.length,
      };
    } catch (e) {
      throw PaymentServiceException('Error obteniendo estadísticas: $e');
    }
  }

  /// Obtiene estadísticas de pagos para un usuario
  Future<Map<String, dynamic>> getUserPaymentStats(String userId) async {
    try {
      final transactions = await getPaymentHistory(userId, limit: 1000);

      final completedPayments = transactions
          .where((t) => t.status.isSuccessful)
          .toList();

      final totalAmount = completedPayments.fold(
        0.0,
        (sum, t) => sum + t.amount,
      );

      return {
        'total_transactions': transactions.length,
        'completed_transactions': completedPayments.length,
        'total_amount': totalAmount,
        'average_transaction': transactions.isEmpty
            ? 0.0
            : totalAmount / transactions.length,
        'last_payment_date': completedPayments.isNotEmpty
            ? completedPayments.last.transactionDate?.toIso8601String()
            : null,
      };
    } catch (e) {
      throw PaymentServiceException(
        'Error obteniendo estadísticas del usuario: $e',
      );
    }
  }
}

/// Excepción específica del servicio de pagos
class PaymentServiceException implements Exception {
  final String message;
  final dynamic details;

  PaymentServiceException(this.message, [this.details]);

  @override
  String toString() {
    if (details != null) {
      return 'PaymentServiceException: $message\nDetails: $details';
    }
    return 'PaymentServiceException: $message';
  }
}
