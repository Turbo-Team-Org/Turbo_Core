// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tropipay_webhook.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TropipayWebhook {

/// ID único del webhook
 String get id;/// ID de la transacción
 String get transactionId;/// ID del pago
 String? get paymentId;/// Tipo de evento
@TropipayWebhookEventTypeConverter() TropipayWebhookEventType get eventType;/// Estado del pago
@PaymentStatusConverter() PaymentStatus get status;/// Monto del pago
 double get amount;/// Moneda
 String get currency;/// Referencia externa
 String? get externalReference;/// Timestamp del evento
 DateTime get timestamp;/// Firma de verificación
 String? get signature;/// Datos adicionales del evento
 Map<String, dynamic> get metadata;/// Datos específicos del evento
 TropipayWebhookEventData? get eventData;
/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayWebhookCopyWith<TropipayWebhook> get copyWith => _$TropipayWebhookCopyWithImpl<TropipayWebhook>(this as TropipayWebhook, _$identity);

  /// Serializes this TropipayWebhook to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhook&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.eventData, eventData) || other.eventData == eventData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,paymentId,eventType,status,amount,currency,externalReference,timestamp,signature,const DeepCollectionEquality().hash(metadata),eventData);

@override
String toString() {
  return 'TropipayWebhook(id: $id, transactionId: $transactionId, paymentId: $paymentId, eventType: $eventType, status: $status, amount: $amount, currency: $currency, externalReference: $externalReference, timestamp: $timestamp, signature: $signature, metadata: $metadata, eventData: $eventData)';
}


}

/// @nodoc
abstract mixin class $TropipayWebhookCopyWith<$Res>  {
  factory $TropipayWebhookCopyWith(TropipayWebhook value, $Res Function(TropipayWebhook) _then) = _$TropipayWebhookCopyWithImpl;
@useResult
$Res call({
 String id, String transactionId, String? paymentId,@TropipayWebhookEventTypeConverter() TropipayWebhookEventType eventType,@PaymentStatusConverter() PaymentStatus status, double amount, String currency, String? externalReference, DateTime timestamp, String? signature, Map<String, dynamic> metadata, TropipayWebhookEventData? eventData
});


$TropipayWebhookEventTypeCopyWith<$Res> get eventType;$PaymentStatusCopyWith<$Res> get status;$TropipayWebhookEventDataCopyWith<$Res>? get eventData;

}
/// @nodoc
class _$TropipayWebhookCopyWithImpl<$Res>
    implements $TropipayWebhookCopyWith<$Res> {
  _$TropipayWebhookCopyWithImpl(this._self, this._then);

  final TropipayWebhook _self;
  final $Res Function(TropipayWebhook) _then;

/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? transactionId = null,Object? paymentId = freezed,Object? eventType = null,Object? status = null,Object? amount = null,Object? currency = null,Object? externalReference = freezed,Object? timestamp = null,Object? signature = freezed,Object? metadata = null,Object? eventData = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as TropipayWebhookEventType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,eventData: freezed == eventData ? _self.eventData : eventData // ignore: cast_nullable_to_non_nullable
as TropipayWebhookEventData?,
  ));
}
/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayWebhookEventTypeCopyWith<$Res> get eventType {
  
  return $TropipayWebhookEventTypeCopyWith<$Res>(_self.eventType, (value) {
    return _then(_self.copyWith(eventType: value));
  });
}/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayWebhookEventDataCopyWith<$Res>? get eventData {
    if (_self.eventData == null) {
    return null;
  }

  return $TropipayWebhookEventDataCopyWith<$Res>(_self.eventData!, (value) {
    return _then(_self.copyWith(eventData: value));
  });
}
}


