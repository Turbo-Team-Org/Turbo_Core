// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'google_place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_GooglePlace _$GooglePlaceFromJson(Map<String, dynamic> json) => _GooglePlace(
  placeId: json['placeId'] as String,
  name: json['name'] as String,
  formattedAddress: json['formattedAddress'] as String,
  location: LocationData.fromJson(json['location'] as Map<String, dynamic>),
  types:
      (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  businessStatus: json['businessStatus'] as String?,
  vicinity: json['vicinity'] as String?,
  rating: (json['rating'] as num?)?.toDouble(),
  userRatingsTotal: (json['userRatingsTotal'] as num?)?.toInt(),
  photoReference: json['photoReference'] as String?,
  photoReferences:
      (json['photoReferences'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  website: json['website'] as String?,
  phoneNumber: json['phoneNumber'] as String?,
  internationalPhoneNumber: json['internationalPhoneNumber'] as String?,
  openingHours:
      (json['openingHours'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  plusCode: json['plusCode'] as String?,
  addressComponents:
      (json['addressComponents'] as List<dynamic>?)
          ?.map((e) => e as Map<String, dynamic>)
          .toList() ??
      const [],
  geometry: json['geometry'] as Map<String, dynamic>?,
  icon: json['icon'] as String?,
  iconBackgroundColor: json['iconBackgroundColor'] as String?,
  iconMaskBaseUri: json['iconMaskBaseUri'] as String?,
  permanentlyClosed: json['permanentlyClosed'] as bool?,
  secondaryOpeningsHours:
      (json['secondaryOpeningsHours'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  utcOffset: json['utcOffset'] as String?,
  adrAddress: json['adrAddress'] as String?,
  formattedPhoneNumber: json['formattedPhoneNumber'] as String?,
  url: json['url'] as String?,
);

Map<String, dynamic> _$GooglePlaceToJson(_GooglePlace instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'name': instance.name,
      'formattedAddress': instance.formattedAddress,
      'location': instance.location,
      'types': instance.types,
      'businessStatus': instance.businessStatus,
      'vicinity': instance.vicinity,
      'rating': instance.rating,
      'userRatingsTotal': instance.userRatingsTotal,
      'photoReference': instance.photoReference,
      'photoReferences': instance.photoReferences,
      'website': instance.website,
      'phoneNumber': instance.phoneNumber,
      'internationalPhoneNumber': instance.internationalPhoneNumber,
      'openingHours': instance.openingHours,
      'plusCode': instance.plusCode,
      'addressComponents': instance.addressComponents,
      'geometry': instance.geometry,
      'icon': instance.icon,
      'iconBackgroundColor': instance.iconBackgroundColor,
      'iconMaskBaseUri': instance.iconMaskBaseUri,
      'permanentlyClosed': instance.permanentlyClosed,
      'secondaryOpeningsHours': instance.secondaryOpeningsHours,
      'utcOffset': instance.utcOffset,
      'adrAddress': instance.adrAddress,
      'formattedPhoneNumber': instance.formattedPhoneNumber,
      'url': instance.url,
    };
