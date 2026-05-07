// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ReservationSettings {

 String get id; String get placeId; bool get acceptsReservations; int get defaultSlotDuration; int get minPartySize; int get maxPartySize; int get maxAdvanceBookingDays; int get minAdvanceBookingHours; int get maxDurationMinutes; bool get requiresConfirmation; bool get allowCancellation; bool get allowModification; int get cancellationHours; int get modificationHours; bool get sendConfirmationEmail; bool get sendReminderEmail; int get reminderHours; List<String> get blockedTimeSlots; List<ReservationRule> get customRules; String? get welcomeMessage; String? get cancellationPolicy; String? get specialInstructions; DateTime? get createdAt; DateTime? get updatedAt; String? get createdBy; Map<String, dynamic>? get metadata;
/// Create a copy of ReservationSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationSettingsCopyWith<ReservationSettings> get copyWith => _$ReservationSettingsCopyWithImpl<ReservationSettings>(this as ReservationSettings, _$identity);

  /// Serializes this ReservationSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.acceptsReservations, acceptsReservations) || other.acceptsReservations == acceptsReservations)&&(identical(other.defaultSlotDuration, defaultSlotDuration) || other.defaultSlotDuration == defaultSlotDuration)&&(identical(other.minPartySize, minPartySize) || other.minPartySize == minPartySize)&&(identical(other.maxPartySize, maxPartySize) || other.maxPartySize == maxPartySize)&&(identical(other.maxAdvanceBookingDays, maxAdvanceBookingDays) || other.maxAdvanceBookingDays == maxAdvanceBookingDays)&&(identical(other.minAdvanceBookingHours, minAdvanceBookingHours) || other.minAdvanceBookingHours == minAdvanceBookingHours)&&(identical(other.maxDurationMinutes, maxDurationMinutes) || other.maxDurationMinutes == maxDurationMinutes)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation)&&(identical(other.allowCancellation, allowCancellation) || other.allowCancellation == allowCancellation)&&(identical(other.allowModification, allowModification) || other.allowModification == allowModification)&&(identical(other.cancellationHours, cancellationHours) || other.cancellationHours == cancellationHours)&&(identical(other.modificationHours, modificationHours) || other.modificationHours == modificationHours)&&(identical(other.sendConfirmationEmail, sendConfirmationEmail) || other.sendConfirmationEmail == sendConfirmationEmail)&&(identical(other.sendReminderEmail, sendReminderEmail) || other.sendReminderEmail == sendReminderEmail)&&(identical(other.reminderHours, reminderHours) || other.reminderHours == reminderHours)&&const DeepCollectionEquality().equals(other.blockedTimeSlots, blockedTimeSlots)&&const DeepCollectionEquality().equals(other.customRules, customRules)&&(identical(other.welcomeMessage, welcomeMessage) || other.welcomeMessage == welcomeMessage)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.specialInstructions, specialInstructions) || other.specialInstructions == specialInstructions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,placeId,acceptsReservations,defaultSlotDuration,minPartySize,maxPartySize,maxAdvanceBookingDays,minAdvanceBookingHours,maxDurationMinutes,requiresConfirmation,allowCancellation,allowModification,cancellationHours,modificationHours,sendConfirmationEmail,sendReminderEmail,reminderHours,const DeepCollectionEquality().hash(blockedTimeSlots),const DeepCollectionEquality().hash(customRules),welcomeMessage,cancellationPolicy,specialInstructions,createdAt,updatedAt,createdBy,const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'ReservationSettings(id: $id, placeId: $placeId, acceptsReservations: $acceptsReservations, defaultSlotDuration: $defaultSlotDuration, minPartySize: $minPartySize, maxPartySize: $maxPartySize, maxAdvanceBookingDays: $maxAdvanceBookingDays, minAdvanceBookingHours: $minAdvanceBookingHours, maxDurationMinutes: $maxDurationMinutes, requiresConfirmation: $requiresConfirmation, allowCancellation: $allowCancellation, allowModification: $allowModification, cancellationHours: $cancellationHours, modificationHours: $modificationHours, sendConfirmationEmail: $sendConfirmationEmail, sendReminderEmail: $sendReminderEmail, reminderHours: $reminderHours, blockedTimeSlots: $blockedTimeSlots, customRules: $customRules, welcomeMessage: $welcomeMessage, cancellationPolicy: $cancellationPolicy, specialInstructions: $specialInstructions, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ReservationSettingsCopyWith<$Res>  {
  factory $ReservationSettingsCopyWith(ReservationSettings value, $Res Function(ReservationSettings) _then) = _$ReservationSettingsCopyWithImpl;