/// Adds pattern-matching-related methods to [TropipayWebhook].
extension TropipayWebhookPatterns on TropipayWebhook {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayWebhook value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayWebhook() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayWebhook value)  $default,){
final _that = this;
switch (_that) {
case _TropipayWebhook():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayWebhook value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayWebhook() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String transactionId,  String? paymentId, @TropipayWebhookEventTypeConverter()  TropipayWebhookEventType eventType, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? externalReference,  DateTime timestamp,  String? signature,  Map<String, dynamic> metadata,  TropipayWebhookEventData? eventData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayWebhook() when $default != null:
return $default(_that.id,_that.transactionId,_that.paymentId,_that.eventType,_that.status,_that.amount,_that.currency,_that.externalReference,_that.timestamp,_that.signature,_that.metadata,_that.eventData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String transactionId,  String? paymentId, @TropipayWebhookEventTypeConverter()  TropipayWebhookEventType eventType, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? externalReference,  DateTime timestamp,  String? signature,  Map<String, dynamic> metadata,  TropipayWebhookEventData? eventData)  $default,) {final _that = this;
switch (_that) {
case _TropipayWebhook():
return $default(_that.id,_that.transactionId,_that.paymentId,_that.eventType,_that.status,_that.amount,_that.currency,_that.externalReference,_that.timestamp,_that.signature,_that.metadata,_that.eventData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String transactionId,  String? paymentId, @TropipayWebhookEventTypeConverter()  TropipayWebhookEventType eventType, @PaymentStatusConverter()  PaymentStatus status,  double amount,  String currency,  String? externalReference,  DateTime timestamp,  String? signature,  Map<String, dynamic> metadata,  TropipayWebhookEventData? eventData)?  $default,) {final _that = this;
switch (_that) {
case _TropipayWebhook() when $default != null:
return $default(_that.id,_that.transactionId,_that.paymentId,_that.eventType,_that.status,_that.amount,_that.currency,_that.externalReference,_that.timestamp,_that.signature,_that.metadata,_that.eventData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayWebhook implements TropipayWebhook {
  const _TropipayWebhook({required this.id, required this.transactionId, this.paymentId, @TropipayWebhookEventTypeConverter() required this.eventType, @PaymentStatusConverter() required this.status, required this.amount, this.currency = 'CUP', this.externalReference, required this.timestamp, this.signature, final  Map<String, dynamic> metadata = const {}, this.eventData}): _metadata = metadata;
  factory _TropipayWebhook.fromJson(Map<String, dynamic> json) => _$TropipayWebhookFromJson(json);

/// ID único del webhook
@override final  String id;
/// ID de la transacción
@override final  String transactionId;
/// ID del pago
@override final  String? paymentId;
/// Tipo de evento
@override@TropipayWebhookEventTypeConverter() final  TropipayWebhookEventType eventType;
/// Estado del pago
@override@PaymentStatusConverter() final  PaymentStatus status;
/// Monto del pago
@override final  double amount;
/// Moneda
@override@JsonKey() final  String currency;
/// Referencia externa
@override final  String? externalReference;
/// Timestamp del evento
@override final  DateTime timestamp;
/// Firma de verificación
@override final  String? signature;
/// Datos adicionales del evento
 final  Map<String, dynamic> _metadata;
/// Datos adicionales del evento
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// Datos específicos del evento
@override final  TropipayWebhookEventData? eventData;

/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayWebhookCopyWith<_TropipayWebhook> get copyWith => __$TropipayWebhookCopyWithImpl<_TropipayWebhook>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayWebhookToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayWebhook&&(identical(other.id, id) || other.id == id)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentId, paymentId) || other.paymentId == paymentId)&&(identical(other.eventType, eventType) || other.eventType == eventType)&&(identical(other.status, status) || other.status == status)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.externalReference, externalReference) || other.externalReference == externalReference)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.signature, signature) || other.signature == signature)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.eventData, eventData) || other.eventData == eventData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,transactionId,paymentId,eventType,status,amount,currency,externalReference,timestamp,signature,const DeepCollectionEquality().hash(_metadata),eventData);

@override
String toString() {
  return 'TropipayWebhook(id: $id, transactionId: $transactionId, paymentId: $paymentId, eventType: $eventType, status: $status, amount: $amount, currency: $currency, externalReference: $externalReference, timestamp: $timestamp, signature: $signature, metadata: $metadata, eventData: $eventData)';
}


}

