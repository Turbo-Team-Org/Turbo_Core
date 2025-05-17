// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthUser _$AuthUserFromJson(Map<String, dynamic> json) => _AuthUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String?,
  photoUrl: json['photoUrl'] as String?,
  createdAt: DateTime.parse(json['createdAt'] as String),
  phoneNumber: json['phoneNumber'] as String?,
  authProvider: json['authProvider'] as String?,
  favorites:
      (json['favorites'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList() ??
      const [],
);

Map<String, dynamic> _$AuthUserToJson(_AuthUser instance) => <String, dynamic>{
  'uid': instance.uid,
  'email': instance.email,
  'displayName': instance.displayName,
  'photoUrl': instance.photoUrl,
  'createdAt': instance.createdAt.toIso8601String(),
  'phoneNumber': instance.phoneNumber,
  'authProvider': instance.authProvider,
  'favorites': instance.favorites,
};
