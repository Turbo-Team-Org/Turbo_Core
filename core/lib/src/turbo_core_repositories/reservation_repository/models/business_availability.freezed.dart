// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_availability.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessAvailability {

 String get id; String get placeId; List<WeeklySchedule> get weeklySchedule; List<SpecialDay> get specialDays; List<BlackoutDate> get blackoutDates; bool get acceptsReservations; int get defaultSlotDuration; int get maxPartySizeDefault; int get maxAdvanceBookingDays; int get minAdvanceBookingHours; DateTime? get createdAt; DateTime? get updatedAt; String? get createdBy; Map<String, dynamic>? get metadata;
/// Create a copy of BusinessAvailability
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessAvailabilityCopyWith<BusinessAvailability> get copyWith => _$BusinessAvailabilityCopyWithImpl<BusinessAvailability>(this as BusinessAvailability, _$identity);

  /// Serializes this BusinessAvailability to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessAvailability&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&const DeepCollectionEquality().equals(other.weeklySchedule, weeklySchedule)&&const DeepCollectionEquality().equals(other.specialDays, specialDays)&&const DeepCollectionEquality().equals(other.blackoutDates, blackoutDates)&&(identical(other.acceptsReservations, acceptsReservations) || other.acceptsReservations == acceptsReservations)&&(identical(other.defaultSlotDuration, defaultSlotDuration) || other.defaultSlotDuration == defaultSlotDuration)&&(identical(other.maxPartySizeDefault, maxPartySizeDefault) || other.maxPartySizeDefault == maxPartySizeDefault)&&(identical(other.maxAdvanceBookingDays, maxAdvanceBookingDays) || other.maxAdvanceBookingDays == maxAdvanceBookingDays)&&(identical(other.minAdvanceBookingHours, minAdvanceBookingHours) || other.minAdvanceBookingHours == minAdvanceBookingHours)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,const DeepCollectionEquality().hash(weeklySchedule),const DeepCollectionEquality().hash(specialDays),const DeepCollectionEquality().hash(blackoutDates),acceptsReservations,defaultSlotDuration,maxPartySizeDefault,maxAdvanceBookingDays,minAdvanceBookingHours,createdAt,updatedAt,createdBy,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'BusinessAvailability(id: $id, placeId: $placeId, weeklySchedule: $weeklySchedule, specialDays: $specialDays, blackoutDates: $blackoutDates, acceptsReservations: $acceptsReservations, defaultSlotDuration: $defaultSlotDuration, maxPartySizeDefault: $maxPartySizeDefault, maxAdvanceBookingDays: $maxAdvanceBookingDays, minAdvanceBookingHours: $minAdvanceBookingHours, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $BusinessAvailabilityCopyWith<$Res>  {
  factory $BusinessAvailabilityCopyWith(BusinessAvailability value, $Res Function(BusinessAvailability) _then) = _$BusinessAvailabilityCopyWithImpl;
