// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reservation.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Reservation {

 String get id; String get placeId; String get userId; DateTime get reservationDate; DateTime get startTime; DateTime get endTime; int get partySize; ReservationStatus get status; String get customerName; String get customerEmail; String get customerPhone; String? get placeName; String? get specialRequests; String? get notes; String? get tableNumber; String? get confirmationCode; DateTime? get createdAt; DateTime? get updatedAt; DateTime? get confirmedAt; DateTime? get checkedInAt; DateTime? get cancelledAt; String? get cancelReason; String? get adminNotes; bool? get reminderSent; Map<String, dynamic> get customerInfo; Map<String, dynamic> get metadata;
/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReservationCopyWith<Reservation> get copyWith => _$ReservationCopyWithImpl<Reservation>(this as Reservation, _$identity);

  /// Serializes this Reservation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Reservation&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.reservationDate, reservationDate) || other.reservationDate == reservationDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.status, status) || other.status == status)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.specialRequests, specialRequests) || other.specialRequests == specialRequests)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.tableNumber, tableNumber) || other.tableNumber == tableNumber)&&(identical(other.confirmationCode, confirmationCode) || other.confirmationCode == confirmationCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.checkedInAt, checkedInAt) || other.checkedInAt == checkedInAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.reminderSent, reminderSent) || other.reminderSent == reminderSent)&&const DeepCollectionEquality().equals(other.customerInfo, customerInfo)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,placeId,userId,reservationDate,startTime,endTime,partySize,status,customerName,customerEmail,customerPhone,placeName,specialRequests,notes,tableNumber,confirmationCode,createdAt,updatedAt,confirmedAt,checkedInAt,cancelledAt,cancelReason,adminNotes,reminderSent,const DeepCollectionEquality().hash(customerInfo),const DeepCollectionEquality().hash(metadata)]);

