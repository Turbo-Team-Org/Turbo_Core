// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_time_slot.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReservationTimeSlot {

 String get id; DateTime get startTime; DateTime get endTime; int get maxCapacity; int get currentReservations; bool get isAvailable; int get durationMinutes; String? get specialNotes; Map<String, dynamic>? get metadata;
/// Create a copy of ReservationTimeSlot
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationTimeSlotCopyWith<ReservationTimeSlot> get copyWith => _$ReservationTimeSlotCopyWithImpl<ReservationTimeSlot>(this as ReservationTimeSlot, _$identity);

  /// Serializes this ReservationTimeSlot to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationTimeSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity)&&(identical(other.currentReservations, currentReservations) || other.currentReservations == currentReservations)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.specialNotes, specialNotes) || other.specialNotes == specialNotes)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,maxCapacity,currentReservations,isAvailable,durationMinutes,specialNotes,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'ReservationTimeSlot(id: $id, startTime: $startTime, endTime: $endTime, maxCapacity: $maxCapacity, currentReservations: $currentReservations, isAvailable: $isAvailable, durationMinutes: $durationMinutes, specialNotes: $specialNotes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ReservationTimeSlotCopyWith<$Res>  {
  factory $ReservationTimeSlotCopyWith(ReservationTimeSlot value, $Res Function(ReservationTimeSlot) _then) = _$ReservationTimeSlotCopyWithImpl;
@useResult
$Res call({
 String id, DateTime startTime, DateTime endTime, int maxCapacity, int currentReservations, bool isAvailable, int durationMinutes, String? specialNotes, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ReservationTimeSlotCopyWithImpl<$Res>
    implements $ReservationTimeSlotCopyWith<$Res> {
  _$ReservationTimeSlotCopyWithImpl(this._self, this._then);

  final ReservationTimeSlot _self;
  final $Res Function(ReservationTimeSlot) _then;

/// Create a copy of ReservationTimeSlot
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? maxCapacity = null,Object? currentReservations = null,Object? isAvailable = null,Object? durationMinutes = null,Object? specialNotes = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,currentReservations: null == currentReservations ? _self.currentReservations : currentReservations // ignore: cast_nullable_to_non_nullable
as int,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,specialNotes: freezed == specialNotes ? _self.specialNotes : specialNotes // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReservationTimeSlot].
extension ReservationTimeSlotPatterns on ReservationTimeSlot {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationTimeSlot value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationTimeSlot() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationTimeSlot value)  $default,){
final _that = this;
switch (_that) {
case _ReservationTimeSlot():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationTimeSlot value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationTimeSlot() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  DateTime startTime,  DateTime endTime,  int maxCapacity,  int currentReservations,  bool isAvailable,  int durationMinutes,  String? specialNotes,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationTimeSlot() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.maxCapacity,_that.currentReservations,_that.isAvailable,_that.durationMinutes,_that.specialNotes,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  DateTime startTime,  DateTime endTime,  int maxCapacity,  int currentReservations,  bool isAvailable,  int durationMinutes,  String? specialNotes,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _ReservationTimeSlot():
return $default(_that.id,_that.startTime,_that.endTime,_that.maxCapacity,_that.currentReservations,_that.isAvailable,_that.durationMinutes,_that.specialNotes,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  DateTime startTime,  DateTime endTime,  int maxCapacity,  int currentReservations,  bool isAvailable,  int durationMinutes,  String? specialNotes,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _ReservationTimeSlot() when $default != null:
return $default(_that.id,_that.startTime,_that.endTime,_that.maxCapacity,_that.currentReservations,_that.isAvailable,_that.durationMinutes,_that.specialNotes,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReservationTimeSlot extends ReservationTimeSlot {
  const _ReservationTimeSlot({required this.id, required this.startTime, required this.endTime, required this.maxCapacity, required this.currentReservations, this.isAvailable = true, this.durationMinutes = 60, this.specialNotes, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  factory _ReservationTimeSlot.fromJson(Map<String, dynamic> json) => _$ReservationTimeSlotFromJson(json);

@override final  String id;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  int maxCapacity;
@override final  int currentReservations;
@override@JsonKey() final  bool isAvailable;
@override@JsonKey() final  int durationMinutes;
@override final  String? specialNotes;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of ReservationTimeSlot
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationTimeSlotCopyWith<_ReservationTimeSlot> get copyWith => __$ReservationTimeSlotCopyWithImpl<_ReservationTimeSlot>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationTimeSlotToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationTimeSlot&&(identical(other.id, id) || other.id == id)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity)&&(identical(other.currentReservations, currentReservations) || other.currentReservations == currentReservations)&&(identical(other.isAvailable, isAvailable) || other.isAvailable == isAvailable)&&(identical(other.durationMinutes, durationMinutes) || other.durationMinutes == durationMinutes)&&(identical(other.specialNotes, specialNotes) || other.specialNotes == specialNotes)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,startTime,endTime,maxCapacity,currentReservations,isAvailable,durationMinutes,specialNotes,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'ReservationTimeSlot(id: $id, startTime: $startTime, endTime: $endTime, maxCapacity: $maxCapacity, currentReservations: $currentReservations, isAvailable: $isAvailable, durationMinutes: $durationMinutes, specialNotes: $specialNotes, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ReservationTimeSlotCopyWith<$Res> implements $ReservationTimeSlotCopyWith<$Res> {
  factory _$ReservationTimeSlotCopyWith(_ReservationTimeSlot value, $Res Function(_ReservationTimeSlot) _then) = __$ReservationTimeSlotCopyWithImpl;
@override @useResult
$Res call({
 String id, DateTime startTime, DateTime endTime, int maxCapacity, int currentReservations, bool isAvailable, int durationMinutes, String? specialNotes, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$ReservationTimeSlotCopyWithImpl<$Res>
    implements _$ReservationTimeSlotCopyWith<$Res> {
  __$ReservationTimeSlotCopyWithImpl(this._self, this._then);

  final _ReservationTimeSlot _self;
  final $Res Function(_ReservationTimeSlot) _then;

/// Create a copy of ReservationTimeSlot
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? startTime = null,Object? endTime = null,Object? maxCapacity = null,Object? currentReservations = null,Object? isAvailable = null,Object? durationMinutes = null,Object? specialNotes = freezed,Object? metadata = freezed,}) {
  return _then(_ReservationTimeSlot(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,currentReservations: null == currentReservations ? _self.currentReservations : currentReservations // ignore: cast_nullable_to_non_nullable
as int,isAvailable: null == isAvailable ? _self.isAvailable : isAvailable // ignore: cast_nullable_to_non_nullable
as bool,durationMinutes: null == durationMinutes ? _self.durationMinutes : durationMinutes // ignore: cast_nullable_to_non_nullable
as int,specialNotes: freezed == specialNotes ? _self.specialNotes : specialNotes // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
