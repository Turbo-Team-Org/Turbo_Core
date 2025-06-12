// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'auth_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$AuthResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'AuthResult()';
}


}

/// @nodoc
class $AuthResultCopyWith<$Res>  {
$AuthResultCopyWith(AuthResult _, $Res Function(AuthResult) __);
}


/// @nodoc


class AuthResultAdmin implements AuthResult {
  const AuthResultAdmin(this.user);
  

 final  AdminUser user;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResultAdminCopyWith<AuthResultAdmin> get copyWith => _$AuthResultAdminCopyWithImpl<AuthResultAdmin>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResultAdmin&&(identical(other.user, user) || other.user == user));
}


@override
int get hashCode => Object.hash(runtimeType,user);

@override
String toString() {
  return 'AuthResult.admin(user: $user)';
}


}

/// @nodoc
abstract mixin class $AuthResultAdminCopyWith<$Res> implements $AuthResultCopyWith<$Res> {
  factory $AuthResultAdminCopyWith(AuthResultAdmin value, $Res Function(AuthResultAdmin) _then) = _$AuthResultAdminCopyWithImpl;
@useResult
$Res call({
 AdminUser user
});


$AdminUserCopyWith<$Res> get user;

}
/// @nodoc
class _$AuthResultAdminCopyWithImpl<$Res>
    implements $AuthResultAdminCopyWith<$Res> {
  _$AuthResultAdminCopyWithImpl(this._self, this._then);

  final AuthResultAdmin _self;
  final $Res Function(AuthResultAdmin) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? user = null,}) {
  return _then(AuthResultAdmin(
null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as AdminUser,
  ));
}

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AdminUserCopyWith<$Res> get user {
  
  return $AdminUserCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}
}

/// @nodoc


class AuthResultBusinessOwner implements AuthResult {
  const AuthResultBusinessOwner(this.request);
  

 final  BusinessOwnerRequest request;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AuthResultBusinessOwnerCopyWith<AuthResultBusinessOwner> get copyWith => _$AuthResultBusinessOwnerCopyWithImpl<AuthResultBusinessOwner>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AuthResultBusinessOwner&&(identical(other.request, request) || other.request == request));
}


@override
int get hashCode => Object.hash(runtimeType,request);

@override
String toString() {
  return 'AuthResult.businessOwner(request: $request)';
}


}

/// @nodoc
abstract mixin class $AuthResultBusinessOwnerCopyWith<$Res> implements $AuthResultCopyWith<$Res> {
  factory $AuthResultBusinessOwnerCopyWith(AuthResultBusinessOwner value, $Res Function(AuthResultBusinessOwner) _then) = _$AuthResultBusinessOwnerCopyWithImpl;
@useResult
$Res call({
 BusinessOwnerRequest request
});


$BusinessOwnerRequestCopyWith<$Res> get request;

}
/// @nodoc
class _$AuthResultBusinessOwnerCopyWithImpl<$Res>
    implements $AuthResultBusinessOwnerCopyWith<$Res> {
  _$AuthResultBusinessOwnerCopyWithImpl(this._self, this._then);

  final AuthResultBusinessOwner _self;
  final $Res Function(AuthResultBusinessOwner) _then;

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? request = null,}) {
  return _then(AuthResultBusinessOwner(
null == request ? _self.request : request // ignore: cast_nullable_to_non_nullable
as BusinessOwnerRequest,
  ));
}

/// Create a copy of AuthResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$BusinessOwnerRequestCopyWith<$Res> get request {
  
  return $BusinessOwnerRequestCopyWith<$Res>(_self.request, (value) {
    return _then(_self.copyWith(request: value));
  });
}
}

// dart format on
