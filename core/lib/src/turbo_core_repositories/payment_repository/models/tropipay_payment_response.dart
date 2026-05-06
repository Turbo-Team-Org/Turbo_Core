import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_status.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/converters/payment_converters.dart';

part 'tropipay_payment_response.freezed.dart';
part 'tropipay_payment_response.g.dart';

/// Respuesta de la API de Tropipay para pagos
@freezed
sealed class TropipayPaymentResponse with _$TropipayPaymentResponse {
  const factory TropipayPaymentResponse({
    /// Indica si la operación fue exitosa
    required bool success,

    /// ID único de la transacción en Tropipay
    String? transactionId,

    /// ID del pago
    String? paymentId,

    /// Estado del pago
    @PaymentStatusConverter() required PaymentStatus status,

    /// Monto del pago
    required double amount,

    /// Moneda
    @Default('CUP') String currency,

    /// Descripción del pago
    String? description,

    /// URL de redirección para completar el pago
    String? redirectUrl,

    /// URL de la pasarela de pago
    String? paymentUrl,

    /// Referencia externa
    String? externalReference,

    /// Código de autorización (si aplica)
    String? authorizationCode,

    /// Mensaje de respuesta
    String? message,

    /// Código de error (si aplica)
    String? errorCode,

    /// Detalles del error
    String? errorDetails,

    /// Fecha de creación
    DateTime? createdAt,

    /// Fecha de expiración
    DateTime? expiresAt,

    /// Datos adicionales de la respuesta
    @Default({}) Map<String, dynamic> metadata,

    /// Datos del cliente
    TropipayResponseCustomerData? customer,

    /// Datos de la tarjeta (últimos 4 dígitos)
    TropipayResponseCardData? cardData,

    /// Comisiones aplicadas
    TropipayFeeData? fees,
  }) = _TropipayPaymentResponse;

  factory TropipayPaymentResponse.fromJson(Map<String, dynamic> json) =>
      _$TropipayPaymentResponseFromJson(json);

  /// Crea una respuesta desde la API de Tropipay
  factory TropipayPaymentResponse.fromApiResponse(Map<String, dynamic> data) {
    return TropipayPaymentResponse(
      success: data['success'] == true,
      transactionId: data['transaction_id']?.toString(),
      paymentId: data['payment_id']?.toString(),
      status: PaymentStatusExtension.fromString(
        data['status']?.toString() ?? 'unknown',
      ),
      amount: (data['amount'] as num? ?? 0.0).toDouble(),
      currency: data['currency']?.toString() ?? 'CUP',
      description: data['description']?.toString(),
      redirectUrl: data['redirect_url']?.toString(),
      paymentUrl: data['payment_url']?.toString(),
      externalReference: data['external_reference']?.toString(),
      authorizationCode: data['authorization_code']?.toString(),
      message: data['message']?.toString(),
      errorCode: data['error_code']?.toString(),
      errorDetails: data['error_details']?.toString(),
      createdAt: data['created_at'] != null
          ? DateTime.tryParse(data['created_at'].toString())
          : null,
      expiresAt: data['expires_at'] != null
          ? DateTime.tryParse(data['expires_at'].toString())
          : null,
      metadata: Map<String, dynamic>.from(
        data['metadata'] as Map<String, dynamic>? ?? {},
      ),
      customer: data['customer'] != null
          ? TropipayResponseCustomerData.fromJson(
              data['customer'] as Map<String, dynamic>,
            )
          : null,
      cardData: data['card_data'] != null
          ? TropipayResponseCardData.fromJson(
              data['card_data'] as Map<String, dynamic>,
            )
          : null,
      fees: data['fees'] != null
          ? TropipayFeeData.fromJson(data['fees'] as Map<String, dynamic>)
          : null,
    );
  }
}

/// Datos del cliente en la respuesta de Tropipay
@freezed
sealed class TropipayResponseCustomerData with _$TropipayResponseCustomerData {
  const factory TropipayResponseCustomerData({
    /// Nombre completo del cliente
    String? fullName,

    /// Email del cliente
    String? email,

    /// Teléfono del cliente
    String? phone,

    /// ID del cliente en Tropipay
    String? customerId,
  }) = _TropipayResponseCustomerData;

