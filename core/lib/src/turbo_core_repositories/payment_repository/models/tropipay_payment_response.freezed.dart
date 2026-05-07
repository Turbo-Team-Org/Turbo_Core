// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tropipay_payment_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TropipayPaymentResponse {

/// Indica si la operación fue exitosa
 bool get success;/// ID único de la transacción en Tropipay
 String? get transactionId;/// ID del pago
 String? get paymentId;/// Estado del pago
@PaymentStatusConverter() PaymentStatus get status;/// Monto del pago
 double get amount;/// Moneda
 String get currency;/// Descripción del pago
 String? get description;/// URL de redirección para completar el pago
 String? get redirectUrl;/// URL de la pasarela de pago
 String? get paymentUrl;/// Referencia externa
 String? get externalReference;/// Código de autorización (si aplica)
 String? get authorizationCode;/// Mensaje de respuesta
 String? get message;/// Código de error (si aplica)
 String? get errorCode;/// Detalles del error
 String? get errorDetails;/// Fecha de creación
 DateTime? get createdAt;/// Fecha de expiración
 DateTime? get expiresAt;/// Datos adicionales de la respuesta
 Map<String, dynamic> get metadata;/// Datos del cliente
 TropipayResponseCustomerData? get customer;/// Datos de la tarjeta (últimos 4 dígitos)
 TropipayResponseCardData? get cardData;/// Comisiones aplicadas
 TropipayFeeData? get fees;
/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayPaymentResponseCopyWith<TropipayPaymentResponse> get copyWith => _$TropipayPaymentResponseCopyWithImpl<TropipayPaymentResponse>(this as TropipayPaymentResponse, _$identity);

  /// Serializes this TropipayPaymentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayPaymentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.authorizationCode, authorizationCode) || other.authorizationCode == authorizationCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorDetails, errorDetails) || other.errorDetails == errorDetails)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.cardData, cardData) || other.cardData == cardData)&&(identical(other.fees, fees) || other.fees == fees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,success,transactionId,paymentId,status,amount,currency,description,redirectUrl,paymentUrl,externalReference,authorizationCode,message,errorCode,errorDetails,createdAt,expiresAt,const DeepCollectionEquality().hash(metadata),customer,cardData,fees]);

@override
String toString() {
  return 'TropipayPaymentResponse(success: $success, transactionId: $transactionId, paymentId: $paymentId, status: $status, amount: $amount, currency: $currency, description: $description, redirectUrl: $redirectUrl, paymentUrl: $paymentUrl, externalReference: $externalReference, authorizationCode: $authorizationCode, message: $message, errorCode: $errorCode, errorDetails: $errorDetails, createdAt: $createdAt, expiresAt: $expiresAt, metadata: $metadata, customer: $customer, cardData: $cardData, fees: $fees)';
}


}

/// @nodoc
abstract mixin class $TropipayPaymentResponseCopyWith<$Res>  {
  factory $TropipayPaymentResponseCopyWith(TropipayPaymentResponse value, $Res Function(TropipayPaymentResponse) _then) = _$TropipayPaymentResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? transactionId, String? paymentId,@PaymentStatusConverter() PaymentStatus status, double amount, String currency, String? description, String? redirectUrl, String? paymentUrl, String? externalReference, String? authorizationCode, String? message, String? errorCode, String? errorDetails, DateTime? createdAt, DateTime? expiresAt, Map<String, dynamic> metadata, TropipayResponseCustomerData? customer, TropipayResponseCardData? cardData, TropipayFeeData? fees
});