@override
String toString() {
  return 'Reservation(id: $id, placeId: $placeId, userId: $userId, reservationDate: $reservationDate, startTime: $startTime, endTime: $endTime, partySize: $partySize, status: $status, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone, placeName: $placeName, specialRequests: $specialRequests, notes: $notes, tableNumber: $tableNumber, confirmationCode: $confirmationCode, createdAt: $createdAt, updatedAt: $updatedAt, confirmedAt: $confirmedAt, checkedInAt: $checkedInAt, cancelledAt: $cancelledAt, cancelReason: $cancelReason, adminNotes: $adminNotes, reminderSent: $reminderSent, customerInfo: $customerInfo, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $ReservationCopyWith<$Res>  {
  factory $ReservationCopyWith(Reservation value, $Res Function(Reservation) _then) = _$ReservationCopyWithImpl;
@useResult
$Res call({
 String id, String placeId, String userId, DateTime reservationDate, DateTime startTime, DateTime endTime, int partySize, ReservationStatus status, String customerName, String customerEmail, String customerPhone, String? placeName, String? specialRequests, String? notes, String? tableNumber, String? confirmationCode, DateTime? createdAt, DateTime? updatedAt, DateTime? confirmedAt, DateTime? checkedInAt, DateTime? cancelledAt, String? cancelReason, String? adminNotes, bool? reminderSent, Map<String, dynamic> customerInfo, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$ReservationCopyWithImpl<$Res>
    implements $ReservationCopyWith<$Res> {
  _$ReservationCopyWithImpl(this._self, this._then);

  final Reservation _self;
  final $Res Function(Reservation) _then;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? userId = null,Object? reservationDate = null,Object? startTime = null,Object? endTime = null,Object? partySize = null,Object? status = null,Object? customerName = null,Object? customerEmail = null,Object? customerPhone = null,Object? placeName = freezed,Object? specialRequests = freezed,Object? notes = freezed,Object? tableNumber = freezed,Object? confirmationCode = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? confirmedAt = freezed,Object? checkedInAt = freezed,Object? cancelledAt = freezed,Object? cancelReason = freezed,Object? adminNotes = freezed,Object? reminderSent = freezed,Object? customerInfo = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,reservationDate: null == reservationDate ? _self.reservationDate : reservationDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerEmail: null == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,specialRequests: freezed == specialRequests ? _self.specialRequests : specialRequests // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,tableNumber: freezed == tableNumber ? _self.tableNumber : tableNumber // ignore: cast_nullable_to_non_nullable
as String?,confirmationCode: freezed == confirmationCode ? _self.confirmationCode : confirmationCode // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,reminderSent: freezed == reminderSent ? _self.reminderSent : reminderSent // ignore: cast_nullable_to_non_nullable
as bool?,customerInfo: null == customerInfo ? _self.customerInfo : customerInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [Reservation].
extension ReservationPatterns on Reservation {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Reservation value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Reservation value)  $default,){
final _that = this;
switch (_that) {
case _Reservation():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Reservation value)?  $default,){
final _that = this;
switch (_that) {
case _Reservation() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String placeId,  String userId,  DateTime reservationDate,  DateTime startTime,  DateTime endTime,  int partySize,  ReservationStatus status,  String customerName,  String customerEmail,  String customerPhone,  String? placeName,  String? specialRequests,  String? notes,  String? tableNumber,  String? confirmationCode,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? confirmedAt,  DateTime? checkedInAt,  DateTime? cancelledAt,  String? cancelReason,  String? adminNotes,  bool? reminderSent,  Map<String, dynamic> customerInfo,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
return $default(_that.id,_that.placeId,_that.userId,_that.reservationDate,_that.startTime,_that.endTime,_that.partySize,_that.status,_that.customerName,_that.customerEmail,_that.customerPhone,_that.placeName,_that.specialRequests,_that.notes,_that.tableNumber,_that.confirmationCode,_that.createdAt,_that.updatedAt,_that.confirmedAt,_that.checkedInAt,_that.cancelledAt,_that.cancelReason,_that.adminNotes,_that.reminderSent,_that.customerInfo,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String placeId,  String userId,  DateTime reservationDate,  DateTime startTime,  DateTime endTime,  int partySize,  ReservationStatus status,  String customerName,  String customerEmail,  String customerPhone,  String? placeName,  String? specialRequests,  String? notes,  String? tableNumber,  String? confirmationCode,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? confirmedAt,  DateTime? checkedInAt,  DateTime? cancelledAt,  String? cancelReason,  String? adminNotes,  bool? reminderSent,  Map<String, dynamic> customerInfo,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _Reservation():
return $default(_that.id,_that.placeId,_that.userId,_that.reservationDate,_that.startTime,_that.endTime,_that.partySize,_that.status,_that.customerName,_that.customerEmail,_that.customerPhone,_that.placeName,_that.specialRequests,_that.notes,_that.tableNumber,_that.confirmationCode,_that.createdAt,_that.updatedAt,_that.confirmedAt,_that.checkedInAt,_that.cancelledAt,_that.cancelReason,_that.adminNotes,_that.reminderSent,_that.customerInfo,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String placeId,  String userId,  DateTime reservationDate,  DateTime startTime,  DateTime endTime,  int partySize,  ReservationStatus status,  String customerName,  String customerEmail,  String customerPhone,  String? placeName,  String? specialRequests,  String? notes,  String? tableNumber,  String? confirmationCode,  DateTime? createdAt,  DateTime? updatedAt,  DateTime? confirmedAt,  DateTime? checkedInAt,  DateTime? cancelledAt,  String? cancelReason,  String? adminNotes,  bool? reminderSent,  Map<String, dynamic> customerInfo,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _Reservation() when $default != null:
return $default(_that.id,_that.placeId,_that.userId,_that.reservationDate,_that.startTime,_that.endTime,_that.partySize,_that.status,_that.customerName,_that.customerEmail,_that.customerPhone,_that.placeName,_that.specialRequests,_that.notes,_that.tableNumber,_that.confirmationCode,_that.createdAt,_that.updatedAt,_that.confirmedAt,_that.checkedInAt,_that.cancelledAt,_that.cancelReason,_that.adminNotes,_that.reminderSent,_that.customerInfo,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Reservation extends Reservation {
  const _Reservation({required this.id, required this.placeId, required this.userId, required this.reservationDate, required this.startTime, required this.endTime, required this.partySize, required this.status, this.customerName = '', this.customerEmail = '', this.customerPhone = '', this.placeName, this.specialRequests, this.notes, this.tableNumber, this.confirmationCode, this.createdAt, this.updatedAt, this.confirmedAt, this.checkedInAt, this.cancelledAt, this.cancelReason, this.adminNotes, this.reminderSent, final  Map<String, dynamic> customerInfo = const {}, final  Map<String, dynamic> metadata = const {}}): _customerInfo = customerInfo,_metadata = metadata,super._();
  factory _Reservation.fromJson(Map<String, dynamic> json) => _$ReservationFromJson(json);

@override final  String id;
@override final  String placeId;
@override final  String userId;
@override final  DateTime reservationDate;
@override final  DateTime startTime;
@override final  DateTime endTime;
@override final  int partySize;
@override final  ReservationStatus status;
@override@JsonKey() final  String customerName;
@override@JsonKey() final  String customerEmail;
@override@JsonKey() final  String customerPhone;
@override final  String? placeName;
@override final  String? specialRequests;
@override final  String? notes;
@override final  String? tableNumber;
@override final  String? confirmationCode;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  DateTime? confirmedAt;
@override final  DateTime? checkedInAt;
@override final  DateTime? cancelledAt;
@override final  String? cancelReason;
@override final  String? adminNotes;
@override final  bool? reminderSent;
 final  Map<String, dynamic> _customerInfo;
@override@JsonKey() Map<String, dynamic> get customerInfo {
  if (_customerInfo is EqualUnmodifiableMapView) return _customerInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_customerInfo);
}

 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReservationCopyWith<_Reservation> get copyWith => __$ReservationCopyWithImpl<_Reservation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReservationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Reservation&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.reservationDate, reservationDate) || other.reservationDate == reservationDate)&&(identical(other.startTime, startTime) || other.startTime == startTime)&&(identical(other.endTime, endTime) || other.endTime == endTime)&&(identical(other.partySize, partySize) || other.partySize == partySize)&&(identical(other.status, status) || other.status == status)&&(identical(other.customerName, customerName) || other.customerName == customerName)&&(identical(other.customerEmail, customerEmail) || other.customerEmail == customerEmail)&&(identical(other.customerPhone, customerPhone) || other.customerPhone == customerPhone)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.specialRequests, specialRequests) || other.specialRequests == specialRequests)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.tableNumber, tableNumber) || other.tableNumber == tableNumber)&&(identical(other.confirmationCode, confirmationCode) || other.confirmationCode == confirmationCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.confirmedAt, confirmedAt) || other.confirmedAt == confirmedAt)&&(identical(other.checkedInAt, checkedInAt) || other.checkedInAt == checkedInAt)&&(identical(other.cancelledAt, cancelledAt) || other.cancelledAt == cancelledAt)&&(identical(other.cancelReason, cancelReason) || other.cancelReason == cancelReason)&&(identical(other.adminNotes, adminNotes) || other.adminNotes == adminNotes)&&(identical(other.reminderSent, reminderSent) || other.reminderSent == reminderSent)&&const DeepCollectionEquality().equals(other._customerInfo, _customerInfo)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,placeId,userId,reservationDate,startTime,endTime,partySize,status,customerName,customerEmail,customerPhone,placeName,specialRequests,notes,tableNumber,confirmationCode,createdAt,updatedAt,confirmedAt,checkedInAt,cancelledAt,cancelReason,adminNotes,reminderSent,const DeepCollectionEquality().hash(_customerInfo),const DeepCollectionEquality().hash(_metadata)]);

