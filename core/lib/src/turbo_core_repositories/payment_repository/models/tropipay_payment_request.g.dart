// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tropipay_payment_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_TropipayPaymentRequest _$TropipayPaymentRequestFromJson(
  Map<String, dynamic> json,
) => _TropipayPaymentRequest(
  amount: (json['amount'] as num).toDouble(),
  currency: json['currency'] as String? ?? 'CUP',
  description: json['description'] as String,
  paymentMethod: json['paymentMethod'] == null
      ? const PaymentMethod.card()
      : const PaymentMethodConverter().fromJson(
          json['paymentMethod'] as String,
        ),
  userId: json['userId'] as String,
  placeId: json['placeId'] as String,
  reservationId: json['reservationId'] as String?,
  externalReference: json['externalReference'] as String?,
  returnUrl: json['returnUrl'] as String?,
  cancelUrl: json['cancelUrl'] as String?,
  webhookUrl: json['webhookUrl'] as String?,
  expirationMinutes: (json['expirationMinutes'] as num?)?.toInt() ?? 30,
  customer: json['customer'] == null
      ? null
      : TropipayCustomerData.fromJson(json['customer'] as Map<String, dynamic>),
  cardData: json['cardData'] == null
      ? null
      : TropipayCardData.fromJson(json['cardData'] as Map<String, dynamic>),
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  isTestMode: json['isTestMode'] as bool? ?? false,
);

Map<String, dynamic> _$TropipayPaymentRequestToJson(
  _TropipayPaymentRequest instance,
) => <String, dynamic>{
  'amount': instance.amount,
  'currency': instance.currency,
  'description': instance.description,
  'paymentMethod': const PaymentMethodConverter().toJson(
    instance.paymentMethod,
  ),
  'userId': instance.userId,
  'placeId': instance.placeId,
  'reservationId': instance.reservationId,
  'externalReference': instance.externalReference,
  'returnUrl': instance.returnUrl,
  'cancelUrl': instance.cancelUrl,
  'webhookUrl': instance.webhookUrl,
  'expirationMinutes': instance.expirationMinutes,
  'customer': instance.customer,
  'cardData': instance.cardData,
  'metadata': instance.metadata,
  'isTestMode': instance.isTestMode,
};

_TropipayCustomerData _$TropipayCustomerDataFromJson(
  Map<String, dynamic> json,
) => _TropipayCustomerData(
  fullName: json['fullName'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
  city: json['city'] as String?,
  country: json['country'] as String? ?? 'CU',
  postalCode: json['postalCode'] as String?,
  documentId: json['documentId'] as String?,
  documentType: json['documentType'] as String?,
);

Map<String, dynamic> _$TropipayCustomerDataToJson(
  _TropipayCustomerData instance,
) => <String, dynamic>{
  'fullName': instance.fullName,
  'email': instance.email,
  'phone': instance.phone,
  'address': instance.address,
  'city': instance.city,
  'country': instance.country,
  'postalCode': instance.postalCode,
  'documentId': instance.documentId,
  'documentType': instance.documentType,
};

_TropipayCardData _$TropipayCardDataFromJson(Map<String, dynamic> json) =>
    _TropipayCardData(
      cardNumber: json['cardNumber'] as String,
      expiryMonth: (json['expiryMonth'] as num).toInt(),
      expiryYear: (json['expiryYear'] as num).toInt(),
      cvv: json['cvv'] as String,
      cardholderName: json['cardholderName'] as String,
      cardType: json['cardType'] as String?,
      country: json['country'] as String?,
    );

Map<String, dynamic> _$TropipayCardDataToJson(_TropipayCardData instance) =>
    <String, dynamic>{
      'cardNumber': instance.cardNumber,
      'expiryMonth': instance.expiryMonth,
      'expiryYear': instance.expiryYear,
      'cvv': instance.cvv,
      'cardholderName': instance.cardholderName,
      'cardType': instance.cardType,
      'country': instance.country,
    };
