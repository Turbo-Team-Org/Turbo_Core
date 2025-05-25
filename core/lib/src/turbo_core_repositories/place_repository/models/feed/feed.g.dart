// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'feed.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Feed _$FeedFromJson(Map<String, dynamic> json) => _Feed(
  id: (json['id'] as num).toInt(),
  author: json['author'] as String,
  content: json['content'] as String,
  imageUrl: json['imageUrl'] as String,
  timestamp: DateTime.parse(json['timestamp'] as String),
);

Map<String, dynamic> _$FeedToJson(_Feed instance) => <String, dynamic>{
  'id': instance.id,
  'author': instance.author,
  'content': instance.content,
  'imageUrl': instance.imageUrl,
  'timestamp': instance.timestamp.toIso8601String(),
};
