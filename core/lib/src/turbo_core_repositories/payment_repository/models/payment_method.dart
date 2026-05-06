import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment_method.freezed.dart';

/// Métodos de pago disponibles
@freezed
sealed class PaymentMethod with _$PaymentMethod {
  /// Tarjeta de crédito/débito
  const factory PaymentMethod.card() = PaymentMethodCard;

  /// Transferencia bancaria
  const factory PaymentMethod.bankTransfer() = PaymentMethodBankTransfer;

  /// PayPal
  const factory PaymentMethod.paypal() = PaymentMethodPaypal;

  /// Transferencia móvil (Enzona, Transfermóvil, etc.)
  const factory PaymentMethod.mobileTransfer() = PaymentMethodMobileTransfer;

  /// Pago en efectivo
  const factory PaymentMethod.cash() = PaymentMethodCash;

  /// Método personalizado
  const factory PaymentMethod.custom(String method) = PaymentMethodCustom;
}

/// Extensión para obtener valores string del método de pago
extension PaymentMethodExtension on PaymentMethod {
  /// Obtiene el valor string del método para APIs
  String get value {
    return when(
      card: () => 'card',
      bankTransfer: () => 'bank_transfer',
      paypal: () => 'paypal',
      mobileTransfer: () => 'mobile_transfer',
      cash: () => 'cash',
      custom: (method) => method,
    );
  }

  /// Obtiene el método desde un string
  static PaymentMethod fromString(String value) {
    switch (value.toLowerCase()) {
      case 'card':
      case 'credit_card':
      case 'debit_card':
        return const PaymentMethod.card();
      case 'bank_transfer':
      case 'wire_transfer':
        return const PaymentMethod.bankTransfer();
      case 'paypal':
        return const PaymentMethod.paypal();
      case 'mobile_transfer':
      case 'mobile_payment':
        return const PaymentMethod.mobileTransfer();
      case 'cash':
      case 'cash_payment':
        return const PaymentMethod.cash();
      default:
        return PaymentMethod.custom(value);
    }
  }

  /// Obtiene el nombre para mostrar en UI
  String get displayName {
    return when(
      card: () => 'Tarjeta de Crédito/Débito',
      bankTransfer: () => 'Transferencia Bancaria',
      paypal: () => 'PayPal',
      mobileTransfer: () => 'Transferencia Móvil',
      cash: () => 'Efectivo',
      custom: (method) => method,
    );
  }

  /// Obtiene el icono asociado al método
  String get iconName {
    return when(
      card: () => 'credit_card',
      bankTransfer: () => 'account_balance',
      paypal: () => 'paypal',
      mobileTransfer: () => 'phone_android',
      cash: () => 'money',
      custom: (method) => 'payment',
    );
  }

  /// Verifica si el método requiere procesamiento online
  bool get requiresOnlineProcessing {
    return when(
      card: () => true,
      bankTransfer: () => true,
      paypal: () => true,
      mobileTransfer: () => true,
      cash: () => false,
      custom: (method) => false,
    );
  }

  /// Verifica si el método está disponible para Tropipay
  bool get isTropipaySupported {
    return when(
      card: () => true,
      bankTransfer: () => true,
      mobileTransfer: () => true,
      paypal: () => false, // Tropipay no soporta PayPal directamente
      cash: () => false,
      custom: (method) => false,
    );
  }
}

