import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_status.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/converters/payment_converters.dart';

part 'tropipay_webhook.freezed.dart';
part 'tropipay_webhook.g.dart';

/// Webhook de Tropipay para notificaciones de cambios de estado
@freezed
sealed class TropipayWebhook with _$TropipayWebhook {
  const factory TropipayWebhook({
    /// ID único del webhook
    required String id,

    /// ID de la transacción
    required String transactionId,

    /// ID del pago
    String? paymentId,

    /// Tipo de evento
    @TropipayWebhookEventTypeConverter()
    required TropipayWebhookEventType eventType,

    /// Estado del pago
    @PaymentStatusConverter() required PaymentStatus status,

    /// Monto del pago
    required double amount,

    /// Moneda
    @Default('CUP') String currency,

    /// Referencia externa
    String? externalReference,

    /// Timestamp del evento
    required DateTime timestamp,

    /// Firma de verificación
    String? signature,

    /// Datos adicionales del evento
    @Default({}) Map<String, dynamic> metadata,

    /// Datos específicos del evento
    TropipayWebhookEventData? eventData,
  }) = _TropipayWebhook;

  factory TropipayWebhook.fromJson(Map<String, dynamic> json) =>
      _$TropipayWebhookFromJson(json);

  /// Crea un webhook desde los datos recibidos de Tropipay
  factory TropipayWebhook.fromTropipayPayload(Map<String, dynamic> payload) {
    return TropipayWebhook(
      id: payload['webhook_id']?.toString() ?? '',
      transactionId: payload['transaction_id']?.toString() ?? '',
      paymentId: payload['payment_id']?.toString(),
      eventType: TropipayWebhookEventTypeExtension.fromString(
        payload['event_type']?.toString() ?? 'unknown',
      ),
      status: PaymentStatusExtension.fromString(
        payload['status']?.toString() ?? 'unknown',
      ),
      amount: (payload['amount'] as num? ?? 0.0).toDouble(),
      currency: payload['currency']?.toString() ?? 'CUP',
      externalReference: payload['external_reference']?.toString(),
      timestamp: payload['timestamp'] != null
          ? DateTime.tryParse(payload['timestamp'].toString()) ?? DateTime.now()
          : DateTime.now(),
      signature: payload['signature']?.toString(),
      metadata: Map<String, dynamic>.from(
        payload['metadata'] as Map<String, dynamic>? ?? {},
      ),
      eventData: payload['event_data'] != null
          ? TropipayWebhookEventData.fromJson(
              payload['event_data'] as Map<String, dynamic>,
            )
          : null,
    );
  }
}

/// Tipos de eventos de webhook de Tropipay
@freezed
sealed class TropipayWebhookEventType with _$TropipayWebhookEventType {
  /// Pago creado
  const factory TropipayWebhookEventType.paymentCreated() =
      TropipayWebhookEventTypePaymentCreated;

  /// Pago completado
  const factory TropipayWebhookEventType.paymentCompleted() =
      TropipayWebhookEventTypePaymentCompleted;

  /// Pago fallido
  const factory TropipayWebhookEventType.paymentFailed() =
      TropipayWebhookEventTypePaymentFailed;

  /// Pago cancelado
  const factory TropipayWebhookEventType.paymentCancelled() =
      TropipayWebhookEventTypePaymentCancelled;

  /// Pago reembolsado
  const factory TropipayWebhookEventType.paymentRefunded() =
      TropipayWebhookEventTypePaymentRefunded;

  /// Pago expirado
  const factory TropipayWebhookEventType.paymentExpired() =
      TropipayWebhookEventTypePaymentExpired;

  /// Pago en proceso
  const factory TropipayWebhookEventType.paymentProcessing() =
      TropipayWebhookEventTypePaymentProcessing;

  /// Evento desconocido
  const factory TropipayWebhookEventType.unknown() =
      TropipayWebhookEventTypeUnknown;
}

/// Extensión para TropipayWebhookEventType
extension TropipayWebhookEventTypeExtension on TropipayWebhookEventType {
  String get value {
    return when(
      paymentCreated: () => 'payment.created',
      paymentCompleted: () => 'payment.completed',
      paymentFailed: () => 'payment.failed',
      paymentCancelled: () => 'payment.cancelled',
      paymentRefunded: () => 'payment.refunded',
      paymentExpired: () => 'payment.expired',
      paymentProcessing: () => 'payment.processing',
      unknown: () => 'unknown',
    );
  }

