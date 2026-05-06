// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_transaction.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentTransaction {

/// ID único de la transacción
 String get id;/// ID del pago asociado
 String get paymentId;/// Pago completo asociado
 Payment? get payment;/// Tipo de transacción
@PaymentTransactionTypeConverter() PaymentTransactionType get type;/// Estado de la transacción
@PaymentStatusConverter() PaymentStatus get status;/// Monto de la transacción
 double get amount;/// Moneda
 String get currency;/// Descripción de la transacción
 String? get description;/// ID de la transacción en la pasarela
 String? get gatewayTransactionId;/// Código de autorización (si aplica)
 String? get authorizationCode;/// Referencia externa
 String? get externalReference;/// Fecha de la transacción
 DateTime? get transactionDate;/// Fecha de creación
 DateTime? get createdAt;/// Fecha de actualización
 DateTime? get updatedAt;/// Datos adicionales
 Map<String, dynamic> get metadata;/// Motivo de fallo
 String? get failureReason;/// Comisión de la transacción
 double? get fee;/// Datos de la tarjeta (últimos 4 dígitos)
 String? get cardLastFourDigits;/// Tipo de tarjeta
 String? get cardType;/// País de origen
 String? get country;
/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentTransactionCopyWith<PaymentTransaction> get copyWith => _$PaymentTransactionCopyWithImpl<PaymentTransaction>(this as PaymentTransaction, _$identity);

  /// Serializes this PaymentTransaction to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.gatewayTransactionId, gatewayTransactionId) || other.gatewayTransactionId == gatewayTransactionId)&&(identical(other.authorizationCode, authorizationCode) || other.authorizationCode == authorizationCode)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.cardLastFourDigits, cardLastFourDigits) || other.cardLastFourDigits == cardLastFourDigits)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,paymentId,payment,type,status,amount,currency,description,gatewayTransactionId,authorizationCode,externalReference,transactionDate,createdAt,updatedAt,const DeepCollectionEquality().hash(metadata),failureReason,fee,cardLastFourDigits,cardType,country]);

@override
String toString() {
  return 'PaymentTransaction(id: $id, paymentId: $paymentId, payment: $payment, type: $type, status: $status, amount: $amount, currency: $currency, description: $description, gatewayTransactionId: $gatewayTransactionId, authorizationCode: $authorizationCode, externalReference: $externalReference, transactionDate: $transactionDate, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata, failureReason: $failureReason, fee: $fee, cardLastFourDigits: $cardLastFourDigits, cardType: $cardType, country: $country)';
}


}

