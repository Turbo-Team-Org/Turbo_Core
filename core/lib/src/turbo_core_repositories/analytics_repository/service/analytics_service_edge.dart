import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/business_dashboard.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/date_range.dart';
import 'package:dio/dio.dart';

class AnalyticsServiceEdge implements AnalyticsInterface {
  AnalyticsServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  String _url(String path) => '$baseUrl$path';

  @override
  Future<BusinessDashboard> getDashboardData(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_get_dashboard'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return BusinessDashboard.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<void> updateRealTimeMetrics(String placeId) async {
    await httpClient.post<void>(
      _url('/analytics_update_realtime'),
      data: {'placeId': placeId},
    );
  }

  @override
  Future<List<HourlyData>> getHourlyTraffic(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_hourly_traffic'),
      queryParameters: {
        'placeId': placeId,
        'start': dateRange.startDate.toIso8601String(),
        'end': dateRange.endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => HourlyData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<DailyData>> getDailyTraffic(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_daily_traffic'),
      queryParameters: {
        'placeId': placeId,
        'start': dateRange.startDate.toIso8601String(),
        'end': dateRange.endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => DailyData.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<ReviewInsights> getReviewInsights(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_review_insights'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return ReviewInsights.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<PopularContent> getPopularContent(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_popular_content'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return PopularContent.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<List<ComparisonMetric>> compareWithPreviousPeriod(
    String placeId,
    DateRange currentRange,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_compare_previous'),
      queryParameters: {
        'placeId': placeId,
        'start': currentRange.startDate.toIso8601String(),
        'end': currentRange.endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => ComparisonMetric.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ComparisonMetric>> compareWithIndustry(
    String placeId,
    DateRange dateRange,
    String categoryId,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_compare_industry'),
      queryParameters: {
        'placeId': placeId,
        'categoryId': categoryId,
        'start': dateRange.startDate.toIso8601String(),
        'end': dateRange.endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => ComparisonMetric.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ComparisonMetric>> compareWithCompetitors(
    String placeId,
    DateRange dateRange,
    List<String> competitorIds,
  ) async {
    final Response<List<dynamic>> res = await httpClient.post<List<dynamic>>(
      _url('/analytics_compare_competitors'),
      data: {
        'placeId': placeId,
        'competitorIds': competitorIds,
        'start': dateRange.startDate.toIso8601String(),
        'end': dateRange.endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => ComparisonMetric.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Map<String, dynamic>> getPredictiveAnalytics(
    String placeId,
    int daysToPredict,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_predictive'),
          queryParameters: {'placeId': placeId, 'days': daysToPredict},
        );
    return res.data ?? <String, dynamic>{};
  }

  @override
  Future<Map<String, dynamic>> getTrendAnalysis(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_trends'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return res.data ?? <String, dynamic>{};
  }

  @override
  Future<List<String>> getImprovementOpportunities(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_improvements'),
      queryParameters: {
        'placeId': placeId,
        'start': dateRange.startDate.toIso8601String(),
        'end': dateRange.endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items.map((e) => e.toString()).toList();
  }

  @override
  Future<void> trackVisit(String placeId, Map<String, dynamic> metadata) async {
    await httpClient.post<void>(
      _url('/analytics_track_visit'),
      data: {'placeId': placeId, 'metadata': metadata},
    );
  }

  @override
  Future<void> trackConversion(
    String placeId,
    String conversionType,
    Map<String, dynamic> metadata,
  ) async {
    await httpClient.post<void>(
      _url('/analytics_track_conversion'),
      data: {
        'placeId': placeId,
        'conversionType': conversionType,
        'metadata': metadata,
      },
    );
  }

  @override
  Future<void> trackSessionDuration(
    String placeId,
    Duration sessionDuration,
    Map<String, dynamic> metadata,
  ) async {
    await httpClient.post<void>(
      _url('/analytics_track_session'),
      data: {
        'placeId': placeId,
        'durationSeconds': sessionDuration.inSeconds,
        'metadata': metadata,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> generateCustomReport(
    String placeId,
    DateRange dateRange,
    List<String> selectedMetrics,
    String reportFormat,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/analytics_generate_report'),
          data: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
            'metrics': selectedMetrics,
            'format': reportFormat,
          },
        );
    return res.data ?? <String, dynamic>{};
  }

  @override
  Future<String> exportAnalyticsData(
    String placeId,
    DateRange dateRange,
    String format,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_export_data'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
            'format': format,
          },
        );
    return (res.data?['url'] as String?) ?? '';
  }

  @override
  Future<void> setupMetricAlert(
    String placeId,
    String metricName,
    double threshold,
    String alertType,
  ) async {
    await httpClient.post<void>(
      _url('/analytics_setup_alert'),
      data: {
        'placeId': placeId,
        'metricName': metricName,
        'threshold': threshold,
        'alertType': alertType,
      },
    );
  }

  @override
  Future<List<Map<String, dynamic>>> getMetricAlerts(String placeId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_get_alerts'),
      queryParameters: {'placeId': placeId},
    );
    final items = res.data ?? <dynamic>[];
    return items.map((e) => (e as Map).cast<String, dynamic>()).toList();
  }

  @override
  Future<void> removeMetricAlert(String placeId, String alertId) async {
    await httpClient.post<void>(
      _url('/analytics_remove_alert'),
      data: {'placeId': placeId, 'alertId': alertId},
    );
  }

  @override
  Future<SentimentAnalysis> analyzeSentiments(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_sentiments'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return SentimentAnalysis.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<List<String>> getTopKeywords(
    String placeId,
    DateRange dateRange, {
    int limit = 10,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_top_keywords'),
      queryParameters: {
        'placeId': placeId,
        'start': dateRange.startDate.toIso8601String(),
        'end': dateRange.endDate.toIso8601String(),
        'limit': limit,
      },
    );
    final items = res.data ?? <dynamic>[];
    return items.map((e) => e.toString()).toList();
  }

  @override
  Future<List<String>> detectCommonIssues(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/analytics_common_issues'),
      queryParameters: {
        'placeId': placeId,
        'start': dateRange.startDate.toIso8601String(),
        'end': dateRange.endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items.map((e) => e.toString()).toList();
  }

  @override
  Future<double> calculateCustomerLifetimeValue(String placeId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_clv'),
          queryParameters: {'placeId': placeId},
        );
    return (res.data?['clv'] as num?)?.toDouble() ?? 0.0;
  }

  @override
  Future<double> calculateRetentionRate(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_retention_rate'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return (res.data?['retentionRate'] as num?)?.toDouble() ?? 0.0;
  }

  @override
  Future<Map<String, double>> getUserEngagementMetrics(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_user_engagement'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    final data = res.data ?? <String, dynamic>{};
    return data.map((key, value) => MapEntry(key, (value as num).toDouble()));
  }

  @override
  Future<Map<String, dynamic>> analyzeCustomerJourney(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_customer_journey'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return res.data ?? <String, dynamic>{};
  }

  @override
  Future<double> getAverageLoadTime(String placeId, DateRange dateRange) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_average_load_time'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    return (res.data?['avgLoadTime'] as num?)?.toDouble() ?? 0.0;
  }

  @override
  Future<Map<String, int>> getDeviceAnalytics(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_device_analytics'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    final data = res.data ?? <String, dynamic>{};
    return data.map((k, v) => MapEntry(k, (v as num?)?.toInt() ?? 0));
  }

  @override
  Future<Map<String, int>> getGeoAnalytics(
    String placeId,
    DateRange dateRange,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/analytics_geo_analytics'),
          queryParameters: {
            'placeId': placeId,
            'start': dateRange.startDate.toIso8601String(),
            'end': dateRange.endDate.toIso8601String(),
          },
        );
    final data = res.data ?? <String, dynamic>{};
    return data.map((k, v) => MapEntry(k, (v as num?)?.toInt() ?? 0));
  }

  @override
  Future<void> initializeAnalyticsStructure(String placeId) async {
    await httpClient.post<void>(
      _url('/analytics_initialize_structure'),
      data: {'placeId': placeId},
    );
  }

  @override
  Future<void> cleanupAnalyticsStructure(String placeId) async {
    await httpClient.post<void>(
      _url('/analytics_cleanup_structure'),
      data: {'placeId': placeId},
    );
  }
}
