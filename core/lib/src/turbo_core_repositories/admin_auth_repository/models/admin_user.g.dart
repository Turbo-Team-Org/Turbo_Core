// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AdminUser _$AdminUserFromJson(Map<String, dynamic> json) => _AdminUser(
  uid: json['uid'] as String,
  email: json['email'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  displayName: json['displayName'] as String?,
  role:
      $enumDecodeNullable(_$AdminRoleEnumMap, json['role']) ??
      AdminRole.placeOwner,
  ownedPlaceIds:
      (json['ownedPlaceIds'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  permissions:
      (json['permissions'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(
          k,
          (e as List<dynamic>)
              .map((e) => $enumDecode(_$PermissionEnumMap, e))
              .toList(),
        ),
      ) ??
      const {},
  lastLogin:
      json['lastLogin'] == null
          ? null
          : DateTime.parse(json['lastLogin'] as String),
  isActive: json['isActive'] as bool? ?? true,
  photoUrl: json['photoUrl'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$AdminUserToJson(_AdminUser instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'createdAt': instance.createdAt.toIso8601String(),
      'displayName': instance.displayName,
      'role': _$AdminRoleEnumMap[instance.role]!,
      'ownedPlaceIds': instance.ownedPlaceIds,
      'permissions': instance.permissions.map(
        (k, e) => MapEntry(k, e.map((e) => _$PermissionEnumMap[e]!).toList()),
      ),
      'lastLogin': instance.lastLogin?.toIso8601String(),
      'isActive': instance.isActive,
      'photoUrl': instance.photoUrl,
      'phoneNumber': instance.phoneNumber,
      'metadata': instance.metadata,
    };

const _$AdminRoleEnumMap = {
  AdminRole.placeOwner: 'placeOwner',
  AdminRole.superAdmin: 'superAdmin',
};

const _$PermissionEnumMap = {
  Permission.readPlace: 'readPlace',
  Permission.editPlace: 'editPlace',
  Permission.deletePlace: 'deletePlace',
  Permission.manageEvents: 'manageEvents',
  Permission.viewReviews: 'viewReviews',
  Permission.moderateReviews: 'moderateReviews',
  Permission.viewAnalytics: 'viewAnalytics',
  Permission.viewDetailedAnalytics: 'viewDetailedAnalytics',
  Permission.manageOffers: 'manageOffers',
  Permission.manageMedia: 'manageMedia',
  Permission.manageUsers: 'manageUsers',
  Permission.systemConfiguration: 'systemConfiguration',
};
