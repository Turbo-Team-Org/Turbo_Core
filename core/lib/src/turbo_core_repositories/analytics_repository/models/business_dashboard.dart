import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/date_range.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/kpi_metric.dart';

part 'business_dashboard.freezed.dart';
part 'business_dashboard.g.dart';

/// Modelo principal del dashboard de negocio con todas las métricas
@freezed
sealed class BusinessDashboard with _$BusinessDashboard {
  /// Constructor
  const factory BusinessDashboard({
    required String placeId,
    required String placeName,
    required DateRange dateRange,
    required List<KpiMetric> kpiMetrics,
    required DashboardSummary summary,
    required List<HourlyData> hourlyTraffic,
    required List<DailyData> dailyTraffic,
    required ReviewInsights reviewInsights,
    required PopularContent popularContent,
    @Default([]) List<ComparisonMetric> comparisons,
    required DateTime lastUpdated,
    Map<String, dynamic>? metadata,
  }) = _BusinessDashboard;

  /// Constructor desde JSON
  factory BusinessDashboard.fromJson(Map<String, dynamic> json) =>
      _$BusinessDashboardFromJson(json);

  /// Constructor desde datos de Firestore
  factory BusinessDashboard.fromFirestore(Map<String, dynamic> data) {
    return BusinessDashboard.fromJson(data);
  }
}

/// Resumen general del dashboard
@freezed
sealed class DashboardSummary with _$DashboardSummary {
  /// Constructor
  const factory DashboardSummary({
    required int totalViews,
    required int uniqueVisitors,
    required double averageRating,
    required int totalReviews,
    required int totalFavorites,
    required double conversionRate,
    required int totalEvents,
    required double avgSessionDuration,
    @Default(0) int previousTotalViews,
    @Default(0) int previousUniqueVisitors,
    @Default(0.0) double previousAverageRating,
    @Default(0) int previousTotalReviews,
  }) = _DashboardSummary;

  /// Constructor desde JSON
  factory DashboardSummary.fromJson(Map<String, dynamic> json) =>
      _$DashboardSummaryFromJson(json);
}

/// Datos de tráfico por hora
@freezed
sealed class HourlyData with _$HourlyData {
  /// Constructor
  const factory HourlyData({
    required int hour,
    required int views,
    required int uniqueVisitors,
    required DateTime date,
    @Default(0) int interactions,
  }) = _HourlyData;

  /// Constructor desde JSON
  factory HourlyData.fromJson(Map<String, dynamic> json) =>
      _$HourlyDataFromJson(json);
}

/// Datos de tráfico por día
@freezed
sealed class DailyData with _$DailyData {
  /// Constructor
  const factory DailyData({
    required DateTime date,
    required int views,
    required int uniqueVisitors,
    required int newReviews,
    required int newFavorites,
    @Default(0) int interactions,
    @Default(0.0) double avgRating,
  }) = _DailyData;

  /// Constructor desde JSON
  factory DailyData.fromJson(Map<String, dynamic> json) =>
      _$DailyDataFromJson(json);
}

/// Insights de las reseñas
@freezed
sealed class ReviewInsights with _$ReviewInsights {
  /// Constructor
  const factory ReviewInsights({
    required int totalReviews,
    required double averageRating,
    required Map<int, int> ratingDistribution,
    required List<String> topKeywords,
    required List<String> topComplaints,
    required List<String> topPraises,
    required SentimentAnalysis sentimentAnalysis,
    @Default(0) int pendingReviews,
    @Default(0) int thisWeekReviews,
  }) = _ReviewInsights;

  /// Constructor desde JSON
  factory ReviewInsights.fromJson(Map<String, dynamic> json) =>
      _$ReviewInsightsFromJson(json);
}

/// Análisis de sentimientos
@freezed
sealed class SentimentAnalysis with _$SentimentAnalysis {
  /// Constructor
  const factory SentimentAnalysis({
    required double positiveScore,
    required double neutralScore,
    required double negativeScore,
    required SentimentTrend trend,
    @Default([]) List<String> positiveKeywords,
    @Default([]) List<String> negativeKeywords,
  }) = _SentimentAnalysis;

  /// Constructor desde JSON
  factory SentimentAnalysis.fromJson(Map<String, dynamic> json) =>
      _$SentimentAnalysisFromJson(json);
}

/// Contenido popular (productos, servicios, etc.)
@freezed
sealed class PopularContent with _$PopularContent {
  /// Constructor
  const factory PopularContent({
    required List<PopularItem> topCategories,
    required List<PopularItem> topProducts,
    required List<PopularItem> topServices,
    required List<PopularItem> topOffers,
    @Default([]) List<PopularItem> topSearchTerms,
  }) = _PopularContent;

  /// Constructor desde JSON
  factory PopularContent.fromJson(Map<String, dynamic> json) =>
      _$PopularContentFromJson(json);
}

/// Item popular genérico
@freezed
sealed class PopularItem with _$PopularItem {
  /// Constructor
  const factory PopularItem({
    required String id,
    required String name,
    required int count,
    required double percentage,
    Map<String, dynamic>? metadata,
  }) = _PopularItem;

  /// Constructor desde JSON
  factory PopularItem.fromJson(Map<String, dynamic> json) =>
      _$PopularItemFromJson(json);
}

/// Métrica de comparación
@freezed
sealed class ComparisonMetric with _$ComparisonMetric {
  /// Constructor
  const factory ComparisonMetric({
    required String metricName,
    required double currentValue,
    required double compareValue,
    required String compareLabel,
    required ComparisonType type,
  }) = _ComparisonMetric;

  /// Constructor desde JSON
  factory ComparisonMetric.fromJson(Map<String, dynamic> json) =>
      _$ComparisonMetricFromJson(json);
}

/// Tendencia de sentimientos
enum SentimentTrend { improving, declining, stable }

/// Tipo de comparación
enum ComparisonType { previousPeriod, industry, competitor, goal }
