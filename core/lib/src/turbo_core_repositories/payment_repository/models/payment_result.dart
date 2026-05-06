import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_status.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/converters/payment_converters.dart';

part 'payment_result.freezed.dart';
part 'payment_result.g.dart';

/// Resultado de una operación de pago
@freezed
sealed class PaymentResult with _$PaymentResult {
  const factory PaymentResult({
    /// Indica si la operación fue exitosa
    required bool success,

    /// Estado del pago
    @PaymentStatusConverter() required PaymentStatus status,

    /// Pago procesado (si aplica)
    Payment? payment,

    /// ID de la transacción
    String? transactionId,

    /// URL de redirección para completar el pago
    String? redirectUrl,

    /// URL de la pasarela de pago
    String? paymentUrl,

    /// Mensaje descriptivo
    String? message,

    /// Código de error (si aplica)
    String? errorCode,

    /// Detalles del error
    String? errorDetails,

    /// Datos adicionales de la respuesta
    @Default({}) Map<String, dynamic> metadata,

    /// Timestamp de la operación
    DateTime? timestamp,
  }) = _PaymentResult;

  factory PaymentResult.fromJson(Map<String, dynamic> json) =>
      _$PaymentResultFromJson(json);

  /// Crea un resultado exitoso
  factory PaymentResult.success({
    required Payment payment,
    String? redirectUrl,
    String? paymentUrl,
    String? message,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentResult(
      success: true,
      status: payment.status,
      payment: payment,
      transactionId: payment.id,
      redirectUrl: redirectUrl,
      paymentUrl: paymentUrl,
      message: message ?? 'Pago procesado exitosamente',
      metadata: metadata ?? {},
      timestamp: DateTime.now(),
    );
  }

  /// Crea un resultado de error
  factory PaymentResult.error({
    required String errorCode,
    required String errorDetails,
    PaymentStatus? status,
    Payment? payment,
    String? message,
    Map<String, dynamic>? metadata,
  }) {
    return PaymentResult(
      success: false,
      status: status ?? const PaymentStatus.failed(),
      payment: payment,
      message: message ?? 'Error en el procesamiento del pago',
      errorCode: errorCode,
      errorDetails: errorDetails,
      metadata: metadata ?? {},
      timestamp: DateTime.now(),
    );
  }

  /// Crea un resultado desde respuesta de Tropipay
  factory PaymentResult.fromTropipayResponse(Map<String, dynamic> data) {
    final isSuccess =
        data['success'] == true ||
        data['status']?.toString().toLowerCase() == 'completed';

    final payment = data['payment'] != null
        ? Payment.fromTropipayResponse(data['payment'] as Map<String, dynamic>)
        : null;

    return PaymentResult(
      success: isSuccess,
      status:
          payment?.status ??
          PaymentStatusExtension.fromString(
            data['status']?.toString() ?? 'unknown',
          ),
      payment: payment,
      transactionId:
          data['transaction_id']?.toString() ?? data['payment_id']?.toString(),
      redirectUrl: data['redirect_url']?.toString(),
      paymentUrl: data['payment_url']?.toString(),
      message: data['message']?.toString(),
      errorCode: data['error_code']?.toString(),
      errorDetails: data['error_details']?.toString(),
      metadata: Map<String, dynamic>.from(
        data['metadata'] as Map<String, dynamic>? ?? <String, dynamic>{},
      ),
      timestamp: data['timestamp'] != null
          ? DateTime.tryParse(data['timestamp'].toString())
          : DateTime.now(),
    );
  }
}

/// Extensión para funcionalidades adicionales del resultado
extension PaymentResultExtension on PaymentResult {
  /// Verifica si el pago requiere redirección
  bool get requiresRedirect {
    return redirectUrl != null || paymentUrl != null;
  }

  /// Obtiene la URL de redirección preferida
  String? get preferredRedirectUrl {
    return redirectUrl ?? paymentUrl;
  }

  /// Verifica si hay un error específico
  bool get hasError {
    return !success && errorCode != null;
  }

  /// Obtiene el mensaje de usuario amigable
  String get userFriendlyMessage {
    if (success) {
      return message ?? 'Operación completada exitosamente';
    }

    switch (errorCode?.toLowerCase()) {
      case 'insufficient_funds':
        return 'Fondos insuficientes en la cuenta';
      case 'card_declined':
        return 'Tarjeta rechazada por el banco';
      case 'expired_card':
        return 'Tarjeta expirada';
      case 'invalid_card':
        return 'Datos de tarjeta inválidos';
      case 'network_error':
        return 'Error de conexión. Intente nuevamente';
      case 'timeout':
        return 'Tiempo de espera agotado';
      case 'invalid_amount':
        return 'Monto inválido';
      case 'currency_not_supported':
        return 'Moneda no soportada';
      case 'payment_method_not_supported':
        return 'Método de pago no soportado';
      case 'merchant_not_found':
        return 'Comercio no encontrado';
      case 'duplicate_transaction':
        return 'Transacción duplicada';
      case 'fraud_detected':
        return 'Transacción bloqueada por seguridad';
      default:
        return message ?? errorDetails ?? 'Error desconocido';
    }
  }

  /// Obtiene el color para UI basado en el estado
  String get statusColor {
    if (success) {
      return status.when(
        pending: () => '#FFA726', // Orange
        processing: () => '#2196F3', // Blue
        completed: () => '#4CAF50', // Green
        failed: () => '#F44336', // Red
        cancelled: () => '#9E9E9E', // Grey
        refunded: () => '#FF9800', // Orange
        expired: () => '#795548', // Brown
        unknown: () => '#607D8B', // Blue Grey
      );
    } else {
      return '#F44336'; // Red for errors
    }
  }

  /// Convierte a formato para logging
  Map<String, dynamic> toLogFormat() {
    return {
      'success': success,
      'status': status.value,
      'transaction_id': transactionId,
      'payment_id': payment?.id,
      'amount': payment?.amount,
      'currency': payment?.currency,
      'error_code': errorCode,
      'error_details': errorDetails,
      'timestamp': timestamp?.toIso8601String(),
      'metadata': metadata,
    };
  }
}