@useResult
$Res call({
 String id, String placeId, List<WeeklySchedule> weeklySchedule, List<SpecialDay> specialDays, List<BlackoutDate> blackoutDates, bool acceptsReservations, int defaultSlotDuration, int maxPartySizeDefault, int maxAdvanceBookingDays, int minAdvanceBookingHours, DateTime? createdAt, DateTime? updatedAt, String? createdBy, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$BusinessAvailabilityCopyWithImpl<$Res>
    implements $BusinessAvailabilityCopyWith<$Res> {
  _$BusinessAvailabilityCopyWithImpl(this._self, this._then);

  final BusinessAvailability _self;
  final $Res Function(BusinessAvailability) _then;

/// Create a copy of BusinessAvailability
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? weeklySchedule = null,Object? specialDays = null,Object? blackoutDates = null,Object? acceptsReservations = null,Object? defaultSlotDuration = null,Object? maxPartySizeDefault = null,Object? maxAdvanceBookingDays = null,Object? minAdvanceBookingHours = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,weeklySchedule: null == weeklySchedule ? _self.weeklySchedule : weeklySchedule // ignore: cast_nullable_to_non_nullable
as List<WeeklySchedule>,specialDays: null == specialDays ? _self.specialDays : specialDays // ignore: cast_nullable_to_non_nullable
as List<SpecialDay>,blackoutDates: null == blackoutDates ? _self.blackoutDates : blackoutDates // ignore: cast_nullable_to_non_nullable
as List<BlackoutDate>,acceptsReservations: null == acceptsReservations ? _self.acceptsReservations : acceptsReservations // ignore: cast_nullable_to_non_nullable
as bool,defaultSlotDuration: null == defaultSlotDuration ? _self.defaultSlotDuration : defaultSlotDuration // ignore: cast_nullable_to_non_nullable
as int,maxPartySizeDefault: null == maxPartySizeDefault ? _self.maxPartySizeDefault : maxPartySizeDefault // ignore: cast_nullable_to_non_nullable
as int,maxAdvanceBookingDays: null == maxAdvanceBookingDays ? _self.maxAdvanceBookingDays : maxAdvanceBookingDays // ignore: cast_nullable_to_non_nullable
as int,minAdvanceBookingHours: null == minAdvanceBookingHours ? _self.minAdvanceBookingHours : minAdvanceBookingHours // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BusinessAvailability extends BusinessAvailability {
  const _BusinessAvailability({required this.id, required this.placeId, required final  List<WeeklySchedule> weeklySchedule, final  List<SpecialDay> specialDays = const [], final  List<BlackoutDate> blackoutDates = const [], this.acceptsReservations = true, this.defaultSlotDuration = 60, this.maxPartySizeDefault = 1, this.maxAdvanceBookingDays = 4, this.minAdvanceBookingHours = 2, this.createdAt, this.updatedAt, this.createdBy, final  Map<String, dynamic>? metadata}): _weeklySchedule = weeklySchedule,_specialDays = specialDays,_blackoutDates = blackoutDates,_metadata = metadata,super._();
  factory _BusinessAvailability.fromJson(Map<String, dynamic> json) => _$BusinessAvailabilityFromJson(json);

@override final  String id;
@override final  String placeId;
 final  List<WeeklySchedule> _weeklySchedule;
@override List<WeeklySchedule> get weeklySchedule {
  if (_weeklySchedule is EqualUnmodifiableListView) return _weeklySchedule;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_weeklySchedule);
}

 final  List<SpecialDay> _specialDays;
@override@JsonKey() List<SpecialDay> get specialDays {
  if (_specialDays is EqualUnmodifiableListView) return _specialDays;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specialDays);
}

 final  List<BlackoutDate> _blackoutDates;
@override@JsonKey() List<BlackoutDate> get blackoutDates {
  if (_blackoutDates is EqualUnmodifiableListView) return _blackoutDates;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blackoutDates);
}

