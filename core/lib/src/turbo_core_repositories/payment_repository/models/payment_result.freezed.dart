// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentResult {

/// Indica si la operación fue exitosa
 bool get success;/// Estado del pago
@PaymentStatusConverter() PaymentStatus get status;/// Pago procesado (si aplica)
 Payment? get payment;/// ID de la transacción
 String? get transactionId;/// URL de redirección para completar el pago
 String? get redirectUrl;/// URL de la pasarela de pago
 String? get paymentUrl;/// Mensaje descriptivo
 String? get message;/// Código de error (si aplica)
 String? get errorCode;/// Detalles del error
 String? get errorDetails;/// Datos adicionales de la respuesta
 Map<String, dynamic> get metadata;/// Timestamp de la operación
 DateTime? get timestamp;
/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentResultCopyWith<PaymentResult> get copyWith => _$PaymentResultCopyWithImpl<PaymentResult>(this as PaymentResult, _$identity);

  /// Serializes this PaymentResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentResult&&(identical(other.success, success) || other.success == success)&&(identical(other.status, status) || other.status == status)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorDetails, errorDetails) || other.errorDetails == errorDetails)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,status,payment,transactionId,redirectUrl,paymentUrl,message,errorCode,errorDetails,const DeepCollectionEquality().hash(metadata),timestamp);

@override
String toString() {
  return 'PaymentResult(success: $success, status: $status, payment: $payment, transactionId: $transactionId, redirectUrl: $redirectUrl, paymentUrl: $paymentUrl, message: $message, errorCode: $errorCode, errorDetails: $errorDetails, metadata: $metadata, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class $PaymentResultCopyWith<$Res>  {
  factory $PaymentResultCopyWith(PaymentResult value, $Res Function(PaymentResult) _then) = _$PaymentResultCopyWithImpl;
@useResult
$Res call({
 bool success,@PaymentStatusConverter() PaymentStatus status, Payment? payment, String? transactionId, String? redirectUrl, String? paymentUrl, String? message, String? errorCode, String? errorDetails, Map<String, dynamic> metadata, DateTime? timestamp
});


$PaymentStatusCopyWith<$Res> get status;$PaymentCopyWith<$Res>? get payment;

}
/// @nodoc
class _$PaymentResultCopyWithImpl<$Res>
    implements $PaymentResultCopyWith<$Res> {
  _$PaymentResultCopyWithImpl(this._self, this._then);

  final PaymentResult _self;
  final $Res Function(PaymentResult) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? status = null,Object? payment = freezed,Object? transactionId = freezed,Object? redirectUrl = freezed,Object? paymentUrl = freezed,Object? message = freezed,Object? errorCode = freezed,Object? errorDetails = freezed,Object? metadata = null,Object? timestamp = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as Payment?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorDetails: freezed == errorDetails ? _self.errorDetails : errorDetails // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}
/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of PaymentResult
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
}
}