@useResult
$Res call({
 String id, String placeId, bool acceptsReservations, int defaultSlotDuration, int minPartySize, int maxPartySize, int maxAdvanceBookingDays, int minAdvanceBookingHours, int maxDurationMinutes, bool requiresConfirmation, bool allowCancellation, bool allowModification, int cancellationHours, int modificationHours, bool sendConfirmationEmail, bool sendReminderEmail, int reminderHours, List<String> blockedTimeSlots, List<ReservationRule> customRules, String? welcomeMessage, String? cancellationPolicy, String? specialInstructions, DateTime? createdAt, DateTime? updatedAt, String? createdBy, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$ReservationSettingsCopyWithImpl<$Res>
    implements $ReservationSettingsCopyWith<$Res> {
  _$ReservationSettingsCopyWithImpl(this._self, this._then);

  final ReservationSettings _self;
  final $Res Function(ReservationSettings) _then;

/// Create a copy of ReservationSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? acceptsReservations = null,Object? defaultSlotDuration = null,Object? minPartySize = null,Object? maxPartySize = null,Object? maxAdvanceBookingDays = null,Object? minAdvanceBookingHours = null,Object? maxDurationMinutes = null,Object? requiresConfirmation = null,Object? allowCancellation = null,Object? allowModification = null,Object? cancellationHours = null,Object? modificationHours = null,Object? sendConfirmationEmail = null,Object? sendReminderEmail = null,Object? reminderHours = null,Object? blockedTimeSlots = null,Object? customRules = null,Object? welcomeMessage = freezed,Object? cancellationPolicy = freezed,Object? specialInstructions = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,acceptsReservations: null == acceptsReservations ? _self.acceptsReservations : acceptsReservations // ignore: cast_nullable_to_non_nullable
as bool,defaultSlotDuration: null == defaultSlotDuration ? _self.defaultSlotDuration : defaultSlotDuration // ignore: cast_nullable_to_non_nullable
as int,minPartySize: null == minPartySize ? _self.minPartySize : minPartySize // ignore: cast_nullable_to_non_nullable
as int,maxPartySize: null == maxPartySize ? _self.maxPartySize : maxPartySize // ignore: cast_nullable_to_non_nullable
as int,maxAdvanceBookingDays: null == maxAdvanceBookingDays ? _self.maxAdvanceBookingDays : maxAdvanceBookingDays // ignore: cast_nullable_to_non_nullable
as int,minAdvanceBookingHours: null == minAdvanceBookingHours ? _self.minAdvanceBookingHours : minAdvanceBookingHours // ignore: cast_nullable_to_non_nullable
as int,maxDurationMinutes: null == maxDurationMinutes ? _self.maxDurationMinutes : maxDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,allowCancellation: null == allowCancellation ? _self.allowCancellation : allowCancellation // ignore: cast_nullable_to_non_nullable
as bool,allowModification: null == allowModification ? _self.allowModification : allowModification // ignore: cast_nullable_to_non_nullable
as bool,cancellationHours: null == cancellationHours ? _self.cancellationHours : cancellationHours // ignore: cast_nullable_to_non_nullable
as int,modificationHours: null == modificationHours ? _self.modificationHours : modificationHours // ignore: cast_nullable_to_non_nullable
as int,sendConfirmationEmail: null == sendConfirmationEmail ? _self.sendConfirmationEmail : sendConfirmationEmail // ignore: cast_nullable_to_non_nullable
as bool,sendReminderEmail: null == sendReminderEmail ? _self.sendReminderEmail : sendReminderEmail // ignore: cast_nullable_to_non_nullable
as bool,reminderHours: null == reminderHours ? _self.reminderHours : reminderHours // ignore: cast_nullable_to_non_nullable
as int,blockedTimeSlots: null == blockedTimeSlots ? _self.blockedTimeSlots : blockedTimeSlots // ignore: cast_nullable_to_non_nullable
as List<String>,customRules: null == customRules ? _self.customRules : customRules // ignore: cast_nullable_to_non_nullable
as List<ReservationRule>,welcomeMessage: freezed == welcomeMessage ? _self.welcomeMessage : welcomeMessage // ignore: cast_nullable_to_non_nullable
as String?,cancellationPolicy: freezed == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as String?,specialInstructions: freezed == specialInstructions ? _self.specialInstructions : specialInstructions // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReservationSettings].
extension ReservationSettingsPatterns on ReservationSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationSettings value)  $default,){
final _that = this;
switch (_that) {
case _ReservationSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationSettings value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String placeId,  bool acceptsReservations,  int defaultSlotDuration,  int minPartySize,  int maxPartySize,  int maxAdvanceBookingDays,  int minAdvanceBookingHours,  int maxDurationMinutes,  bool requiresConfirmation,  bool allowCancellation,  bool allowModification,  int cancellationHours,  int modificationHours,  bool sendConfirmationEmail,  bool sendReminderEmail,  int reminderHours,  List<String> blockedTimeSlots,  List<ReservationRule> customRules,  String? welcomeMessage,  String? cancellationPolicy,  String? specialInstructions,  DateTime? createdAt,  DateTime? updatedAt,  String? createdBy,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationSettings() when $default != null:
return $default(_that.id,_that.placeId,_that.acceptsReservations,_that.defaultSlotDuration,_that.minPartySize,_that.maxPartySize,_that.maxAdvanceBookingDays,_that.minAdvanceBookingHours,_that.maxDurationMinutes,_that.requiresConfirmation,_that.allowCancellation,_that.allowModification,_that.cancellationHours,_that.modificationHours,_that.sendConfirmationEmail,_that.sendReminderEmail,_that.reminderHours,_that.blockedTimeSlots,_that.customRules,_that.welcomeMessage,_that.cancellationPolicy,_that.specialInstructions,_that.createdAt,_that.updatedAt,_that.createdBy,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String placeId,  bool acceptsReservations,  int defaultSlotDuration,  int minPartySize,  int maxPartySize,  int maxAdvanceBookingDays,  int minAdvanceBookingHours,  int maxDurationMinutes,  bool requiresConfirmation,  bool allowCancellation,  bool allowModification,  int cancellationHours,  int modificationHours,  bool sendConfirmationEmail,  bool sendReminderEmail,  int reminderHours,  List<String> blockedTimeSlots,  List<ReservationRule> customRules,  String? welcomeMessage,  String? cancellationPolicy,  String? specialInstructions,  DateTime? createdAt,  DateTime? updatedAt,  String? createdBy,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _ReservationSettings():
return $default(_that.id,_that.placeId,_that.acceptsReservations,_that.defaultSlotDuration,_that.minPartySize,_that.maxPartySize,_that.maxAdvanceBookingDays,_that.minAdvanceBookingHours,_that.maxDurationMinutes,_that.requiresConfirmation,_that.allowCancellation,_that.allowModification,_that.cancellationHours,_that.modificationHours,_that.sendConfirmationEmail,_that.sendReminderEmail,_that.reminderHours,_that.blockedTimeSlots,_that.customRules,_that.welcomeMessage,_that.cancellationPolicy,_that.specialInstructions,_that.createdAt,_that.updatedAt,_that.createdBy,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String placeId,  bool acceptsReservations,  int defaultSlotDuration,  int minPartySize,  int maxPartySize,  int maxAdvanceBookingDays,  int minAdvanceBookingHours,  int maxDurationMinutes,  bool requiresConfirmation,  bool allowCancellation,  bool allowModification,  int cancellationHours,  int modificationHours,  bool sendConfirmationEmail,  bool sendReminderEmail,  int reminderHours,  List<String> blockedTimeSlots,  List<ReservationRule> customRules,  String? welcomeMessage,  String? cancellationPolicy,  String? specialInstructions,  DateTime? createdAt,  DateTime? updatedAt,  String? createdBy,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _ReservationSettings() when $default != null:
return $default(_that.id,_that.placeId,_that.acceptsReservations,_that.defaultSlotDuration,_that.minPartySize,_that.maxPartySize,_that.maxAdvanceBookingDays,_that.minAdvanceBookingHours,_that.maxDurationMinutes,_that.requiresConfirmation,_that.allowCancellation,_that.allowModification,_that.cancellationHours,_that.modificationHours,_that.sendConfirmationEmail,_that.sendReminderEmail,_that.reminderHours,_that.blockedTimeSlots,_that.customRules,_that.welcomeMessage,_that.cancellationPolicy,_that.specialInstructions,_that.createdAt,_that.updatedAt,_that.createdBy,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReservationSettings extends ReservationSettings {
  const _ReservationSettings({required this.id, required this.placeId, this.acceptsReservations = true, this.defaultSlotDuration = 60, this.minPartySize = 1, this.maxPartySize = 20, this.maxAdvanceBookingDays = 7, this.minAdvanceBookingHours = 2, this.maxDurationMinutes = 30, this.requiresConfirmation = true, this.allowCancellation = true, this.allowModification = true, this.cancellationHours = 2, this.modificationHours = 4, this.sendConfirmationEmail = true, this.sendReminderEmail = true, this.reminderHours = 24, final  List<String> blockedTimeSlots = const [], final  List<ReservationRule> customRules = const [], this.welcomeMessage, this.cancellationPolicy, this.specialInstructions, this.createdAt, this.updatedAt, this.createdBy, final  Map<String, dynamic>? metadata}): _blockedTimeSlots = blockedTimeSlots,_customRules = customRules,_metadata = metadata,super._();
  factory _ReservationSettings.fromJson(Map<String, dynamic> json) => _$ReservationSettingsFromJson(json);

@override final  String id;
@override final  String placeId;
@override@JsonKey() final  bool acceptsReservations;
@override@JsonKey() final  int defaultSlotDuration;
@override@JsonKey() final  int minPartySize;
@override@JsonKey() final  int maxPartySize;
@override@JsonKey() final  int maxAdvanceBookingDays;
@override@JsonKey() final  int minAdvanceBookingHours;
@override@JsonKey() final  int maxDurationMinutes;
@override@JsonKey() final  bool requiresConfirmation;
@override@JsonKey() final  bool allowCancellation;
@override@JsonKey() final  bool allowModification;
@override@JsonKey() final  int cancellationHours;
@override@JsonKey() final  int modificationHours;
@override@JsonKey() final  bool sendConfirmationEmail;
@override@JsonKey() final  bool sendReminderEmail;
@override@JsonKey() final  int reminderHours;
 final  List<String> _blockedTimeSlots;
@override@JsonKey() List<String> get blockedTimeSlots {
  if (_blockedTimeSlots is EqualUnmodifiableListView) return _blockedTimeSlots;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_blockedTimeSlots);
}

 final  List<ReservationRule> _customRules;
@override@JsonKey() List<ReservationRule> get customRules {
  if (_customRules is EqualUnmodifiableListView) return _customRules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_customRules);
}

@override final  String? welcomeMessage;
@override final  String? cancellationPolicy;
@override final  String? specialInstructions;
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


/// Create a copy of ReservationSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationSettingsCopyWith<_ReservationSettings> get copyWith => __$ReservationSettingsCopyWithImpl<_ReservationSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationSettings&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.acceptsReservations, acceptsReservations) || other.acceptsReservations == acceptsReservations)&&(identical(other.defaultSlotDuration, defaultSlotDuration) || other.defaultSlotDuration == defaultSlotDuration)&&(identical(other.minPartySize, minPartySize) || other.minPartySize == minPartySize)&&(identical(other.maxPartySize, maxPartySize) || other.maxPartySize == maxPartySize)&&(identical(other.maxAdvanceBookingDays, maxAdvanceBookingDays) || other.maxAdvanceBookingDays == maxAdvanceBookingDays)&&(identical(other.minAdvanceBookingHours, minAdvanceBookingHours) || other.minAdvanceBookingHours == minAdvanceBookingHours)&&(identical(other.maxDurationMinutes, maxDurationMinutes) || other.maxDurationMinutes == maxDurationMinutes)&&(identical(other.requiresConfirmation, requiresConfirmation) || other.requiresConfirmation == requiresConfirmation)&&(identical(other.allowCancellation, allowCancellation) || other.allowCancellation == allowCancellation)&&(identical(other.allowModification, allowModification) || other.allowModification == allowModification)&&(identical(other.cancellationHours, cancellationHours) || other.cancellationHours == cancellationHours)&&(identical(other.modificationHours, modificationHours) || other.modificationHours == modificationHours)&&(identical(other.sendConfirmationEmail, sendConfirmationEmail) || other.sendConfirmationEmail == sendConfirmationEmail)&&(identical(other.sendReminderEmail, sendReminderEmail) || other.sendReminderEmail == sendReminderEmail)&&(identical(other.reminderHours, reminderHours) || other.reminderHours == reminderHours)&&const DeepCollectionEquality().equals(other._blockedTimeSlots, _blockedTimeSlots)&&const DeepCollectionEquality().equals(other._customRules, _customRules)&&(identical(other.welcomeMessage, welcomeMessage) || other.welcomeMessage == welcomeMessage)&&(identical(other.cancellationPolicy, cancellationPolicy) || other.cancellationPolicy == cancellationPolicy)&&(identical(other.specialInstructions, specialInstructions) || other.specialInstructions == specialInstructions)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,placeId,acceptsReservations,defaultSlotDuration,minPartySize,maxPartySize,maxAdvanceBookingDays,minAdvanceBookingHours,maxDurationMinutes,requiresConfirmation,allowCancellation,allowModification,cancellationHours,modificationHours,sendConfirmationEmail,sendReminderEmail,reminderHours,const DeepCollectionEquality().hash(_blockedTimeSlots),const DeepCollectionEquality().hash(_customRules),welcomeMessage,cancellationPolicy,specialInstructions,createdAt,updatedAt,createdBy,const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'ReservationSettings(id: $id, placeId: $placeId, acceptsReservations: $acceptsReservations, defaultSlotDuration: $defaultSlotDuration, minPartySize: $minPartySize, maxPartySize: $maxPartySize, maxAdvanceBookingDays: $maxAdvanceBookingDays, minAdvanceBookingHours: $minAdvanceBookingHours, maxDurationMinutes: $maxDurationMinutes, requiresConfirmation: $requiresConfirmation, allowCancellation: $allowCancellation, allowModification: $allowModification, cancellationHours: $cancellationHours, modificationHours: $modificationHours, sendConfirmationEmail: $sendConfirmationEmail, sendReminderEmail: $sendReminderEmail, reminderHours: $reminderHours, blockedTimeSlots: $blockedTimeSlots, customRules: $customRules, welcomeMessage: $welcomeMessage, cancellationPolicy: $cancellationPolicy, specialInstructions: $specialInstructions, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ReservationSettingsCopyWith<$Res> implements $ReservationSettingsCopyWith<$Res> {
  factory _$ReservationSettingsCopyWith(_ReservationSettings value, $Res Function(_ReservationSettings) _then) = __$ReservationSettingsCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeId, bool acceptsReservations, int defaultSlotDuration, int minPartySize, int maxPartySize, int maxAdvanceBookingDays, int minAdvanceBookingHours, int maxDurationMinutes, bool requiresConfirmation, bool allowCancellation, bool allowModification, int cancellationHours, int modificationHours, bool sendConfirmationEmail, bool sendReminderEmail, int reminderHours, List<String> blockedTimeSlots, List<ReservationRule> customRules, String? welcomeMessage, String? cancellationPolicy, String? specialInstructions, DateTime? createdAt, DateTime? updatedAt, String? createdBy, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$ReservationSettingsCopyWithImpl<$Res>
    implements _$ReservationSettingsCopyWith<$Res> {
  __$ReservationSettingsCopyWithImpl(this._self, this._then);

  final _ReservationSettings _self;
  final $Res Function(_ReservationSettings) _then;

/// Create a copy of ReservationSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? acceptsReservations = null,Object? defaultSlotDuration = null,Object? minPartySize = null,Object? maxPartySize = null,Object? maxAdvanceBookingDays = null,Object? minAdvanceBookingHours = null,Object? maxDurationMinutes = null,Object? requiresConfirmation = null,Object? allowCancellation = null,Object? allowModification = null,Object? cancellationHours = null,Object? modificationHours = null,Object? sendConfirmationEmail = null,Object? sendReminderEmail = null,Object? reminderHours = null,Object? blockedTimeSlots = null,Object? customRules = null,Object? welcomeMessage = freezed,Object? cancellationPolicy = freezed,Object? specialInstructions = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_ReservationSettings(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,acceptsReservations: null == acceptsReservations ? _self.acceptsReservations : acceptsReservations // ignore: cast_nullable_to_non_nullable
as bool,defaultSlotDuration: null == defaultSlotDuration ? _self.defaultSlotDuration : defaultSlotDuration // ignore: cast_nullable_to_non_nullable
as int,minPartySize: null == minPartySize ? _self.minPartySize : minPartySize // ignore: cast_nullable_to_non_nullable
as int,maxPartySize: null == maxPartySize ? _self.maxPartySize : maxPartySize // ignore: cast_nullable_to_non_nullable
as int,maxAdvanceBookingDays: null == maxAdvanceBookingDays ? _self.maxAdvanceBookingDays : maxAdvanceBookingDays // ignore: cast_nullable_to_non_nullable
as int,minAdvanceBookingHours: null == minAdvanceBookingHours ? _self.minAdvanceBookingHours : minAdvanceBookingHours // ignore: cast_nullable_to_non_nullable
as int,maxDurationMinutes: null == maxDurationMinutes ? _self.maxDurationMinutes : maxDurationMinutes // ignore: cast_nullable_to_non_nullable
as int,requiresConfirmation: null == requiresConfirmation ? _self.requiresConfirmation : requiresConfirmation // ignore: cast_nullable_to_non_nullable
as bool,allowCancellation: null == allowCancellation ? _self.allowCancellation : allowCancellation // ignore: cast_nullable_to_non_nullable
as bool,allowModification: null == allowModification ? _self.allowModification : allowModification // ignore: cast_nullable_to_non_nullable
as bool,cancellationHours: null == cancellationHours ? _self.cancellationHours : cancellationHours // ignore: cast_nullable_to_non_nullable
as int,modificationHours: null == modificationHours ? _self.modificationHours : modificationHours // ignore: cast_nullable_to_non_nullable
as int,sendConfirmationEmail: null == sendConfirmationEmail ? _self.sendConfirmationEmail : sendConfirmationEmail // ignore: cast_nullable_to_non_nullable
as bool,sendReminderEmail: null == sendReminderEmail ? _self.sendReminderEmail : sendReminderEmail // ignore: cast_nullable_to_non_nullable
as bool,reminderHours: null == reminderHours ? _self.reminderHours : reminderHours // ignore: cast_nullable_to_non_nullable
as int,blockedTimeSlots: null == blockedTimeSlots ? _self._blockedTimeSlots : blockedTimeSlots // ignore: cast_nullable_to_non_nullable
as List<String>,customRules: null == customRules ? _self._customRules : customRules // ignore: cast_nullable_to_non_nullable
as List<ReservationRule>,welcomeMessage: freezed == welcomeMessage ? _self.welcomeMessage : welcomeMessage // ignore: cast_nullable_to_non_nullable
as String?,cancellationPolicy: freezed == cancellationPolicy ? _self.cancellationPolicy : cancellationPolicy // ignore: cast_nullable_to_non_nullable
as String?,specialInstructions: freezed == specialInstructions ? _self.specialInstructions : specialInstructions // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ReservationRule {

 String get id; String get name; String get description; RuleType get type; Map<String, dynamic> get conditions; bool get isActive; String? get errorMessage;
/// Create a copy of ReservationRule
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationRuleCopyWith<ReservationRule> get copyWith => _$ReservationRuleCopyWithImpl<ReservationRule>(this as ReservationRule, _$identity);

  /// Serializes this ReservationRule to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReservationRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other.conditions, conditions)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,const DeepCollectionEquality().hash(conditions),isActive,errorMessage);

@override
String toString() {
  return 'ReservationRule(id: $id, name: $name, description: $description, type: $type, conditions: $conditions, isActive: $isActive, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $ReservationRuleCopyWith<$Res>  {
  factory $ReservationRuleCopyWith(ReservationRule value, $Res Function(ReservationRule) _then) = _$ReservationRuleCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, RuleType type, Map<String, dynamic> conditions, bool isActive, String? errorMessage
});




}
/// @nodoc
class _$ReservationRuleCopyWithImpl<$Res>
    implements $ReservationRuleCopyWith<$Res> {
  _$ReservationRuleCopyWithImpl(this._self, this._then);

  final ReservationRule _self;
  final $Res Function(ReservationRule) _then;

/// Create a copy of ReservationRule
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? conditions = null,Object? isActive = null,Object? errorMessage = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RuleType,conditions: null == conditions ? _self.conditions : conditions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ReservationRule].
extension ReservationRulePatterns on ReservationRule {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReservationRule value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReservationRule() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReservationRule value)  $default,){
final _that = this;
switch (_that) {
case _ReservationRule():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReservationRule value)?  $default,){
final _that = this;
switch (_that) {
case _ReservationRule() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  RuleType type,  Map<String, dynamic> conditions,  bool isActive,  String? errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReservationRule() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.conditions,_that.isActive,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  RuleType type,  Map<String, dynamic> conditions,  bool isActive,  String? errorMessage)  $default,) {final _that = this;
switch (_that) {
case _ReservationRule():
return $default(_that.id,_that.name,_that.description,_that.type,_that.conditions,_that.isActive,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  RuleType type,  Map<String, dynamic> conditions,  bool isActive,  String? errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _ReservationRule() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.type,_that.conditions,_that.isActive,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ReservationRule extends ReservationRule {
  const _ReservationRule({required this.id, required this.name, required this.description, required this.type, required final  Map<String, dynamic> conditions, this.isActive = true, this.errorMessage}): _conditions = conditions,super._();
  factory _ReservationRule.fromJson(Map<String, dynamic> json) => _$ReservationRuleFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  RuleType type;
 final  Map<String, dynamic> _conditions;
@override Map<String, dynamic> get conditions {
  if (_conditions is EqualUnmodifiableMapView) return _conditions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_conditions);
}

@override@JsonKey() final  bool isActive;
@override final  String? errorMessage;

/// Create a copy of ReservationRule
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationRuleCopyWith<_ReservationRule> get copyWith => __$ReservationRuleCopyWithImpl<_ReservationRule>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationRuleToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReservationRule&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.type, type) || other.type == type)&&const DeepCollectionEquality().equals(other._conditions, _conditions)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,type,const DeepCollectionEquality().hash(_conditions),isActive,errorMessage);

@override
String toString() {
  return 'ReservationRule(id: $id, name: $name, description: $description, type: $type, conditions: $conditions, isActive: $isActive, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$ReservationRuleCopyWith<$Res> implements $ReservationRuleCopyWith<$Res> {
  factory _$ReservationRuleCopyWith(_ReservationRule value, $Res Function(_ReservationRule) _then) = __$ReservationRuleCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, RuleType type, Map<String, dynamic> conditions, bool isActive, String? errorMessage
});




}
/// @nodoc
class __$ReservationRuleCopyWithImpl<$Res>
    implements _$ReservationRuleCopyWith<$Res> {
  __$ReservationRuleCopyWithImpl(this._self, this._then);

  final _ReservationRule _self;
  final $Res Function(_ReservationRule) _then;

/// Create a copy of ReservationRule
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? type = null,Object? conditions = null,Object? isActive = null,Object? errorMessage = freezed,}) {
  return _then(_ReservationRule(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as RuleType,conditions: null == conditions ? _self._conditions : conditions // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
