// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'place.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Place _$PlaceFromJson(Map<String, dynamic> json) => _Place(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  address: json['address'] as String,
  averagePrice: (json['averagePrice'] as num).toDouble(),
  imageUrls:
      (json['imageUrls'] as List<dynamic>).map((e) => e as String).toList(),
  rating: (json['rating'] as num).toDouble(),
  reviews:
      (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
  offers:
      (json['offers'] as List<dynamic>?)
          ?.map((e) => Offer.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  isOpen: json['isOpen'] as bool? ?? false,
  schedules:
      (json['schedules'] as List<dynamic>?)
          ?.map((e) => Schedule.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  mainImage: json['mainImage'] as String? ?? '',
  favoriteCount: (json['favoriteCount'] as num?)?.toInt() ?? 0,
  menuUrl: json['menuUrl'] as String? ?? '',
  latitude: (json['latitude'] as num?)?.toDouble() ?? 0.0,
  longitude: (json['longitude'] as num?)?.toDouble() ?? 0.0,
  categoryId: json['categoryId'] as String? ?? '',
  categoryName: json['categoryName'] as String? ?? '',
  categoryIcon: json['categoryIcon'] as String? ?? '',
  openingHours:
      (json['openingHours'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, Map<String, String>.from(e as Map)),
      ) ??
      const {},
  phone: json['phone'] as String? ?? '',
  website: json['website'] as String? ?? '',
  priceLevel: (json['priceLevel'] as num?)?.toInt() ?? 0,
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
  ownerIds:
      (json['ownerIds'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  createdBy: json['createdBy'] as String? ?? '',
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  lastUpdated:
      json['lastUpdated'] == null
          ? null
          : DateTime.parse(json['lastUpdated'] as String),
);

Map<String, dynamic> _$PlaceToJson(_Place instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'address': instance.address,
  'averagePrice': instance.averagePrice,
  'imageUrls': instance.imageUrls,
  'rating': instance.rating,
  'reviews': instance.reviews,
  'offers': instance.offers,
  'tags': instance.tags,
  'isOpen': instance.isOpen,
  'schedules': instance.schedules,
  'mainImage': instance.mainImage,
  'favoriteCount': instance.favoriteCount,
  'menuUrl': instance.menuUrl,
  'latitude': instance.latitude,
  'longitude': instance.longitude,
  'categoryId': instance.categoryId,
  'categoryName': instance.categoryName,
  'categoryIcon': instance.categoryIcon,
  'openingHours': instance.openingHours,
  'phone': instance.phone,
  'website': instance.website,
  'priceLevel': instance.priceLevel,
  'metadata': instance.metadata,
  'ownerIds': instance.ownerIds,
  'createdBy': instance.createdBy,
  'createdAt': instance.createdAt?.toIso8601String(),
  'lastUpdated': instance.lastUpdated?.toIso8601String(),
};
