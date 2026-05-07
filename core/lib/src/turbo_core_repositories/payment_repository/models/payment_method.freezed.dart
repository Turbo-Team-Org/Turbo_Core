// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_method.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentMethod {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethod);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentMethod()';
}


}

/// @nodoc
class $PaymentMethodCopyWith<$Res>  {
$PaymentMethodCopyWith(PaymentMethod _, $Res Function(PaymentMethod) __);
}


/// Adds pattern-matching-related methods to [PaymentMethod].
extension PaymentMethodPatterns on PaymentMethod {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( PaymentMethodCard value)?  card,TResult Function( PaymentMethodBankTransfer value)?  bankTransfer,TResult Function( PaymentMethodPaypal value)?  paypal,TResult Function( PaymentMethodMobileTransfer value)?  mobileTransfer,TResult Function( PaymentMethodCash value)?  cash,TResult Function( PaymentMethodCustom value)?  custom,required TResult orElse(),}){
final _that = this;
switch (_that) {
case PaymentMethodCard() when card != null:
return card(_that);case PaymentMethodBankTransfer() when bankTransfer != null:
return bankTransfer(_that);case PaymentMethodPaypal() when paypal != null:
return paypal(_that);case PaymentMethodMobileTransfer() when mobileTransfer != null:
return mobileTransfer(_that);case PaymentMethodCash() when cash != null:
return cash(_that);case PaymentMethodCustom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( PaymentMethodCard value)  card,required TResult Function( PaymentMethodBankTransfer value)  bankTransfer,required TResult Function( PaymentMethodPaypal value)  paypal,required TResult Function( PaymentMethodMobileTransfer value)  mobileTransfer,required TResult Function( PaymentMethodCash value)  cash,required TResult Function( PaymentMethodCustom value)  custom,}){
final _that = this;
switch (_that) {
case PaymentMethodCard():
return card(_that);case PaymentMethodBankTransfer():
return bankTransfer(_that);case PaymentMethodPaypal():
return paypal(_that);case PaymentMethodMobileTransfer():
return mobileTransfer(_that);case PaymentMethodCash():
return cash(_that);case PaymentMethodCustom():
return custom(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( PaymentMethodCard value)?  card,TResult? Function( PaymentMethodBankTransfer value)?  bankTransfer,TResult? Function( PaymentMethodPaypal value)?  paypal,TResult? Function( PaymentMethodMobileTransfer value)?  mobileTransfer,TResult? Function( PaymentMethodCash value)?  cash,TResult? Function( PaymentMethodCustom value)?  custom,}){
final _that = this;
switch (_that) {
case PaymentMethodCard() when card != null:
return card(_that);case PaymentMethodBankTransfer() when bankTransfer != null:
return bankTransfer(_that);case PaymentMethodPaypal() when paypal != null:
return paypal(_that);case PaymentMethodMobileTransfer() when mobileTransfer != null:
return mobileTransfer(_that);case PaymentMethodCash() when cash != null:
return cash(_that);case PaymentMethodCustom() when custom != null:
return custom(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  card,TResult Function()?  bankTransfer,TResult Function()?  paypal,TResult Function()?  mobileTransfer,TResult Function()?  cash,TResult Function( String method)?  custom,required TResult orElse(),}) {final _that = this;
switch (_that) {
case PaymentMethodCard() when card != null:
return card();case PaymentMethodBankTransfer() when bankTransfer != null:
return bankTransfer();case PaymentMethodPaypal() when paypal != null:
return paypal();case PaymentMethodMobileTransfer() when mobileTransfer != null:
return mobileTransfer();case PaymentMethodCash() when cash != null:
return cash();case PaymentMethodCustom() when custom != null:
return custom(_that.method);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  card,required TResult Function()  bankTransfer,required TResult Function()  paypal,required TResult Function()  mobileTransfer,required TResult Function()  cash,required TResult Function( String method)  custom,}) {final _that = this;
switch (_that) {
case PaymentMethodCard():
return card();case PaymentMethodBankTransfer():
return bankTransfer();case PaymentMethodPaypal():
return paypal();case PaymentMethodMobileTransfer():
return mobileTransfer();case PaymentMethodCash():
return cash();case PaymentMethodCustom():
return custom(_that.method);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  card,TResult? Function()?  bankTransfer,TResult? Function()?  paypal,TResult? Function()?  mobileTransfer,TResult? Function()?  cash,TResult? Function( String method)?  custom,}) {final _that = this;
switch (_that) {
case PaymentMethodCard() when card != null:
return card();case PaymentMethodBankTransfer() when bankTransfer != null:
return bankTransfer();case PaymentMethodPaypal() when paypal != null:
return paypal();case PaymentMethodMobileTransfer() when mobileTransfer != null:
return mobileTransfer();case PaymentMethodCash() when cash != null:
return cash();case PaymentMethodCustom() when custom != null:
return custom(_that.method);case _:
  return null;

}
}

}

/// @nodoc


class PaymentMethodCard implements PaymentMethod {
  const PaymentMethodCard();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodCard);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentMethod.card()';
}


}




/// @nodoc


class PaymentMethodBankTransfer implements PaymentMethod {
  const PaymentMethodBankTransfer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodBankTransfer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentMethod.bankTransfer()';
}


}




/// @nodoc


class PaymentMethodPaypal implements PaymentMethod {
  const PaymentMethodPaypal();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodPaypal);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentMethod.paypal()';
}


}




/// @nodoc


class PaymentMethodMobileTransfer implements PaymentMethod {
  const PaymentMethodMobileTransfer();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodMobileTransfer);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentMethod.mobileTransfer()';
}


}




/// @nodoc


class PaymentMethodCash implements PaymentMethod {
  const PaymentMethodCash();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodCash);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentMethod.cash()';
}


}




/// @nodoc


class PaymentMethodCustom implements PaymentMethod {
  const PaymentMethodCustom(this.method);
  

 final  String method;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentMethodCustomCopyWith<PaymentMethodCustom> get copyWith => _$PaymentMethodCustomCopyWithImpl<PaymentMethodCustom>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentMethodCustom&&(identical(other.method, method) || other.method == method));
}


@override
int get hashCode => Object.hash(runtimeType,method);

@override
String toString() {
  return 'PaymentMethod.custom(method: $method)';
}


}

/// @nodoc
abstract mixin class $PaymentMethodCustomCopyWith<$Res> implements $PaymentMethodCopyWith<$Res> {
  factory $PaymentMethodCustomCopyWith(PaymentMethodCustom value, $Res Function(PaymentMethodCustom) _then) = _$PaymentMethodCustomCopyWithImpl;
@useResult
$Res call({
 String method
});




}
/// @nodoc
class _$PaymentMethodCustomCopyWithImpl<$Res>
    implements $PaymentMethodCustomCopyWith<$Res> {
  _$PaymentMethodCustomCopyWithImpl(this._self, this._then);

  final PaymentMethodCustom _self;
  final $Res Function(PaymentMethodCustom) _then;

/// Create a copy of PaymentMethod
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? method = null,}) {
  return _then(PaymentMethodCustom(
null == method ? _self.method : method // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
