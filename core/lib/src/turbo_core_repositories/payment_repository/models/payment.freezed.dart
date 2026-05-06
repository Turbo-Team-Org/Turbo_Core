// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Payment {

/// ID único del pago
 String get id;/// ID del usuario que realiza el pago
 String get userId;/// ID del lugar/negocio
 String get placeId;/// ID de la reserva asociada (opcional)
 String? get reservationId;/// Monto del pago en CUP
 double get amount;/// Moneda del pago (por defecto CUP)
 String get currency;/// Método de pago utilizado
@PaymentMethodConverter() PaymentMethod get paymentMethod;/// Estado actual del pago
@PaymentStatusConverter() PaymentStatus get status;/// Descripción del pago
 String? get description;/// Datos adicionales del pago
 Map<String, dynamic> get metadata;/// URL de retorno después del pago
 String? get returnUrl;/// URL de cancelación
 String? get cancelUrl;/// ID de la transacción en la pasarela de pago
 String? get gatewayTransactionId;/// Referencia externa (número de orden, etc.)
 String? get externalReference;/// Fecha de creación del pago
 DateTime? get createdAt;/// Fecha de actualización del pago
 DateTime? get updatedAt;/// Fecha de procesamiento del pago
 DateTime? get processedAt;/// Fecha de expiración del pago
 DateTime? get expiresAt;/// Motivo de fallo (si aplica)
 String? get failureReason;/// Datos de la tarjeta (encriptados, solo últimos 4 dígitos)
 String? get cardLastFourDigits;/// Tipo de tarjeta (si aplica)
 String? get cardType;/// País de origen del pago
 String? get country;/// IP del cliente
 String? get clientIp;/// User Agent del cliente
 String? get userAgent;/// Comisión de la pasarela
 double? get gatewayFee;/// Comisión de la plataforma
 double? get platformFee;/// Monto neto recibido por el negocio
 double? get netAmount;
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentCopyWith<Payment> get copyWith => _$PaymentCopyWithImpl<Payment>(this as Payment, _$identity);

  /// Serializes this Payment to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl)&&(identical(other.gatewayTransactionId, gatewayTransactionId) || other.gatewayTransactionId == gatewayTransactionId)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.cardLastFourDigits, cardLastFourDigits) || other.cardLastFourDigits == cardLastFourDigits)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country)&&(identical(other.clientIp, clientIp) || other.clientIp == clientIp)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.gatewayFee, gatewayFee) || other.gatewayFee == gatewayFee)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,placeId,reservationId,amount,currency,paymentMethod,status,description,const DeepCollectionEquality().hash(metadata),returnUrl,cancelUrl,gatewayTransactionId,externalReference,createdAt,updatedAt,processedAt,expiresAt,failureReason,cardLastFourDigits,cardType,country,clientIp,userAgent,gatewayFee,platformFee,netAmount]);

@override
String toString() {
  return 'Payment(id: $id, userId: $userId, placeId: $placeId, reservationId: $reservationId, amount: $amount, currency: $currency, paymentMethod: $paymentMethod, status: $status, description: $description, metadata: $metadata, returnUrl: $returnUrl, cancelUrl: $cancelUrl, gatewayTransactionId: $gatewayTransactionId, externalReference: $externalReference, createdAt: $createdAt, updatedAt: $updatedAt, processedAt: $processedAt, expiresAt: $expiresAt, failureReason: $failureReason, cardLastFourDigits: $cardLastFourDigits, cardType: $cardType, country: $country, clientIp: $clientIp, userAgent: $userAgent, gatewayFee: $gatewayFee, platformFee: $platformFee, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class $PaymentCopyWith<$Res>  {
  factory $PaymentCopyWith(Payment value, $Res Function(Payment) _then) = _$PaymentCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String placeId, String? reservationId, double amount, String currency,@PaymentMethodConverter() PaymentMethod paymentMethod,@PaymentStatusConverter() PaymentStatus status, String? description, Map<String, dynamic> metadata, String? returnUrl, String? cancelUrl, String? gatewayTransactionId, String? externalReference, DateTime? createdAt, DateTime? updatedAt, DateTime? processedAt, DateTime? expiresAt, String? failureReason, String? cardLastFourDigits, String? cardType, String? country, String? clientIp, String? userAgent, double? gatewayFee, double? platformFee, double? netAmount
});


