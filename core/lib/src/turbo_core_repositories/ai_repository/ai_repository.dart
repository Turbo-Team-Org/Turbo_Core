import 'package:core/src/turbo_core_repositories/ai_repository/interface/ai_interface.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_chat_response.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_message.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';

/// Repositorio de alto nivel para operaciones de IA.
class AiRepository {
  AiRepository({required this.aiService});

  final AiInterface aiService;

  Future<AiChatResponse> chatCompletion({
    required List<AiMessage> messages,
    String? model,
    String? systemPrompt,
    double temperature = 0.7,
    Map<String, dynamic>? metadata,
  }) {
    return aiService.chatCompletion(
      messages: messages,
      model: model,
      systemPrompt: systemPrompt,
      temperature: temperature,
      metadata: metadata,
    );
  }

  Future<String> generatePlaceDescription({
    required Place place,
    String? tone,
    String language = 'es',
  }) {
    return aiService.generatePlaceDescription(
      place: place,
      tone: tone,
      language: language,
    );
  }

  Future<List<String>> generateTagsForPlace({
    required Place place,
    int maxTags = 8,
    String language = 'es',
  }) {
    return aiService.generateTagsForPlace(
      place: place,
      maxTags: maxTags,
      language: language,
    );
  }

  Future<String> summarizeReviewsText({
    required String reviewsText,
    int maxWords = 120,
    String language = 'es',
  }) {
    return aiService.summarizeReviewsText(
      reviewsText: reviewsText,
      maxWords: maxWords,
      language: language,
    );
  }

  Future<bool> moderateText({required String text}) {
    return aiService.moderateText(text: text);
  }

  Future<String> translateText({
    required String text,
    required String targetLanguage,
  }) {
    return aiService.translateText(text: text, targetLanguage: targetLanguage);
  }
}
