import 'package:core/src/turbo_core_repositories/analytics_repository/models/business_dashboard.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/date_range.dart';

/// Interface para el sistema de analytics de negocios
abstract class AnalyticsInterface {
  // ==================== DASHBOARD PRINCIPAL ====================

  /// Obtiene los datos completos del dashboard para un lugar específico
  Future<BusinessDashboard> getDashboardData(
    String placeId,
    DateRange dateRange,
  );

  /// Actualiza las métricas en tiempo real
  Future<void> updateRealTimeMetrics(String placeId);

  // ==================== MÉTRICAS ESPECÍFICAS ====================

  /// Obtiene métricas de tráfico por horas
  Future<List<HourlyData>> getHourlyTraffic(
    String placeId,
    DateRange dateRange,
  );

  /// Obtiene métricas de tráfico por días
  Future<List<DailyData>> getDailyTraffic(String placeId, DateRange dateRange);

  /// Obtiene insights detallados de las reseñas
  Future<ReviewInsights> getReviewInsights(String placeId, DateRange dateRange);

  /// Obtiene contenido y servicios más populares
  Future<PopularContent> getPopularContent(String placeId, DateRange dateRange);

  // ==================== ANÁLISIS COMPARATIVO ====================

  /// Compara métricas con el período anterior
  Future<List<ComparisonMetric>> compareWithPreviousPeriod(
    String placeId,
    DateRange currentRange,
  );

  /// Compara métricas con promedios de la industria
  Future<List<ComparisonMetric>> compareWithIndustry(
    String placeId,
    DateRange dateRange,
    String categoryId,
  );

  /// Compara métricas con competidores (si disponible)
  Future<List<ComparisonMetric>> compareWithCompetitors(
    String placeId,
    DateRange dateRange,
    List<String> competitorIds,
  );

  // ==================== ANÁLISIS PREDICTIVO ====================

  /// Predice métricas futuras basadas en datos históricos
  Future<Map<String, dynamic>> getPredictiveAnalytics(
    String placeId,
    int daysToPredict,
  );

  /// Detecta tendencias y patrones en los datos
  Future<Map<String, dynamic>> getTrendAnalysis(
    String placeId,
    DateRange dateRange,
  );

  /// Identifica oportunidades de mejora
  Future<List<String>> getImprovementOpportunities(
    String placeId,
    DateRange dateRange,
  );

  // ==================== EVENTOS Y TRACKING ====================

  /// Registra una visita/interacción para analytics
  Future<void> trackVisit(String placeId, Map<String, dynamic> metadata);

  /// Registra una conversión (favorito, reserva, etc.)
  Future<void> trackConversion(
    String placeId,
    String conversionType,
    Map<String, dynamic> metadata,
  );

  /// Registra tiempo de sesión
  Future<void> trackSessionDuration(
    String placeId,
    Duration sessionDuration,
    Map<String, dynamic> metadata,
  );

  // ==================== REPORTES PERSONALIZADOS ====================

  /// Genera un reporte personalizado
  Future<Map<String, dynamic>> generateCustomReport(
    String placeId,
    DateRange dateRange,
    List<String> selectedMetrics,
    String reportFormat, // 'json', 'pdf', 'excel'
  );

  /// Exporta datos de analytics en formato específico
  Future<String> exportAnalyticsData(
    String placeId,
    DateRange dateRange,
    String format, // 'json', 'csv', 'excel'
  );

  // ==================== CONFIGURACIÓN Y ALERTAS ====================

  /// Configura alertas automáticas para métricas específicas
  Future<void> setupMetricAlert(
    String placeId,
    String metricName,
    double threshold,
    String alertType, // 'email', 'push', 'sms'
  );

  /// Obtiene configuración de alertas existentes
  Future<List<Map<String, dynamic>>> getMetricAlerts(String placeId);

  /// Elimina una alerta específica
  Future<void> removeMetricAlert(String placeId, String alertId);

  // ==================== ANÁLISIS DE SENTIMIENTOS ====================

  /// Analiza sentimientos de las reseñas recientes
  Future<SentimentAnalysis> analyzeSentiments(
    String placeId,
    DateRange dateRange,
  );

  /// Obtiene palabras clave más mencionadas
  Future<List<String>> getTopKeywords(
    String placeId,
    DateRange dateRange, {
    int limit = 10,
  });

  /// Detecta problemas recurrentes en las reseñas
  Future<List<String>> detectCommonIssues(String placeId, DateRange dateRange);

  // ==================== ESTADÍSTICAS AVANZADAS ====================

  /// Calcula el Customer Lifetime Value
  Future<double> calculateCustomerLifetimeValue(String placeId);

  /// Calcula la tasa de retención de clientes
  Future<double> calculateRetentionRate(String placeId, DateRange dateRange);

  /// Obtiene métricas de engagement del usuario
  Future<Map<String, double>> getUserEngagementMetrics(
    String placeId,
    DateRange dateRange,
  );

  /// Analiza el journey del cliente
  Future<Map<String, dynamic>> analyzeCustomerJourney(
    String placeId,
    DateRange dateRange,
  );

  // ==================== MÉTRICAS DE PERFORMANCE ====================

  /// Obtiene tiempo de carga promedio de la página del lugar
  Future<double> getAverageLoadTime(String placeId, DateRange dateRange);

  /// Analiza dispositivos más utilizados
  Future<Map<String, int>> getDeviceAnalytics(
    String placeId,
    DateRange dateRange,
  );

  /// Obtiene datos de ubicación de los visitantes
  Future<Map<String, int>> getGeoAnalytics(String placeId, DateRange dateRange);

  // ==================== INICIALIZACIÓN Y LIMPIEZA ====================

  /// Inicializa la estructura completa de analytics para un lugar nuevo
  /// Este método debe ser llamado automáticamente cuando se crea un lugar
  Future<void> initializeAnalyticsStructure(String placeId);

  /// Limpia completamente la estructura de analytics de un lugar
  /// Útil para testing o cuando se elimina un lugar
  Future<void> cleanupAnalyticsStructure(String placeId);
}
