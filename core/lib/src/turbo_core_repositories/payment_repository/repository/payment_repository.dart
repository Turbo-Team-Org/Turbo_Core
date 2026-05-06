import 'package:core/src/turbo_core_repositories/payment_repository/interface/payment_interface.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/service/payment_service.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_result.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_transaction.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/tropipay_payment_request.dart';

/// Repositorio de pagos que implementa la interface
class PaymentRepository implements PaymentInterface {
  final PaymentService _paymentService;

  PaymentRepository({required PaymentService paymentService})
    : _paymentService = paymentService;

  @override
  Future<PaymentResult> processPayment(TropipayPaymentRequest request) async {
    return await _paymentService.processPayment(request);
  }

  @override
  Future<PaymentResult> getPaymentStatus(String transactionId) async {
    return await _paymentService.getPaymentStatus(transactionId);
  }

  @override
  Future<List<PaymentTransaction>> getPaymentHistory(
    String userId, {
    int? limit,
  }) async {
    return await _paymentService.getPaymentHistory(userId, limit: limit);
  }

  @override
  Future<List<PaymentTransaction>> getPlacePaymentHistory(
    String placeId, {
    int? limit,
  }) async {
    return await _paymentService.getPlacePaymentHistory(placeId, limit: limit);
  }

  @override
  Future<PaymentResult> cancelPayment(String transactionId) async {
    return await _paymentService.cancelPayment(transactionId);
  }

  @override
  Future<PaymentResult> processRefund(
    String transactionId, {
    double? amount,
    String? reason,
  }) async {
    return await _paymentService.processRefund(
      transactionId,
      amount: amount,
      reason: reason,
    );
  }

  @override
  Future<bool> verifyTropipayConfiguration() async {
    return await _paymentService.verifyTropipayConfiguration();
  }

  @override
  Future<List<String>> getAvailablePaymentMethods() async {
    return await _paymentService.getAvailablePaymentMethods();
  }

  /// Método de conveniencia para procesar pago de reserva
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
    return await _paymentService.processReservationPayment(
      userId: userId,
      placeId: placeId,
      reservationId: reservationId,
      amount: amount,
      description: description,
      returnUrl: returnUrl,
      cancelUrl: cancelUrl,
      metadata: metadata,
    );
  }

  /// Método de conveniencia para procesar pago de evento
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
    return await _paymentService.processEventPayment(
      userId: userId,
      placeId: placeId,
      eventId: eventId,
      amount: amount,
      description: description,
      returnUrl: returnUrl,
      cancelUrl: cancelUrl,
      metadata: metadata,
    );
  }

  /// Obtiene estadísticas de pagos para un lugar
  Future<Map<String, dynamic>> getPlacePaymentStats(String placeId) async {
    return await _paymentService.getPlacePaymentStats(placeId);
  }

  /// Obtiene estadísticas de pagos para un usuario
  Future<Map<String, dynamic>> getUserPaymentStats(String userId) async {
    return await _paymentService.getUserPaymentStats(userId);
  }
}