/// @nodoc
abstract mixin class _$TropipayWebhookCopyWith<$Res> implements $TropipayWebhookCopyWith<$Res> {
  factory _$TropipayWebhookCopyWith(_TropipayWebhook value, $Res Function(_TropipayWebhook) _then) = __$TropipayWebhookCopyWithImpl;
@override @useResult
$Res call({
 String id, String transactionId, String? paymentId,@TropipayWebhookEventTypeConverter() TropipayWebhookEventType eventType,@PaymentStatusConverter() PaymentStatus status, double amount, String currency, String? externalReference, DateTime timestamp, String? signature, Map<String, dynamic> metadata, TropipayWebhookEventData? eventData
});


@override $TropipayWebhookEventTypeCopyWith<$Res> get eventType;@override $PaymentStatusCopyWith<$Res> get status;@override $TropipayWebhookEventDataCopyWith<$Res>? get eventData;

}
/// @nodoc
class __$TropipayWebhookCopyWithImpl<$Res>
    implements _$TropipayWebhookCopyWith<$Res> {
  __$TropipayWebhookCopyWithImpl(this._self, this._then);

  final _TropipayWebhook _self;
  final $Res Function(_TropipayWebhook) _then;

/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? transactionId = null,Object? paymentId = freezed,Object? eventType = null,Object? status = null,Object? amount = null,Object? currency = null,Object? externalReference = freezed,Object? timestamp = null,Object? signature = freezed,Object? metadata = null,Object? eventData = freezed,}) {
  return _then(_TropipayWebhook(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,transactionId: null == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String,paymentId: freezed == paymentId ? _self.paymentId : paymentId // ignore: cast_nullable_to_non_nullable
as String?,eventType: null == eventType ? _self.eventType : eventType // ignore: cast_nullable_to_non_nullable
as TropipayWebhookEventType,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: null == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String,externalReference: freezed == externalReference ? _self.externalReference : externalReference // ignore: cast_nullable_to_non_nullable
as String?,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,signature: freezed == signature ? _self.signature : signature // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,eventData: freezed == eventData ? _self.eventData : eventData // ignore: cast_nullable_to_non_nullable
as TropipayWebhookEventData?,
  ));
}

/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayWebhookEventTypeCopyWith<$Res> get eventType {
  
  return $TropipayWebhookEventTypeCopyWith<$Res>(_self.eventType, (value) {
    return _then(_self.copyWith(eventType: value));
  });
}/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of TropipayWebhook
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$TropipayWebhookEventDataCopyWith<$Res>? get eventData {
    if (_self.eventData == null) {
    return null;
  }

  return $TropipayWebhookEventDataCopyWith<$Res>(_self.eventData!, (value) {
    return _then(_self.copyWith(eventData: value));
  });
}
}

/// @nodoc
mixin _$TropipayWebhookEventType {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventType);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType()';
}


}

/// @nodoc
class $TropipayWebhookEventTypeCopyWith<$Res>  {
$TropipayWebhookEventTypeCopyWith(TropipayWebhookEventType _, $Res Function(TropipayWebhookEventType) __);
}


