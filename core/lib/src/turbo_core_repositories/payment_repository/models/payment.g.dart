// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Payment _$PaymentFromJson(Map<String, dynamic> json) => _Payment(
  id: json['id'] as String,
  userId: json['userId'] as String,
  placeId: json['placeId'] as String,
  reservationId: json['reservationId'] as String?,
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'CUP',
  paymentMethod: const PaymentMethodConverter().fromJson(
    json['paymentMethod'] as String,
  ),
  status: const PaymentStatusConverter().fromJson(json['status'] as String),
  description: json['description'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  returnUrl: json['returnUrl'] as String?,
  cancelUrl: json['cancelUrl'] as String?,
  gatewayTransactionId: json['gatewayTransactionId'] as String?,
  externalReference: json['externalReference'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  processedAt: json['processedAt'] == null
      ? null
      : DateTime.parse(json['processedAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  failureReason: json['failureReason'] as String?,
  cardLastFourDigits: json['cardLastFourDigits'] as String?,
  cardType: json['cardType'] as String?,
  country: json['country'] as String?,
  clientIp: json['clientIp'] as String?,
  userAgent: json['userAgent'] as String?,
  gatewayFee: (json['gatewayFee'] as num?)?.toDouble(),
  platformFee: (json['platformFee'] as num?)?.toDouble(),
  netAmount: (json['netAmount'] as num?)?.toDouble(),
);

Map<String, dynamic> _$PaymentToJson(_Payment instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'placeId': instance.placeId,
  'reservationId': instance.reservationId,
  'amount': instance.amount,
  'currency': instance.currency,
  'paymentMethod': const PaymentMethodConverter().toJson(
    instance.paymentMethod,
  ),
  'status': const PaymentStatusConverter().toJson(instance.status),
  'description': instance.description,
  'metadata': instance.metadata,
  'returnUrl': instance.returnUrl,
  'cancelUrl': instance.cancelUrl,
  'gatewayTransactionId': instance.gatewayTransactionId,
  'externalReference': instance.externalReference,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'processedAt': instance.processedAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'failureReason': instance.failureReason,
  'cardLastFourDigits': instance.cardLastFourDigits,
  'cardType': instance.cardType,
  'country': instance.country,
  'clientIp': instance.clientIp,
  'userAgent': instance.userAgent,
  'gatewayFee': instance.gatewayFee,
  'platformFee': instance.platformFee,
  'netAmount': instance.netAmount,
};