  factory TropipayResponseCustomerData.fromJson(Map<String, dynamic> json) =>
      _$TropipayResponseCustomerDataFromJson(json);
}

/// Datos de la tarjeta en la respuesta de Tropipay
@freezed
sealed class TropipayResponseCardData with _$TropipayResponseCardData {
  const factory TropipayResponseCardData({
    /// Últimos 4 dígitos de la tarjeta
    String? lastFourDigits,

    /// Tipo de tarjeta
    String? cardType,

    /// País de emisión
    String? country,

    /// Banco emisor
    String? bankName,
  }) = _TropipayResponseCardData;

  factory TropipayResponseCardData.fromJson(Map<String, dynamic> json) =>
      _$TropipayResponseCardDataFromJson(json);
}

/// Datos de comisiones en la respuesta de Tropipay
@freezed
sealed class TropipayFeeData with _$TropipayFeeData {
  const factory TropipayFeeData({
    /// Comisión de Tropipay
    double? tropipayFee,

    /// Comisión del banco
    double? bankFee,

    /// Comisión total
    double? totalFee,

    /// Monto neto para el comercio
    double? netAmount,

    /// Porcentaje de comisión
    double? feePercentage,
  }) = _TropipayFeeData;

  factory TropipayFeeData.fromJson(Map<String, dynamic> json) =>
      _$TropipayFeeDataFromJson(json);
}

/// Extensión para TropipayPaymentResponse
extension TropipayPaymentResponseExtension on TropipayPaymentResponse {
  /// Verifica si el pago requiere redirección
  bool get requiresRedirect {
    return redirectUrl != null || paymentUrl != null;
  }

  /// Obtiene la URL de redirección preferida
  String? get preferredRedirectUrl {
    return redirectUrl ?? paymentUrl;
  }

  /// Verifica si hay un error
  bool get hasError {
    return !success && errorCode != null;
  }

  /// Obtiene el mensaje de usuario amigable
  String get userFriendlyMessage {
    if (success) {
      return message ?? 'Pago procesado exitosamente';
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
      case 'invalid_credentials':
        return 'Credenciales de Tropipay inválidas';
      case 'api_rate_limit':
        return 'Límite de requests excedido. Intente más tarde';
      default:
        return message ?? errorDetails ?? 'Error desconocido';
    }
  }

  /// Verifica si el pago está expirado
  bool get isExpired {
    if (expiresAt == null) return false;
    return DateTime.now().isAfter(expiresAt!);
  }

  /// Obtiene el tiempo restante hasta la expiración
  Duration? get timeUntilExpiration {
    if (expiresAt == null) return null;
    final now = DateTime.now();
    if (now.isAfter(expiresAt!)) return Duration.zero;
    return expiresAt!.difference(now);
  }

  /// Convierte a formato para logging
  Map<String, dynamic> toLogFormat() {
    return {
      'success': success,
      'transaction_id': transactionId,
      'payment_id': paymentId,
      'status': status.value,
      'amount': amount,
      'currency': currency,
      'error_code': errorCode,
      'error_details': errorDetails,
      'created_at': createdAt?.toIso8601String(),
      'expires_at': expiresAt?.toIso8601String(),
      'metadata': metadata,
    };
  }

  /// Obtiene el resumen del pago para mostrar al usuario
  String get paymentSummary {
    final amountFormatted = '${amount.toStringAsFixed(2)} $currency';
    final statusText = status.when(
      pending: () => 'Pendiente',
      processing: () => 'Procesando',
      completed: () => 'Completado',
      failed: () => 'Fallido',
      cancelled: () => 'Cancelado',
      refunded: () => 'Reembolsado',
      expired: () => 'Expirado',
      unknown: () => 'Desconocido',
    );

    return '$amountFormatted - $statusText';
  }
}
