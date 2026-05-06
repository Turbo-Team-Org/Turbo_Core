import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_status.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/converters/payment_converters.dart';

part 'payment_transaction.freezed.dart';
part 'payment_transaction.g.dart';

/// Modelo de transacción de pago - Historial detallado
@freezed
sealed class PaymentTransaction with _$PaymentTransaction {
  const factory PaymentTransaction({
    /// ID único de la transacción
    required String id,

    /// ID del pago asociado
    required String paymentId,

    /// Pago completo asociado
    Payment? payment,

    /// Tipo de transacción
    @PaymentTransactionTypeConverter() required PaymentTransactionType type,

    /// Estado de la transacción
    @PaymentStatusConverter() required PaymentStatus status,

    /// Monto de la transacción
    required double amount,

    /// Moneda
    @Default('CUP') String currency,

    /// Descripción de la transacción
    String? description,

    /// ID de la transacción en la pasarela
    String? gatewayTransactionId,

    /// Código de autorización (si aplica)
    String? authorizationCode,

    /// Referencia externa
    String? externalReference,

    /// Fecha de la transacción
    DateTime? transactionDate,

    /// Fecha de creación
    DateTime? createdAt,

    /// Fecha de actualización
    DateTime? updatedAt,

    /// Datos adicionales
    @Default({}) Map<String, dynamic> metadata,

    /// Motivo de fallo
    String? failureReason,

    /// Comisión de la transacción
    double? fee,

    /// Datos de la tarjeta (últimos 4 dígitos)
    String? cardLastFourDigits,

    /// Tipo de tarjeta
    String? cardType,

    /// País de origen
    String? country,
  }) = _PaymentTransaction;

  factory PaymentTransaction.fromJson(Map<String, dynamic> json) =>
      _$PaymentTransactionFromJson(json);

  /// Crea una transacción desde respuesta de Tropipay
  factory PaymentTransaction.fromTropipayResponse(Map<String, dynamic> data) {
    return PaymentTransaction(
      id: data['transaction_id']?.toString() ?? '',
      paymentId: data['payment_id']?.toString() ?? '',
      type: PaymentTransactionTypeExtension.fromString(
        data['transaction_type']?.toString() ?? 'payment',
      ),
      status: PaymentStatusExtension.fromString(
        data['status']?.toString() ?? 'unknown',
      ),
      amount: (data['amount'] as num? ?? 0.0).toDouble(),
      currency: data['currency']?.toString() ?? 'CUP',
      description: data['description']?.toString(),
      gatewayTransactionId: data['gateway_transaction_id']?.toString(),
      authorizationCode: data['authorization_code']?.toString(),
      externalReference: data['external_reference']?.toString(),
      transactionDate: data['transaction_date'] != null
          ? DateTime.tryParse(data['transaction_date'].toString())
          : null,
      createdAt: data['created_at'] != null
          ? DateTime.tryParse(data['created_at'].toString())
          : null,
      updatedAt: data['updated_at'] != null
          ? DateTime.tryParse(data['updated_at'].toString())
          : null,
      metadata: Map<String, dynamic>.from(
        data['metadata'] as Map<String, dynamic>? ?? {},
      ),
      failureReason: data['failure_reason']?.toString(),
      fee: (data['fee'] as num? ?? 0.0).toDouble(),
      cardLastFourDigits: data['card_last_four_digits']?.toString(),
      cardType: data['card_type']?.toString(),
      country: data['country']?.toString(),
    );
  }
}

/// Tipos de transacciones de pago
@freezed
sealed class PaymentTransactionType with _$PaymentTransactionType {
  /// Pago inicial
  const factory PaymentTransactionType.payment() =
      PaymentTransactionTypePayment;

  /// Reembolso
  const factory PaymentTransactionType.refund() = PaymentTransactionTypeRefund;

  /// Captura de pago
  const factory PaymentTransactionType.capture() =
      PaymentTransactionTypeCapture;

  /// Cancelación
  const factory PaymentTransactionType.cancellation() =
      PaymentTransactionTypeCancellation;

  /// Autorización
  const factory PaymentTransactionType.authorization() =
      PaymentTransactionTypeAuthorization;

  /// Reversión
  const factory PaymentTransactionType.reversal() =
      PaymentTransactionTypeReversal;

  /// Comisión
  const factory PaymentTransactionType.fee() = PaymentTransactionTypeFee;
}

/// Extensión para PaymentTransactionType
extension PaymentTransactionTypeExtension on PaymentTransactionType {
  String get value {
    return when(
      payment: () => 'payment',
      refund: () => 'refund',
      capture: () => 'capture',
      cancellation: () => 'cancellation',
      authorization: () => 'authorization',
      reversal: () => 'reversal',
      fee: () => 'fee',
    );
  }

  static PaymentTransactionType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'payment':
      case 'charge':
        return const PaymentTransactionType.payment();
      case 'refund':
        return const PaymentTransactionType.refund();
      case 'capture':
        return const PaymentTransactionType.capture();
      case 'cancellation':
      case 'cancel':
        return const PaymentTransactionType.cancellation();
      case 'authorization':
      case 'auth':
        return const PaymentTransactionType.authorization();
      case 'reversal':
        return const PaymentTransactionType.reversal();
      case 'fee':
        return const PaymentTransactionType.fee();
      default:
        return const PaymentTransactionType.payment();
    }
  }

  String get displayName {
    return when(
      payment: () => 'Pago',
      refund: () => 'Reembolso',
      capture: () => 'Captura',
      cancellation: () => 'Cancelación',
      authorization: () => 'Autorización',
      reversal: () => 'Reversión',
      fee: () => 'Comisión',
    );
  }
}
