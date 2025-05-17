// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Event _$EventFromJson(Map<String, dynamic> json) => _Event(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  date: DateTime.parse(json['date'] as String),
  location: json['location'] as String,
  imageUrl: json['imageUrl'] as String,
  type: $enumDecode(_$EventTypeEnumMap, json['type']),
  placeId: json['placeId'] as String?,
  price: (json['price'] as num?)?.toDouble(),
  isHighlighted: json['isHighlighted'] as bool? ?? false,
  tags:
      (json['tags'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
  organizerName: json['organizerName'] as String?,
  organizerContact: json['organizerContact'] as String?,
  endDate:
      json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
  link: json['link'] as String?,
);

Map<String, dynamic> _$EventToJson(_Event instance) => <String, dynamic>{
  'id': instance.id,
  'title': instance.title,
  'description': instance.description,
  'date': instance.date.toIso8601String(),
  'location': instance.location,
  'imageUrl': instance.imageUrl,
  'type': _$EventTypeEnumMap[instance.type]!,
  'placeId': instance.placeId,
  'price': instance.price,
  'isHighlighted': instance.isHighlighted,
  'tags': instance.tags,
  'organizerName': instance.organizerName,
  'organizerContact': instance.organizerContact,
  'endDate': instance.endDate?.toIso8601String(),
  'link': instance.link,
};

const _$EventTypeEnumMap = {
  EventType.party: 'party',
  EventType.concert: 'concert',
  EventType.promotion: 'promotion',
  EventType.offer: 'offer',
  EventType.cultural: 'cultural',
};
