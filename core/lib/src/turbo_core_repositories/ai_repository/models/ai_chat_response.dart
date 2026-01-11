import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_chat_response.freezed.dart';
part 'ai_chat_response.g.dart';

/// Respuesta estándar del modelo de chat.
@Freezed()
sealed class AiChatResponse with _$AiChatResponse {
  const factory AiChatResponse({
    required String id,
    required String model,
    required String content,
    @Default({}) Map<String, dynamic> metadata,
  }) = _AiChatResponse;

  factory AiChatResponse.fromJson(Map<String, dynamic> json) =>
      _$AiChatResponseFromJson(json);
}
