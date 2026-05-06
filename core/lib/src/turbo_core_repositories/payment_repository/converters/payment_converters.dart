import 'package:json_annotation/json_annotation.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_method.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_status.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/payment_transaction.dart';
import 'package:core/src/turbo_core_repositories/payment_repository/models/tropipay_webhook.dart';

/// Converter para PaymentMethod
class PaymentMethodConverter implements JsonConverter<PaymentMethod, String> {
  const PaymentMethodConverter();

  @override
  PaymentMethod fromJson(String json) {
    return PaymentMethodExtension.fromString(json);
  }

  @override
  String toJson(PaymentMethod object) {
    return object.value;
  }
}

/// Converter para PaymentStatus
class PaymentStatusConverter implements JsonConverter<PaymentStatus, String> {
  const PaymentStatusConverter();

  @override
  PaymentStatus fromJson(String json) {
    return PaymentStatusExtension.fromString(json);
  }

  @override
  String toJson(PaymentStatus object) {
    return object.value;
  }
}

/// Converter para PaymentTransactionType
class PaymentTransactionTypeConverter
    implements JsonConverter<PaymentTransactionType, String> {
  const PaymentTransactionTypeConverter();

  @override
  PaymentTransactionType fromJson(String json) {
    return PaymentTransactionTypeExtension.fromString(json);
  }

  @override
  String toJson(PaymentTransactionType object) {
    return object.value;
  }
}

/// Converter para TropipayWebhookEventType
class TropipayWebhookEventTypeConverter
    implements JsonConverter<TropipayWebhookEventType, String> {
  const TropipayWebhookEventTypeConverter();

  @override
  TropipayWebhookEventType fromJson(String json) {
    return TropipayWebhookEventTypeExtension.fromString(json);
  }

  @override
  String toJson(TropipayWebhookEventType object) {
    return object.value;
  }
}