@override
String toString() {
  return 'Reservation(id: $id, placeId: $placeId, userId: $userId, reservationDate: $reservationDate, startTime: $startTime, endTime: $endTime, partySize: $partySize, status: $status, customerName: $customerName, customerEmail: $customerEmail, customerPhone: $customerPhone, placeName: $placeName, specialRequests: $specialRequests, notes: $notes, tableNumber: $tableNumber, confirmationCode: $confirmationCode, createdAt: $createdAt, updatedAt: $updatedAt, confirmedAt: $confirmedAt, checkedInAt: $checkedInAt, cancelledAt: $cancelledAt, cancelReason: $cancelReason, adminNotes: $adminNotes, reminderSent: $reminderSent, customerInfo: $customerInfo, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$ReservationCopyWith<$Res> implements $ReservationCopyWith<$Res> {
  factory _$ReservationCopyWith(_Reservation value, $Res Function(_Reservation) _then) = __$ReservationCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeId, String userId, DateTime reservationDate, DateTime startTime, DateTime endTime, int partySize, ReservationStatus status, String customerName, String customerEmail, String customerPhone, String? placeName, String? specialRequests, String? notes, String? tableNumber, String? confirmationCode, DateTime? createdAt, DateTime? updatedAt, DateTime? confirmedAt, DateTime? checkedInAt, DateTime? cancelledAt, String? cancelReason, String? adminNotes, bool? reminderSent, Map<String, dynamic> customerInfo, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$ReservationCopyWithImpl<$Res>
    implements _$ReservationCopyWith<$Res> {
  __$ReservationCopyWithImpl(this._self, this._then);

  final _Reservation _self;
  final $Res Function(_Reservation) _then;

/// Create a copy of Reservation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? userId = null,Object? reservationDate = null,Object? startTime = null,Object? endTime = null,Object? partySize = null,Object? status = null,Object? customerName = null,Object? customerEmail = null,Object? customerPhone = null,Object? placeName = freezed,Object? specialRequests = freezed,Object? notes = freezed,Object? tableNumber = freezed,Object? confirmationCode = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? confirmedAt = freezed,Object? checkedInAt = freezed,Object? cancelledAt = freezed,Object? cancelReason = freezed,Object? adminNotes = freezed,Object? reminderSent = freezed,Object? customerInfo = null,Object? metadata = null,}) {
  return _then(_Reservation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,reservationDate: null == reservationDate ? _self.reservationDate : reservationDate // ignore: cast_nullable_to_non_nullable
as DateTime,startTime: null == startTime ? _self.startTime : startTime // ignore: cast_nullable_to_non_nullable
as DateTime,endTime: null == endTime ? _self.endTime : endTime // ignore: cast_nullable_to_non_nullable
as DateTime,partySize: null == partySize ? _self.partySize : partySize // ignore: cast_nullable_to_non_nullable
as int,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReservationStatus,customerName: null == customerName ? _self.customerName : customerName // ignore: cast_nullable_to_non_nullable
as String,customerEmail: null == customerEmail ? _self.customerEmail : customerEmail // ignore: cast_nullable_to_non_nullable
as String,customerPhone: null == customerPhone ? _self.customerPhone : customerPhone // ignore: cast_nullable_to_non_nullable
as String,placeName: freezed == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String?,specialRequests: freezed == specialRequests ? _self.specialRequests : specialRequests // ignore: cast_nullable_to_non_nullable
as String?,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,tableNumber: freezed == tableNumber ? _self.tableNumber : tableNumber // ignore: cast_nullable_to_non_nullable
as String?,confirmationCode: freezed == confirmationCode ? _self.confirmationCode : confirmationCode // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,confirmedAt: freezed == confirmedAt ? _self.confirmedAt : confirmedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,checkedInAt: freezed == checkedInAt ? _self.checkedInAt : checkedInAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelledAt: freezed == cancelledAt ? _self.cancelledAt : cancelledAt // ignore: cast_nullable_to_non_nullable
as DateTime?,cancelReason: freezed == cancelReason ? _self.cancelReason : cancelReason // ignore: cast_nullable_to_non_nullable
as String?,adminNotes: freezed == adminNotes ? _self.adminNotes : adminNotes // ignore: cast_nullable_to_non_nullable
as String?,reminderSent: freezed == reminderSent ? _self.reminderSent : reminderSent // ignore: cast_nullable_to_non_nullable
as bool?,customerInfo: null == customerInfo ? _self._customerInfo : customerInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
