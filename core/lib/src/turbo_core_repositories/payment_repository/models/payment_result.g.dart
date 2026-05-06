// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaymentResult _$PaymentResultFromJson(Map<String, dynamic> json) =>
    _PaymentResult(
      success: json['success'] as bool,
      status: const PaymentStatusConverter().fromJson(json['status'] as String),
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
      transactionId: json['transactionId'] as String?,
      redirectUrl: json['redirectUrl'] as String?,
      paymentUrl: json['paymentUrl'] as String?,
      message: json['message'] as String?,
      errorCode: json['errorCode'] as String?,
      errorDetails: json['errorDetails'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
      timestamp: json['timestamp'] == null
          ? null
          : DateTime.parse(json['timestamp'] as String),
    );

Map<String, dynamic> _$PaymentResultToJson(_PaymentResult instance) =>
    <String, dynamic>{
      'success': instance.success,
      'status': const PaymentStatusConverter().toJson(instance.status),
      'payment': instance.payment,
      'transactionId': instance.transactionId,
      'redirectUrl': instance.redirectUrl,
      'paymentUrl': instance.paymentUrl,
      'message': instance.message,
      'errorCode': instance.errorCode,
      'errorDetails': instance.errorDetails,
      'metadata': instance.metadata,
      'timestamp': instance.timestamp?.toIso8601String(),
    };