/// @nodoc
abstract mixin class $PaymentTransactionCopyWith<$Res>  {
  factory $PaymentTransactionCopyWith(PaymentTransaction value, $Res Function(PaymentTransaction) _then) = _$PaymentTransactionCopyWithImpl;
@useResult
$Res call({
 String id, String paymentId, Payment? payment,@PaymentTransactionTypeConverter() PaymentTransactionType type,@PaymentStatusConverter() PaymentStatus status, double amount, String currency, String? description, String? gatewayTransactionId, String? authorizationCode, String? externalReference, DateTime? transactionDate, DateTime? createdAt, DateTime? updatedAt, Map<String, dynamic> metadata, String? failureReason, double? fee, String? cardLastFourDigits, String? cardType, String? country
});


$PaymentCopyWith<$Res>? get payment;$PaymentTransactionTypeCopyWith<$Res> get type;$PaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class _$PaymentTransactionCopyWithImpl<$Res>
    implements $PaymentTransactionCopyWith<$Res> {
  _$PaymentTransactionCopyWithImpl(this._self, this._then);

  final PaymentTransaction _self;
  final $Res Function(PaymentTransaction) _then;

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? paymentId = null,Object? payment = freezed,Object? type = null,Object? status = null,Object? amount = null,Object? currency = null,Object? description = freezed,Object? gatewayTransactionId = freezed,Object? authorizationCode = freezed,Object? externalReference = freezed,Object? transactionDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? metadata = null,Object? failureReason = freezed,Object? fee = freezed,Object? cardLastFourDigits = freezed,Object? cardType = freezed,Object? country = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as Payment?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentTransactionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,gatewayTransactionId: freezed == gatewayTransactionId ? _self.gatewayTransactionId : gatewayTransactionId // ignore: cast_nullable_to_non_nullable
as String?,authorizationCode: freezed == authorizationCode ? _self.authorizationCode : authorizationCode // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double?,cardLastFourDigits: freezed == cardLastFourDigits ? _self.cardLastFourDigits : cardLastFourDigits // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentCopyWith<$Res>? get payment {
    if (_self.payment == null) {
    return null;
  }

  return $PaymentCopyWith<$Res>(_self.payment!, (value) {
    return _then(_self.copyWith(payment: value));
  });
}/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentTransactionTypeCopyWith<$Res> get type {
  
  return $PaymentTransactionTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentTransaction].
extension PaymentTransactionPatterns on PaymentTransaction {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentTransaction value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentTransaction value)  $default,){
final _that = this;
switch (_that) {
case _PaymentTransaction():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentTransaction value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String paymentId,  Payment? payment, @PaymentTransactionTypeConverter()  PaymentTransactionType type, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? description,  String? gatewayTransactionId,  String? authorizationCode,  String? externalReference,  DateTime? transactionDate,  DateTime? createdAt,  DateTime? updatedAt,  Map<String, dynamic> metadata,  String? failureReason,  double? fee,  String? cardLastFourDigits,  String? cardType,  String? country)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
return $default(_that.id,_that.paymentId,_that.payment,_that.type,_that.status,_that.amount,_that.currency,_that.description,_that.gatewayTransactionId,_that.authorizationCode,_that.externalReference,_that.transactionDate,_that.createdAt,_that.updatedAt,_that.metadata,_that.failureReason,_that.fee,_that.cardLastFourDigits,_that.cardType,_that.country);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String paymentId,  Payment? payment, @PaymentTransactionTypeConverter()  PaymentTransactionType type, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? description,  String? gatewayTransactionId,  String? authorizationCode,  String? externalReference,  DateTime? transactionDate,  DateTime? createdAt,  DateTime? updatedAt,  Map<String, dynamic> metadata,  String? failureReason,  double? fee,  String? cardLastFourDigits,  String? cardType,  String? country)  $default,) {final _that = this;
switch (_that) {
case _PaymentTransaction():
return $default(_that.id,_that.paymentId,_that.payment,_that.type,_that.status,_that.amount,_that.currency,_that.description,_that.gatewayTransactionId,_that.authorizationCode,_that.externalReference,_that.transactionDate,_that.createdAt,_that.updatedAt,_that.metadata,_that.failureReason,_that.fee,_that.cardLastFourDigits,_that.cardType,_that.country);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String paymentId,  Payment? payment, @PaymentTransactionTypeConverter()  PaymentTransactionType type, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? description,  String? gatewayTransactionId,  String? authorizationCode,  String? externalReference,  DateTime? transactionDate,  DateTime? createdAt,  DateTime? updatedAt,  Map<String, dynamic> metadata,  String? failureReason,  double? fee,  String? cardLastFourDigits,  String? cardType,  String? country)?  $default,) {final _that = this;
switch (_that) {
case _PaymentTransaction() when $default != null:
return $default(_that.id,_that.paymentId,_that.payment,_that.type,_that.status,_that.amount,_that.currency,_that.description,_that.gatewayTransactionId,_that.authorizationCode,_that.externalReference,_that.transactionDate,_that.createdAt,_that.updatedAt,_that.metadata,_that.failureReason,_that.fee,_that.cardLastFourDigits,_that.cardType,_that.country);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentTransaction implements PaymentTransaction {
  const _PaymentTransaction({required this.id, required this.paymentId, this.payment, @PaymentTransactionTypeConverter() required this.type, @PaymentStatusConverter() required this.status, required this.amount, this.currency = 'CUP', this.description, this.gatewayTransactionId, this.authorizationCode, this.externalReference, this.transactionDate, this.createdAt, this.updatedAt, final  Map<String, dynamic> metadata = const {}, this.failureReason, this.fee, this.cardLastFourDigits, this.cardType, this.country}): _metadata = metadata;
  factory _PaymentTransaction.fromJson(Map<String, dynamic> json) => _$PaymentTransactionFromJson(json);

/// ID único de la transacción
@override final  String id;
/// ID del pago asociado
@override final  String paymentId;
/// Pago completo asociado
@override final  Payment? payment;
/// Tipo de transacción
@override@PaymentTransactionTypeConverter() final  PaymentTransactionType type;
/// Estado de la transacción
@override@PaymentStatusConverter() final  PaymentStatus status;
/// Monto de la transacción
@override final  double amount;
/// Moneda
@override@JsonKey() final  String currency;
/// Descripción de la transacción
@override final  String? description;
/// ID de la transacción en la pasarela
@override final  String? gatewayTransactionId;
/// Código de autorización (si aplica)
@override final  String? authorizationCode;
/// Referencia externa
@override final  String? externalReference;
/// Fecha de la transacción
@override final  DateTime? transactionDate;
/// Fecha de creación
@override final  DateTime? createdAt;
/// Fecha de actualización
@override final  DateTime? updatedAt;
/// Datos adicionales
 final  Map<String, dynamic> _metadata;
/// Datos adicionales
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// Motivo de fallo
@override final  String? failureReason;
/// Comisión de la transacción
@override final  double? fee;
/// Datos de la tarjeta (últimos 4 dígitos)
@override final  String? cardLastFourDigits;
/// Tipo de tarjeta
@override final  String? cardType;
/// País de origen
@override final  String? country;

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentTransactionCopyWith<_PaymentTransaction> get copyWith => __$PaymentTransactionCopyWithImpl<_PaymentTransaction>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentTransactionToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentTransaction&&(identical(other.id, id) || other.id == id)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.type, type) || other.type == type)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.description, description) || other.description == description)&&(identical(other.gatewayTransactionId, gatewayTransactionId) || other.gatewayTransactionId == gatewayTransactionId)&&(identical(other.authorizationCode, authorizationCode) || other.authorizationCode == authorizationCode)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.transactionDate, transactionDate) || other.transactionDate == transactionDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&(identical(other.fee, fee) || other.fee == fee)&&(identical(other.cardLastFourDigits, cardLastFourDigits) || other.cardLastFourDigits == cardLastFourDigits)&&(identical(other.cardType, cardType) || other.cardType == cardType)&&(identical(other.country, country) || other.country == country));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,paymentId,payment,type,status,amount,currency,description,gatewayTransactionId,authorizationCode,externalReference,transactionDate,createdAt,updatedAt,const DeepCollectionEquality().hash(_metadata),failureReason,fee,cardLastFourDigits,cardType,country]);

