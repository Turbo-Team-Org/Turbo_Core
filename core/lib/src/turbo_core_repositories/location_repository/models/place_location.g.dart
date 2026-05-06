// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_location.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceLocation _$PlaceLocationFromJson(Map<String, dynamic> json) =>
    _PlaceLocation(
      id: json['id'] as String,
      placeId: json['placeId'] as String,
      coordinates: LocationData.fromJson(
        json['coordinates'] as Map<String, dynamic>,
      ),
      formattedAddress: json['formattedAddress'] as String,
      streetNumber: json['streetNumber'] as String?,
      streetName: json['streetName'] as String?,
      neighborhood: json['neighborhood'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postalCode: json['postalCode'] as String?,
      googlePlaceId: json['googlePlaceId'] as String?,
      addressComponents:
          (json['addressComponents'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      plusCode: json['plusCode'] as String?,
      createdAt: json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
      updatedAt: json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PlaceLocationToJson(_PlaceLocation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'coordinates': instance.coordinates,
      'formattedAddress': instance.formattedAddress,
      'streetNumber': instance.streetNumber,
      'streetName': instance.streetName,
      'neighborhood': instance.neighborhood,
      'city': instance.city,
      'state': instance.state,
      'country': instance.country,
      'postalCode': instance.postalCode,
      'googlePlaceId': instance.googlePlaceId,
      'addressComponents': instance.addressComponents,
      'plusCode': instance.plusCode,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'createdBy': instance.createdBy,
      'metadata': instance.metadata,
    };
