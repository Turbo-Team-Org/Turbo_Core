// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tropipay_webhook.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TropipayWebhook _$TropipayWebhookFromJson(Map<String, dynamic> json) =>
    _TropipayWebhook(
      id: json['id'] as String,
      transactionId: json['transactionId'] as String,
      paymentId: json['paymentId'] as String?,
      eventType: const TropipayWebhookEventTypeConverter().fromJson(
        json['eventType'] as String,
      ),
      status: const PaymentStatusConverter().fromJson(json['status'] as String),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'CUP',
      externalReference: json['externalReference'] as String?,
      timestamp: DateTime.parse(json['timestamp'] as String),
      signature: json['signature'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      eventData: json['eventData'] == null
          ? null
          : TropipayWebhookEventData.fromJson(
              json['eventData'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TropipayWebhookToJson(_TropipayWebhook instance) =>
    <String, dynamic>{
      'id': instance.id,
      'transactionId': instance.transactionId,
      'paymentId': instance.paymentId,
      'eventType': const TropipayWebhookEventTypeConverter().toJson(
        instance.eventType,
      ),
      'status': const PaymentStatusConverter().toJson(instance.status),
      'amount': instance.amount,
      'currency': instance.currency,
      'externalReference': instance.externalReference,
      'timestamp': instance.timestamp.toIso8601String(),
      'signature': instance.signature,
      'metadata': instance.metadata,
      'eventData': instance.eventData,
    };

_TropipayWebhookEventData _$TropipayWebhookEventDataFromJson(
  Map<String, dynamic> json,
) => _TropipayWebhookEventData(
  authorizationCode: json['authorizationCode'] as String?,
  failureReason: json['failureReason'] as String?,
  customerData: json['customerData'] as Map<String, dynamic>?,
  cardData: json['cardData'] as Map<String, dynamic>?,
  feeData: json['feeData'] as Map<String, dynamic>?,
  redirectUrl: json['redirectUrl'] as String?,
  additionalData: json['additionalData'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$TropipayWebhookEventDataToJson(
  _TropipayWebhookEventData instance,
) => <String, dynamic>{
  'authorizationCode': instance.authorizationCode,
  'failureReason': instance.failureReason,
  'customerData': instance.customerData,
  'cardData': instance.cardData,
  'feeData': instance.feeData,
  'redirectUrl': instance.redirectUrl,
  'additionalData': instance.additionalData,
};
