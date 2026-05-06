// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentTransaction _$PaymentTransactionFromJson(Map<String, dynamic> json) =>
    _PaymentTransaction(
      id: json['id'] as String,
      paymentId: json['paymentId'] as String,
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
      type: const PaymentTransactionTypeConverter().fromJson(
        json['type'] as String,
      ),
      status: const PaymentStatusConverter().fromJson(json['status'] as String),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'CUP',
      description: json['description'] as String?,
      gatewayTransactionId: json['gatewayTransactionId'] as String?,
      authorizationCode: json['authorizationCode'] as String?,
      externalReference: json['externalReference'] as String?,
      transactionDate: json['transactionDate'] == null
          ? null
          : DateTime.parse(json['transactionDate'] as String),
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      failureReason: json['failureReason'] as String?,
      fee: (json['fee'] as num?)?.toDouble(),
      cardLastFourDigits: json['cardLastFourDigits'] as String?,
      cardType: json['cardType'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$PaymentTransactionToJson(_PaymentTransaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'paymentId': instance.paymentId,
      'payment': instance.payment,
      'type': const PaymentTransactionTypeConverter().toJson(instance.type),
      'status': const PaymentStatusConverter().toJson(instance.status),
      'amount': instance.amount,
      'currency': instance.currency,
      'description': instance.description,
      'gatewayTransactionId': instance.gatewayTransactionId,
      'authorizationCode': instance.authorizationCode,
      'externalReference': instance.externalReference,
      'transactionDate': instance.transactionDate?.toIso8601String(),
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'metadata': instance.metadata,
      'failureReason': instance.failureReason,
      'fee': instance.fee,
      'cardLastFourDigits': instance.cardLastFourDigits,
      'cardType': instance.cardType,
      'country': instance.country,
    };
