// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tropipay_payment_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TropipayPaymentRequest {

/// Monto del pago
 double get amount;/// Moneda (CUP por defecto)
 String get currency;/// Descripción del pago
 String get description;/// Método de pago preferido
@PaymentMethodConverter() PaymentMethod get paymentMethod;/// ID del usuario que realiza el pago
 String get userId;/// ID del lugar/negocio
 String get placeId;/// ID de la reserva (opcional)
 String? get reservationId;/// Referencia externa (número de orden, etc.)
 String? get externalReference;/// URL de retorno después del pago
 String? get returnUrl;/// URL de cancelación
 String? get cancelUrl;/// URL de webhook para notificaciones
 String? get webhookUrl;/// Tiempo de expiración en minutos (por defecto 30)
 int get expirationMinutes;/// Datos del cliente
 TropipayCustomerData? get customer;/// Datos de la tarjeta (para pagos con tarjeta)
 TropipayCardData? get cardData;/// Datos adicionales
 Map<String, dynamic> get metadata;/// Indica si es un pago de prueba
 bool get isTestMode;
/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayPaymentRequestCopyWith<TropipayPaymentRequest> get copyWith => _$TropipayPaymentRequestCopyWithImpl<TropipayPaymentRequest>(this as TropipayPaymentRequest, _$identity);

  /// Serializes this TropipayPaymentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayPaymentRequest&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl)&&(identical(other.webhookUrl, webhookUrl) || other.webhookUrl == webhookUrl)&&(identical(other.expirationMinutes, expirationMinutes) || other.expirationMinutes == expirationMinutes)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.cardData, cardData) || other.cardData == cardData)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.isTestMode, isTestMode) || other.isTestMode == isTestMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency,description,paymentMethod,userId,placeId,reservationId,externalReference,returnUrl,cancelUrl,webhookUrl,expirationMinutes,customer,cardData,const DeepCollectionEquality().hash(metadata),isTestMode);

@override
String toString() {
  return 'TropipayPaymentRequest(amount: $amount, currency: $currency, description: $description, paymentMethod: $paymentMethod, userId: $userId, placeId: $placeId, reservationId: $reservationId, externalReference: $externalReference, returnUrl: $returnUrl, cancelUrl: $cancelUrl, webhookUrl: $webhookUrl, expirationMinutes: $expirationMinutes, customer: $customer, cardData: $cardData, metadata: $metadata, isTestMode: $isTestMode)';
}


}

/// @nodoc
abstract mixin class $TropipayPaymentRequestCopyWith<$Res>  {
  factory $TropipayPaymentRequestCopyWith(TropipayPaymentRequest value, $Res Function(TropipayPaymentRequest) _then) = _$TropipayPaymentRequestCopyWithImpl;
@useResult
$Res call({
 double amount, String currency, String description,@PaymentMethodConverter() PaymentMethod paymentMethod, String userId, String placeId, String? reservationId, String? externalReference, String? returnUrl, String? cancelUrl, String? webhookUrl, int expirationMinutes, TropipayCustomerData? customer, TropipayCardData? cardData, Map<String, dynamic> metadata, bool isTestMode
});


$PaymentMethodCopyWith<$Res> get paymentMethod;$TropipayCustomerDataCopyWith<$Res>? get customer;$TropipayCardDataCopyWith<$Res>? get cardData;

}
/// @nodoc
class _$TropipayPaymentRequestCopyWithImpl<$Res>
    implements $TropipayPaymentRequestCopyWith<$Res> {
  _$TropipayPaymentRequestCopyWithImpl(this._self, this._then);

  final TropipayPaymentRequest _self;
  final $Res Function(TropipayPaymentRequest) _then;

/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? currency = null,Object? description = null,Object? paymentMethod = null,Object? userId = null,Object? placeId = null,Object? reservationId = freezed,Object? externalReference = freezed,Object? returnUrl = freezed,Object? cancelUrl = freezed,Object? webhookUrl = freezed,Object? expirationMinutes = null,Object? customer = freezed,Object? cardData = freezed,Object? metadata = null,Object? isTestMode = null,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,reservationId: freezed == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,webhookUrl: freezed == webhookUrl ? _self.webhookUrl : webhookUrl // ignore: cast_nullable_to_non_nullable
as String?,expirationMinutes: null == expirationMinutes ? _self.expirationMinutes : expirationMinutes // ignore: cast_nullable_to_non_nullable
as int,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as TropipayCustomerData?,cardData: freezed == cardData ? _self.cardData : cardData // ignore: cast_nullable_to_non_nullable
as TropipayCardData?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isTestMode: null == isTestMode ? _self.isTestMode : isTestMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayCustomerDataCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $TropipayCustomerDataCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayCardDataCopyWith<$Res>? get cardData {
    if (_self.cardData == null) {
    return null;
  }

  return $TropipayCardDataCopyWith<$Res>(_self.cardData!, (value) {
    return _then(_self.copyWith(cardData: value));
  });
}
}