$PaymentMethodCopyWith<$Res> get paymentMethod;$PaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$PaymentCopyWithImpl<$Res>
    implements $PaymentCopyWith<$Res> {
  _$PaymentCopyWithImpl(this._self, this._then);

  final Payment _self;
  final $Res Function(Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? reservationId = freezed,Object? amount = null,Object? currency = null,Object? paymentMethod = null,Object? status = null,Object? description = freezed,Object? metadata = null,Object? returnUrl = freezed,Object? cancelUrl = freezed,Object? gatewayTransactionId = freezed,Object? externalReference = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? processedAt = freezed,Object? expiresAt = freezed,Object? failureReason = freezed,Object? cardLastFourDigits = freezed,Object? cardType = freezed,Object? country = freezed,Object? clientIp = freezed,Object? userAgent = freezed,Object? gatewayFee = freezed,Object? platformFee = freezed,Object? netAmount = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,reservationId: freezed == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,gatewayTransactionId: freezed == gatewayTransactionId ? _self.gatewayTransactionId : gatewayTransactionId // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,cardLastFourDigits: freezed == cardLastFourDigits ? _self.cardLastFourDigits : cardLastFourDigits // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,clientIp: freezed == clientIp ? _self.clientIp : clientIp // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,gatewayFee: freezed == gatewayFee ? _self.gatewayFee : gatewayFee // ignore: cast_nullable_to_non_nullable
as double?,platformFee: freezed == platformFee ? _self.platformFee : platformFee // ignore: cast_nullable_to_non_nullable
as double?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}
/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [Payment].
extension PaymentPatterns on Payment {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Payment value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Payment value)  $default,){
final _that = this;
switch (_that) {
case _Payment():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Payment value)?  $default,){
final _that = this;
switch (_that) {
case _Payment() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId,  String? reservationId,  double amount,  String currency, @PaymentMethodConverter()  PaymentMethod paymentMethod, @PaymentStatusConverter()  PaymentStatus status,  String? description,  Map<String, dynamic> metadata,  String? returnUrl,  String? cancelUrl,  String? gatewayTransactionId,  String? externalReference,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? processedAt,  DateTime? expiresAt,  String? failureReason,  String? cardLastFourDigits,  String? cardType,  String? country,  String? clientIp,  String? userAgent,  double? gatewayFee,  double? platformFee,  double? netAmount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.reservationId,_that.amount,_that.currency,_that.paymentMethod,_that.status,_that.description,_that.metadata,_that.returnUrl,_that.cancelUrl,_that.gatewayTransactionId,_that.externalReference,_that.createdAt,_that.updatedAt,_that.processedAt,_that.expiresAt,_that.failureReason,_that.cardLastFourDigits,_that.cardType,_that.country,_that.clientIp,_that.userAgent,_that.gatewayFee,_that.platformFee,_that.netAmount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String placeId,  String? reservationId,  double amount,  String currency, @PaymentMethodConverter()  PaymentMethod paymentMethod, @PaymentStatusConverter()  PaymentStatus status,  String? description,  Map<String, dynamic> metadata,  String? returnUrl,  String? cancelUrl,  String? gatewayTransactionId,  String? externalReference,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? processedAt,  DateTime? expiresAt,  String? failureReason,  String? cardLastFourDigits,  String? cardType,  String? country,  String? clientIp,  String? userAgent,  double? gatewayFee,  double? platformFee,  double? netAmount)  $default,) {final _that = this;
switch (_that) {
case _Payment():
return $default(_that.id,_that.userId,_that.placeId,_that.reservationId,_that.amount,_that.currency,_that.paymentMethod,_that.status,_that.description,_that.metadata,_that.returnUrl,_that.cancelUrl,_that.gatewayTransactionId,_that.externalReference,_that.createdAt,_that.updatedAt,_that.processedAt,_that.expiresAt,_that.failureReason,_that.cardLastFourDigits,_that.cardType,_that.country,_that.clientIp,_that.userAgent,_that.gatewayFee,_that.platformFee,_that.netAmount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String placeId,  String? reservationId,  double amount,  String currency, @PaymentMethodConverter()  PaymentMethod paymentMethod, @PaymentStatusConverter()  PaymentStatus status,  String? description,  Map<String, dynamic> metadata,  String? returnUrl,  String? cancelUrl,  String? gatewayTransactionId,  String? externalReference,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? processedAt,  DateTime? expiresAt,  String? failureReason,  String? cardLastFourDigits,  String? cardType,  String? country,  String? clientIp,  String? userAgent,  double? gatewayFee,  double? platformFee,  double? netAmount)?  $default,) {final _that = this;
switch (_that) {
case _Payment() when $default != null:
return $default(_that.id,_that.userId,_that.placeId,_that.reservationId,_that.amount,_that.currency,_that.paymentMethod,_that.status,_that.description,_that.metadata,_that.returnUrl,_that.cancelUrl,_that.gatewayTransactionId,_that.externalReference,_that.createdAt,_that.updatedAt,_that.processedAt,_that.expiresAt,_that.failureReason,_that.cardLastFourDigits,_that.cardType,_that.country,_that.clientIp,_that.userAgent,_that.gatewayFee,_that.platformFee,_that.netAmount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Payment implements Payment {
  const _Payment({required this.id, required this.userId, required this.placeId, this.reservationId, required this.amount, this.currency = 'CUP', @PaymentMethodConverter() required this.paymentMethod, @PaymentStatusConverter() required this.status, this.description, final  Map<String, dynamic> metadata = const {}, this.returnUrl, this.cancelUrl, this.gatewayTransactionId, this.externalReference, this.createdAt, this.updatedAt, this.processedAt, this.expiresAt, this.failureReason, this.cardLastFourDigits, this.cardType, this.country, this.clientIp, this.userAgent, this.gatewayFee, this.platformFee, this.netAmount}): _metadata = metadata;
  factory _Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

/// ID único del pago
@override final  String id;
/// ID del usuario que realiza el pago
@override final  String userId;
/// ID del lugar/negocio
@override final  String placeId;
/// ID de la reserva asociada (opcional)
@override final  String? reservationId;
/// Monto del pago en CUP
@override final  double amount;
/// Moneda del pago (por defecto CUP)
@override@JsonKey() final  String currency;
/// Método de pago utilizado
@override@PaymentMethodConverter() final  PaymentMethod paymentMethod;
/// Estado actual del pago
@override@PaymentStatusConverter() final  PaymentStatus status;
/// Descripción del pago
@override final  String? description;
/// Datos adicionales del pago
 final  Map<String, dynamic> _metadata;
/// Datos adicionales del pago
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// URL de retorno después del pago
@override final  String? returnUrl;
/// URL de cancelación
@override final  String? cancelUrl;
/// ID de la transacción en la pasarela de pago
@override final  String? gatewayTransactionId;
/// Referencia externa (número de orden, etc.)
@override final  String? externalReference;
/// Fecha de creación del pago
@override final  DateTime? createdAt;
/// Fecha de actualización del pago
@override final  DateTime? updatedAt;
/// Fecha de procesamiento del pago
@override final  DateTime? processedAt;
/// Fecha de expiración del pago
@override final  DateTime? expiresAt;
/// Motivo de fallo (si aplica)
@override final  String? failureReason;
/// Datos de la tarjeta (encriptados, solo últimos 4 dígitos)
@override final  String? cardLastFourDigits;
/// Tipo de tarjeta (si aplica)
@override final  String? cardType;
/// País de origen del pago
@override final  String? country;
/// IP del cliente
@override final  String? clientIp;
/// User Agent del cliente
@override final  String? userAgent;
/// Comisión de la pasarela
@override final  double? gatewayFee;
/// Comisión de la plataforma
@override final  double? platformFee;
/// Monto neto recibido por el negocio
@override final  double? netAmount;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentCopyWith<_Payment> get copyWith => __$PaymentCopyWithImpl<_Payment>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Payment&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.reservationId, reservationId) || other.reservationId == reservationId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.status, status) || other.status == status)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.returnUrl, returnUrl) || other.returnUrl == returnUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl)&&(identical(other.gatewayTransactionId, gatewayTransactionId) || other.gatewayTransactionId == gatewayTransactionId)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.processedAt, processedAt) || other.processedAt == processedAt)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.cardLastFourDigits, cardLastFourDigits) || other.cardLastFourDigits == cardLastFourDigits)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country)&&(identical(other.clientIp, clientIp) || other.clientIp == clientIp)&&(identical(other.userAgent, userAgent) || other.userAgent == userAgent)&&(identical(other.gatewayFee, gatewayFee) || other.gatewayFee == gatewayFee)&&(identical(other.platformFee, platformFee) || other.platformFee == platformFee)&&(identical(other.netAmount, netAmount) || other.netAmount == netAmount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,userId,placeId,reservationId,amount,currency,paymentMethod,status,description,const DeepCollectionEquality().hash(_metadata),returnUrl,cancelUrl,gatewayTransactionId,externalReference,createdAt,updatedAt,processedAt,expiresAt,failureReason,cardLastFourDigits,cardType,country,clientIp,userAgent,gatewayFee,platformFee,netAmount]);

