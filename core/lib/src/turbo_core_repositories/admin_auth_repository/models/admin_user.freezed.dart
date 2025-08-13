// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AdminUser {

 String get uid; String get email; DateTime get createdAt; String? get displayName; AdminRole get role; List<String> get ownedPlaceIds; Map<String, List<Permission>> get permissions; DateTime? get lastLogin; bool get isActive; String? get photoUrl; String? get phoneNumber; Map<String, dynamic> get metadata;
/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AdminUserCopyWith<AdminUser> get copyWith => _$AdminUserCopyWithImpl<AdminUser>(this as AdminUser, _$identity);

  /// Serializes this AdminUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AdminUser&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other.ownedPlaceIds, ownedPlaceIds)&&const DeepCollectionEquality().equals(other.permissions, permissions)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,createdAt,displayName,role,const DeepCollectionEquality().hash(ownedPlaceIds),const DeepCollectionEquality().hash(permissions),lastLogin,isActive,photoUrl,phoneNumber,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'AdminUser(uid: $uid, email: $email, createdAt: $createdAt, displayName: $displayName, role: $role, ownedPlaceIds: $ownedPlaceIds, permissions: $permissions, lastLogin: $lastLogin, isActive: $isActive, photoUrl: $photoUrl, phoneNumber: $phoneNumber, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $AdminUserCopyWith<$Res>  {
  factory $AdminUserCopyWith(AdminUser value, $Res Function(AdminUser) _then) = _$AdminUserCopyWithImpl;