  static TropipayWebhookEventType fromString(String value) {
    switch (value.toLowerCase()) {
      case 'payment.created':
      case 'payment_created':
        return const TropipayWebhookEventType.paymentCreated();
      case 'payment.completed':
      case 'payment_completed':
      case 'payment.success':
        return const TropipayWebhookEventType.paymentCompleted();
      case 'payment.failed':
      case 'payment_failed':
        return const TropipayWebhookEventType.paymentFailed();
      case 'payment.cancelled':
      case 'payment_cancelled':
      case 'payment.canceled':
        return const TropipayWebhookEventType.paymentCancelled();
      case 'payment.refunded':
      case 'payment_refunded':
        return const TropipayWebhookEventType.paymentRefunded();
      case 'payment.expired':
      case 'payment_expired':
        return const TropipayWebhookEventType.paymentExpired();
      case 'payment.processing':
      case 'payment_processing':
        return const TropipayWebhookEventType.paymentProcessing();
      default:
        return const TropipayWebhookEventType.unknown();
    }
  }

  String get displayName {
    return when(
      paymentCreated: () => 'Pago Creado',
      paymentCompleted: () => 'Pago Completado',
      paymentFailed: () => 'Pago Fallido',
      paymentCancelled: () => 'Pago Cancelado',
      paymentRefunded: () => 'Pago Reembolsado',
      paymentExpired: () => 'Pago Expirado',
      paymentProcessing: () => 'Pago Procesando',
      unknown: () => 'Evento Desconocido',
    );
  }
}

/// Datos específicos del evento de webhook
@freezed
sealed class TropipayWebhookEventData with _$TropipayWebhookEventData {
  const factory TropipayWebhookEventData({
    /// Código de autorización
    String? authorizationCode,

    /// Razón del fallo
    String? failureReason,

    /// Datos del cliente
    Map<String, dynamic>? customerData,

    /// Datos de la tarjeta (últimos 4 dígitos)
    Map<String, dynamic>? cardData,

    /// Comisiones aplicadas
    Map<String, dynamic>? feeData,

    /// URL de redirección
    String? redirectUrl,

    /// Datos adicionales del evento
    @Default({}) Map<String, dynamic> additionalData,
  }) = _TropipayWebhookEventData;

  factory TropipayWebhookEventData.fromJson(Map<String, dynamic> json) =>
      _$TropipayWebhookEventDataFromJson(json);
}

/// Extensión para TropipayWebhook
extension TropipayWebhookExtension on TropipayWebhook {
  /// Verifica si el webhook es válido
  bool isValid(String expectedSignature, String secretKey) {
    // Verificar firma del webhook
    if (signature != null && signature != expectedSignature) {
      return false;
    }

    // Verificar timestamp (no más de 5 minutos de diferencia)
    final now = DateTime.now();
    final timeDiff = now.difference(timestamp).abs();
    if (timeDiff.inMinutes > 5) {
      return false;
    }

    return true;
  }

  /// Obtiene el mensaje descriptivo del evento
  String get eventMessage {
    return eventType.displayName;
  }

  /// Verifica si el evento requiere acción inmediata
  bool get requiresImmediateAction {
    return eventType.when(
      paymentCreated: () => false,
      paymentCompleted: () => true,
      paymentFailed: () => true,
      paymentCancelled: () => true,
      paymentRefunded: () => true,
      paymentExpired: () => true,
      paymentProcessing: () => false,
      unknown: () => false,
    );
  }

  /// Obtiene la prioridad del evento para procesamiento
  int get priority {
    return eventType.when(
      paymentCompleted: () => 1, // Alta prioridad
      paymentFailed: () => 1,
      paymentCancelled: () => 2,
      paymentRefunded: () => 2,
      paymentExpired: () => 3,
      paymentProcessing: () => 4,
      paymentCreated: () => 5,
      unknown: () => 6,
    );
  }

  /// Convierte a formato para logging
  Map<String, dynamic> toLogFormat() {
    return {
      'webhook_id': id,
      'transaction_id': transactionId,
      'payment_id': paymentId,
      'event_type': eventType.value,
      'status': status.value,
      'amount': amount,
      'currency': currency,
      'external_reference': externalReference,
      'timestamp': timestamp.toIso8601String(),
      'requires_action': requiresImmediateAction,
      'priority': priority,
      'metadata': metadata,
    };
  }
}
