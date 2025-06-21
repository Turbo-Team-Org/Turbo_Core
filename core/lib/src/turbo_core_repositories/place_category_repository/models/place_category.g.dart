// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place_category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PlaceCategory _$PlaceCategoryFromJson(Map<String, dynamic> json) =>
    _PlaceCategory(
      placeId: json['placeId'] as String,
      categoryId: json['categoryId'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      createdBy: json['createdBy'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PlaceCategoryToJson(_PlaceCategory instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'categoryId': instance.categoryId,
      'createdAt': instance.createdAt.toIso8601String(),
      'createdBy': instance.createdBy,
      'metadata': instance.metadata,
    };
