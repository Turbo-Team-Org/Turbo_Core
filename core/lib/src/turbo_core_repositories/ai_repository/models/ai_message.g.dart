// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_message.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiMessage _$AiMessageFromJson(Map<String, dynamic> json) => _AiMessage(
  role: json['role'] as String,
  content: json['content'] as String,
);

Map<String, dynamic> _$AiMessageToJson(_AiMessage instance) =>
    <String, dynamic>{'role': instance.role, 'content': instance.content};
