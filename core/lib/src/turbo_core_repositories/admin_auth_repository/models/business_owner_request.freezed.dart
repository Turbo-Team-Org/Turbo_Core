// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_owner_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessOwnerRequest {

 String get id; String get userId; String get email; String get displayName; String get businessName; String get businessDescription; String get businessAddress; String? get phoneNumber; String? get website; BusinessOwnerRequestStatus get status; DateTime get createdAt; DateTime? get lastLogin; DateTime? get reviewedAt; String? get reviewedBy; String? get rejectionReason; String? get approvalNotes; Map<String, dynamic> get businessMetadata; Map<String, dynamic> get contactInfo;
/// Create a copy of BusinessOwnerRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessOwnerRequestCopyWith<BusinessOwnerRequest> get copyWith => _$BusinessOwnerRequestCopyWithImpl<BusinessOwnerRequest>(this as BusinessOwnerRequest, _$identity);

  /// Serializes this BusinessOwnerRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessOwnerRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.businessDescription, businessDescription) || other.businessDescription == businessDescription)&&(identical(other.businessAddress, businessAddress) || other.businessAddress == businessAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.website, website) || other.website == website)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.approvalNotes, approvalNotes) || other.approvalNotes == approvalNotes)&&const DeepCollectionEquality().equals(other.businessMetadata, businessMetadata)&&const DeepCollectionEquality().equals(other.contactInfo, contactInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,email,displayName,businessName,businessDescription,businessAddress,phoneNumber,website,status,createdAt,lastLogin,reviewedAt,reviewedBy,rejectionReason,approvalNotes,const DeepCollectionEquality().hash(businessMetadata),const DeepCollectionEquality().hash(contactInfo));

@override
String toString() {
  return 'BusinessOwnerRequest(id: $id, userId: $userId, email: $email, displayName: $displayName, businessName: $businessName, businessDescription: $businessDescription, businessAddress: $businessAddress, phoneNumber: $phoneNumber, website: $website, status: $status, createdAt: $createdAt, lastLogin: $lastLogin, reviewedAt: $reviewedAt, reviewedBy: $reviewedBy, rejectionReason: $rejectionReason, approvalNotes: $approvalNotes, businessMetadata: $businessMetadata, contactInfo: $contactInfo)';
}


}

