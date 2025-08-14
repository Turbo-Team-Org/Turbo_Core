import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_message.freezed.dart';
part 'ai_message.g.dart';

/// Mensaje para chat LLM (role/content), compatible con OpenAI.
@Freezed()
sealed class AiMessage with _$AiMessage {
  const factory AiMessage({
    required String role, // system|user|assistant|tool
    required String content,
  }) = _AiMessage;

  factory AiMessage.fromJson(Map<String, dynamic> json) =>
      _$AiMessageFromJson(json);
}
