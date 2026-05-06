// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tropipay_payment_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TropipayPaymentResponse _$TropipayPaymentResponseFromJson(
  Map<String, dynamic> json,
) => _TropipayPaymentResponse(
  success: json['success'] as bool,
  transactionId: json['transactionId'] as String?,
  paymentId: json['paymentId'] as String?,
  status: const PaymentStatusConverter().fromJson(json['status'] as String),
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'CUP',
  description: json['description'] as String?,
  redirectUrl: json['redirectUrl'] as String?,
  paymentUrl: json['paymentUrl'] as String?,
  externalReference: json['externalReference'] as String?,
  authorizationCode: json['authorizationCode'] as String?,
  message: json['message'] as String?,
  errorCode: json['errorCode'] as String?,
  errorDetails: json['errorDetails'] as String?,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  expiresAt: json['expiresAt'] == null
      ? null
      : DateTime.parse(json['expiresAt'] as String),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  customer: json['customer'] == null
      ? null
      : TropipayResponseCustomerData.fromJson(
          json['customer'] as Map<String, dynamic>,
        ),
  cardData: json['cardData'] == null
      ? null
      : TropipayResponseCardData.fromJson(
          json['cardData'] as Map<String, dynamic>,
        ),
  fees: json['fees'] == null
      ? null
      : TropipayFeeData.fromJson(json['fees'] as Map<String, dynamic>),
);

Map<String, dynamic> _$TropipayPaymentResponseToJson(
  _TropipayPaymentResponse instance,
) => <String, dynamic>{
  'success': instance.success,
  'transactionId': instance.transactionId,
  'paymentId': instance.paymentId,
  'status': const PaymentStatusConverter().toJson(instance.status),
  'amount': instance.amount,
  'currency': instance.currency,
  'description': instance.description,
  'redirectUrl': instance.redirectUrl,
  'paymentUrl': instance.paymentUrl,
  'externalReference': instance.externalReference,
  'authorizationCode': instance.authorizationCode,
  'message': instance.message,
  'errorCode': instance.errorCode,
  'errorDetails': instance.errorDetails,
  'createdAt': instance.createdAt?.toIso8601String(),
  'expiresAt': instance.expiresAt?.toIso8601String(),
  'metadata': instance.metadata,
  'customer': instance.customer,
  'cardData': instance.cardData,
  'fees': instance.fees,
};

_TropipayResponseCustomerData _$TropipayResponseCustomerDataFromJson(
  Map<String, dynamic> json,
) => _TropipayResponseCustomerData(
  fullName: json['fullName'] as String?,
  email: json['email'] as String?,
  phone: json['phone'] as String?,
  customerId: json['customerId'] as String?,
);

Map<String, dynamic> _$TropipayResponseCustomerDataToJson(
  _TropipayResponseCustomerData instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'customerId': instance.customerId,
};

_TropipayResponseCardData _$TropipayResponseCardDataFromJson(
  Map<String, dynamic> json,
) => _TropipayResponseCardData(
  lastFourDigits: json['lastFourDigits'] as String?,
  cardType: json['cardType'] as String?,
  country: json['country'] as String?,
  bankName: json['bankName'] as String?,
);

Map<String, dynamic> _$TropipayResponseCardDataToJson(
  _TropipayResponseCardData instance,
) => <String, dynamic>{
  'lastFourDigits': instance.lastFourDigits,
  'cardType': instance.cardType,
  'country': instance.country,
  'bankName': instance.bankName,
};

_TropipayFeeData _$TropipayFeeDataFromJson(Map<String, dynamic> json) =>
    _TropipayFeeData(
      tropipayFee: (json['tropipayFee'] as num?)?.toDouble(),
      bankFee: (json['bankFee'] as num?)?.toDouble(),
      totalFee: (json['totalFee'] as num?)?.toDouble(),
      netAmount: (json['netAmount'] as num?)?.toDouble(),
      feePercentage: (json['feePercentage'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$TropipayFeeDataToJson(_TropipayFeeData instance) =>
    <String, dynamic>{
      'tropipayFee': instance.tropipayFee,
      'bankFee': instance.bankFee,
      'totalFee': instance.totalFee,
      'netAmount': instance.netAmount,
      'feePercentage': instance.feePercentage,
    };