/// @nodoc
abstract mixin class $BusinessOwnerRequestCopyWith<$Res>  {
  factory $BusinessOwnerRequestCopyWith(BusinessOwnerRequest value, $Res Function(BusinessOwnerRequest) _then) = _$BusinessOwnerRequestCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String email, String displayName, String businessName, String businessDescription, String businessAddress, String? phoneNumber, String? website, BusinessOwnerRequestStatus status, DateTime createdAt, DateTime? lastLogin, DateTime? reviewedAt, String? reviewedBy, String? rejectionReason, String? approvalNotes, Map<String, dynamic> businessMetadata, Map<String, dynamic> contactInfo
});




}
/// @nodoc
class _$BusinessOwnerRequestCopyWithImpl<$Res>
    implements $BusinessOwnerRequestCopyWith<$Res> {
  _$BusinessOwnerRequestCopyWithImpl(this._self, this._then);

  final BusinessOwnerRequest _self;
  final $Res Function(BusinessOwnerRequest) _then;

/// Create a copy of BusinessOwnerRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? email = null,Object? displayName = null,Object? businessName = null,Object? businessDescription = null,Object? businessAddress = null,Object? phoneNumber = freezed,Object? website = freezed,Object? status = null,Object? createdAt = null,Object? lastLogin = freezed,Object? reviewedAt = freezed,Object? reviewedBy = freezed,Object? rejectionReason = freezed,Object? approvalNotes = freezed,Object? businessMetadata = null,Object? contactInfo = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,businessDescription: null == businessDescription ? _self.businessDescription : businessDescription // ignore: cast_nullable_to_non_nullable
as String,businessAddress: null == businessAddress ? _self.businessAddress : businessAddress // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessOwnerRequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,approvalNotes: freezed == approvalNotes ? _self.approvalNotes : approvalNotes // ignore: cast_nullable_to_non_nullable
as String?,businessMetadata: null == businessMetadata ? _self.businessMetadata : businessMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,contactInfo: null == contactInfo ? _self.contactInfo : contactInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [BusinessOwnerRequest].
extension BusinessOwnerRequestPatterns on BusinessOwnerRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _BusinessOwnerRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _BusinessOwnerRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _BusinessOwnerRequest value)  $default,){
final _that = this;
switch (_that) {
case _BusinessOwnerRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _BusinessOwnerRequest value)?  $default,){
final _that = this;
switch (_that) {
case _BusinessOwnerRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String email,  String displayName,  String businessName,  String businessDescription,  String businessAddress,  String? phoneNumber,  String? website,  BusinessOwnerRequestStatus status,  DateTime createdAt,  DateTime? lastLogin,  DateTime? reviewedAt,  String? reviewedBy,  String? rejectionReason,  String? approvalNotes,  Map<String, dynamic> businessMetadata,  Map<String, dynamic> contactInfo)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _BusinessOwnerRequest() when $default != null:
return $default(_that.id,_that.userId,_that.email,_that.displayName,_that.businessName,_that.businessDescription,_that.businessAddress,_that.phoneNumber,_that.website,_that.status,_that.createdAt,_that.lastLogin,_that.reviewedAt,_that.reviewedBy,_that.rejectionReason,_that.approvalNotes,_that.businessMetadata,_that.contactInfo);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String email,  String displayName,  String businessName,  String businessDescription,  String businessAddress,  String? phoneNumber,  String? website,  BusinessOwnerRequestStatus status,  DateTime createdAt,  DateTime? lastLogin,  DateTime? reviewedAt,  String? reviewedBy,  String? rejectionReason,  String? approvalNotes,  Map<String, dynamic> businessMetadata,  Map<String, dynamic> contactInfo)  $default,) {final _that = this;
switch (_that) {
case _BusinessOwnerRequest():
return $default(_that.id,_that.userId,_that.email,_that.displayName,_that.businessName,_that.businessDescription,_that.businessAddress,_that.phoneNumber,_that.website,_that.status,_that.createdAt,_that.lastLogin,_that.reviewedAt,_that.reviewedBy,_that.rejectionReason,_that.approvalNotes,_that.businessMetadata,_that.contactInfo);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String email,  String displayName,  String businessName,  String businessDescription,  String businessAddress,  String? phoneNumber,  String? website,  BusinessOwnerRequestStatus status,  DateTime createdAt,  DateTime? lastLogin,  DateTime? reviewedAt,  String? reviewedBy,  String? rejectionReason,  String? approvalNotes,  Map<String, dynamic> businessMetadata,  Map<String, dynamic> contactInfo)?  $default,) {final _that = this;
switch (_that) {
case _BusinessOwnerRequest() when $default != null:
return $default(_that.id,_that.userId,_that.email,_that.displayName,_that.businessName,_that.businessDescription,_that.businessAddress,_that.phoneNumber,_that.website,_that.status,_that.createdAt,_that.lastLogin,_that.reviewedAt,_that.reviewedBy,_that.rejectionReason,_that.approvalNotes,_that.businessMetadata,_that.contactInfo);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _BusinessOwnerRequest extends BusinessOwnerRequest {
  const _BusinessOwnerRequest({required this.id, required this.userId, required this.email, required this.displayName, required this.businessName, required this.businessDescription, required this.businessAddress, this.phoneNumber, this.website, this.status = BusinessOwnerRequestStatus.pending, required this.createdAt, this.lastLogin, this.reviewedAt, this.reviewedBy, this.rejectionReason, this.approvalNotes, final  Map<String, dynamic> businessMetadata = const {}, final  Map<String, dynamic> contactInfo = const {}}): _businessMetadata = businessMetadata,_contactInfo = contactInfo,super._();
  factory _BusinessOwnerRequest.fromJson(Map<String, dynamic> json) => _$BusinessOwnerRequestFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String email;
@override final  String displayName;
@override final  String businessName;
@override final  String businessDescription;
@override final  String businessAddress;
@override final  String? phoneNumber;
@override final  String? website;
@override@JsonKey() final  BusinessOwnerRequestStatus status;
@override final  DateTime createdAt;
@override final  DateTime? lastLogin;
@override final  DateTime? reviewedAt;
@override final  String? reviewedBy;
@override final  String? rejectionReason;
@override final  String? approvalNotes;
 final  Map<String, dynamic> _businessMetadata;
@override@JsonKey() Map<String, dynamic> get businessMetadata {
  if (_businessMetadata is EqualUnmodifiableMapView) return _businessMetadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_businessMetadata);
}

 final  Map<String, dynamic> _contactInfo;
@override@JsonKey() Map<String, dynamic> get contactInfo {
  if (_contactInfo is EqualUnmodifiableMapView) return _contactInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_contactInfo);
}


/// Create a copy of BusinessOwnerRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessOwnerRequestCopyWith<_BusinessOwnerRequest> get copyWith => __$BusinessOwnerRequestCopyWithImpl<_BusinessOwnerRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessOwnerRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessOwnerRequest&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.businessDescription, businessDescription) || other.businessDescription == businessDescription)&&(identical(other.businessAddress, businessAddress) || other.businessAddress == businessAddress)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.website, website) || other.website == website)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.reviewedAt, reviewedAt) || other.reviewedAt == reviewedAt)&&(identical(other.reviewedBy, reviewedBy) || other.reviewedBy == reviewedBy)&&(identical(other.rejectionReason, rejectionReason) || other.rejectionReason == rejectionReason)&&(identical(other.approvalNotes, approvalNotes) || other.approvalNotes == approvalNotes)&&const DeepCollectionEquality().equals(other._businessMetadata, _businessMetadata)&&const DeepCollectionEquality().equals(other._contactInfo, _contactInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,email,displayName,businessName,businessDescription,businessAddress,phoneNumber,website,status,createdAt,lastLogin,reviewedAt,reviewedBy,rejectionReason,approvalNotes,const DeepCollectionEquality().hash(_businessMetadata),const DeepCollectionEquality().hash(_contactInfo));

@override
String toString() {
  return 'BusinessOwnerRequest(id: $id, userId: $userId, email: $email, displayName: $displayName, businessName: $businessName, businessDescription: $businessDescription, businessAddress: $businessAddress, phoneNumber: $phoneNumber, website: $website, status: $status, createdAt: $createdAt, lastLogin: $lastLogin, reviewedAt: $reviewedAt, reviewedBy: $reviewedBy, rejectionReason: $rejectionReason, approvalNotes: $approvalNotes, businessMetadata: $businessMetadata, contactInfo: $contactInfo)';
}


}