$PaymentStatusCopyWith<$Res> get status;$TropipayResponseCustomerDataCopyWith<$Res>? get customer;$TropipayResponseCardDataCopyWith<$Res>? get cardData;$TropipayFeeDataCopyWith<$Res>? get fees;

}
/// @nodoc
class _$TropipayPaymentResponseCopyWithImpl<$Res>
    implements $TropipayPaymentResponseCopyWith<$Res> {
  _$TropipayPaymentResponseCopyWithImpl(this._self, this._then);

  final TropipayPaymentResponse _self;
  final $Res Function(TropipayPaymentResponse) _then;

/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? transactionId = freezed,Object? paymentId = freezed,Object? status = null,Object? amount = null,Object? currency = null,Object? description = freezed,Object? redirectUrl = freezed,Object? paymentUrl = freezed,Object? externalReference = freezed,Object? authorizationCode = freezed,Object? message = freezed,Object? errorCode = freezed,Object? errorDetails = freezed,Object? createdAt = freezed,Object? expiresAt = freezed,Object? metadata = null,Object? customer = freezed,Object? cardData = freezed,Object? fees = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,authorizationCode: freezed == authorizationCode ? _self.authorizationCode : authorizationCode // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorDetails: freezed == errorDetails ? _self.errorDetails : errorDetails // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as TropipayResponseCustomerData?,cardData: freezed == cardData ? _self.cardData : cardData // ignore: cast_nullable_to_non_nullable
as TropipayResponseCardData?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as TropipayFeeData?,
  ));
}
/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayResponseCustomerDataCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $TropipayResponseCustomerDataCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayResponseCardDataCopyWith<$Res>? get cardData {
    if (_self.cardData == null) {
    return null;
  }

  return $TropipayResponseCardDataCopyWith<$Res>(_self.cardData!, (value) {
    return _then(_self.copyWith(cardData: value));
  });
}/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayFeeDataCopyWith<$Res>? get fees {
    if (_self.fees == null) {
    return null;
  }

  return $TropipayFeeDataCopyWith<$Res>(_self.fees!, (value) {
    return _then(_self.copyWith(fees: value));
  });
}
}


