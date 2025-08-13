// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'schedule.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Schedule {

 String get opening; String get closing; bool get isFullDay; String get dayName;
/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ScheduleCopyWith<Schedule> get copyWith => _$ScheduleCopyWithImpl<Schedule>(this as Schedule, _$identity);

  /// Serializes this Schedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Schedule&&(identical(other.opening, opening) || other.opening == opening)&&(identical(other.closing, closing) || other.closing == closing)&&(identical(other.isFullDay, isFullDay) || other.isFullDay == isFullDay)&&(identical(other.dayName, dayName) || other.dayName == dayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opening,closing,isFullDay,dayName);

@override
String toString() {
  return 'Schedule(opening: $opening, closing: $closing, isFullDay: $isFullDay, dayName: $dayName)';
}


}

/// @nodoc
abstract mixin class $ScheduleCopyWith<$Res>  {
  factory $ScheduleCopyWith(Schedule value, $Res Function(Schedule) _then) = _$ScheduleCopyWithImpl;
@useResult
$Res call({
 String opening, String closing, bool isFullDay, String dayName
});




}
/// @nodoc
class _$ScheduleCopyWithImpl<$Res>
    implements $ScheduleCopyWith<$Res> {
  _$ScheduleCopyWithImpl(this._self, this._then);

  final Schedule _self;
  final $Res Function(Schedule) _then;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? opening = null,Object? closing = null,Object? isFullDay = null,Object? dayName = null,}) {
  return _then(_self.copyWith(
opening: null == opening ? _self.opening : opening // ignore: cast_nullable_to_non_nullable
as String,closing: null == closing ? _self.closing : closing // ignore: cast_nullable_to_non_nullable
as String,isFullDay: null == isFullDay ? _self.isFullDay : isFullDay // ignore: cast_nullable_to_non_nullable
as bool,dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Schedule].
extension SchedulePatterns on Schedule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Schedule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Schedule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Schedule value)  $default,){
final _that = this;
switch (_that) {
case _Schedule():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Schedule value)?  $default,){
final _that = this;
switch (_that) {
case _Schedule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String opening,  String closing,  bool isFullDay,  String dayName)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Schedule() when $default != null:
return $default(_that.opening,_that.closing,_that.isFullDay,_that.dayName);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String opening,  String closing,  bool isFullDay,  String dayName)  $default,) {final _that = this;
switch (_that) {
case _Schedule():
return $default(_that.opening,_that.closing,_that.isFullDay,_that.dayName);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String opening,  String closing,  bool isFullDay,  String dayName)?  $default,) {final _that = this;
switch (_that) {
case _Schedule() when $default != null:
return $default(_that.opening,_that.closing,_that.isFullDay,_that.dayName);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Schedule extends Schedule {
  const _Schedule({required this.opening, required this.closing, this.isFullDay = false, this.dayName = ''}): super._();
  factory _Schedule.fromJson(Map<String, dynamic> json) => _$ScheduleFromJson(json);

@override final  String opening;
@override final  String closing;
@override@JsonKey() final  bool isFullDay;
@override@JsonKey() final  String dayName;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ScheduleCopyWith<_Schedule> get copyWith => __$ScheduleCopyWithImpl<_Schedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Schedule&&(identical(other.opening, opening) || other.opening == opening)&&(identical(other.closing, closing) || other.closing == closing)&&(identical(other.isFullDay, isFullDay) || other.isFullDay == isFullDay)&&(identical(other.dayName, dayName) || other.dayName == dayName));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,opening,closing,isFullDay,dayName);

@override
String toString() {
  return 'Schedule(opening: $opening, closing: $closing, isFullDay: $isFullDay, dayName: $dayName)';
}


}

/// @nodoc
abstract mixin class _$ScheduleCopyWith<$Res> implements $ScheduleCopyWith<$Res> {
  factory _$ScheduleCopyWith(_Schedule value, $Res Function(_Schedule) _then) = __$ScheduleCopyWithImpl;
@override @useResult
$Res call({
 String opening, String closing, bool isFullDay, String dayName
});




}
/// @nodoc
class __$ScheduleCopyWithImpl<$Res>
    implements _$ScheduleCopyWith<$Res> {
  __$ScheduleCopyWithImpl(this._self, this._then);

  final _Schedule _self;
  final $Res Function(_Schedule) _then;

/// Create a copy of Schedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? opening = null,Object? closing = null,Object? isFullDay = null,Object? dayName = null,}) {
  return _then(_Schedule(
opening: null == opening ? _self.opening : opening // ignore: cast_nullable_to_non_nullable
as String,closing: null == closing ? _self.closing : closing // ignore: cast_nullable_to_non_nullable
as String,isFullDay: null == isFullDay ? _self.isFullDay : isFullDay // ignore: cast_nullable_to_non_nullable
as bool,dayName: null == dayName ? _self.dayName : dayName // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
