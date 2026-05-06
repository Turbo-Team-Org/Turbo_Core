import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_result.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_transaction.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/tropipay_payment_request.dart';

/// Interface para el repositorio de pagos
/// Define las operaciones disponibles para procesar pagos a través de pasarelas
abstract class PaymentInterface {
  /// Procesa un pago utilizando Tropipay
  ///
  /// [request] - Datos del pago a procesar
  /// Retorna [PaymentResult] con el resultado del procesamiento
  Future<PaymentResult> processPayment(TropipayPaymentRequest request);

  /// Verifica el estado de un pago
  ///
  /// [transactionId] - ID de la transacción
  /// Retorna [PaymentResult] con el estado actual
  Future<PaymentResult> getPaymentStatus(String transactionId);

  /// Obtiene el historial de pagos de un usuario
  ///
  /// [userId] - ID del usuario
  /// [limit] - Límite de resultados (opcional)
  /// Retorna lista de [PaymentTransaction]
  Future<List<PaymentTransaction>> getPaymentHistory(
    String userId, {
    int? limit,
  });

  /// Obtiene el historial de pagos de un lugar/negocio
  ///
  /// [placeId] - ID del lugar
  /// [limit] - Límite de resultados (opcional)
  /// Retorna lista de [PaymentTransaction]
  Future<List<PaymentTransaction>> getPlacePaymentHistory(
    String placeId, {
    int? limit,
  });

  /// Cancela un pago pendiente
  ///
  /// [transactionId] - ID de la transacción
  /// Retorna [PaymentResult] con el resultado de la cancelación
  Future<PaymentResult> cancelPayment(String transactionId);

  /// Procesa un reembolso
  ///
  /// [transactionId] - ID de la transacción original
  /// [amount] - Monto a reembolsar (opcional, si no se especifica reembolsa todo)
  /// [reason] - Razón del reembolso
  /// Retorna [PaymentResult] con el resultado del reembolso
  Future<PaymentResult> processRefund(
    String transactionId, {
    double? amount,
    String? reason,
  });

  /// Verifica la configuración de Tropipay
  ///
  /// Retorna true si la configuración es válida
  Future<bool> verifyTropipayConfiguration();

  /// Obtiene métodos de pago disponibles
  ///
  /// Retorna lista de métodos de pago soportados
  Future<List<String>> getAvailablePaymentMethods();
}