/// Adds pattern-matching-related methods to [PaymentResult].
extension PaymentResultPatterns on PaymentResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentResult value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentResult value)  $default,){
final _that = this;
switch (_that) {
case _PaymentResult():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentResult value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success, @PaymentStatusConverter()  PaymentStatus status,  Payment? payment,  String? transactionId,  String? redirectUrl,  String? paymentUrl,  String? message,  String? errorCode,  String? errorDetails,  Map<String, dynamic> metadata,  DateTime? timestamp)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
return $default(_that.success,_that.status,_that.payment,_that.transactionId,_that.redirectUrl,_that.paymentUrl,_that.message,_that.errorCode,_that.errorDetails,_that.metadata,_that.timestamp);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success, @PaymentStatusConverter()  PaymentStatus status,  Payment? payment,  String? transactionId,  String? redirectUrl,  String? paymentUrl,  String? message,  String? errorCode,  String? errorDetails,  Map<String, dynamic> metadata,  DateTime? timestamp)  $default,) {final _that = this;
switch (_that) {
case _PaymentResult():
return $default(_that.success,_that.status,_that.payment,_that.transactionId,_that.redirectUrl,_that.paymentUrl,_that.message,_that.errorCode,_that.errorDetails,_that.metadata,_that.timestamp);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success, @PaymentStatusConverter()  PaymentStatus status,  Payment? payment,  String? transactionId,  String? redirectUrl,  String? paymentUrl,  String? message,  String? errorCode,  String? errorDetails,  Map<String, dynamic> metadata,  DateTime? timestamp)?  $default,) {final _that = this;
switch (_that) {
case _PaymentResult() when $default != null:
return $default(_that.success,_that.status,_that.payment,_that.transactionId,_that.redirectUrl,_that.paymentUrl,_that.message,_that.errorCode,_that.errorDetails,_that.metadata,_that.timestamp);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentResult implements PaymentResult {
  const _PaymentResult({required this.success, @PaymentStatusConverter() required this.status, this.payment, this.transactionId, this.redirectUrl, this.paymentUrl, this.message, this.errorCode, this.errorDetails, final  Map<String, dynamic> metadata = const {}, this.timestamp}): _metadata = metadata;
  factory _PaymentResult.fromJson(Map<String, dynamic> json) => _$PaymentResultFromJson(json);

/// Indica si la operación fue exitosa
@override final  bool success;
/// Estado del pago
@override@PaymentStatusConverter() final  PaymentStatus status;
/// Pago procesado (si aplica)
@override final  Payment? payment;
/// ID de la transacción
@override final  String? transactionId;
/// URL de redirección para completar el pago
@override final  String? redirectUrl;
/// URL de la pasarela de pago
@override final  String? paymentUrl;
/// Mensaje descriptivo
@override final  String? message;
/// Código de error (si aplica)
@override final  String? errorCode;
/// Detalles del error
@override final  String? errorDetails;
/// Datos adicionales de la respuesta
 final  Map<String, dynamic> _metadata;
/// Datos adicionales de la respuesta
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

/// Timestamp de la operación
@override final  DateTime? timestamp;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentResultCopyWith<_PaymentResult> get copyWith => __$PaymentResultCopyWithImpl<_PaymentResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentResult&&(identical(other.success, success) || other.success == success)&&(identical(other.status, status) || other.status == status)&&(identical(other.payment, payment) || other.payment == payment)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.redirectUrl, redirectUrl) || other.redirectUrl == redirectUrl)&&(identical(other.paymentUrl, paymentUrl) || other.paymentUrl == paymentUrl)&&(identical(other.message, message) || other.message == message)&&(identical(other.errorCode, errorCode) || other.errorCode == errorCode)&&(identical(other.errorDetails, errorDetails) || other.errorDetails == errorDetails)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,status,payment,transactionId,redirectUrl,paymentUrl,message,errorCode,errorDetails,const DeepCollectionEquality().hash(_metadata),timestamp);

@override
String toString() {
  return 'PaymentResult(success: $success, status: $status, payment: $payment, transactionId: $transactionId, redirectUrl: $redirectUrl, paymentUrl: $paymentUrl, message: $message, errorCode: $errorCode, errorDetails: $errorDetails, metadata: $metadata, timestamp: $timestamp)';
}


}

/// @nodoc
abstract mixin class _$PaymentResultCopyWith<$Res> implements $PaymentResultCopyWith<$Res> {
  factory _$PaymentResultCopyWith(_PaymentResult value, $Res Function(_PaymentResult) _then) = __$PaymentResultCopyWithImpl;
@override @useResult
$Res call({
 bool success,@PaymentStatusConverter() PaymentStatus status, Payment? payment, String? transactionId, String? redirectUrl, String? paymentUrl, String? message, String? errorCode, String? errorDetails, Map<String, dynamic> metadata, DateTime? timestamp
});


@override $PaymentStatusCopyWith<$Res> get status;@override $PaymentCopyWith<$Res>? get payment;

}
/// @nodoc
class __$PaymentResultCopyWithImpl<$Res>
    implements _$PaymentResultCopyWith<$Res> {
  __$PaymentResultCopyWithImpl(this._self, this._then);

  final _PaymentResult _self;
  final $Res Function(_PaymentResult) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? status = null,Object? payment = freezed,Object? transactionId = freezed,Object? redirectUrl = freezed,Object? paymentUrl = freezed,Object? message = freezed,Object? errorCode = freezed,Object? errorDetails = freezed,Object? metadata = null,Object? timestamp = freezed,}) {
  return _then(_PaymentResult(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as PaymentStatus,payment: freezed == payment ? _self.payment : payment // ignore: cast_nullable_to_non_nullable
as Payment?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,redirectUrl: freezed == redirectUrl ? _self.redirectUrl : redirectUrl // ignore: cast_nullable_to_non_nullable
as String?,paymentUrl: freezed == paymentUrl ? _self.paymentUrl : paymentUrl // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,errorCode: freezed == errorCode ? _self.errorCode : errorCode // ignore: cast_nullable_to_non_nullable
as String?,errorDetails: freezed == errorDetails ? _self.errorDetails : errorDetails // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,timestamp: freezed == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatusCopyWith<$Res> get status {
  
  return $PaymentStatusCopyWith<$Res>(_self.status, (value) {
    return _then(_self.copyWith(status: value));
  });
}/// Create a copy of PaymentResult
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
}
}

// dart format on
