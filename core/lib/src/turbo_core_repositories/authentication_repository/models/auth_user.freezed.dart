// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_user.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AuthUser {

 String get uid; String get email; DateTime get createdAt; String? get displayName; String? get photoUrl; String? get phoneNumber; String? get authProvider; List<int> get favorites; UserRole get role;
/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthUserCopyWith<AuthUser> get copyWith => _$AuthUserCopyWithImpl<AuthUser>(this as AuthUser, _$identity);

  /// Serializes this AuthUser to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthUser&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&const DeepCollectionEquality().equals(other.favorites, favorites)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,createdAt,displayName,photoUrl,phoneNumber,authProvider,const DeepCollectionEquality().hash(favorites),role);

@override
String toString() {
  return 'AuthUser(uid: $uid, email: $email, createdAt: $createdAt, displayName: $displayName, photoUrl: $photoUrl, phoneNumber: $phoneNumber, authProvider: $authProvider, favorites: $favorites, role: $role)';
}


}

/// @nodoc
abstract mixin class $AuthUserCopyWith<$Res>  {
  factory $AuthUserCopyWith(AuthUser value, $Res Function(AuthUser) _then) = _$AuthUserCopyWithImpl;
@useResult
$Res call({
 String uid, String email, DateTime createdAt, String? displayName, String? photoUrl, String? phoneNumber, String? authProvider, List<int> favorites, UserRole role
});




}
/// @nodoc
class _$AuthUserCopyWithImpl<$Res>
    implements $AuthUserCopyWith<$Res> {
  _$AuthUserCopyWithImpl(this._self, this._then);

  final AuthUser _self;
  final $Res Function(AuthUser) _then;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? uid = null,Object? email = null,Object? createdAt = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? phoneNumber = freezed,Object? authProvider = freezed,Object? favorites = null,Object? role = null,}) {
  return _then(_self.copyWith(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,authProvider: freezed == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String?,favorites: null == favorites ? _self.favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<int>,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}

}


/// Adds pattern-matching-related methods to [AuthUser].
extension AuthUserPatterns on AuthUser {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AuthUser value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AuthUser value)  $default,){
final _that = this;
switch (_that) {
case _AuthUser():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AuthUser value)?  $default,){
final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String uid,  String email,  DateTime createdAt,  String? displayName,  String? photoUrl,  String? phoneNumber,  String? authProvider,  List<int> favorites,  UserRole role)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
return $default(_that.uid,_that.email,_that.createdAt,_that.displayName,_that.photoUrl,_that.phoneNumber,_that.authProvider,_that.favorites,_that.role);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String uid,  String email,  DateTime createdAt,  String? displayName,  String? photoUrl,  String? phoneNumber,  String? authProvider,  List<int> favorites,  UserRole role)  $default,) {final _that = this;
switch (_that) {
case _AuthUser():
return $default(_that.uid,_that.email,_that.createdAt,_that.displayName,_that.photoUrl,_that.phoneNumber,_that.authProvider,_that.favorites,_that.role);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String uid,  String email,  DateTime createdAt,  String? displayName,  String? photoUrl,  String? phoneNumber,  String? authProvider,  List<int> favorites,  UserRole role)?  $default,) {final _that = this;
switch (_that) {
case _AuthUser() when $default != null:
return $default(_that.uid,_that.email,_that.createdAt,_that.displayName,_that.photoUrl,_that.phoneNumber,_that.authProvider,_that.favorites,_that.role);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AuthUser implements AuthUser {
  const _AuthUser({required this.uid, required this.email, required this.createdAt, this.displayName, this.photoUrl, this.phoneNumber, this.authProvider, final  List<int> favorites = const [], this.role = UserRole.regular}): _favorites = favorites;
  factory _AuthUser.fromJson(Map<String, dynamic> json) => _$AuthUserFromJson(json);

@override final  String uid;
@override final  String email;
@override final  DateTime createdAt;
@override final  String? displayName;
@override final  String? photoUrl;
@override final  String? phoneNumber;
@override final  String? authProvider;
 final  List<int> _favorites;
@override@JsonKey() List<int> get favorites {
  if (_favorites is EqualUnmodifiableListView) return _favorites;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_favorites);
}

@override@JsonKey() final  UserRole role;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AuthUserCopyWith<_AuthUser> get copyWith => __$AuthUserCopyWithImpl<_AuthUser>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AuthUserToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AuthUser&&(identical(other.uid, uid) || other.uid == uid)&&(identical(other.email, email) || other.email == email)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.displayName, displayName) || other.displayName == displayName)&&(identical(other.photoUrl, photoUrl) || other.photoUrl == photoUrl)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.authProvider, authProvider) || other.authProvider == authProvider)&&const DeepCollectionEquality().equals(other._favorites, _favorites)&&(identical(other.role, role) || other.role == role));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,uid,email,createdAt,displayName,photoUrl,phoneNumber,authProvider,const DeepCollectionEquality().hash(_favorites),role);

@override
String toString() {
  return 'AuthUser(uid: $uid, email: $email, createdAt: $createdAt, displayName: $displayName, photoUrl: $photoUrl, phoneNumber: $phoneNumber, authProvider: $authProvider, favorites: $favorites, role: $role)';
}


}

/// @nodoc
abstract mixin class _$AuthUserCopyWith<$Res> implements $AuthUserCopyWith<$Res> {
  factory _$AuthUserCopyWith(_AuthUser value, $Res Function(_AuthUser) _then) = __$AuthUserCopyWithImpl;
@override @useResult
$Res call({
 String uid, String email, DateTime createdAt, String? displayName, String? photoUrl, String? phoneNumber, String? authProvider, List<int> favorites, UserRole role
});




}
/// @nodoc
class __$AuthUserCopyWithImpl<$Res>
    implements _$AuthUserCopyWith<$Res> {
  __$AuthUserCopyWithImpl(this._self, this._then);

  final _AuthUser _self;
  final $Res Function(_AuthUser) _then;

/// Create a copy of AuthUser
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? uid = null,Object? email = null,Object? createdAt = null,Object? displayName = freezed,Object? photoUrl = freezed,Object? phoneNumber = freezed,Object? authProvider = freezed,Object? favorites = null,Object? role = null,}) {
  return _then(_AuthUser(
uid: null == uid ? _self.uid : uid // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,displayName: freezed == displayName ? _self.displayName : displayName // ignore: cast_nullable_to_non_nullable
as String?,photoUrl: freezed == photoUrl ? _self.photoUrl : photoUrl // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,authProvider: freezed == authProvider ? _self.authProvider : authProvider // ignore: cast_nullable_to_non_nullable
as String?,favorites: null == favorites ? _self._favorites : favorites // ignore: cast_nullable_to_non_nullable
as List<int>,role: null == role ? _self.role : role // ignore: cast_nullable_to_non_nullable
as UserRole,
  ));
}


}

// dart format on
