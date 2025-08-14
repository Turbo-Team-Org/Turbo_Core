// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_chat_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AiChatResponse _$AiChatResponseFromJson(Map<String, dynamic> json) =>
    _AiChatResponse(
      id: json['id'] as String,
      model: json['model'] as String,
      content: json['content'] as String,
      metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
    );

Map<String, dynamic> _$AiChatResponseToJson(_AiChatResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'model': instance.model,
      'content': instance.content,
      'metadata': instance.metadata,
    };