@override@JsonKey() final  bool acceptsReservations;
@override@JsonKey() final  int defaultSlotDuration;
@override@JsonKey() final  int maxPartySizeDefault;
@override@JsonKey() final  int maxAdvanceBookingDays;
@override@JsonKey() final  int minAdvanceBookingHours;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  String? createdBy;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of BusinessAvailability
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessAvailabilityCopyWith<_BusinessAvailability> get copyWith => __$BusinessAvailabilityCopyWithImpl<_BusinessAvailability>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessAvailabilityToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessAvailability&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&const DeepCollectionEquality().equals(other._weeklySchedule, _weeklySchedule)&&const DeepCollectionEquality().equals(other._specialDays, _specialDays)&&const DeepCollectionEquality().equals(other._blackoutDates, _blackoutDates)&&(identical(other.acceptsReservations, acceptsReservations) || other.acceptsReservations == acceptsReservations)&&(identical(other.defaultSlotDuration, defaultSlotDuration) || other.defaultSlotDuration == defaultSlotDuration)&&(identical(other.maxPartySizeDefault, maxPartySizeDefault) || other.maxPartySizeDefault == maxPartySizeDefault)&&(identical(other.maxAdvanceBookingDays, maxAdvanceBookingDays) || other.maxAdvanceBookingDays == maxAdvanceBookingDays)&&(identical(other.minAdvanceBookingHours, minAdvanceBookingHours) || other.minAdvanceBookingHours == minAdvanceBookingHours)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,const DeepCollectionEquality().hash(_weeklySchedule),const DeepCollectionEquality().hash(_specialDays),const DeepCollectionEquality().hash(_blackoutDates),acceptsReservations,defaultSlotDuration,maxPartySizeDefault,maxAdvanceBookingDays,minAdvanceBookingHours,createdAt,updatedAt,createdBy,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'BusinessAvailability(id: $id, placeId: $placeId, weeklySchedule: $weeklySchedule, specialDays: $specialDays, blackoutDates: $blackoutDates, acceptsReservations: $acceptsReservations, defaultSlotDuration: $defaultSlotDuration, maxPartySizeDefault: $maxPartySizeDefault, maxAdvanceBookingDays: $maxAdvanceBookingDays, minAdvanceBookingHours: $minAdvanceBookingHours, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$BusinessAvailabilityCopyWith<$Res> implements $BusinessAvailabilityCopyWith<$Res> {
  factory _$BusinessAvailabilityCopyWith(_BusinessAvailability value, $Res Function(_BusinessAvailability) _then) = __$BusinessAvailabilityCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeId, List<WeeklySchedule> weeklySchedule, List<SpecialDay> specialDays, List<BlackoutDate> blackoutDates, bool acceptsReservations, int defaultSlotDuration, int maxPartySizeDefault, int maxAdvanceBookingDays, int minAdvanceBookingHours, DateTime? createdAt, DateTime? updatedAt, String? createdBy, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$BusinessAvailabilityCopyWithImpl<$Res>
    implements _$BusinessAvailabilityCopyWith<$Res> {
  __$BusinessAvailabilityCopyWithImpl(this._self, this._then);

  final _BusinessAvailability _self;
  final $Res Function(_BusinessAvailability) _then;

/// Create a copy of BusinessAvailability
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? weeklySchedule = null,Object? specialDays = null,Object? blackoutDates = null,Object? acceptsReservations = null,Object? defaultSlotDuration = null,Object? maxPartySizeDefault = null,Object? maxAdvanceBookingDays = null,Object? minAdvanceBookingHours = null,Object? createdAt = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_BusinessAvailability(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,weeklySchedule: null == weeklySchedule ? _self._weeklySchedule : weeklySchedule // ignore: cast_nullable_to_non_nullable
as List<WeeklySchedule>,specialDays: null == specialDays ? _self._specialDays : specialDays // ignore: cast_nullable_to_non_nullable
as List<SpecialDay>,blackoutDates: null == blackoutDates ? _self._blackoutDates : blackoutDates // ignore: cast_nullable_to_non_nullable
as List<BlackoutDate>,acceptsReservations: null == acceptsReservations ? _self.acceptsReservations : acceptsReservations // ignore: cast_nullable_to_non_nullable
as bool,defaultSlotDuration: null == defaultSlotDuration ? _self.defaultSlotDuration : defaultSlotDuration // ignore: cast_nullable_to_non_nullable
as int,maxPartySizeDefault: null == maxPartySizeDefault ? _self.maxPartySizeDefault : maxPartySizeDefault // ignore: cast_nullable_to_non_nullable
as int,maxAdvanceBookingDays: null == maxAdvanceBookingDays ? _self.maxAdvanceBookingDays : maxAdvanceBookingDays // ignore: cast_nullable_to_non_nullable
as int,minAdvanceBookingHours: null == minAdvanceBookingHours ? _self.minAdvanceBookingHours : minAdvanceBookingHours // ignore: cast_nullable_to_non_nullable
as int,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$WeeklySchedule {

 int get dayOfWeek;// 1 = Monday, 7 = Sunday
 bool get isOpen; List<TimeRange> get timeRanges; String? get notes;
/// Create a copy of WeeklySchedule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WeeklyScheduleCopyWith<WeeklySchedule> get copyWith => _$WeeklyScheduleCopyWithImpl<WeeklySchedule>(this as WeeklySchedule, _$identity);

  /// Serializes this WeeklySchedule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WeeklySchedule&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.timeRanges, timeRanges)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,isOpen,const DeepCollectionEquality().hash(timeRanges),notes);

@override
String toString() {
  return 'WeeklySchedule(dayOfWeek: $dayOfWeek, isOpen: $isOpen, timeRanges: $timeRanges, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $WeeklyScheduleCopyWith<$Res>  {
  factory $WeeklyScheduleCopyWith(WeeklySchedule value, $Res Function(WeeklySchedule) _then) = _$WeeklyScheduleCopyWithImpl;
@useResult
$Res call({
 int dayOfWeek, bool isOpen, List<TimeRange> timeRanges, String? notes
});




}
/// @nodoc
class _$WeeklyScheduleCopyWithImpl<$Res>
    implements $WeeklyScheduleCopyWith<$Res> {
  _$WeeklyScheduleCopyWithImpl(this._self, this._then);

  final WeeklySchedule _self;
  final $Res Function(WeeklySchedule) _then;

/// Create a copy of WeeklySchedule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? dayOfWeek = null,Object? isOpen = null,Object? timeRanges = null,Object? notes = freezed,}) {
  return _then(_self.copyWith(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,timeRanges: null == timeRanges ? _self.timeRanges : timeRanges // ignore: cast_nullable_to_non_nullable
as List<TimeRange>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _WeeklySchedule extends WeeklySchedule {
  const _WeeklySchedule({required this.dayOfWeek, required this.isOpen, final  List<TimeRange> timeRanges = const [], this.notes}): _timeRanges = timeRanges,super._();
  factory _WeeklySchedule.fromJson(Map<String, dynamic> json) => _$WeeklyScheduleFromJson(json);

@override final  int dayOfWeek;
// 1 = Monday, 7 = Sunday
@override final  bool isOpen;
 final  List<TimeRange> _timeRanges;
@override@JsonKey() List<TimeRange> get timeRanges {
  if (_timeRanges is EqualUnmodifiableListView) return _timeRanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeRanges);
}

@override final  String? notes;

/// Create a copy of WeeklySchedule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WeeklyScheduleCopyWith<_WeeklySchedule> get copyWith => __$WeeklyScheduleCopyWithImpl<_WeeklySchedule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WeeklyScheduleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WeeklySchedule&&(identical(other.dayOfWeek, dayOfWeek) || other.dayOfWeek == dayOfWeek)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._timeRanges, _timeRanges)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,dayOfWeek,isOpen,const DeepCollectionEquality().hash(_timeRanges),notes);

@override
String toString() {
  return 'WeeklySchedule(dayOfWeek: $dayOfWeek, isOpen: $isOpen, timeRanges: $timeRanges, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$WeeklyScheduleCopyWith<$Res> implements $WeeklyScheduleCopyWith<$Res> {
  factory _$WeeklyScheduleCopyWith(_WeeklySchedule value, $Res Function(_WeeklySchedule) _then) = __$WeeklyScheduleCopyWithImpl;
@override @useResult
$Res call({
 int dayOfWeek, bool isOpen, List<TimeRange> timeRanges, String? notes
});




}
/// @nodoc
class __$WeeklyScheduleCopyWithImpl<$Res>
    implements _$WeeklyScheduleCopyWith<$Res> {
  __$WeeklyScheduleCopyWithImpl(this._self, this._then);

  final _WeeklySchedule _self;
  final $Res Function(_WeeklySchedule) _then;

/// Create a copy of WeeklySchedule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? dayOfWeek = null,Object? isOpen = null,Object? timeRanges = null,Object? notes = freezed,}) {
  return _then(_WeeklySchedule(
dayOfWeek: null == dayOfWeek ? _self.dayOfWeek : dayOfWeek // ignore: cast_nullable_to_non_nullable
as int,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,timeRanges: null == timeRanges ? _self._timeRanges : timeRanges // ignore: cast_nullable_to_non_nullable
as List<TimeRange>,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SpecialDay {

 DateTime get date; bool get isOpen; List<TimeRange> get timeRanges; String? get name; String? get description;
/// Create a copy of SpecialDay
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SpecialDayCopyWith<SpecialDay> get copyWith => _$SpecialDayCopyWithImpl<SpecialDay>(this as SpecialDay, _$identity);

  /// Serializes this SpecialDay to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SpecialDay&&(identical(other.date, date) || other.date == date)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.timeRanges, timeRanges)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,isOpen,const DeepCollectionEquality().hash(timeRanges),name,description);

@override
String toString() {
  return 'SpecialDay(date: $date, isOpen: $isOpen, timeRanges: $timeRanges, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class $SpecialDayCopyWith<$Res>  {
  factory $SpecialDayCopyWith(SpecialDay value, $Res Function(SpecialDay) _then) = _$SpecialDayCopyWithImpl;
@useResult
$Res call({
 DateTime date, bool isOpen, List<TimeRange> timeRanges, String? name, String? description
});




}
/// @nodoc
class _$SpecialDayCopyWithImpl<$Res>
    implements $SpecialDayCopyWith<$Res> {
  _$SpecialDayCopyWithImpl(this._self, this._then);

  final SpecialDay _self;
  final $Res Function(SpecialDay) _then;

/// Create a copy of SpecialDay
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? isOpen = null,Object? timeRanges = null,Object? name = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,timeRanges: null == timeRanges ? _self.timeRanges : timeRanges // ignore: cast_nullable_to_non_nullable
as List<TimeRange>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SpecialDay extends SpecialDay {
  const _SpecialDay({required this.date, required this.isOpen, final  List<TimeRange> timeRanges = const [], this.name, this.description}): _timeRanges = timeRanges,super._();
  factory _SpecialDay.fromJson(Map<String, dynamic> json) => _$SpecialDayFromJson(json);

@override final  DateTime date;
@override final  bool isOpen;
 final  List<TimeRange> _timeRanges;
@override@JsonKey() List<TimeRange> get timeRanges {
  if (_timeRanges is EqualUnmodifiableListView) return _timeRanges;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_timeRanges);
}

@override final  String? name;
@override final  String? description;

/// Create a copy of SpecialDay
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SpecialDayCopyWith<_SpecialDay> get copyWith => __$SpecialDayCopyWithImpl<_SpecialDay>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SpecialDayToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SpecialDay&&(identical(other.date, date) || other.date == date)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._timeRanges, _timeRanges)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,isOpen,const DeepCollectionEquality().hash(_timeRanges),name,description);

@override
String toString() {
  return 'SpecialDay(date: $date, isOpen: $isOpen, timeRanges: $timeRanges, name: $name, description: $description)';
}


}

/// @nodoc
abstract mixin class _$SpecialDayCopyWith<$Res> implements $SpecialDayCopyWith<$Res> {
  factory _$SpecialDayCopyWith(_SpecialDay value, $Res Function(_SpecialDay) _then) = __$SpecialDayCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, bool isOpen, List<TimeRange> timeRanges, String? name, String? description
});




}
/// @nodoc
class __$SpecialDayCopyWithImpl<$Res>
    implements _$SpecialDayCopyWith<$Res> {
  __$SpecialDayCopyWithImpl(this._self, this._then);

  final _SpecialDay _self;
  final $Res Function(_SpecialDay) _then;

/// Create a copy of SpecialDay
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? isOpen = null,Object? timeRanges = null,Object? name = freezed,Object? description = freezed,}) {
  return _then(_SpecialDay(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,timeRanges: null == timeRanges ? _self._timeRanges : timeRanges // ignore: cast_nullable_to_non_nullable
as List<TimeRange>,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$BlackoutDate {

 DateTime get startDate; DateTime get endDate; String? get reason; String? get description;
/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BlackoutDateCopyWith<BlackoutDate> get copyWith => _$BlackoutDateCopyWithImpl<BlackoutDate>(this as BlackoutDate, _$identity);

  /// Serializes this BlackoutDate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BlackoutDate&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,reason,description);

@override
String toString() {
  return 'BlackoutDate(startDate: $startDate, endDate: $endDate, reason: $reason, description: $description)';
}


}

/// @nodoc
abstract mixin class $BlackoutDateCopyWith<$Res>  {
  factory $BlackoutDateCopyWith(BlackoutDate value, $Res Function(BlackoutDate) _then) = _$BlackoutDateCopyWithImpl;
@useResult
$Res call({
 DateTime startDate, DateTime endDate, String? reason, String? description
});




}
/// @nodoc
class _$BlackoutDateCopyWithImpl<$Res>
    implements $BlackoutDateCopyWith<$Res> {
  _$BlackoutDateCopyWithImpl(this._self, this._then);

  final BlackoutDate _self;
  final $Res Function(BlackoutDate) _then;

/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startDate = null,Object? endDate = null,Object? reason = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _BlackoutDate extends BlackoutDate {
  const _BlackoutDate({required this.startDate, required this.endDate, this.reason, this.description}): super._();
  factory _BlackoutDate.fromJson(Map<String, dynamic> json) => _$BlackoutDateFromJson(json);

@override final  DateTime startDate;
@override final  DateTime endDate;
@override final  String? reason;
@override final  String? description;

/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BlackoutDateCopyWith<_BlackoutDate> get copyWith => __$BlackoutDateCopyWithImpl<_BlackoutDate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BlackoutDateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BlackoutDate&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.reason, reason) || other.reason == reason)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startDate,endDate,reason,description);

@override
String toString() {
  return 'BlackoutDate(startDate: $startDate, endDate: $endDate, reason: $reason, description: $description)';
}


}

/// @nodoc
abstract mixin class _$BlackoutDateCopyWith<$Res> implements $BlackoutDateCopyWith<$Res> {
  factory _$BlackoutDateCopyWith(_BlackoutDate value, $Res Function(_BlackoutDate) _then) = __$BlackoutDateCopyWithImpl;
@override @useResult
$Res call({
 DateTime startDate, DateTime endDate, String? reason, String? description
});




}
/// @nodoc
class __$BlackoutDateCopyWithImpl<$Res>
    implements _$BlackoutDateCopyWith<$Res> {
  __$BlackoutDateCopyWithImpl(this._self, this._then);

  final _BlackoutDate _self;
  final $Res Function(_BlackoutDate) _then;

/// Create a copy of BlackoutDate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startDate = null,Object? endDate = null,Object? reason = freezed,Object? description = freezed,}) {
  return _then(_BlackoutDate(
startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: null == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime,reason: freezed == reason ? _self.reason : reason // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$TimeRange {

 String get startTime;// "09:00"
 String get endTime;// "17:00"
 int get maxCapacity;
/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TimeRangeCopyWith<TimeRange> get copyWith => _$TimeRangeCopyWithImpl<TimeRange>(this as TimeRange, _$identity);

  /// Serializes this TimeRange to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TimeRange&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,maxCapacity);

@override
String toString() {
  return 'TimeRange(startTime: $startTime, endTime: $endTime, maxCapacity: $maxCapacity)';
}


}

/// @nodoc
abstract mixin class $TimeRangeCopyWith<$Res>  {
  factory $TimeRangeCopyWith(TimeRange value, $Res Function(TimeRange) _then) = _$TimeRangeCopyWithImpl;
@useResult
$Res call({
 String startTime, String endTime, int maxCapacity
});




}
/// @nodoc
class _$TimeRangeCopyWithImpl<$Res>
    implements $TimeRangeCopyWith<$Res> {
  _$TimeRangeCopyWithImpl(this._self, this._then);

  final TimeRange _self;
  final $Res Function(TimeRange) _then;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? startTime = null,Object? endTime = null,Object? maxCapacity = null,}) {
  return _then(_self.copyWith(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _TimeRange extends TimeRange {
  const _TimeRange({required this.startTime, required this.endTime, this.maxCapacity = 1}): super._();
  factory _TimeRange.fromJson(Map<String, dynamic> json) => _$TimeRangeFromJson(json);

@override final  String startTime;
// "09:00"
@override final  String endTime;
// "17:00"
@override@JsonKey() final  int maxCapacity;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TimeRangeCopyWith<_TimeRange> get copyWith => __$TimeRangeCopyWithImpl<_TimeRange>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TimeRangeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TimeRange&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.maxCapacity, maxCapacity) || other.maxCapacity == maxCapacity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,startTime,endTime,maxCapacity);

@override
String toString() {
  return 'TimeRange(startTime: $startTime, endTime: $endTime, maxCapacity: $maxCapacity)';
}


}

/// @nodoc
abstract mixin class _$TimeRangeCopyWith<$Res> implements $TimeRangeCopyWith<$Res> {
  factory _$TimeRangeCopyWith(_TimeRange value, $Res Function(_TimeRange) _then) = __$TimeRangeCopyWithImpl;
@override @useResult
$Res call({
 String startTime, String endTime, int maxCapacity
});




}
/// @nodoc
class __$TimeRangeCopyWithImpl<$Res>
    implements _$TimeRangeCopyWith<$Res> {
  __$TimeRangeCopyWithImpl(this._self, this._then);

  final _TimeRange _self;
  final $Res Function(_TimeRange) _then;

/// Create a copy of TimeRange
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? startTime = null,Object? endTime = null,Object? maxCapacity = null,}) {
  return _then(_TimeRange(
startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as String,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as String,maxCapacity: null == maxCapacity ? _self.maxCapacity : maxCapacity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
