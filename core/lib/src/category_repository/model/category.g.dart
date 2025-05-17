// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Category _$CategoryFromJson(Map<String, dynamic> json) => _Category(
  id: json['id'] as String,
  name: json['name'] as String,
  icon: json['icon'] as String,
  description: json['description'] as String?,
  imageUrl: json['imageUrl'] as String?,
  placesCount: (json['placesCount'] as num?)?.toInt() ?? 0,
  isFeatured: json['isFeatured'] as bool? ?? false,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$CategoryToJson(_Category instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'icon': instance.icon,
  'description': instance.description,
  'imageUrl': instance.imageUrl,
  'placesCount': instance.placesCount,
  'isFeatured': instance.isFeatured,
  'metadata': instance.metadata,
};