@override
String toString() {
  return 'Payment(id: $id, userId: $userId, placeId: $placeId, reservationId: $reservationId, amount: $amount, currency: $currency, paymentMethod: $paymentMethod, status: $status, description: $description, metadata: $metadata, returnUrl: $returnUrl, cancelUrl: $cancelUrl, gatewayTransactionId: $gatewayTransactionId, externalReference: $externalReference, createdAt: $createdAt, updatedAt: $updatedAt, processedAt: $processedAt, expiresAt: $expiresAt, failureReason: $failureReason, cardLastFourDigits: $cardLastFourDigits, cardType: $cardType, country: $country, clientIp: $clientIp, userAgent: $userAgent, gatewayFee: $gatewayFee, platformFee: $platformFee, netAmount: $netAmount)';
}


}

/// @nodoc
abstract mixin class _$PaymentCopyWith<$Res> implements $PaymentCopyWith<$Res> {
  factory _$PaymentCopyWith(_Payment value, $Res Function(_Payment) _then) = __$PaymentCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String placeId, String? reservationId, double amount, String currency,@PaymentMethodConverter() PaymentMethod paymentMethod,@PaymentStatusConverter() PaymentStatus status, String? description, Map<String, dynamic> metadata, String? returnUrl, String? cancelUrl, String? gatewayTransactionId, String? externalReference, DateTime? createdAt, DateTime? updatedAt, DateTime? processedAt, DateTime? expiresAt, String? failureReason, String? cardLastFourDigits, String? cardType, String? country, String? clientIp, String? userAgent, double? gatewayFee, double? platformFee, double? netAmount
});


