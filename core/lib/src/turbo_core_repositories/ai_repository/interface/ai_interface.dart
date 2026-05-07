import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_chat_response.dart';
import 'package:core/src/turbo_core_repositories/ai_repository/models/ai_message.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';

/// Interfaz base para servicios de IA (OpenAI/DeepSeek/LLM-compatible).
abstract class AiInterface {
  /// Chat general con el asistente (OpenAI-compatible `chat/completions`).
  Future<AiChatResponse> chatCompletion({
    required List<AiMessage> messages,
    String? model,
    String? systemPrompt,
    double temperature,
    Map<String, dynamic>? metadata,
  });

  /// Genera una descripción de marketing para un `Place`.
  Future<String> generatePlaceDescription({
    required Place place,
    String? tone,
    String language,
  });

  /// Sugiere tags para un `Place`.
  Future<List<String>> generateTagsForPlace({
    required Place place,
    int maxTags,
    String language,
  });

  /// Resume reseñas de un lugar (texto ya agregado) en lenguaje natural.
  Future<String> summarizeReviewsText({
    required String reviewsText,
    int maxWords,
    String language,
  });

  /// Moderación básica de contenido.
  Future<bool> moderateText({required String text});

  /// Traducción de texto usando el modelo genérico (si aplica).
  Future<String> translateText({
    required String text,
    required String targetLanguage,
  });
}