/// Adds pattern-matching-related methods to [TropipayPaymentResponse].
extension TropipayPaymentResponsePatterns on TropipayPaymentResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayPaymentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayPaymentResponse value)  $default,){
final _that = this;
switch (_that) {
case _TropipayPaymentResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayPaymentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? transactionId,  String? paymentId, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? description,  String? redirectUrl,  String? paymentUrl,  String? externalReference,  String? authorizationCode,  String? message,  String? errorCode,  String? errorDetails,  DateTime? createdAt,  DateTime? expiresAt,  Map<String, dynamic> metadata,  TropipayResponseCustomerData? customer,  TropipayResponseCardData? cardData,  TropipayFeeData? fees)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayPaymentResponse() when $default != null:
return $default(_that.success,_that.transactionId,_that.paymentId,_that.status,_that.amount,_that.currency,_that.description,_that.redirectUrl,_that.paymentUrl,_that.externalReference,_that.authorizationCode,_that.message,_that.errorCode,_that.errorDetails,_that.createdAt,_that.expiresAt,_that.metadata,_that.customer,_that.cardData,_that.fees);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? transactionId,  String? paymentId, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? description,  String? redirectUrl,  String? paymentUrl,  String? externalReference,  String? authorizationCode,  String? message,  String? errorCode,  String? errorDetails,  DateTime? createdAt,  DateTime? expiresAt,  Map<String, dynamic> metadata,  TropipayResponseCustomerData? customer,  TropipayResponseCardData? cardData,  TropipayFeeData? fees)  $default,) {final _that = this;
switch (_that) {
case _TropipayPaymentResponse():
return $default(_that.success,_that.transactionId,_that.paymentId,_that.status,_that.amount,_that.currency,_that.description,_that.redirectUrl,_that.paymentUrl,_that.externalReference,_that.authorizationCode,_that.message,_that.errorCode,_that.errorDetails,_that.createdAt,_that.expiresAt,_that.metadata,_that.customer,_that.cardData,_that.fees);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? transactionId,  String? paymentId, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? description,  String? redirectUrl,  String? paymentUrl,  String? externalReference,  String? authorizationCode,  String? message,  String? errorCode,  String? errorDetails,  DateTime? createdAt,  DateTime? expiresAt,  Map<String, dynamic> metadata,  TropipayResponseCustomerData? customer,  TropipayResponseCardData? cardData,  TropipayFeeData? fees)?  $default,) {final _that = this;
switch (_that) {
case _TropipayPaymentResponse() when $default != null:
return $default(_that.success,_that.transactionId,_that.paymentId,_that.status,_that.amount,_that.currency,_that.description,_that.redirectUrl,_that.paymentUrl,_that.externalReference,_that.authorizationCode,_that.message,_that.errorCode,_that.errorDetails,_that.createdAt,_that.expiresAt,_that.metadata,_that.customer,_that.cardData,_that.fees);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayPaymentResponse implements TropipayPaymentResponse {
  const _TropipayPaymentResponse({required this.success, this.transactionId, this.paymentId, @PaymentStatusConverter() required this.status, required this.amount, this.currency = 'CUP', this.description, this.redirectUrl, this.paymentUrl, this.externalReference, this.authorizationCode, this.message, this.errorCode, this.errorDetails, this.createdAt, this.expiresAt, final  Map<String, dynamic> metadata = const {}, this.customer, this.cardData, this.fees}): _metadata = metadata;
  factory _TropipayPaymentResponse.fromJson(Map<String, dynamic> json) => _$TropipayPaymentResponseFromJson(json);

/// Indica si la operación fue exitosa
@override final  bool success;
/// ID único de la transacción en Tropipay
@override final  String? transactionId;
/// ID del pago
@override final  String? paymentId;
/// Estado del pago
@override@PaymentStatusConverter() final  PaymentStatus status;
/// Monto del pago
@override final  double amount;
/// Moneda
@override@JsonKey() final  String currency;
/// Descripción del pago
@override final  String? description;
/// URL de redirección para completar el pago
@override final  String? redirectUrl;
/// URL de la pasarela de pago
@override final  String? paymentUrl;
/// Referencia externa
@override final  String? externalReference;
/// Código de autorización (si aplica)
@override final  String? authorizationCode;
/// Mensaje de respuesta
@override final  String? message;
/// Código de error (si aplica)
@override final  String? errorCode;
/// Detalles del error
@override final  String? errorDetails;
/// Fecha de creación
@override final  DateTime? createdAt;
/// Fecha de expiración
@override final  DateTime? expiresAt;
/// Datos adicionales de la respuesta
 final  Map<String, dynamic> _metadata;
/// Datos adicionales de la respuesta
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// Datos del cliente
@override final  TropipayResponseCustomerData? customer;
/// Datos de la tarjeta (últimos 4 dígitos)
@override final  TropipayResponseCardData? cardData;
/// Comisiones aplicadas
@override final  TropipayFeeData? fees;

/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayPaymentResponseCopyWith<_TropipayPaymentResponse> get copyWith => __$TropipayPaymentResponseCopyWithImpl<_TropipayPaymentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayPaymentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayPaymentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.authorizationCode, authorizationCode) || other.authorizationCode == authorizationCode)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorDetails, errorDetails) || other.errorDetails == errorDetails)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.cardData, cardData) || other.cardData == cardData)&&(identical(other.fees, fees) || other.fees == fees));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,success,transactionId,paymentId,status,amount,currency,description,redirectUrl,paymentUrl,externalReference,authorizationCode,message,errorCode,errorDetails,createdAt,expiresAt,const DeepCollectionEquality().hash(_metadata),customer,cardData,fees]);

@override
String toString() {
  return 'TropipayPaymentResponse(success: $success, transactionId: $transactionId, paymentId: $paymentId, status: $status, amount: $amount, currency: $currency, description: $description, redirectUrl: $redirectUrl, paymentUrl: $paymentUrl, externalReference: $externalReference, authorizationCode: $authorizationCode, message: $message, errorCode: $errorCode, errorDetails: $errorDetails, createdAt: $createdAt, expiresAt: $expiresAt, metadata: $metadata, customer: $customer, cardData: $cardData, fees: $fees)';
}


}