@override $PaymentMethodCopyWith<$Res> get paymentMethod;@override $PaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$PaymentCopyWithImpl<$Res>
    implements _$PaymentCopyWith<$Res> {
  __$PaymentCopyWithImpl(this._self, this._then);

  final _Payment _self;
  final $Res Function(_Payment) _then;

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? placeId = null,Object? reservationId = freezed,Object? amount = null,Object? currency = null,Object? paymentMethod = null,Object? status = null,Object? description = freezed,Object? metadata = null,Object? returnUrl = freezed,Object? cancelUrl = freezed,Object? gatewayTransactionId = freezed,Object? externalReference = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? processedAt = freezed,Object? expiresAt = freezed,Object? failureReason = freezed,Object? cardLastFourDigits = freezed,Object? cardType = freezed,Object? country = freezed,Object? clientIp = freezed,Object? userAgent = freezed,Object? gatewayFee = freezed,Object? platformFee = freezed,Object? netAmount = freezed,}) {
  return _then(_Payment(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,reservationId: freezed == reservationId ? _self.reservationId : reservationId // ignore: cast_nullable_to_non_nullable
as String?,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,paymentMethod: null == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as PaymentMethod,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,returnUrl: freezed == returnUrl ? _self.returnUrl : returnUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,gatewayTransactionId: freezed == gatewayTransactionId ? _self.gatewayTransactionId : gatewayTransactionId // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,processedAt: freezed == processedAt ? _self.processedAt : processedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,expiresAt: freezed == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as DateTime?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,cardLastFourDigits: freezed == cardLastFourDigits ? _self.cardLastFourDigits : cardLastFourDigits // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,clientIp: freezed == clientIp ? _self.clientIp : clientIp // ignore: cast_nullable_to_non_nullable
as String?,userAgent: freezed == userAgent ? _self.userAgent : userAgent // ignore: cast_nullable_to_non_nullable
as String?,gatewayFee: freezed == gatewayFee ? _self.gatewayFee : gatewayFee // ignore: cast_nullable_to_non_nullable
as double?,platformFee: freezed == platformFee ? _self.platformFee : platformFee // ignore: cast_nullable_to_non_nullable
as double?,netAmount: freezed == netAmount ? _self.netAmount : netAmount // ignore: cast_nullable_to_non_nullable
as double?,
  ));
}

/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentMethodCopyWith<$Res> get paymentMethod {
  
  return $PaymentMethodCopyWith<$Res>(_self.paymentMethod, (value) {
    return _then(_self.copyWith(paymentMethod: value));
  });
}/// Create a copy of Payment
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

// dart format on
