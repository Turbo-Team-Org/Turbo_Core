// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_status.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentStatus {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentStatus);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus()';
}


}

/// @nodoc
class $PaymentStatusCopyWith<$Res>  {
$PaymentStatusCopyWith(PaymentStatus _, $Res Function(PaymentStatus) __);
}


/// Adds pattern-matching-related methods to [PaymentStatus].
extension PaymentStatusPatterns on PaymentStatus {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaymentPending value)?  pending,TResult Function( PaymentProcessing value)?  processing,TResult Function( PaymentCompleted value)?  completed,TResult Function( PaymentFailed value)?  failed,TResult Function( PaymentCancelled value)?  cancelled,TResult Function( PaymentRefunded value)?  refunded,TResult Function( PaymentExpired value)?  expired,TResult Function( PaymentUnknown value)?  unknown,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaymentPending() when pending != null:
return pending(_that);case PaymentProcessing() when processing != null:
return processing(_that);case PaymentCompleted() when completed != null:
return completed(_that);case PaymentFailed() when failed != null:
return failed(_that);case PaymentCancelled() when cancelled != null:
return cancelled(_that);case PaymentRefunded() when refunded != null:
return refunded(_that);case PaymentExpired() when expired != null:
return expired(_that);case PaymentUnknown() when unknown != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaymentPending value)  pending,required TResult Function( PaymentProcessing value)  processing,required TResult Function( PaymentCompleted value)  completed,required TResult Function( PaymentFailed value)  failed,required TResult Function( PaymentCancelled value)  cancelled,required TResult Function( PaymentRefunded value)  refunded,required TResult Function( PaymentExpired value)  expired,required TResult Function( PaymentUnknown value)  unknown,}){
final _that = this;
switch (_that) {
case PaymentPending():
return pending(_that);case PaymentProcessing():
return processing(_that);case PaymentCompleted():
return completed(_that);case PaymentFailed():
return failed(_that);case PaymentCancelled():
return cancelled(_that);case PaymentRefunded():
return refunded(_that);case PaymentExpired():
return expired(_that);case PaymentUnknown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaymentPending value)?  pending,TResult? Function( PaymentProcessing value)?  processing,TResult? Function( PaymentCompleted value)?  completed,TResult? Function( PaymentFailed value)?  failed,TResult? Function( PaymentCancelled value)?  cancelled,TResult? Function( PaymentRefunded value)?  refunded,TResult? Function( PaymentExpired value)?  expired,TResult? Function( PaymentUnknown value)?  unknown,}){
final _that = this;
switch (_that) {
case PaymentPending() when pending != null:
return pending(_that);case PaymentProcessing() when processing != null:
return processing(_that);case PaymentCompleted() when completed != null:
return completed(_that);case PaymentFailed() when failed != null:
return failed(_that);case PaymentCancelled() when cancelled != null:
return cancelled(_that);case PaymentRefunded() when refunded != null:
return refunded(_that);case PaymentExpired() when expired != null:
return expired(_that);case PaymentUnknown() when unknown != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  pending,TResult Function()?  processing,TResult Function()?  completed,TResult Function()?  failed,TResult Function()?  cancelled,TResult Function()?  refunded,TResult Function()?  expired,TResult Function()?  unknown,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaymentPending() when pending != null:
return pending();case PaymentProcessing() when processing != null:
return processing();case PaymentCompleted() when completed != null:
return completed();case PaymentFailed() when failed != null:
return failed();case PaymentCancelled() when cancelled != null:
return cancelled();case PaymentRefunded() when refunded != null:
return refunded();case PaymentExpired() when expired != null:
return expired();case PaymentUnknown() when unknown != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  pending,required TResult Function()  processing,required TResult Function()  completed,required TResult Function()  failed,required TResult Function()  cancelled,required TResult Function()  refunded,required TResult Function()  expired,required TResult Function()  unknown,}) {final _that = this;
switch (_that) {
case PaymentPending():
return pending();case PaymentProcessing():
return processing();case PaymentCompleted():
return completed();case PaymentFailed():
return failed();case PaymentCancelled():
return cancelled();case PaymentRefunded():
return refunded();case PaymentExpired():
return expired();case PaymentUnknown():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  pending,TResult? Function()?  processing,TResult? Function()?  completed,TResult? Function()?  failed,TResult? Function()?  cancelled,TResult? Function()?  refunded,TResult? Function()?  expired,TResult? Function()?  unknown,}) {final _that = this;
switch (_that) {
case PaymentPending() when pending != null:
return pending();case PaymentProcessing() when processing != null:
return processing();case PaymentCompleted() when completed != null:
return completed();case PaymentFailed() when failed != null:
return failed();case PaymentCancelled() when cancelled != null:
return cancelled();case PaymentRefunded() when refunded != null:
return refunded();case PaymentExpired() when expired != null:
return expired();case PaymentUnknown() when unknown != null:
return unknown();case _:
  return null;

}
}

}

/// @nodoc


class PaymentPending implements PaymentStatus {
  const PaymentPending();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentPending);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.pending()';
}


}




/// @nodoc


class PaymentProcessing implements PaymentStatus {
  const PaymentProcessing();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentProcessing);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.processing()';
}


}




/// @nodoc


class PaymentCompleted implements PaymentStatus {
  const PaymentCompleted();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentCompleted);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.completed()';
}


}




/// @nodoc


class PaymentFailed implements PaymentStatus {
  const PaymentFailed();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentFailed);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.failed()';
}


}




/// @nodoc


class PaymentCancelled implements PaymentStatus {
  const PaymentCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.cancelled()';
}


}




/// @nodoc


class PaymentRefunded implements PaymentStatus {
  const PaymentRefunded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentRefunded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.refunded()';
}


}




/// @nodoc


class PaymentExpired implements PaymentStatus {
  const PaymentExpired();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentExpired);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.expired()';
}


}




/// @nodoc


class PaymentUnknown implements PaymentStatus {
  const PaymentUnknown();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentUnknown);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentStatus.unknown()';
}


}




// dart format on
