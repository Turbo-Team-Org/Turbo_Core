// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'distance_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DistanceResult _$DistanceResultFromJson(Map<String, dynamic> json) =>
    _DistanceResult(
      distanceKm: (json['distanceKm'] as num).toDouble(),
      distanceMeters: (json['distanceMeters'] as num).toDouble(),
      formattedDistance: json['formattedDistance'] as String,
      estimatedTravelTime: Duration(
        microseconds: (json['estimatedTravelTime'] as num).toInt(),
      ),
      travelMode: json['travelMode'] as String?,
      additionalInfo: json['additionalInfo'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$DistanceResultToJson(_DistanceResult instance) =>
    <String, dynamic>{
      'distanceKm': instance.distanceKm,
      'distanceMeters': instance.distanceMeters,
      'formattedDistance': instance.formattedDistance,
      'estimatedTravelTime': instance.estimatedTravelTime.inMicroseconds,
      'travelMode': instance.travelMode,
      'additionalInfo': instance.additionalInfo,
    };

_NearbySearchResult _$NearbySearchResultFromJson(Map<String, dynamic> json) =>
    _NearbySearchResult(
      placeId: json['placeId'] as String,
      name: json['name'] as String,
      distance: DistanceResult.fromJson(
        json['distance'] as Map<String, dynamic>,
      ),
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      address: json['address'] as String?,
      rating: (json['rating'] as num?)?.toDouble(),
      types:
          (json['types'] as List<dynamic>?)?.map((e) => e as String).toList() ??
          const [],
      photoReference: json['photoReference'] as String?,
      additionalData: json['additionalData'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$NearbySearchResultToJson(_NearbySearchResult instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'name': instance.name,
      'distance': instance.distance,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'address': instance.address,
      'rating': instance.rating,
      'types': instance.types,
      'photoReference': instance.photoReference,
      'additionalData': instance.additionalData,
    };

_ProximityFilter _$ProximityFilterFromJson(Map<String, dynamic> json) =>
    _ProximityFilter(
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      radiusMeters: (json['radiusMeters'] as num?)?.toDouble() ?? 5000,
      limit: (json['limit'] as num?)?.toInt() ?? 10,
      categories:
          (json['categories'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      excludeIds:
          (json['excludeIds'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      sortBy: json['sortBy'] as String?,
      minRating: (json['minRating'] as num?)?.toDouble(),
      openNow: json['openNow'] as bool?,
    );

Map<String, dynamic> _$ProximityFilterToJson(_ProximityFilter instance) =>
    <String, dynamic>{
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'radiusMeters': instance.radiusMeters,
      'limit': instance.limit,
      'categories': instance.categories,
      'excludeIds': instance.excludeIds,
      'sortBy': instance.sortBy,
      'minRating': instance.minRating,
      'openNow': instance.openNow,
    };
