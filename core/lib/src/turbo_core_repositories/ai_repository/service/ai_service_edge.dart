import 'package:core/src/turbo_core_repositories/ai_repository/interface/ai_interface.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_chat_response.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_message.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:dio/dio.dart';

class AiServiceEdge implements AiInterface {
  AiServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;

  String _url(String path) => '$baseUrl$path';

  @override
  Future<AiChatResponse> chatCompletion({
    required List<AiMessage> messages,
    String? model,
    String? systemPrompt,
    double temperature = 0.7,
    Map<String, dynamic>? metadata,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient.post(
      _url('/ai_chat_completion'),
      data: {
        'model': model,
        'system': systemPrompt,
        'temperature': temperature,
        'messages': messages.map((m) => m.toJson()).toList(),
        'metadata': metadata ?? <String, dynamic>{},
      },
    );
    final data = res.data ?? <String, dynamic>{};
    return AiChatResponse.fromJson(data);
  }

  @override
  Future<String> generatePlaceDescription({
    required Place place,
    String? tone,
    String language = 'es',
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient.post(
      _url('/ai_generate_place_description'),
      data: {'place': place.toJson(), 'tone': tone, 'language': language},
    );
    return (res.data?['content'] as String?) ?? '';
  }

  @override
  Future<List<String>> generateTagsForPlace({
    required Place place,
    int maxTags = 8,
    String language = 'es',
  }) async {
    final Response<List<dynamic>> res = await httpClient.post(
      _url('/ai_generate_place_tags'),
      data: {'place': place.toJson(), 'maxTags': maxTags, 'language': language},
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => e.toString()).toList();
  }

  @override
  Future<String> summarizeReviewsText({
    required String reviewsText,
    int maxWords = 120,
    String language = 'es',
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient.post(
      _url('/ai_summarize_reviews'),
      data: {'text': reviewsText, 'maxWords': maxWords, 'language': language},
    );
    return (res.data?['summary'] as String?) ?? '';
  }

  @override
  Future<bool> moderateText({required String text}) async {
    final Response<Map<String, dynamic>> res = await httpClient.post(
      _url('/ai_moderate_text'),
      data: {'text': text},
    );
    return (res.data?['allowed'] as bool?) ?? true;
  }

  @override
  Future<String> translateText({
    required String text,
    required String targetLanguage,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient.post(
      _url('/ai_translate_text'),
      data: {'text': text, 'targetLanguage': targetLanguage},
    );
    return (res.data?['content'] as String?) ?? '';
  }
}