/// Adds pattern-matching-related methods to [TropipayPaymentRequest].
extension TropipayPaymentRequestPatterns on TropipayPaymentRequest {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayPaymentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayPaymentRequest() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayPaymentRequest value)  $default,){
final _that = this;
switch (_that) {
case _TropipayPaymentRequest():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayPaymentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayPaymentRequest() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String currency,  String description, @PaymentMethodConverter()  PaymentMethod paymentMethod,  String userId,  String placeId,  String? reservationId,  String? externalReference,  String? returnUrl,  String? cancelUrl,  String? webhookUrl,  int expirationMinutes,  TropipayCustomerData? customer,  TropipayCardData? cardData,  Map<String, dynamic> metadata,  bool isTestMode)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayPaymentRequest() when $default != null:
return $default(_that.amount,_that.currency,_that.description,_that.paymentMethod,_that.userId,_that.placeId,_that.reservationId,_that.externalReference,_that.returnUrl,_that.cancelUrl,_that.webhookUrl,_that.expirationMinutes,_that.customer,_that.cardData,_that.metadata,_that.isTestMode);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String currency,  String description, @PaymentMethodConverter()  PaymentMethod paymentMethod,  String userId,  String placeId,  String? reservationId,  String? externalReference,  String? returnUrl,  String? cancelUrl,  String? webhookUrl,  int expirationMinutes,  TropipayCustomerData? customer,  TropipayCardData? cardData,  Map<String, dynamic> metadata,  bool isTestMode)  $default,) {final _that = this;
switch (_that) {
case _TropipayPaymentRequest():
return $default(_that.amount,_that.currency,_that.description,_that.paymentMethod,_that.userId,_that.placeId,_that.reservationId,_that.externalReference,_that.returnUrl,_that.cancelUrl,_that.webhookUrl,_that.expirationMinutes,_that.customer,_that.cardData,_that.metadata,_that.isTestMode);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String currency,  String description, @PaymentMethodConverter()  PaymentMethod paymentMethod,  String userId,  String placeId,  String? reservationId,  String? externalReference,  String? returnUrl,  String? cancelUrl,  String? webhookUrl,  int expirationMinutes,  TropipayCustomerData? customer,  TropipayCardData? cardData,  Map<String, dynamic> metadata,  bool isTestMode)?  $default,) {final _that = this;
switch (_that) {
case _TropipayPaymentRequest() when $default != null:
return $default(_that.amount,_that.currency,_that.description,_that.paymentMethod,_that.userId,_that.placeId,_that.reservationId,_that.externalReference,_that.returnUrl,_that.cancelUrl,_that.webhookUrl,_that.expirationMinutes,_that.customer,_that.cardData,_that.metadata,_that.isTestMode);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayPaymentRequest implements TropipayPaymentRequest {
  const _TropipayPaymentRequest({required this.amount, this.currency = 'CUP', required this.description, @PaymentMethodConverter() this.paymentMethod = const PaymentMethod.card(), required this.userId, required this.placeId, this.reservationId, this.externalReference, this.returnUrl, this.cancelUrl, this.webhookUrl, this.expirationMinutes = 30, this.customer, this.cardData, final  Map<String, dynamic> metadata = const {}, this.isTestMode = false}): _metadata = metadata;
  factory _TropipayPaymentRequest.fromJson(Map<String, dynamic> json) => _$TropipayPaymentRequestFromJson(json);

/// Monto del pago
@override final  double amount;
/// Moneda (CUP por defecto)
@override@JsonKey() final  String currency;
/// Descripción del pago
@override final  String description;
/// Método de pago preferido
@override@JsonKey()@PaymentMethodConverter() final  PaymentMethod paymentMethod;
/// ID del usuario que realiza el pago
@override final  String userId;
/// ID del lugar/negocio
@override final  String placeId;
/// ID de la reserva (opcional)
@override final  String? reservationId;
/// Referencia externa (número de orden, etc.)
@override final  String? externalReference;
/// URL de retorno después del pago
@override final  String? returnUrl;
/// URL de cancelación
@override final  String? cancelUrl;
/// URL de webhook para notificaciones
@override final  String? webhookUrl;
/// Tiempo de expiración en minutos (por defecto 30)
@override@JsonKey() final  int expirationMinutes;
/// Datos del cliente
@override final  TropipayCustomerData? customer;
/// Datos de la tarjeta (para pagos con tarjeta)
@override final  TropipayCardData? cardData;
/// Datos adicionales
 final  Map<String, dynamic> _metadata;
/// Datos adicionales
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// Indica si es un pago de prueba
@override@JsonKey() final  bool isTestMode;

/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayPaymentRequestCopyWith<_TropipayPaymentRequest> get copyWith => __$TropipayPaymentRequestCopyWithImpl<_TropipayPaymentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayPaymentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayPaymentRequest&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl)&&(identical(other.webhookUrl, webhookUrl) || other.webhookUrl == webhookUrl)&&(identical(other.expirationMinutes, expirationMinutes) || other.expirationMinutes == expirationMinutes)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.cardData, cardData) || other.cardData == cardData)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.isTestMode, isTestMode) || other.isTestMode == isTestMode));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency,description,paymentMethod,userId,placeId,reservationId,externalReference,returnUrl,cancelUrl,webhookUrl,expirationMinutes,customer,cardData,const DeepCollectionEquality().hash(_metadata),isTestMode);