/// Adds pattern-matching-related methods to [TropipayWebhookEventType].
extension TropipayWebhookEventTypePatterns on TropipayWebhookEventType {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( TropipayWebhookEventTypePaymentCreated value)?  paymentCreated,TResult Function( TropipayWebhookEventTypePaymentCompleted value)?  paymentCompleted,TResult Function( TropipayWebhookEventTypePaymentFailed value)?  paymentFailed,TResult Function( TropipayWebhookEventTypePaymentCancelled value)?  paymentCancelled,TResult Function( TropipayWebhookEventTypePaymentRefunded value)?  paymentRefunded,TResult Function( TropipayWebhookEventTypePaymentExpired value)?  paymentExpired,TResult Function( TropipayWebhookEventTypePaymentProcessing value)?  paymentProcessing,TResult Function( TropipayWebhookEventTypeUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case TropipayWebhookEventTypePaymentCreated() when paymentCreated != null:
return paymentCreated(_that);case TropipayWebhookEventTypePaymentCompleted() when paymentCompleted != null:
return paymentCompleted(_that);case TropipayWebhookEventTypePaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case TropipayWebhookEventTypePaymentCancelled() when paymentCancelled != null:
return paymentCancelled(_that);case TropipayWebhookEventTypePaymentRefunded() when paymentRefunded != null:
return paymentRefunded(_that);case TropipayWebhookEventTypePaymentExpired() when paymentExpired != null:
return paymentExpired(_that);case TropipayWebhookEventTypePaymentProcessing() when paymentProcessing != null:
return paymentProcessing(_that);case TropipayWebhookEventTypeUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( TropipayWebhookEventTypePaymentCreated value)  paymentCreated,required TResult Function( TropipayWebhookEventTypePaymentCompleted value)  paymentCompleted,required TResult Function( TropipayWebhookEventTypePaymentFailed value)  paymentFailed,required TResult Function( TropipayWebhookEventTypePaymentCancelled value)  paymentCancelled,required TResult Function( TropipayWebhookEventTypePaymentRefunded value)  paymentRefunded,required TResult Function( TropipayWebhookEventTypePaymentExpired value)  paymentExpired,required TResult Function( TropipayWebhookEventTypePaymentProcessing value)  paymentProcessing,required TResult Function( TropipayWebhookEventTypeUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case TropipayWebhookEventTypePaymentCreated():
return paymentCreated(_that);case TropipayWebhookEventTypePaymentCompleted():
return paymentCompleted(_that);case TropipayWebhookEventTypePaymentFailed():
return paymentFailed(_that);case TropipayWebhookEventTypePaymentCancelled():
return paymentCancelled(_that);case TropipayWebhookEventTypePaymentRefunded():
return paymentRefunded(_that);case TropipayWebhookEventTypePaymentExpired():
return paymentExpired(_that);case TropipayWebhookEventTypePaymentProcessing():
return paymentProcessing(_that);case TropipayWebhookEventTypeUnknown():
return unknown(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( TropipayWebhookEventTypePaymentCreated value)?  paymentCreated,TResult? Function( TropipayWebhookEventTypePaymentCompleted value)?  paymentCompleted,TResult? Function( TropipayWebhookEventTypePaymentFailed value)?  paymentFailed,TResult? Function( TropipayWebhookEventTypePaymentCancelled value)?  paymentCancelled,TResult? Function( TropipayWebhookEventTypePaymentRefunded value)?  paymentRefunded,TResult? Function( TropipayWebhookEventTypePaymentExpired value)?  paymentExpired,TResult? Function( TropipayWebhookEventTypePaymentProcessing value)?  paymentProcessing,TResult? Function( TropipayWebhookEventTypeUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case TropipayWebhookEventTypePaymentCreated() when paymentCreated != null:
return paymentCreated(_that);case TropipayWebhookEventTypePaymentCompleted() when paymentCompleted != null:
return paymentCompleted(_that);case TropipayWebhookEventTypePaymentFailed() when paymentFailed != null:
return paymentFailed(_that);case TropipayWebhookEventTypePaymentCancelled() when paymentCancelled != null:
return paymentCancelled(_that);case TropipayWebhookEventTypePaymentRefunded() when paymentRefunded != null:
return paymentRefunded(_that);case TropipayWebhookEventTypePaymentExpired() when paymentExpired != null:
return paymentExpired(_that);case TropipayWebhookEventTypePaymentProcessing() when paymentProcessing != null:
return paymentProcessing(_that);case TropipayWebhookEventTypeUnknown() when unknown != null:
return unknown(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  paymentCreated,TResult Function()?  paymentCompleted,TResult Function()?  paymentFailed,TResult Function()?  paymentCancelled,TResult Function()?  paymentRefunded,TResult Function()?  paymentExpired,TResult Function()?  paymentProcessing,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case TropipayWebhookEventTypePaymentCreated() when paymentCreated != null:
return paymentCreated();case TropipayWebhookEventTypePaymentCompleted() when paymentCompleted != null:
return paymentCompleted();case TropipayWebhookEventTypePaymentFailed() when paymentFailed != null:
return paymentFailed();case TropipayWebhookEventTypePaymentCancelled() when paymentCancelled != null:
return paymentCancelled();case TropipayWebhookEventTypePaymentRefunded() when paymentRefunded != null:
return paymentRefunded();case TropipayWebhookEventTypePaymentExpired() when paymentExpired != null:
return paymentExpired();case TropipayWebhookEventTypePaymentProcessing() when paymentProcessing != null:
return paymentProcessing();case TropipayWebhookEventTypeUnknown() when unknown != null:
return unknown();case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  paymentCreated,required TResult Function()  paymentCompleted,required TResult Function()  paymentFailed,required TResult Function()  paymentCancelled,required TResult Function()  paymentRefunded,required TResult Function()  paymentExpired,required TResult Function()  paymentProcessing,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case TropipayWebhookEventTypePaymentCreated():
return paymentCreated();case TropipayWebhookEventTypePaymentCompleted():
return paymentCompleted();case TropipayWebhookEventTypePaymentFailed():
return paymentFailed();case TropipayWebhookEventTypePaymentCancelled():
return paymentCancelled();case TropipayWebhookEventTypePaymentRefunded():
return paymentRefunded();case TropipayWebhookEventTypePaymentExpired():
return paymentExpired();case TropipayWebhookEventTypePaymentProcessing():
return paymentProcessing();case TropipayWebhookEventTypeUnknown():
return unknown();}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  paymentCreated,TResult? Function()?  paymentCompleted,TResult? Function()?  paymentFailed,TResult? Function()?  paymentCancelled,TResult? Function()?  paymentRefunded,TResult? Function()?  paymentExpired,TResult? Function()?  paymentProcessing,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case TropipayWebhookEventTypePaymentCreated() when paymentCreated != null:
return paymentCreated();case TropipayWebhookEventTypePaymentCompleted() when paymentCompleted != null:
return paymentCompleted();case TropipayWebhookEventTypePaymentFailed() when paymentFailed != null:
return paymentFailed();case TropipayWebhookEventTypePaymentCancelled() when paymentCancelled != null:
return paymentCancelled();case TropipayWebhookEventTypePaymentRefunded() when paymentRefunded != null:
return paymentRefunded();case TropipayWebhookEventTypePaymentExpired() when paymentExpired != null:
return paymentExpired();case TropipayWebhookEventTypePaymentProcessing() when paymentProcessing != null:
return paymentProcessing();case TropipayWebhookEventTypeUnknown() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc


class TropipayWebhookEventTypePaymentCreated implements TropipayWebhookEventType {
  const TropipayWebhookEventTypePaymentCreated();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypePaymentCreated);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.paymentCreated()';
}


}




/// @nodoc


class TropipayWebhookEventTypePaymentCompleted implements TropipayWebhookEventType {
  const TropipayWebhookEventTypePaymentCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypePaymentCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.paymentCompleted()';
}


}




/// @nodoc


class TropipayWebhookEventTypePaymentFailed implements TropipayWebhookEventType {
  const TropipayWebhookEventTypePaymentFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypePaymentFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.paymentFailed()';
}


}




/// @nodoc


class TropipayWebhookEventTypePaymentCancelled implements TropipayWebhookEventType {
  const TropipayWebhookEventTypePaymentCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypePaymentCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.paymentCancelled()';
}


}




