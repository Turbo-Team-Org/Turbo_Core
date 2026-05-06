import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_method.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/converters/payment_converters.dart';

part 'tropipay_payment_request.freezed.dart';
part 'tropipay_payment_request.g.dart';

/// Request para crear un pago en Tropipay
@freezed
sealed class TropipayPaymentRequest with _$TropipayPaymentRequest {
  const factory TropipayPaymentRequest({
    /// Monto del pago
    required double amount,

    /// Moneda (CUP por defecto)
    @Default('CUP') String currency,

    /// Descripción del pago
    required String description,

    /// Método de pago preferido
    @Default(PaymentMethod.card())
    @PaymentMethodConverter()
    PaymentMethod paymentMethod,

    /// ID del usuario que realiza el pago
    required String userId,

    /// ID del lugar/negocio
    required String placeId,

    /// ID de la reserva (opcional)
    String? reservationId,

    /// Referencia externa (número de orden, etc.)
    String? externalReference,

    /// URL de retorno después del pago
    String? returnUrl,

    /// URL de cancelación
    String? cancelUrl,

    /// URL de webhook para notificaciones
    String? webhookUrl,

    /// Tiempo de expiración en minutos (por defecto 30)
    @Default(30) int expirationMinutes,

    /// Datos del cliente
    TropipayCustomerData? customer,

    /// Datos de la tarjeta (para pagos con tarjeta)
    TropipayCardData? cardData,

    /// Datos adicionales
    @Default({}) Map<String, dynamic> metadata,

    /// Indica si es un pago de prueba
    @Default(false) bool isTestMode,
  }) = _TropipayPaymentRequest;

  factory TropipayPaymentRequest.fromJson(Map<String, dynamic> json) =>
      _$TropipayPaymentRequestFromJson(json);

  /// Crea una request desde un pago existente
  factory TropipayPaymentRequest.fromPayment({
    required double amount,
    required String description,
    required String userId,
    required String placeId,
    String? reservationId,
    PaymentMethod? paymentMethod,
    String? returnUrl,
    String? cancelUrl,
    String? webhookUrl,
    Map<String, dynamic>? metadata,
  }) {
    return TropipayPaymentRequest(
      amount: amount,
      description: description,
      userId: userId,
      placeId: placeId,
      reservationId: reservationId,
      paymentMethod: paymentMethod ?? const PaymentMethod.card(),
      returnUrl: returnUrl,
      cancelUrl: cancelUrl,
      webhookUrl: webhookUrl,
      metadata: metadata ?? {},
    );
  }
}

/// Datos del cliente para Tropipay
@freezed
sealed class TropipayCustomerData with _$TropipayCustomerData {
  const factory TropipayCustomerData({
    /// Nombre completo del cliente
    required String fullName,

    /// Email del cliente
    required String email,

    /// Teléfono del cliente
    String? phone,

    /// Dirección del cliente
    String? address,

    /// Ciudad
    String? city,

    /// País
    @Default('CU') String country,

    /// Código postal
    String? postalCode,

    /// Documento de identidad
    String? documentId,

    /// Tipo de documento
    String? documentType,
  }) = _TropipayCustomerData;

  factory TropipayCustomerData.fromJson(Map<String, dynamic> json) =>
      _$TropipayCustomerDataFromJson(json);
}

/// Datos de la tarjeta para Tropipay
@freezed
sealed class TropipayCardData with _$TropipayCardData {
  const factory TropipayCardData({
    /// Número de tarjeta (sin espacios ni guiones)
    required String cardNumber,

    /// Mes de expiración (1-12)
    required int expiryMonth,

    /// Año de expiración (4 dígitos)
    required int expiryYear,

    /// Código de seguridad (CVV/CVC)
    required String cvv,

    /// Nombre del titular de la tarjeta
    required String cardholderName,

    /// Tipo de tarjeta (opcional, se detecta automáticamente)
    String? cardType,

    /// País de emisión de la tarjeta
    String? country,
  }) = _TropipayCardData;

