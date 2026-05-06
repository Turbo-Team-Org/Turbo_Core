import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_method.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_status.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/converters/payment_converters.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

/// Modelo principal de pago
@freezed
sealed class Payment with _$Payment {
  const factory Payment({
    /// ID único del pago
    required String id,

    /// ID del usuario que realiza el pago
    required String userId,

    /// ID del lugar/negocio
    required String placeId,

    /// ID de la reserva asociada (opcional)
    String? reservationId,

    /// Monto del pago en CUP
    required double amount,

    /// Moneda del pago (por defecto CUP)
    @Default('CUP') String currency,

    /// Método de pago utilizado
    @PaymentMethodConverter() required PaymentMethod paymentMethod,

    /// Estado actual del pago
    @PaymentStatusConverter() required PaymentStatus status,

    /// Descripción del pago
    String? description,

    /// Datos adicionales del pago
    @Default({}) Map<String, dynamic> metadata,

    /// URL de retorno después del pago
    String? returnUrl,

    /// URL de cancelación
    String? cancelUrl,

    /// ID de la transacción en la pasarela de pago
    String? gatewayTransactionId,

    /// Referencia externa (número de orden, etc.)
    String? externalReference,

    /// Fecha de creación del pago
    DateTime? createdAt,

    /// Fecha de actualización del pago
    DateTime? updatedAt,

    /// Fecha de procesamiento del pago
    DateTime? processedAt,

    /// Fecha de expiración del pago
    DateTime? expiresAt,

    /// Motivo de fallo (si aplica)
    String? failureReason,

    /// Datos de la tarjeta (encriptados, solo últimos 4 dígitos)
    String? cardLastFourDigits,

    /// Tipo de tarjeta (si aplica)
    String? cardType,

    /// País de origen del pago
    String? country,

    /// IP del cliente
    String? clientIp,

    /// User Agent del cliente
    String? userAgent,

    /// Comisión de la pasarela
    double? gatewayFee,

    /// Comisión de la plataforma
    double? platformFee,

    /// Monto neto recibido por el negocio
    double? netAmount,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);

  /// Crea un pago desde datos de Tropipay
  factory Payment.fromTropipayResponse(Map<String, dynamic> data) {
    return Payment(
      id: data['id']?.toString() ?? '',
      userId: data['user_id']?.toString() ?? '',
      placeId: data['place_id']?.toString() ?? '',
      reservationId: data['reservation_id']?.toString(),
      amount: (data['amount'] as num? ?? 0.0).toDouble(),
      currency: data['currency']?.toString() ?? 'CUP',
      paymentMethod: PaymentMethodExtension.fromString(
        data['payment_method']?.toString() ?? 'card',
      ),
      status: PaymentStatusExtension.fromString(
        data['status']?.toString() ?? 'unknown',
      ),
      description: data['description']?.toString(),
      metadata: Map<String, dynamic>.from(
        data['metadata'] as Map<String, dynamic>? ?? {},
      ),
      returnUrl: data['return_url']?.toString(),
      cancelUrl: data['cancel_url']?.toString(),
      gatewayTransactionId: data['gateway_transaction_id']?.toString(),
      externalReference: data['external_reference']?.toString(),
      createdAt: data['created_at'] != null
          ? DateTime.tryParse(data['created_at'].toString())
          : null,
      updatedAt: data['updated_at'] != null
          ? DateTime.tryParse(data['updated_at'].toString())
          : null,
      processedAt: data['processed_at'] != null
          ? DateTime.tryParse(data['processed_at'].toString())
          : null,
      expiresAt: data['expires_at'] != null
          ? DateTime.tryParse(data['expires_at'].toString())
          : null,
      failureReason: data['failure_reason']?.toString(),
      cardLastFourDigits: data['card_last_four_digits']?.toString(),
      cardType: data['card_type']?.toString(),
      country: data['country']?.toString(),
      clientIp: data['client_ip']?.toString(),
      userAgent: data['user_agent']?.toString(),
      gatewayFee: (data['gateway_fee'] as num? ?? 0.0).toDouble(),
      platformFee: (data['platform_fee'] as num? ?? 0.0).toDouble(),
      netAmount: (data['net_amount'] as num? ?? 0.0).toDouble(),
    );
  }
}

/// Extensión para funcionalidades adicionales del pago
extension PaymentExtension on Payment {
  /// Convierte el pago a formato para Tropipay
  Map<String, dynamic> toTropipayRequest() {
    return {
      'amount': amount,
      'currency': currency,
      'payment_method': paymentMethod.value,
      'description': description ?? 'Pago de reserva',
      'external_reference': externalReference ?? id,
      'return_url': returnUrl,
      'cancel_url': cancelUrl,
      'metadata': {
        ...metadata,
        'user_id': userId,
        'place_id': placeId,
        'reservation_id': reservationId,
      },
    };
  }

  /// Verifica si el pago está expirado
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// Verifica si el pago puede ser cancelado
  bool get canBeCancelled {
    return status.when(
      pending: () => !isExpired,
      processing: () => false,
      completed: () => false,
      failed: () => false,
      cancelled: () => false,
      refunded: () => false,
      expired: () => false,
      unknown: () => false,
    );
  }

  /// Verifica si el pago puede ser reembolsado
  bool get canBeRefunded {
    return status == const PaymentStatus.completed() &&
        processedAt != null &&
        processedAt!.isAfter(DateTime.now().subtract(const Duration(days: 30)));
  }

  /// Calcula el monto total con comisiones
  double get totalAmount {
    return amount + (gatewayFee ?? 0.0) + (platformFee ?? 0.0);
  }

  /// Obtiene el monto neto para el negocio
  double get businessNetAmount {
    return amount - (gatewayFee ?? 0.0) - (platformFee ?? 0.0);
  }

  /// Obtiene el porcentaje de comisión total
  double get totalCommissionPercentage {
    if (amount == 0) return 0.0;
    return ((gatewayFee ?? 0.0) + (platformFee ?? 0.0)) / amount * 100;
  }
}