/// @nodoc


class TropipayWebhookEventTypePaymentRefunded implements TropipayWebhookEventType {
  const TropipayWebhookEventTypePaymentRefunded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypePaymentRefunded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.paymentRefunded()';
}


}




/// @nodoc


class TropipayWebhookEventTypePaymentExpired implements TropipayWebhookEventType {
  const TropipayWebhookEventTypePaymentExpired();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypePaymentExpired);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.paymentExpired()';
}


}




/// @nodoc


class TropipayWebhookEventTypePaymentProcessing implements TropipayWebhookEventType {
  const TropipayWebhookEventTypePaymentProcessing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypePaymentProcessing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.paymentProcessing()';
}


}




/// @nodoc


class TropipayWebhookEventTypeUnknown implements TropipayWebhookEventType {
  const TropipayWebhookEventTypeUnknown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventTypeUnknown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'TropipayWebhookEventType.unknown()';
}


}





/// @nodoc
mixin _$TropipayWebhookEventData {

/// Código de autorización
 String? get authorizationCode;/// Razón del fallo
 String? get failureReason;/// Datos del cliente
 Map<String, dynamic>? get customerData;/// Datos de la tarjeta (últimos 4 dígitos)
 Map<String, dynamic>? get cardData;/// Comisiones aplicadas
 Map<String, dynamic>? get feeData;/// URL de redirección
 String? get redirectUrl;/// Datos adicionales del evento
 Map<String, dynamic> get additionalData;
/// Create a copy of TropipayWebhookEventData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TropipayWebhookEventDataCopyWith<TropipayWebhookEventData> get copyWith => _$TropipayWebhookEventDataCopyWithImpl<TropipayWebhookEventData>(this as TropipayWebhookEventData, _$identity);

  /// Serializes this TropipayWebhookEventData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TropipayWebhookEventData&&(identical(other.authorizationCode, authorizationCode) || other.authorizationCode == authorizationCode)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&const DeepCollectionEquality().equals(other.customerData, customerData)&&const DeepCollectionEquality().equals(other.cardData, cardData)&&const DeepCollectionEquality().equals(other.feeData, feeData)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&const DeepCollectionEquality().equals(other.additionalData, additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorizationCode,failureReason,const DeepCollectionEquality().hash(customerData),const DeepCollectionEquality().hash(cardData),const DeepCollectionEquality().hash(feeData),redirectUrl,const DeepCollectionEquality().hash(additionalData));

@override
String toString() {
  return 'TropipayWebhookEventData(authorizationCode: $authorizationCode, failureReason: $failureReason, customerData: $customerData, cardData: $cardData, feeData: $feeData, redirectUrl: $redirectUrl, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class $TropipayWebhookEventDataCopyWith<$Res>  {
  factory $TropipayWebhookEventDataCopyWith(TropipayWebhookEventData value, $Res Function(TropipayWebhookEventData) _then) = _$TropipayWebhookEventDataCopyWithImpl;
@useResult
$Res call({
 String? authorizationCode, String? failureReason, Map<String, dynamic>? customerData, Map<String, dynamic>? cardData, Map<String, dynamic>? feeData, String? redirectUrl, Map<String, dynamic> additionalData
});




}
/// @nodoc
class _$TropipayWebhookEventDataCopyWithImpl<$Res>
    implements $TropipayWebhookEventDataCopyWith<$Res> {
  _$TropipayWebhookEventDataCopyWithImpl(this._self, this._then);

  final TropipayWebhookEventData _self;
  final $Res Function(TropipayWebhookEventData) _then;

/// Create a copy of TropipayWebhookEventData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? authorizationCode = freezed,Object? failureReason = freezed,Object? customerData = freezed,Object? cardData = freezed,Object? feeData = freezed,Object? redirectUrl = freezed,Object? additionalData = null,}) {
  return _then(_self.copyWith(
authorizationCode: freezed == authorizationCode ? _self.authorizationCode : authorizationCode // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,customerData: freezed == customerData ? _self.customerData : customerData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,cardData: freezed == cardData ? _self.cardData : cardData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,feeData: freezed == feeData ? _self.feeData : feeData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,additionalData: null == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [TropipayWebhookEventData].
extension TropipayWebhookEventDataPatterns on TropipayWebhookEventData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TropipayWebhookEventData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TropipayWebhookEventData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TropipayWebhookEventData value)  $default,){
final _that = this;
switch (_that) {
case _TropipayWebhookEventData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TropipayWebhookEventData value)?  $default,){
final _that = this;
switch (_that) {
case _TropipayWebhookEventData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? authorizationCode,  String? failureReason,  Map<String, dynamic>? customerData,  Map<String, dynamic>? cardData,  Map<String, dynamic>? feeData,  String? redirectUrl,  Map<String, dynamic> additionalData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TropipayWebhookEventData() when $default != null:
return $default(_that.authorizationCode,_that.failureReason,_that.customerData,_that.cardData,_that.feeData,_that.redirectUrl,_that.additionalData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? authorizationCode,  String? failureReason,  Map<String, dynamic>? customerData,  Map<String, dynamic>? cardData,  Map<String, dynamic>? feeData,  String? redirectUrl,  Map<String, dynamic> additionalData)  $default,) {final _that = this;
switch (_that) {
case _TropipayWebhookEventData():
return $default(_that.authorizationCode,_that.failureReason,_that.customerData,_that.cardData,_that.feeData,_that.redirectUrl,_that.additionalData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? authorizationCode,  String? failureReason,  Map<String, dynamic>? customerData,  Map<String, dynamic>? cardData,  Map<String, dynamic>? feeData,  String? redirectUrl,  Map<String, dynamic> additionalData)?  $default,) {final _that = this;
switch (_that) {
case _TropipayWebhookEventData() when $default != null:
return $default(_that.authorizationCode,_that.failureReason,_that.customerData,_that.cardData,_that.feeData,_that.redirectUrl,_that.additionalData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TropipayWebhookEventData implements TropipayWebhookEventData {
  const _TropipayWebhookEventData({this.authorizationCode, this.failureReason, final  Map<String, dynamic>? customerData, final  Map<String, dynamic>? cardData, final  Map<String, dynamic>? feeData, this.redirectUrl, final  Map<String, dynamic> additionalData = const {}}): _customerData = customerData,_cardData = cardData,_feeData = feeData,_additionalData = additionalData;
  factory _TropipayWebhookEventData.fromJson(Map<String, dynamic> json) => _$TropipayWebhookEventDataFromJson(json);

/// Código de autorización
@override final  String? authorizationCode;
/// Razón del fallo
@override final  String? failureReason;
/// Datos del cliente
 final  Map<String, dynamic>? _customerData;
/// Datos del cliente
@override Map<String, dynamic>? get customerData {
  final value = _customerData;
  if (value == null) return null;
  if (_customerData is EqualUnmodifiableMapView) return _customerData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Datos de la tarjeta (últimos 4 dígitos)
 final  Map<String, dynamic>? _cardData;
/// Datos de la tarjeta (últimos 4 dígitos)
@override Map<String, dynamic>? get cardData {
  final value = _cardData;
  if (value == null) return null;
  if (_cardData is EqualUnmodifiableMapView) return _cardData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// Comisiones aplicadas
 final  Map<String, dynamic>? _feeData;
/// Comisiones aplicadas
@override Map<String, dynamic>? get feeData {
  final value = _feeData;
  if (value == null) return null;
  if (_feeData is EqualUnmodifiableMapView) return _feeData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

/// URL de redirección
@override final  String? redirectUrl;
/// Datos adicionales del evento
 final  Map<String, dynamic> _additionalData;
/// Datos adicionales del evento
@override@JsonKey() Map<String, dynamic> get additionalData {
  if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_additionalData);
}


/// Create a copy of TropipayWebhookEventData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TropipayWebhookEventDataCopyWith<_TropipayWebhookEventData> get copyWith => __$TropipayWebhookEventDataCopyWithImpl<_TropipayWebhookEventData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TropipayWebhookEventDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TropipayWebhookEventData&&(identical(other.authorizationCode, authorizationCode) || other.authorizationCode == authorizationCode)&&(identical(other.failureReason, failureReason) || other.failureReason == failureReason)&&const DeepCollectionEquality().equals(other._customerData, _customerData)&&const DeepCollectionEquality().equals(other._cardData, _cardData)&&const DeepCollectionEquality().equals(other._feeData, _feeData)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&const DeepCollectionEquality().equals(other._additionalData, _additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,authorizationCode,failureReason,const DeepCollectionEquality().hash(_customerData),const DeepCollectionEquality().hash(_cardData),const DeepCollectionEquality().hash(_feeData),redirectUrl,const DeepCollectionEquality().hash(_additionalData));

@override
String toString() {
  return 'TropipayWebhookEventData(authorizationCode: $authorizationCode, failureReason: $failureReason, customerData: $customerData, cardData: $cardData, feeData: $feeData, redirectUrl: $redirectUrl, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class _$TropipayWebhookEventDataCopyWith<$Res> implements $TropipayWebhookEventDataCopyWith<$Res> {
  factory _$TropipayWebhookEventDataCopyWith(_TropipayWebhookEventData value, $Res Function(_TropipayWebhookEventData) _then) = __$TropipayWebhookEventDataCopyWithImpl;
@override @useResult
$Res call({
 String? authorizationCode, String? failureReason, Map<String, dynamic>? customerData, Map<String, dynamic>? cardData, Map<String, dynamic>? feeData, String? redirectUrl, Map<String, dynamic> additionalData
});




}
/// @nodoc
class __$TropipayWebhookEventDataCopyWithImpl<$Res>
    implements _$TropipayWebhookEventDataCopyWith<$Res> {
  __$TropipayWebhookEventDataCopyWithImpl(this._self, this._then);

  final _TropipayWebhookEventData _self;
  final $Res Function(_TropipayWebhookEventData) _then;

/// Create a copy of TropipayWebhookEventData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? authorizationCode = freezed,Object? failureReason = freezed,Object? customerData = freezed,Object? cardData = freezed,Object? feeData = freezed,Object? redirectUrl = freezed,Object? additionalData = null,}) {
  return _then(_TropipayWebhookEventData(
authorizationCode: freezed == authorizationCode ? _self.authorizationCode : authorizationCode // ignore: cast_nullable_to_non_nullable
as String?,failureReason: freezed == failureReason ? _self.failureReason : failureReason // ignore: cast_nullable_to_non_nullable
as String?,customerData: freezed == customerData ? _self._customerData : customerData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,cardData: freezed == cardData ? _self._cardData : cardData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,feeData: freezed == feeData ? _self._feeData : feeData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,additionalData: null == additionalData ? _self._additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
