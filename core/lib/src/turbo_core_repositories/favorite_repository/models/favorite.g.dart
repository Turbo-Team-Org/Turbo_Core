// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Favorite _$FavoriteFromJson(Map<String, dynamic> json) => _Favorite(
  id: json['id'] as String,
  userId: json['userId'] as String,
  placeId: json['placeId'] as String,
  date: DateTime.parse(json['date'] as String),
  place:
      json['place'] == null
          ? null
          : Place.fromJson(json['place'] as Map<String, dynamic>),
);

Map<String, dynamic> _$FavoriteToJson(_Favorite instance) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'placeId': instance.placeId,
  'date': instance.date.toIso8601String(),
  'place': instance.place,
};
