import 'dart:convert';

import 'package:core/src/turbo_core_repositories/ai_repository/interface/ai_interface.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_chat_response.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_message.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Implementación que llama a un RPC/Function de Supabase (p.e. http request proxy)
class AiServiceSupabase implements AiInterface {
  AiServiceSupabase({required this.supabase});

  final SupabaseClient supabase;

  @override
  Future<AiChatResponse> chatCompletion({
    required List<AiMessage> messages,
    String? model,
    String? systemPrompt,
    double temperature = 0.7,
    Map<String, dynamic>? metadata,
  }) async {
    final payload = {
      'model': model,
      'system': systemPrompt,
      'temperature': temperature,
      'messages': messages.map((m) => m.toJson()).toList(),
      'metadata': metadata ?? <String, dynamic>{},
    };
    final res = await supabase.functions.invoke(
      'ai_chat_completion',
      body: jsonEncode(payload),
    );
    return AiChatResponse.fromJson(
      (res.data as Map<String, dynamic>? ?? <String, dynamic>{}),
    );
  }

  @override
  Future<String> generatePlaceDescription({
    required Place place,
    String? tone,
    String language = 'es',
  }) async {
    final res = await supabase.functions.invoke(
      'ai_generate_place_description',
      body: jsonEncode({
        'place': place.toJson(),
        'tone': tone,
        'language': language,
      }),
    );
    return (res.data as Map<String, dynamic>? ?? {})['content'] as String? ??
        '';
  }

  @override
  Future<List<String>> generateTagsForPlace({
    required Place place,
    int maxTags = 8,
    String language = 'es',
  }) async {
    final res = await supabase.functions.invoke(
      'ai_generate_place_tags',
      body: jsonEncode({
        'place': place.toJson(),
        'maxTags': maxTags,
        'language': language,
      }),
    );
    final list = (res.data as List<dynamic>? ?? <dynamic>[]);
    return list.map((e) => e.toString()).toList();
  }

  @override
  Future<String> summarizeReviewsText({
    required String reviewsText,
    int maxWords = 120,
    String language = 'es',
  }) async {
    final res = await supabase.functions.invoke(
      'ai_summarize_reviews',
      body: jsonEncode({
        'text': reviewsText,
        'maxWords': maxWords,
        'language': language,
      }),
    );
    return (res.data as Map<String, dynamic>? ?? {})['summary'] as String? ??
        '';
  }

  @override
  Future<bool> moderateText({required String text}) async {
    final res = await supabase.functions.invoke(
      'ai_moderate_text',
      body: jsonEncode({'text': text}),
    );
    return (res.data as Map<String, dynamic>? ?? {})['allowed'] as bool? ??
        true;
  }

  @override
  Future<String> translateText({
    required String text,
    required String targetLanguage,
  }) async {
    final res = await supabase.functions.invoke(
      'ai_translate_text',
      body: jsonEncode({'text': text, 'targetLanguage': targetLanguage}),
    );
    return (res.data as Map<String, dynamic>? ?? {})['content'] as String? ??
        '';
  }
}