  factory TropipayCardData.fromJson(Map<String, dynamic> json) =>
      _$TropipayCardDataFromJson(json);

  /// Obtiene el número de tarjeta enmascarado para mostrar
  static String getMaskedCardNumber(String cardNumber) {
    if (cardNumber.length < 4) return '****';

    final lastFour = cardNumber.substring(cardNumber.length - 4);
    final masked = '*' * (cardNumber.length - 4);

    return '$masked$lastFour';
  }
}

/// Extensión para TropipayCardData
extension TropipayCardDataExtension on TropipayCardData {
  /// Valida los datos de la tarjeta
  bool isValid() {
    // Validar número de tarjeta (básico)
    if (cardNumber.length < 13 || cardNumber.length > 19) return false;

    // Validar mes de expiración
    if (expiryMonth < 1 || expiryMonth > 12) return false;

    // Validar año de expiración
    final currentYear = DateTime.now().year;
    if (expiryYear < currentYear || expiryYear > currentYear + 10) return false;

    // Validar CVV
    if (cvv.length < 3 || cvv.length > 4) return false;

    // Validar nombre del titular
    if (cardholderName.trim().isEmpty) return false;

    return true;
  }

  /// Detecta el tipo de tarjeta basado en el número
  String detectCardType() {
    final number = cardNumber.replaceAll(RegExp(r'\D'), '');

    if (number.startsWith('4')) return 'visa';
    if (number.startsWith('5') || number.startsWith('2')) return 'mastercard';
    if (number.startsWith('3')) return 'amex';
    if (number.startsWith('6')) return 'discover';

    return 'unknown';
  }
}

/// Extensión para TropipayPaymentRequest
extension TropipayPaymentRequestExtension on TropipayPaymentRequest {
  /// Convierte a formato JSON para la API de Tropipay
  Map<String, dynamic> toTropipayApiFormat() {
    final request = {
      'amount': amount,
      'currency': currency,
      'description': description,
      'payment_method': paymentMethod.value,
      'external_reference':
          externalReference ??
          '${placeId}_${DateTime.now().millisecondsSinceEpoch}',
      'return_url': returnUrl,
      'cancel_url': cancelUrl,
      'webhook_url': webhookUrl,
      'expiration_minutes': expirationMinutes,
      'test_mode': isTestMode,
      'metadata': {
        ...metadata,
        'user_id': userId,
        'place_id': placeId,
        'reservation_id': reservationId,
      },
    };

    // Agregar datos del cliente si están disponibles
    if (customer != null) {
      request['customer'] = customer!.toJson();
    }

    // Agregar datos de la tarjeta si están disponibles
    if (cardData != null && paymentMethod == const PaymentMethod.card()) {
      request['card_data'] = cardData!.toJson();
    }

    return request;
  }

  /// Valida la request antes de enviar
  List<String> validate() {
    final errors = <String>[];

    if (amount <= 0) {
      errors.add('El monto debe ser mayor a 0');
    }

    if (amount > 1000000) {
      // Límite de 1M CUP
      errors.add('El monto excede el límite máximo permitido');
    }

    if (description.trim().isEmpty) {
      errors.add('La descripción es requerida');
    }

    if (userId.trim().isEmpty) {
      errors.add('El ID del usuario es requerido');
    }

    if (placeId.trim().isEmpty) {
      errors.add('El ID del lugar es requerido');
    }

    if (paymentMethod == const PaymentMethod.card() && cardData != null) {
      if (!cardData!.isValid()) {
        errors.add('Los datos de la tarjeta no son válidos');
      }
    }

    if (customer != null) {
      if (customer!.fullName.trim().isEmpty) {
        errors.add('El nombre del cliente es requerido');
      }
      if (customer!.email.trim().isEmpty) {
        errors.add('El email del cliente es requerido');
      }
    }

    return errors;
  }

  /// Obtiene el tiempo de expiración como DateTime
  DateTime get expirationDateTime {
    return DateTime.now().add(Duration(minutes: expirationMinutes));
  }
}