@override
String toString() {
  return 'TropipayPaymentRequest(amount: $amount, currency: $currency, description: $description, paymentMethod: $paymentMethod, userId: $userId, placeId: $placeId, reservationId: $reservationId, externalReference: $externalReference, returnUrl: $returnUrl, cancelUrl: $cancelUrl, webhookUrl: $webhookUrl, expirationMinutes: $expirationMinutes, customer: $customer, cardData: $cardData, metadata: $metadata, isTestMode: $isTestMode)';
}


}

/// @nodoc
abstract mixin class _$TropipayPaymentRequestCopyWith<$Res> implements $TropipayPaymentRequestCopyWith<$Res> {
  factory _$TropipayPaymentRequestCopyWith(_TropipayPaymentRequest value, $Res Function(_TropipayPaymentRequest) _then) = __$TropipayPaymentRequestCopyWithImpl;
@override @useResult
$Res call({
 double amount, String currency, String description,@PaymentMethodConverter() PaymentMethod paymentMethod, String userId, String placeId, String? reservationId, String? externalReference, String? returnUrl, String? cancelUrl, String? webhookUrl, int expirationMinutes, TropipayCustomerData? customer, TropipayCardData? cardData, Map<String, dynamic> metadata, bool isTestMode
});


@override $PaymentMethodCopyWith<$Res> get paymentMethod;@override $TropipayCustomerDataCopyWith<$Res>? get customer;@override $TropipayCardDataCopyWith<$Res>? get cardData;

}
/// @nodoc
class __$TropipayPaymentRequestCopyWithImpl<$Res>
    implements _$TropipayPaymentRequestCopyWith<$Res> {
  __$TropipayPaymentRequestCopyWithImpl(this._self, this._then);

  final _TropipayPaymentRequest _self;
  final $Res Function(_TropipayPaymentRequest) _then;

/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? currency = null,Object? description = null,Object? paymentMethod = null,Object? userId = null,Object? placeId = null,Object? reservationId = freezed,Object? externalReference = freezed,Object? returnUrl = freezed,Object? cancelUrl = freezed,Object? webhookUrl = freezed,Object? expirationMinutes = null,Object? customer = freezed,Object? cardData = freezed,Object? metadata = null,Object? isTestMode = null,}) {
  return _then(_TropipayPaymentRequest(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,reservationId: freezed == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,webhookUrl: freezed == webhookUrl ? _self.webhookUrl : webhookUrl // ignore: cast_nullable_to_non_nullable
as String?,expirationMinutes: null == expirationMinutes ? _self.expirationMinutes : expirationMinutes // ignore: cast_nullable_to_non_nullable
as int,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as TropipayCustomerData?,cardData: freezed == cardData ? _self.cardData : cardData // ignore: cast_nullable_to_non_nullable
as TropipayCardData?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isTestMode: null == isTestMode ? _self.isTestMode : isTestMode // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayCustomerDataCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $TropipayCustomerDataCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of TropipayPaymentRequest
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayCardDataCopyWith<$Res>? get cardData {
    if (_self.cardData == null) {
    return null;
  }

  return $TropipayCardDataCopyWith<$Res>(_self.cardData!, (value) {
    return _then(_self.copyWith(cardData: value));
  });
}
}


/// @nodoc
mixin _$TropipayCustomerData {

/// Nombre completo del cliente
 String get fullName;/// Email del cliente
 String get email;/// Teléfono del cliente
 String? get phone;/// Dirección del cliente
 String? get address;/// Ciudad
 String? get city;/// País
 String get country;/// Código postal
 String? get postalCode;/// Documento de identidad
 String? get documentId;/// Tipo de documento
 String? get documentType;
/// Create a copy of TropipayCustomerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayCustomerDataCopyWith<TropipayCustomerData> get copyWith => _$TropipayCustomerDataCopyWithImpl<TropipayCustomerData>(this as TropipayCustomerData, _$identity);

  /// Serializes this TropipayCustomerData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayCustomerData&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.documentType, documentType) || other.documentType == documentType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,address,city,country,postalCode,documentId,documentType);

@override
String toString() {
  return 'TropipayCustomerData(fullName: $fullName, email: $email, phone: $phone, address: $address, city: $city, country: $country, postalCode: $postalCode, documentId: $documentId, documentType: $documentType)';
}


}

/// @nodoc
abstract mixin class $TropipayCustomerDataCopyWith<$Res>  {
  factory $TropipayCustomerDataCopyWith(TropipayCustomerData value, $Res Function(TropipayCustomerData) _then) = _$TropipayCustomerDataCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, String? phone, String? address, String? city, String country, String? postalCode, String? documentId, String? documentType
});




}
/// @nodoc
class _$TropipayCustomerDataCopyWithImpl<$Res>
    implements $TropipayCustomerDataCopyWith<$Res> {
  _$TropipayCustomerDataCopyWithImpl(this._self, this._then);

  final TropipayCustomerData _self;
  final $Res Function(TropipayCustomerData) _then;

/// Create a copy of TropipayCustomerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? phone = freezed,Object? address = freezed,Object? city = freezed,Object? country = null,Object? postalCode = freezed,Object? documentId = freezed,Object? documentType = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,documentType: freezed == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TropipayCustomerData].
extension TropipayCustomerDataPatterns on TropipayCustomerData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayCustomerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayCustomerData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayCustomerData value)  $default,){
final _that = this;
switch (_that) {
case _TropipayCustomerData():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayCustomerData value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayCustomerData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String email,  String? phone,  String? address,  String? city,  String country,  String? postalCode,  String? documentId,  String? documentType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayCustomerData() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.address,_that.city,_that.country,_that.postalCode,_that.documentId,_that.documentType);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String email,  String? phone,  String? address,  String? city,  String country,  String? postalCode,  String? documentId,  String? documentType)  $default,) {final _that = this;
switch (_that) {
case _TropipayCustomerData():
return $default(_that.fullName,_that.email,_that.phone,_that.address,_that.city,_that.country,_that.postalCode,_that.documentId,_that.documentType);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String email,  String? phone,  String? address,  String? city,  String country,  String? postalCode,  String? documentId,  String? documentType)?  $default,) {final _that = this;
switch (_that) {
case _TropipayCustomerData() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.address,_that.city,_that.country,_that.postalCode,_that.documentId,_that.documentType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayCustomerData implements TropipayCustomerData {
  const _TropipayCustomerData({required this.fullName, required this.email, this.phone, this.address, this.city, this.country = 'CU', this.postalCode, this.documentId, this.documentType});
  factory _TropipayCustomerData.fromJson(Map<String, dynamic> json) => _$TropipayCustomerDataFromJson(json);

/// Nombre completo del cliente
@override final  String fullName;
/// Email del cliente
@override final  String email;
/// Teléfono del cliente
@override final  String? phone;
/// Dirección del cliente
@override final  String? address;
/// Ciudad
@override final  String? city;
/// País
@override@JsonKey() final  String country;
/// Código postal
@override final  String? postalCode;
/// Documento de identidad
@override final  String? documentId;
/// Tipo de documento
@override final  String? documentType;

/// Create a copy of TropipayCustomerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayCustomerDataCopyWith<_TropipayCustomerData> get copyWith => __$TropipayCustomerDataCopyWithImpl<_TropipayCustomerData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayCustomerDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayCustomerData&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address)&&(identical(other.city, city) || other.city == city)&&(identical(other.country, country) || other.country == country)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.documentId, documentId) || other.documentId == documentId)&&(identical(other.documentType, documentType) || other.documentType == documentType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,address,city,country,postalCode,documentId,documentType);

@override
String toString() {
  return 'TropipayCustomerData(fullName: $fullName, email: $email, phone: $phone, address: $address, city: $city, country: $country, postalCode: $postalCode, documentId: $documentId, documentType: $documentType)';
}


}

/// @nodoc
abstract mixin class _$TropipayCustomerDataCopyWith<$Res> implements $TropipayCustomerDataCopyWith<$Res> {
  factory _$TropipayCustomerDataCopyWith(_TropipayCustomerData value, $Res Function(_TropipayCustomerData) _then) = __$TropipayCustomerDataCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, String? phone, String? address, String? city, String country, String? postalCode, String? documentId, String? documentType
});




}
/// @nodoc
class __$TropipayCustomerDataCopyWithImpl<$Res>
    implements _$TropipayCustomerDataCopyWith<$Res> {
  __$TropipayCustomerDataCopyWithImpl(this._self, this._then);

  final _TropipayCustomerData _self;
  final $Res Function(_TropipayCustomerData) _then;

/// Create a copy of TropipayCustomerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? phone = freezed,Object? address = freezed,Object? city = freezed,Object? country = null,Object? postalCode = freezed,Object? documentId = freezed,Object? documentType = freezed,}) {
  return _then(_TropipayCustomerData(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,documentId: freezed == documentId ? _self.documentId : documentId // ignore: cast_nullable_to_non_nullable
as String?,documentType: freezed == documentType ? _self.documentType : documentType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TropipayCardData {

/// Número de tarjeta (sin espacios ni guiones)
 String get cardNumber;/// Mes de expiración (1-12)
 int get expiryMonth;/// Año de expiración (4 dígitos)
 int get expiryYear;/// Código de seguridad (CVV/CVC)
 String get cvv;/// Nombre del titular de la tarjeta
 String get cardholderName;/// Tipo de tarjeta (opcional, se detecta automáticamente)
 String? get cardType;/// País de emisión de la tarjeta
 String? get country;
/// Create a copy of TropipayCardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayCardDataCopyWith<TropipayCardData> get copyWith => _$TropipayCardDataCopyWithImpl<TropipayCardData>(this as TropipayCardData, _$identity);

  /// Serializes this TropipayCardData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayCardData&&(identical(other.cardNumber, cardNumber) || other.cardNumber == cardNumber)&&(identical(other.expiryMonth, expiryMonth) || other.expiryMonth == expiryMonth)&&(identical(other.expiryYear, expiryYear) || other.expiryYear == expiryYear)&&(identical(other.cvv, cvv) || other.cvv == cvv)&&(identical(other.cardholderName, cardholderName) || other.cardholderName == cardholderName)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardNumber,expiryMonth,expiryYear,cvv,cardholderName,cardType,country);

@override
String toString() {
  return 'TropipayCardData(cardNumber: $cardNumber, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvv: $cvv, cardholderName: $cardholderName, cardType: $cardType, country: $country)';
}


}

/// @nodoc
abstract mixin class $TropipayCardDataCopyWith<$Res>  {
  factory $TropipayCardDataCopyWith(TropipayCardData value, $Res Function(TropipayCardData) _then) = _$TropipayCardDataCopyWithImpl;
@useResult
$Res call({
 String cardNumber, int expiryMonth, int expiryYear, String cvv, String cardholderName, String? cardType, String? country
});




}
/// @nodoc
class _$TropipayCardDataCopyWithImpl<$Res>
    implements $TropipayCardDataCopyWith<$Res> {
  _$TropipayCardDataCopyWithImpl(this._self, this._then);

  final TropipayCardData _self;
  final $Res Function(TropipayCardData) _then;

/// Create a copy of TropipayCardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cardNumber = null,Object? expiryMonth = null,Object? expiryYear = null,Object? cvv = null,Object? cardholderName = null,Object? cardType = freezed,Object? country = freezed,}) {
  return _then(_self.copyWith(
cardNumber: null == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as String,expiryMonth: null == expiryMonth ? _self.expiryMonth : expiryMonth // ignore: cast_nullable_to_non_nullable
as int,expiryYear: null == expiryYear ? _self.expiryYear : expiryYear // ignore: cast_nullable_to_non_nullable
as int,cvv: null == cvv ? _self.cvv : cvv // ignore: cast_nullable_to_non_nullable
as String,cardholderName: null == cardholderName ? _self.cardholderName : cardholderName // ignore: cast_nullable_to_non_nullable
as String,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TropipayCardData].
extension TropipayCardDataPatterns on TropipayCardData {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayCardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayCardData() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayCardData value)  $default,){
final _that = this;
switch (_that) {
case _TropipayCardData():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayCardData value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayCardData() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String cardNumber,  int expiryMonth,  int expiryYear,  String cvv,  String cardholderName,  String? cardType,  String? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayCardData() when $default != null:
return $default(_that.cardNumber,_that.expiryMonth,_that.expiryYear,_that.cvv,_that.cardholderName,_that.cardType,_that.country);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String cardNumber,  int expiryMonth,  int expiryYear,  String cvv,  String cardholderName,  String? cardType,  String? country)  $default,) {final _that = this;
switch (_that) {
case _TropipayCardData():
return $default(_that.cardNumber,_that.expiryMonth,_that.expiryYear,_that.cvv,_that.cardholderName,_that.cardType,_that.country);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String cardNumber,  int expiryMonth,  int expiryYear,  String cvv,  String cardholderName,  String? cardType,  String? country)?  $default,) {final _that = this;
switch (_that) {
case _TropipayCardData() when $default != null:
return $default(_that.cardNumber,_that.expiryMonth,_that.expiryYear,_that.cvv,_that.cardholderName,_that.cardType,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayCardData implements TropipayCardData {
  const _TropipayCardData({required this.cardNumber, required this.expiryMonth, required this.expiryYear, required this.cvv, required this.cardholderName, this.cardType, this.country});
  factory _TropipayCardData.fromJson(Map<String, dynamic> json) => _$TropipayCardDataFromJson(json);

/// Número de tarjeta (sin espacios ni guiones)
@override final  String cardNumber;
/// Mes de expiración (1-12)
@override final  int expiryMonth;
/// Año de expiración (4 dígitos)
@override final  int expiryYear;
/// Código de seguridad (CVV/CVC)
@override final  String cvv;
/// Nombre del titular de la tarjeta
@override final  String cardholderName;
/// Tipo de tarjeta (opcional, se detecta automáticamente)
@override final  String? cardType;
/// País de emisión de la tarjeta
@override final  String? country;

/// Create a copy of TropipayCardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayCardDataCopyWith<_TropipayCardData> get copyWith => __$TropipayCardDataCopyWithImpl<_TropipayCardData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayCardDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayCardData&&(identical(other.cardNumber, cardNumber) || other.cardNumber == cardNumber)&&(identical(other.expiryMonth, expiryMonth) || other.expiryMonth == expiryMonth)&&(identical(other.expiryYear, expiryYear) || other.expiryYear == expiryYear)&&(identical(other.cvv, cvv) || other.cvv == cvv)&&(identical(other.cardholderName, cardholderName) || other.cardholderName == cardholderName)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,cardNumber,expiryMonth,expiryYear,cvv,cardholderName,cardType,country);

@override
String toString() {
  return 'TropipayCardData(cardNumber: $cardNumber, expiryMonth: $expiryMonth, expiryYear: $expiryYear, cvv: $cvv, cardholderName: $cardholderName, cardType: $cardType, country: $country)';
}


}

/// @nodoc
abstract mixin class _$TropipayCardDataCopyWith<$Res> implements $TropipayCardDataCopyWith<$Res> {
  factory _$TropipayCardDataCopyWith(_TropipayCardData value, $Res Function(_TropipayCardData) _then) = __$TropipayCardDataCopyWithImpl;
@override @useResult
$Res call({
 String cardNumber, int expiryMonth, int expiryYear, String cvv, String cardholderName, String? cardType, String? country
});




}
/// @nodoc
class __$TropipayCardDataCopyWithImpl<$Res>
    implements _$TropipayCardDataCopyWith<$Res> {
  __$TropipayCardDataCopyWithImpl(this._self, this._then);

  final _TropipayCardData _self;
  final $Res Function(_TropipayCardData) _then;

/// Create a copy of TropipayCardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cardNumber = null,Object? expiryMonth = null,Object? expiryYear = null,Object? cvv = null,Object? cardholderName = null,Object? cardType = freezed,Object? country = freezed,}) {
  return _then(_TropipayCardData(
cardNumber: null == cardNumber ? _self.cardNumber : cardNumber // ignore: cast_nullable_to_non_nullable
as String,expiryMonth: null == expiryMonth ? _self.expiryMonth : expiryMonth // ignore: cast_nullable_to_non_nullable
as int,expiryYear: null == expiryYear ? _self.expiryYear : expiryYear // ignore: cast_nullable_to_non_nullable
as int,cvv: null == cvv ? _self.cvv : cvv // ignore: cast_nullable_to_non_nullable
as String,cardholderName: null == cardholderName ? _self.cardholderName : cardholderName // ignore: cast_nullable_to_non_nullable
as String,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