/// @nodoc
abstract mixin class _$BusinessOwnerRequestCopyWith<$Res> implements $BusinessOwnerRequestCopyWith<$Res> {
  factory _$BusinessOwnerRequestCopyWith(_BusinessOwnerRequest value, $Res Function(_BusinessOwnerRequest) _then) = __$BusinessOwnerRequestCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String email, String displayName, String businessName, String businessDescription, String businessAddress, String? phoneNumber, String? website, BusinessOwnerRequestStatus status, DateTime createdAt, DateTime? lastLogin, DateTime? reviewedAt, String? reviewedBy, String? rejectionReason, String? approvalNotes, Map<String, dynamic> businessMetadata, Map<String, dynamic> contactInfo
});




}
/// @nodoc
class __$BusinessOwnerRequestCopyWithImpl<$Res>
    implements _$BusinessOwnerRequestCopyWith<$Res> {
  __$BusinessOwnerRequestCopyWithImpl(this._self, this._then);

  final _BusinessOwnerRequest _self;
  final $Res Function(_BusinessOwnerRequest) _then;

/// Create a copy of BusinessOwnerRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? email = null,Object? displayName = null,Object? businessName = null,Object? businessDescription = null,Object? businessAddress = null,Object? phoneNumber = freezed,Object? website = freezed,Object? status = null,Object? createdAt = null,Object? lastLogin = freezed,Object? reviewedAt = freezed,Object? reviewedBy = freezed,Object? rejectionReason = freezed,Object? approvalNotes = freezed,Object? businessMetadata = null,Object? contactInfo = null,}) {
  return _then(_BusinessOwnerRequest(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,displayName: null == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,businessDescription: null == businessDescription ? _self.businessDescription : businessDescription // ignore: cast_nullable_to_non_nullable
as String,businessAddress: null == businessAddress ? _self.businessAddress : businessAddress // ignore: cast_nullable_to_non_nullable
as String,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as BusinessOwnerRequestStatus,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedAt: freezed == reviewedAt ? _self.reviewedAt : reviewedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,reviewedBy: freezed == reviewedBy ? _self.reviewedBy : reviewedBy // ignore: cast_nullable_to_non_nullable
as String?,rejectionReason: freezed == rejectionReason ? _self.rejectionReason : rejectionReason // ignore: cast_nullable_to_non_nullable
as String?,approvalNotes: freezed == approvalNotes ? _self.approvalNotes : approvalNotes // ignore: cast_nullable_to_non_nullable
as String?,businessMetadata: null == businessMetadata ? _self._businessMetadata : businessMetadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,contactInfo: null == contactInfo ? _self._contactInfo : contactInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
