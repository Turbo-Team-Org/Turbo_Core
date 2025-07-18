import 'package:supabase_flutter/supabase_flutter.dart';
// Importa la interfaz y modelos necesarios
// import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
// import 'package:core/src/turbo_core_repositories/analytics_repository/models/analytics_event.dart';

/// Servicio de analíticas usando Supabase
/// Implementa la misma interfaz que AnalyticsService (Firebase)
class AnalyticsServiceSupabase /* implements AnalyticsInterface */ {
  AnalyticsServiceSupabase({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabase;

  // TODO: Implementar todos los métodos de AnalyticsInterface aquí
  // Ejemplo:
  // Future<void> logEvent(AnalyticsEvent event) async {
  //   throw UnimplementedError();
  // }
}