@override
String toString() {
  return 'PaymentTransaction(id: $id, paymentId: $paymentId, payment: $payment, type: $type, status: $status, amount: $amount, currency: $currency, description: $description, gatewayTransactionId: $gatewayTransactionId, authorizationCode: $authorizationCode, externalReference: $externalReference, transactionDate: $transactionDate, createdAt: $createdAt, updatedAt: $updatedAt, metadata: $metadata, failureReason: $failureReason, fee: $fee, cardLastFourDigits: $cardLastFourDigits, cardType: $cardType, country: $country)';
}


}

/// @nodoc
abstract mixin class _$PaymentTransactionCopyWith<$Res> implements $PaymentTransactionCopyWith<$Res> {
  factory _$PaymentTransactionCopyWith(_PaymentTransaction value, $Res Function(_PaymentTransaction) _then) = __$PaymentTransactionCopyWithImpl;
@override @useResult
$Res call({
 String id, String paymentId, Payment? payment,@PaymentTransactionTypeConverter() PaymentTransactionType type,@PaymentStatusConverter() PaymentStatus status, double amount, String currency, String? description, String? gatewayTransactionId, String? authorizationCode, String? externalReference, DateTime? transactionDate, DateTime? createdAt, DateTime? updatedAt, Map<String, dynamic> metadata, String? failureReason, double? fee, String? cardLastFourDigits, String? cardType, String? country
});


@override $PaymentCopyWith<$Res>? get payment;@override $PaymentTransactionTypeCopyWith<$Res> get type;@override $PaymentStatusCopyWith<$Res> get status;

}
/// @nodoc
class __$PaymentTransactionCopyWithImpl<$Res>
    implements _$PaymentTransactionCopyWith<$Res> {
  __$PaymentTransactionCopyWithImpl(this._self, this._then);

  final _PaymentTransaction _self;
  final $Res Function(_PaymentTransaction) _then;

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? paymentId = null,Object? payment = freezed,Object? type = null,Object? status = null,Object? amount = null,Object? currency = null,Object? description = freezed,Object? gatewayTransactionId = freezed,Object? authorizationCode = freezed,Object? externalReference = freezed,Object? transactionDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? metadata = null,Object? failureReason = freezed,Object? fee = freezed,Object? cardLastFourDigits = freezed,Object? cardType = freezed,Object? country = freezed,}) {
  return _then(_PaymentTransaction(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,paymentId: null == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as Payment?,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as PaymentTransactionType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,gatewayTransactionId: freezed == gatewayTransactionId ? _self.gatewayTransactionId : gatewayTransactionId // ignore: cast_nullable_to_non_nullable
as String?,authorizationCode: freezed == authorizationCode ? _self.authorizationCode : authorizationCode // ignore: cast_nullable_to_non_nullable
as String?,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,transactionDate: freezed == transactionDate ? _self.transactionDate : transactionDate // ignore: cast_nullable_to_non_nullable
as DateTime?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,fee: freezed == fee ? _self.fee : fee // ignore: cast_nullable_to_non_nullable
as double?,cardLastFourDigits: freezed == cardLastFourDigits ? _self.cardLastFourDigits : cardLastFourDigits // ignore: cast_nullable_to_non_nullable
as String?,cardType: freezed == cardType ? _self.cardType : cardType // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentCopyWith<$Res>? get payment {
    if (_self.payment == null) {
    return null;
  }

  return $PaymentCopyWith<$Res>(_self.payment!, (value) {
    return _then(_self.copyWith(payment: value));
  });
}/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentTransactionTypeCopyWith<$Res> get type {
  
  return $PaymentTransactionTypeCopyWith<$Res>(_self.type, (value) {
    return _then(_self.copyWith(type: value));
  });
}/// Create a copy of PaymentTransaction
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}
}