@useResult
$Res call({
 String uid, String email, DateTime createdAt, String? displayName, AdminRole role, List<String> ownedPlaceIds, Map<String, List<Permission>> permissions, DateTime? lastLogin, bool isActive, String? photoUrl, String? phoneNumber, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$AdminUserCopyWithImpl<$Res>
    implements $AdminUserCopyWith<$Res> {
  _$AdminUserCopyWithImpl(this._self, this._then);

  final AdminUser _self;
  final $Res Function(AdminUser) _then;

/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? createdAt = null,Object? displayName = freezed,Object? role = null,Object? ownedPlaceIds = null,Object? permissions = null,Object? lastLogin = freezed,Object? isActive = null,Object? photoUrl = freezed,Object? phoneNumber = freezed,Object? metadata = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AdminRole,ownedPlaceIds: null == ownedPlaceIds ? _self.ownedPlaceIds : ownedPlaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,permissions: null == permissions ? _self.permissions : permissions // ignore: cast_nullable_to_non_nullable
as Map<String, List<Permission>>,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [AdminUser].
extension AdminUserPatterns on AdminUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AdminUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AdminUser value)  $default,){
final _that = this;
switch (_that) {
case _AdminUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AdminUser value)?  $default,){
final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  DateTime createdAt,  String? displayName,  AdminRole role,  List<String> ownedPlaceIds,  Map<String, List<Permission>> permissions,  DateTime? lastLogin,  bool isActive,  String? photoUrl,  String? phoneNumber,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
return $default(_that.uid,_that.email,_that.createdAt,_that.displayName,_that.role,_that.ownedPlaceIds,_that.permissions,_that.lastLogin,_that.isActive,_that.photoUrl,_that.phoneNumber,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  DateTime createdAt,  String? displayName,  AdminRole role,  List<String> ownedPlaceIds,  Map<String, List<Permission>> permissions,  DateTime? lastLogin,  bool isActive,  String? photoUrl,  String? phoneNumber,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _AdminUser():
return $default(_that.uid,_that.email,_that.createdAt,_that.displayName,_that.role,_that.ownedPlaceIds,_that.permissions,_that.lastLogin,_that.isActive,_that.photoUrl,_that.phoneNumber,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  DateTime createdAt,  String? displayName,  AdminRole role,  List<String> ownedPlaceIds,  Map<String, List<Permission>> permissions,  DateTime? lastLogin,  bool isActive,  String? photoUrl,  String? phoneNumber,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _AdminUser() when $default != null:
return $default(_that.uid,_that.email,_that.createdAt,_that.displayName,_that.role,_that.ownedPlaceIds,_that.permissions,_that.lastLogin,_that.isActive,_that.photoUrl,_that.phoneNumber,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AdminUser extends AdminUser {
  const _AdminUser({required this.uid, required this.email, required this.createdAt, this.displayName, this.role = AdminRole.placeOwner, final  List<String> ownedPlaceIds = const [], final  Map<String, List<Permission>> permissions = const {}, this.lastLogin, this.isActive = true, this.photoUrl, this.phoneNumber, final  Map<String, dynamic> metadata = const {}}): _ownedPlaceIds = ownedPlaceIds,_permissions = permissions,_metadata = metadata,super._();
  factory _AdminUser.fromJson(Map<String, dynamic> json) => _$AdminUserFromJson(json);

@override final  String uid;
@override final  String email;
@override final  DateTime createdAt;
@override final  String? displayName;
@override@JsonKey() final  AdminRole role;
 final  List<String> _ownedPlaceIds;
@override@JsonKey() List<String> get ownedPlaceIds {
  if (_ownedPlaceIds is EqualUnmodifiableListView) return _ownedPlaceIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownedPlaceIds);
}

 final  Map<String, List<Permission>> _permissions;
@override@JsonKey() Map<String, List<Permission>> get permissions {
  if (_permissions is EqualUnmodifiableMapView) return _permissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_permissions);
}

@override final  DateTime? lastLogin;
@override@JsonKey() final  bool isActive;
@override final  String? photoUrl;
@override final  String? phoneNumber;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AdminUserCopyWith<_AdminUser> get copyWith => __$AdminUserCopyWithImpl<_AdminUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AdminUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AdminUser&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.role, role) || other.role == role)&&const DeepCollectionEquality().equals(other._ownedPlaceIds, _ownedPlaceIds)&&const DeepCollectionEquality().equals(other._permissions, _permissions)&&(identical(other.lastLogin, lastLogin) || other.lastLogin == lastLogin)&&(identical(other.isActive, isActive) || other.isActive == isActive)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,createdAt,displayName,role,const DeepCollectionEquality().hash(_ownedPlaceIds),const DeepCollectionEquality().hash(_permissions),lastLogin,isActive,photoUrl,phoneNumber,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'AdminUser(uid: $uid, email: $email, createdAt: $createdAt, displayName: $displayName, role: $role, ownedPlaceIds: $ownedPlaceIds, permissions: $permissions, lastLogin: $lastLogin, isActive: $isActive, photoUrl: $photoUrl, phoneNumber: $phoneNumber, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$AdminUserCopyWith<$Res> implements $AdminUserCopyWith<$Res> {
  factory _$AdminUserCopyWith(_AdminUser value, $Res Function(_AdminUser) _then) = __$AdminUserCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, DateTime createdAt, String? displayName, AdminRole role, List<String> ownedPlaceIds, Map<String, List<Permission>> permissions, DateTime? lastLogin, bool isActive, String? photoUrl, String? phoneNumber, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$AdminUserCopyWithImpl<$Res>
    implements _$AdminUserCopyWith<$Res> {
  __$AdminUserCopyWithImpl(this._self, this._then);

  final _AdminUser _self;
  final $Res Function(_AdminUser) _then;

/// Create a copy of AdminUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? createdAt = null,Object? displayName = freezed,Object? role = null,Object? ownedPlaceIds = null,Object? permissions = null,Object? lastLogin = freezed,Object? isActive = null,Object? photoUrl = freezed,Object? phoneNumber = freezed,Object? metadata = null,}) {
  return _then(_AdminUser(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as AdminRole,ownedPlaceIds: null == ownedPlaceIds ? _self._ownedPlaceIds : ownedPlaceIds // ignore: cast_nullable_to_non_nullable
as List<String>,permissions: null == permissions ? _self._permissions : permissions // ignore: cast_nullable_to_non_nullable
as Map<String, List<Permission>>,lastLogin: freezed == lastLogin ? _self.lastLogin : lastLogin // ignore: cast_nullable_to_non_nullable
as DateTime?,isActive: null == isActive ? _self.isActive : isActive // ignore: cast_nullable_to_non_nullable
as bool,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