/// @nodoc
abstract mixin class _$TropipayPaymentResponseCopyWith<$Res> implements $TropipayPaymentResponseCopyWith<$Res> {
  factory _$TropipayPaymentResponseCopyWith(_TropipayPaymentResponse value, $Res Function(_TropipayPaymentResponse) _then) = __$TropipayPaymentResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? transactionId, String? paymentId,@PaymentStatusConverter() PaymentStatus status, double amount, String currency, String? description, String? redirectUrl, String? paymentUrl, String? externalReference, String? authorizationCode, String? message, String? errorCode, String? errorDetails, DateTime? createdAt, DateTime? expiresAt, Map<String, dynamic> metadata, TropipayResponseCustomerData? customer, TropipayResponseCardData? cardData, TropipayFeeData? fees
});


@override $PaymentStatusCopyWith<$Res> get status;@override $TropipayResponseCustomerDataCopyWith<$Res>? get customer;@override $TropipayResponseCardDataCopyWith<$Res>? get cardData;@override $TropipayFeeDataCopyWith<$Res>? get fees;

}
/// @nodoc
class __$TropipayPaymentResponseCopyWithImpl<$Res>
    implements _$TropipayPaymentResponseCopyWith<$Res> {
  __$TropipayPaymentResponseCopyWithImpl(this._self, this._then);

  final _TropipayPaymentResponse _self;
  final $Res Function(_TropipayPaymentResponse) _then;

/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? transactionId = freezed,Object? paymentId = freezed,Object? status = null,Object? amount = null,Object? currency = null,Object? description = freezed,Object? redirectUrl = freezed,Object? paymentUrl = freezed,Object? externalReference = freezed,Object? authorizationCode = freezed,Object? message = freezed,Object? errorCode = freezed,Object? errorDetails = freezed,Object? createdAt = freezed,Object? expiresAt = freezed,Object? metadata = null,Object? customer = freezed,Object? cardData = freezed,Object? fees = freezed,}) {
  return _then(_TropipayPaymentResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,authorizationCode: freezed == authorizationCode ? _self.authorizationCode : authorizationCode // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorDetails: freezed == errorDetails ? _self.errorDetails : errorDetails // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as TropipayResponseCustomerData?,cardData: freezed == cardData ? _self.cardData : cardData // ignore: cast_nullable_to_non_nullable
as TropipayResponseCardData?,fees: freezed == fees ? _self.fees : fees // ignore: cast_nullable_to_non_nullable
as TropipayFeeData?,
  ));
}

/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayResponseCustomerDataCopyWith<$Res>? get customer {
    if (_self.customer == null) {
    return null;
  }

  return $TropipayResponseCustomerDataCopyWith<$Res>(_self.customer!, (value) {
    return _then(_self.copyWith(customer: value));
  });
}/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayResponseCardDataCopyWith<$Res>? get cardData {
    if (_self.cardData == null) {
    return null;
  }

  return $TropipayResponseCardDataCopyWith<$Res>(_self.cardData!, (value) {
    return _then(_self.copyWith(cardData: value));
  });
}/// Create a copy of TropipayPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayFeeDataCopyWith<$Res>? get fees {
    if (_self.fees == null) {
    return null;
  }

  return $TropipayFeeDataCopyWith<$Res>(_self.fees!, (value) {
    return _then(_self.copyWith(fees: value));
  });
}
}


/// @nodoc
mixin _$TropipayResponseCustomerData {

/// Nombre completo del cliente
 String? get fullName;/// Email del cliente
 String? get email;/// Teléfono del cliente
 String? get phone;/// ID del cliente en Tropipay
 String? get customerId;
/// Create a copy of TropipayResponseCustomerData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayResponseCustomerDataCopyWith<TropipayResponseCustomerData> get copyWith => _$TropipayResponseCustomerDataCopyWithImpl<TropipayResponseCustomerData>(this as TropipayResponseCustomerData, _$identity);

  /// Serializes this TropipayResponseCustomerData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayResponseCustomerData&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.customerId, customerId) || other.customerId == customerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,customerId);

@override
String toString() {
  return 'TropipayResponseCustomerData(fullName: $fullName, email: $email, phone: $phone, customerId: $customerId)';
}


}