/// @nodoc
mixin _$PaymentTransactionType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType()';
}


}

/// @nodoc
class $PaymentTransactionTypeCopyWith<$Res>  {
$PaymentTransactionTypeCopyWith(PaymentTransactionType _, $Res Function(PaymentTransactionType) __);
}


/// Adds pattern-matching-related methods to [PaymentTransactionType].
extension PaymentTransactionTypePatterns on PaymentTransactionType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaymentTransactionTypePayment value)?  payment,TResult Function( PaymentTransactionTypeRefund value)?  refund,TResult Function( PaymentTransactionTypeCapture value)?  capture,TResult Function( PaymentTransactionTypeCancellation value)?  cancellation,TResult Function( PaymentTransactionTypeAuthorization value)?  authorization,TResult Function( PaymentTransactionTypeReversal value)?  reversal,TResult Function( PaymentTransactionTypeFee value)?  fee,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaymentTransactionTypePayment() when payment != null:
return payment(_that);case PaymentTransactionTypeRefund() when refund != null:
return refund(_that);case PaymentTransactionTypeCapture() when capture != null:
return capture(_that);case PaymentTransactionTypeCancellation() when cancellation != null:
return cancellation(_that);case PaymentTransactionTypeAuthorization() when authorization != null:
return authorization(_that);case PaymentTransactionTypeReversal() when reversal != null:
return reversal(_that);case PaymentTransactionTypeFee() when fee != null:
return fee(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaymentTransactionTypePayment value)  payment,required TResult Function( PaymentTransactionTypeRefund value)  refund,required TResult Function( PaymentTransactionTypeCapture value)  capture,required TResult Function( PaymentTransactionTypeCancellation value)  cancellation,required TResult Function( PaymentTransactionTypeAuthorization value)  authorization,required TResult Function( PaymentTransactionTypeReversal value)  reversal,required TResult Function( PaymentTransactionTypeFee value)  fee,}){
final _that = this;
switch (_that) {
case PaymentTransactionTypePayment():
return payment(_that);case PaymentTransactionTypeRefund():
return refund(_that);case PaymentTransactionTypeCapture():
return capture(_that);case PaymentTransactionTypeCancellation():
return cancellation(_that);case PaymentTransactionTypeAuthorization():
return authorization(_that);case PaymentTransactionTypeReversal():
return reversal(_that);case PaymentTransactionTypeFee():
return fee(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaymentTransactionTypePayment value)?  payment,TResult? Function( PaymentTransactionTypeRefund value)?  refund,TResult? Function( PaymentTransactionTypeCapture value)?  capture,TResult? Function( PaymentTransactionTypeCancellation value)?  cancellation,TResult? Function( PaymentTransactionTypeAuthorization value)?  authorization,TResult? Function( PaymentTransactionTypeReversal value)?  reversal,TResult? Function( PaymentTransactionTypeFee value)?  fee,}){
final _that = this;
switch (_that) {
case PaymentTransactionTypePayment() when payment != null:
return payment(_that);case PaymentTransactionTypeRefund() when refund != null:
return refund(_that);case PaymentTransactionTypeCapture() when capture != null:
return capture(_that);case PaymentTransactionTypeCancellation() when cancellation != null:
return cancellation(_that);case PaymentTransactionTypeAuthorization() when authorization != null:
return authorization(_that);case PaymentTransactionTypeReversal() when reversal != null:
return reversal(_that);case PaymentTransactionTypeFee() when fee != null:
return fee(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  payment,TResult Function()?  refund,TResult Function()?  capture,TResult Function()?  cancellation,TResult Function()?  authorization,TResult Function()?  reversal,TResult Function()?  fee,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaymentTransactionTypePayment() when payment != null:
return payment();case PaymentTransactionTypeRefund() when refund != null:
return refund();case PaymentTransactionTypeCapture() when capture != null:
return capture();case PaymentTransactionTypeCancellation() when cancellation != null:
return cancellation();case PaymentTransactionTypeAuthorization() when authorization != null:
return authorization();case PaymentTransactionTypeReversal() when reversal != null:
return reversal();case PaymentTransactionTypeFee() when fee != null:
return fee();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  payment,required TResult Function()  refund,required TResult Function()  capture,required TResult Function()  cancellation,required TResult Function()  authorization,required TResult Function()  reversal,required TResult Function()  fee,}) {final _that = this;
switch (_that) {
case PaymentTransactionTypePayment():
return payment();case PaymentTransactionTypeRefund():
return refund();case PaymentTransactionTypeCapture():
return capture();case PaymentTransactionTypeCancellation():
return cancellation();case PaymentTransactionTypeAuthorization():
return authorization();case PaymentTransactionTypeReversal():
return reversal();case PaymentTransactionTypeFee():
return fee();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  payment,TResult? Function()?  refund,TResult? Function()?  capture,TResult? Function()?  cancellation,TResult? Function()?  authorization,TResult? Function()?  reversal,TResult? Function()?  fee,}) {final _that = this;
switch (_that) {
case PaymentTransactionTypePayment() when payment != null:
return payment();case PaymentTransactionTypeRefund() when refund != null:
return refund();case PaymentTransactionTypeCapture() when capture != null:
return capture();case PaymentTransactionTypeCancellation() when cancellation != null:
return cancellation();case PaymentTransactionTypeAuthorization() when authorization != null:
return authorization();case PaymentTransactionTypeReversal() when reversal != null:
return reversal();case PaymentTransactionTypeFee() when fee != null:
return fee();case _:
  return null;

}
}

}

