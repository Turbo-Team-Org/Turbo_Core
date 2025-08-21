import 'package:dio/dio.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Crea un cliente Dio configurado para consumir Supabase Edge Functions.
/// - Inyecta Authorization Bearer si existe sesión en Supabase.
/// - Configura timeouts sensatos para red inestable.
Dio createEdgeHttpClient({
  SupabaseClient? supabaseClient,
  Duration connectTimeout = const Duration(seconds: 10),
  Duration sendTimeout = const Duration(seconds: 20),
  Duration receiveTimeout = const Duration(seconds: 20),
}) {
  final dio = Dio(
    BaseOptions(
      connectTimeout: connectTimeout,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      headers: {'Content-Type': 'application/json'},
    ),
  );

  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (options, handler) {
        try {
          final token =
              supabaseClient?.auth.currentSession?.accessToken?.trim();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        } catch (_) {
          // No-op si no hay sesión
        }
        handler.next(options);
      },
    ),
  );

  return dio;
}