/// @nodoc
abstract mixin class $TropipayResponseCustomerDataCopyWith<$Res>  {
  factory $TropipayResponseCustomerDataCopyWith(TropipayResponseCustomerData value, $Res Function(TropipayResponseCustomerData) _then) = _$TropipayResponseCustomerDataCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? email, String? phone, String? customerId
});




}
/// @nodoc
class _$TropipayResponseCustomerDataCopyWithImpl<$Res>
    implements $TropipayResponseCustomerDataCopyWith<$Res> {
  _$TropipayResponseCustomerDataCopyWithImpl(this._self, this._then);

  final TropipayResponseCustomerData _self;
  final $Res Function(TropipayResponseCustomerData) _then;

/// Create a copy of TropipayResponseCustomerData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? customerId = freezed,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TropipayResponseCustomerData].
extension TropipayResponseCustomerDataPatterns on TropipayResponseCustomerData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayResponseCustomerData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayResponseCustomerData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayResponseCustomerData value)  $default,){
final _that = this;
switch (_that) {
case _TropipayResponseCustomerData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayResponseCustomerData value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayResponseCustomerData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? phone,  String? customerId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayResponseCustomerData() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.customerId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? phone,  String? customerId)  $default,) {final _that = this;
switch (_that) {
case _TropipayResponseCustomerData():
return $default(_that.fullName,_that.email,_that.phone,_that.customerId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? email,  String? phone,  String? customerId)?  $default,) {final _that = this;
switch (_that) {
case _TropipayResponseCustomerData() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.customerId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayResponseCustomerData implements TropipayResponseCustomerData {
  const _TropipayResponseCustomerData({this.fullName, this.email, this.phone, this.customerId});
  factory _TropipayResponseCustomerData.fromJson(Map<String, dynamic> json) => _$TropipayResponseCustomerDataFromJson(json);

/// Nombre completo del cliente
@override final  String? fullName;
/// Email del cliente
@override final  String? email;
/// Teléfono del cliente
@override final  String? phone;
/// ID del cliente en Tropipay
@override final  String? customerId;

/// Create a copy of TropipayResponseCustomerData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayResponseCustomerDataCopyWith<_TropipayResponseCustomerData> get copyWith => __$TropipayResponseCustomerDataCopyWithImpl<_TropipayResponseCustomerData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayResponseCustomerDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayResponseCustomerData&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.customerId, customerId) || other.customerId == customerId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,customerId);

@override
String toString() {
  return 'TropipayResponseCustomerData(fullName: $fullName, email: $email, phone: $phone, customerId: $customerId)';
}


}

/// @nodoc
abstract mixin class _$TropipayResponseCustomerDataCopyWith<$Res> implements $TropipayResponseCustomerDataCopyWith<$Res> {
  factory _$TropipayResponseCustomerDataCopyWith(_TropipayResponseCustomerData value, $Res Function(_TropipayResponseCustomerData) _then) = __$TropipayResponseCustomerDataCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? email, String? phone, String? customerId
});




}
/// @nodoc
class __$TropipayResponseCustomerDataCopyWithImpl<$Res>
    implements _$TropipayResponseCustomerDataCopyWith<$Res> {
  __$TropipayResponseCustomerDataCopyWithImpl(this._self, this._then);

  final _TropipayResponseCustomerData _self;
  final $Res Function(_TropipayResponseCustomerData) _then;

/// Create a copy of TropipayResponseCustomerData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? customerId = freezed,}) {
  return _then(_TropipayResponseCustomerData(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,customerId: freezed == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TropipayResponseCardData {

/// Últimos 4 dígitos de la tarjeta
 String? get lastFourDigits;/// Tipo de tarjeta
 String? get cardType;/// País de emisión
 String? get country;/// Banco emisor
 String? get bankName;
/// Create a copy of TropipayResponseCardData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayResponseCardDataCopyWith<TropipayResponseCardData> get copyWith => _$TropipayResponseCardDataCopyWithImpl<TropipayResponseCardData>(this as TropipayResponseCardData, _$identity);

  /// Serializes this TropipayResponseCardData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayResponseCardData&&(identical(other.lastFourDigits, lastFourDigits) || other.lastFourDigits == lastFourDigits)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country)&&(identical(other.bankName, bankName) || other.bankName == bankName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastFourDigits,cardType,country,bankName);

@override
String toString() {
  return 'TropipayResponseCardData(lastFourDigits: $lastFourDigits, cardType: $cardType, country: $country, bankName: $bankName)';
}


}

/// @nodoc
abstract mixin class $TropipayResponseCardDataCopyWith<$Res>  {
  factory $TropipayResponseCardDataCopyWith(TropipayResponseCardData value, $Res Function(TropipayResponseCardData) _then) = _$TropipayResponseCardDataCopyWithImpl;
@useResult
$Res call({
 String? lastFourDigits, String? cardType, String? country, String? bankName
});




}
/// @nodoc
class _$TropipayResponseCardDataCopyWithImpl<$Res>
    implements $TropipayResponseCardDataCopyWith<$Res> {
  _$TropipayResponseCardDataCopyWithImpl(this._self, this._then);

  final TropipayResponseCardData _self;
  final $Res Function(TropipayResponseCardData) _then;

/// Create a copy of TropipayResponseCardData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? lastFourDigits = freezed,Object? cardType = freezed,Object? country = freezed,Object? bankName = freezed,}) {
  return _then(_self.copyWith(
lastFourDigits: freezed == lastFourDigits ? _self.lastFourDigits : lastFourDigits // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [TropipayResponseCardData].
extension TropipayResponseCardDataPatterns on TropipayResponseCardData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayResponseCardData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayResponseCardData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayResponseCardData value)  $default,){
final _that = this;
switch (_that) {
case _TropipayResponseCardData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayResponseCardData value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayResponseCardData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? lastFourDigits,  String? cardType,  String? country,  String? bankName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayResponseCardData() when $default != null:
return $default(_that.lastFourDigits,_that.cardType,_that.country,_that.bankName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? lastFourDigits,  String? cardType,  String? country,  String? bankName)  $default,) {final _that = this;
switch (_that) {
case _TropipayResponseCardData():
return $default(_that.lastFourDigits,_that.cardType,_that.country,_that.bankName);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? lastFourDigits,  String? cardType,  String? country,  String? bankName)?  $default,) {final _that = this;
switch (_that) {
case _TropipayResponseCardData() when $default != null:
return $default(_that.lastFourDigits,_that.cardType,_that.country,_that.bankName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayResponseCardData implements TropipayResponseCardData {
  const _TropipayResponseCardData({this.lastFourDigits, this.cardType, this.country, this.bankName});
  factory _TropipayResponseCardData.fromJson(Map<String, dynamic> json) => _$TropipayResponseCardDataFromJson(json);

/// Últimos 4 dígitos de la tarjeta
@override final  String? lastFourDigits;
/// Tipo de tarjeta
@override final  String? cardType;
/// País de emisión
@override final  String? country;
/// Banco emisor
@override final  String? bankName;

/// Create a copy of TropipayResponseCardData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayResponseCardDataCopyWith<_TropipayResponseCardData> get copyWith => __$TropipayResponseCardDataCopyWithImpl<_TropipayResponseCardData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayResponseCardDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayResponseCardData&&(identical(other.lastFourDigits, lastFourDigits) || other.lastFourDigits == lastFourDigits)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country)&&(identical(other.bankName, bankName) || other.bankName == bankName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,lastFourDigits,cardType,country,bankName);

@override
String toString() {
  return 'TropipayResponseCardData(lastFourDigits: $lastFourDigits, cardType: $cardType, country: $country, bankName: $bankName)';
}


}

/// @nodoc
abstract mixin class _$TropipayResponseCardDataCopyWith<$Res> implements $TropipayResponseCardDataCopyWith<$Res> {
  factory _$TropipayResponseCardDataCopyWith(_TropipayResponseCardData value, $Res Function(_TropipayResponseCardData) _then) = __$TropipayResponseCardDataCopyWithImpl;
@override @useResult
$Res call({
 String? lastFourDigits, String? cardType, String? country, String? bankName
});




}
/// @nodoc
class __$TropipayResponseCardDataCopyWithImpl<$Res>
    implements _$TropipayResponseCardDataCopyWith<$Res> {
  __$TropipayResponseCardDataCopyWithImpl(this._self, this._then);

  final _TropipayResponseCardData _self;
  final $Res Function(_TropipayResponseCardData) _then;

/// Create a copy of TropipayResponseCardData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? lastFourDigits = freezed,Object? cardType = freezed,Object? country = freezed,Object? bankName = freezed,}) {
  return _then(_TropipayResponseCardData(
lastFourDigits: freezed == lastFourDigits ? _self.lastFourDigits : lastFourDigits // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,bankName: freezed == bankName ? _self.bankName : bankName // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TropipayFeeData {

/// Comisión de Tropipay
 double? get tropipayFee;/// Comisión del banco
 double? get bankFee;/// Comisión total
 double? get totalFee;/// Monto neto para el comercio
 double? get netAmount;/// Porcentaje de comisión
 double? get feePercentage;
/// Create a copy of TropipayFeeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayFeeDataCopyWith<TropipayFeeData> get copyWith => _$TropipayFeeDataCopyWithImpl<TropipayFeeData>(this as TropipayFeeData, _$identity);

  /// Serializes this TropipayFeeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayFeeData&&(identical(other.tropipayFee, tropipayFee) || other.tropipayFee == tropipayFee)&&(identical(other.bankFee, bankFee) || other.bankFee == bankFee)&&(identical(other.totalFee, totalFee) || other.totalFee == totalFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.feePercentage, feePercentage) || other.feePercentage == feePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tropipayFee,bankFee,totalFee,netAmount,feePercentage);

@override
String toString() {
  return 'TropipayFeeData(tropipayFee: $tropipayFee, bankFee: $bankFee, totalFee: $totalFee, netAmount: $netAmount, feePercentage: $feePercentage)';
}


}

/// @nodoc
abstract mixin class $TropipayFeeDataCopyWith<$Res>  {
  factory $TropipayFeeDataCopyWith(TropipayFeeData value, $Res Function(TropipayFeeData) _then) = _$TropipayFeeDataCopyWithImpl;
@useResult
$Res call({
 double? tropipayFee, double? bankFee, double? totalFee, double? netAmount, double? feePercentage
});




}
/// @nodoc
class _$TropipayFeeDataCopyWithImpl<$Res>
    implements $TropipayFeeDataCopyWith<$Res> {
  _$TropipayFeeDataCopyWithImpl(this._self, this._then);

  final TropipayFeeData _self;
  final $Res Function(TropipayFeeData) _then;

/// Create a copy of TropipayFeeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? tropipayFee = freezed,Object? bankFee = freezed,Object? totalFee = freezed,Object? netAmount = freezed,Object? feePercentage = freezed,}) {
  return _then(_self.copyWith(
tropipayFee: freezed == tropipayFee ? _self.tropipayFee : tropipayFee // ignore: cast_nullable_to_non_nullable
as double?,bankFee: freezed == bankFee ? _self.bankFee : bankFee // ignore: cast_nullable_to_non_nullable
as double?,totalFee: freezed == totalFee ? _self.totalFee : totalFee // ignore: cast_nullable_to_non_nullable
as double?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,feePercentage: freezed == feePercentage ? _self.feePercentage : feePercentage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

}


/// Adds pattern-matching-related methods to [TropipayFeeData].
extension TropipayFeeDataPatterns on TropipayFeeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayFeeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayFeeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayFeeData value)  $default,){
final _that = this;
switch (_that) {
case _TropipayFeeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayFeeData value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayFeeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double? tropipayFee,  double? bankFee,  double? totalFee,  double? netAmount,  double? feePercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayFeeData() when $default != null:
return $default(_that.tropipayFee,_that.bankFee,_that.totalFee,_that.netAmount,_that.feePercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double? tropipayFee,  double? bankFee,  double? totalFee,  double? netAmount,  double? feePercentage)  $default,) {final _that = this;
switch (_that) {
case _TropipayFeeData():
return $default(_that.tropipayFee,_that.bankFee,_that.totalFee,_that.netAmount,_that.feePercentage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double? tropipayFee,  double? bankFee,  double? totalFee,  double? netAmount,  double? feePercentage)?  $default,) {final _that = this;
switch (_that) {
case _TropipayFeeData() when $default != null:
return $default(_that.tropipayFee,_that.bankFee,_that.totalFee,_that.netAmount,_that.feePercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayFeeData implements TropipayFeeData {
  const _TropipayFeeData({this.tropipayFee, this.bankFee, this.totalFee, this.netAmount, this.feePercentage});
  factory _TropipayFeeData.fromJson(Map<String, dynamic> json) => _$TropipayFeeDataFromJson(json);

/// Comisión de Tropipay
@override final  double? tropipayFee;
/// Comisión del banco
@override final  double? bankFee;
/// Comisión total
@override final  double? totalFee;
/// Monto neto para el comercio
@override final  double? netAmount;
/// Porcentaje de comisión
@override final  double? feePercentage;

/// Create a copy of TropipayFeeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayFeeDataCopyWith<_TropipayFeeData> get copyWith => __$TropipayFeeDataCopyWithImpl<_TropipayFeeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayFeeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayFeeData&&(identical(other.tropipayFee, tropipayFee) || other.tropipayFee == tropipayFee)&&(identical(other.bankFee, bankFee) || other.bankFee == bankFee)&&(identical(other.totalFee, totalFee) || other.totalFee == totalFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount)&&(identical(other.feePercentage, feePercentage) || other.feePercentage == feePercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,tropipayFee,bankFee,totalFee,netAmount,feePercentage);

@override
String toString() {
  return 'TropipayFeeData(tropipayFee: $tropipayFee, bankFee: $bankFee, totalFee: $totalFee, netAmount: $netAmount, feePercentage: $feePercentage)';
}


}

/// @nodoc
abstract mixin class _$TropipayFeeDataCopyWith<$Res> implements $TropipayFeeDataCopyWith<$Res> {
  factory _$TropipayFeeDataCopyWith(_TropipayFeeData value, $Res Function(_TropipayFeeData) _then) = __$TropipayFeeDataCopyWithImpl;
@override @useResult
$Res call({
 double? tropipayFee, double? bankFee, double? totalFee, double? netAmount, double? feePercentage
});




}
/// @nodoc
class __$TropipayFeeDataCopyWithImpl<$Res>
    implements _$TropipayFeeDataCopyWith<$Res> {
  __$TropipayFeeDataCopyWithImpl(this._self, this._then);

  final _TropipayFeeData _self;
  final $Res Function(_TropipayFeeData) _then;

/// Create a copy of TropipayFeeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? tropipayFee = freezed,Object? bankFee = freezed,Object? totalFee = freezed,Object? netAmount = freezed,Object? feePercentage = freezed,}) {
  return _then(_TropipayFeeData(
tropipayFee: freezed == tropipayFee ? _self.tropipayFee : tropipayFee // ignore: cast_nullable_to_non_nullable
as double?,bankFee: freezed == bankFee ? _self.bankFee : bankFee // ignore: cast_nullable_to_non_nullable
as double?,totalFee: freezed == totalFee ? _self.totalFee : totalFee // ignore: cast_nullable_to_non_nullable
as double?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,feePercentage: freezed == feePercentage ? _self.feePercentage : feePercentage // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}


}

// dart format on