/// @nodoc


class PaymentTransactionTypePayment implements PaymentTransactionType {
  const PaymentTransactionTypePayment();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionTypePayment);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType.payment()';
}


}




/// @nodoc


class PaymentTransactionTypeRefund implements PaymentTransactionType {
  const PaymentTransactionTypeRefund();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionTypeRefund);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType.refund()';
}


}




/// @nodoc


class PaymentTransactionTypeCapture implements PaymentTransactionType {
  const PaymentTransactionTypeCapture();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionTypeCapture);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType.capture()';
}


}




/// @nodoc


class PaymentTransactionTypeCancellation implements PaymentTransactionType {
  const PaymentTransactionTypeCancellation();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionTypeCancellation);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType.cancellation()';
}


}




/// @nodoc


class PaymentTransactionTypeAuthorization implements PaymentTransactionType {
  const PaymentTransactionTypeAuthorization();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionTypeAuthorization);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType.authorization()';
}


}




/// @nodoc


class PaymentTransactionTypeReversal implements PaymentTransactionType {
  const PaymentTransactionTypeReversal();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionTypeReversal);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType.reversal()';
}


}




/// @nodoc


class PaymentTransactionTypeFee implements PaymentTransactionType {
  const PaymentTransactionTypeFee();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentTransactionTypeFee);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentTransactionType.fee()';
}


}




// dart format on
