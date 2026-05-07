// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_dashboard.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessDashboard _$BusinessDashboardFromJson(Map<String, dynamic> json) =>
    _BusinessDashboard(
      placeId: json['placeId'] as String,
      placeName: json['placeName'] as String,
      dateRange: DateRange.fromJson(json['dateRange'] as Map<String, dynamic>),
      kpiMetrics: (json['kpiMetrics'] as List<dynamic>)
          .map((e) => KpiMetric.fromJson(e as Map<String, dynamic>))
          .toList(),
      summary: DashboardSummary.fromJson(
        json['summary'] as Map<String, dynamic>,
      ),
      hourlyTraffic: (json['hourlyTraffic'] as List<dynamic>)
          .map((e) => HourlyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      dailyTraffic: (json['dailyTraffic'] as List<dynamic>)
          .map((e) => DailyData.fromJson(e as Map<String, dynamic>))
          .toList(),
      reviewInsights: ReviewInsights.fromJson(
        json['reviewInsights'] as Map<String, dynamic>,
      ),
      popularContent: PopularContent.fromJson(
        json['popularContent'] as Map<String, dynamic>,
      ),
      comparisons:
          (json['comparisons'] as List<dynamic>?)
              ?.map((e) => ComparisonMetric.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      lastUpdated: DateTime.parse(json['lastUpdated'] as String),
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$BusinessDashboardToJson(_BusinessDashboard instance) =>
    <String, dynamic>{
      'placeId': instance.placeId,
      'placeName': instance.placeName,
      'dateRange': instance.dateRange,
      'kpiMetrics': instance.kpiMetrics,
      'summary': instance.summary,
      'hourlyTraffic': instance.hourlyTraffic,
      'dailyTraffic': instance.dailyTraffic,
      'reviewInsights': instance.reviewInsights,
      'popularContent': instance.popularContent,
      'comparisons': instance.comparisons,
      'lastUpdated': instance.lastUpdated.toIso8601String(),
      'metadata': instance.metadata,
    };

_DashboardSummary _$DashboardSummaryFromJson(Map<String, dynamic> json) =>
    _DashboardSummary(
      totalViews: (json['totalViews'] as num).toInt(),
      uniqueVisitors: (json['uniqueVisitors'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      totalReviews: (json['totalReviews'] as num).toInt(),
      totalFavorites: (json['totalFavorites'] as num).toInt(),
      conversionRate: (json['conversionRate'] as num).toDouble(),
      totalEvents: (json['totalEvents'] as num).toInt(),
      avgSessionDuration: (json['avgSessionDuration'] as num).toDouble(),
      previousTotalViews: (json['previousTotalViews'] as num?)?.toInt() ?? 0,
      previousUniqueVisitors:
          (json['previousUniqueVisitors'] as num?)?.toInt() ?? 0,
      previousAverageRating:
          (json['previousAverageRating'] as num?)?.toDouble() ?? 0.0,
      previousTotalReviews:
          (json['previousTotalReviews'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$DashboardSummaryToJson(_DashboardSummary instance) =>
    <String, dynamic>{
      'totalViews': instance.totalViews,
      'uniqueVisitors': instance.uniqueVisitors,
      'averageRating': instance.averageRating,
      'totalReviews': instance.totalReviews,
      'totalFavorites': instance.totalFavorites,
      'conversionRate': instance.conversionRate,
      'totalEvents': instance.totalEvents,
      'avgSessionDuration': instance.avgSessionDuration,
      'previousTotalViews': instance.previousTotalViews,
      'previousUniqueVisitors': instance.previousUniqueVisitors,
      'previousAverageRating': instance.previousAverageRating,
      'previousTotalReviews': instance.previousTotalReviews,
    };

_HourlyData _$HourlyDataFromJson(Map<String, dynamic> json) => _HourlyData(
  hour: (json['hour'] as num).toInt(),
  views: (json['views'] as num).toInt(),
  uniqueVisitors: (json['uniqueVisitors'] as num).toInt(),
  date: DateTime.parse(json['date'] as String),
  interactions: (json['interactions'] as num?)?.toInt() ?? 0,
);

Map<String, dynamic> _$HourlyDataToJson(_HourlyData instance) =>
    <String, dynamic>{
      'hour': instance.hour,
      'views': instance.views,
      'uniqueVisitors': instance.uniqueVisitors,
      'date': instance.date.toIso8601String(),
      'interactions': instance.interactions,
    };

_DailyData _$DailyDataFromJson(Map<String, dynamic> json) => _DailyData(
  date: DateTime.parse(json['date'] as String),
  views: (json['views'] as num).toInt(),
  uniqueVisitors: (json['uniqueVisitors'] as num).toInt(),
  newReviews: (json['newReviews'] as num).toInt(),
  newFavorites: (json['newFavorites'] as num).toInt(),
  interactions: (json['interactions'] as num?)?.toInt() ?? 0,
  avgRating: (json['avgRating'] as num?)?.toDouble() ?? 0.0,
);

Map<String, dynamic> _$DailyDataToJson(_DailyData instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'views': instance.views,
      'uniqueVisitors': instance.uniqueVisitors,
      'newReviews': instance.newReviews,
      'newFavorites': instance.newFavorites,
      'interactions': instance.interactions,
      'avgRating': instance.avgRating,
    };

_ReviewInsights _$ReviewInsightsFromJson(Map<String, dynamic> json) =>
    _ReviewInsights(
      totalReviews: (json['totalReviews'] as num).toInt(),
      averageRating: (json['averageRating'] as num).toDouble(),
      ratingDistribution: (json['ratingDistribution'] as Map<String, dynamic>)
          .map((k, e) => MapEntry(int.parse(k), (e as num).toInt())),
      topKeywords: (json['topKeywords'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      topComplaints: (json['topComplaints'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      topPraises: (json['topPraises'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      sentimentAnalysis: SentimentAnalysis.fromJson(
        json['sentimentAnalysis'] as Map<String, dynamic>,
      ),
      pendingReviews: (json['pendingReviews'] as num?)?.toInt() ?? 0,
      thisWeekReviews: (json['thisWeekReviews'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$ReviewInsightsToJson(_ReviewInsights instance) =>
    <String, dynamic>{
      'totalReviews': instance.totalReviews,
      'averageRating': instance.averageRating,
      'ratingDistribution': instance.ratingDistribution.map(
        (k, e) => MapEntry(k.toString(), e),
      ),
      'topKeywords': instance.topKeywords,
      'topComplaints': instance.topComplaints,
      'topPraises': instance.topPraises,
      'sentimentAnalysis': instance.sentimentAnalysis,
      'pendingReviews': instance.pendingReviews,
      'thisWeekReviews': instance.thisWeekReviews,
    };

_SentimentAnalysis _$SentimentAnalysisFromJson(Map<String, dynamic> json) =>
    _SentimentAnalysis(
      positiveScore: (json['positiveScore'] as num).toDouble(),
      neutralScore: (json['neutralScore'] as num).toDouble(),
      negativeScore: (json['negativeScore'] as num).toDouble(),
      trend: $enumDecode(_$SentimentTrendEnumMap, json['trend']),
      positiveKeywords:
          (json['positiveKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      negativeKeywords:
          (json['negativeKeywords'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SentimentAnalysisToJson(_SentimentAnalysis instance) =>
    <String, dynamic>{
      'positiveScore': instance.positiveScore,
      'neutralScore': instance.neutralScore,
      'negativeScore': instance.negativeScore,
      'trend': _$SentimentTrendEnumMap[instance.trend]!,
      'positiveKeywords': instance.positiveKeywords,
      'negativeKeywords': instance.negativeKeywords,
    };

const _$SentimentTrendEnumMap = {
  SentimentTrend.improving: 'improving',
  SentimentTrend.declining: 'declining',
  SentimentTrend.stable: 'stable',
};

_PopularContent _$PopularContentFromJson(Map<String, dynamic> json) =>
    _PopularContent(
      topCategories: (json['topCategories'] as List<dynamic>)
          .map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      topProducts: (json['topProducts'] as List<dynamic>)
          .map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      topServices: (json['topServices'] as List<dynamic>)
          .map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      topOffers: (json['topOffers'] as List<dynamic>)
          .map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
          .toList(),
      topSearchTerms:
          (json['topSearchTerms'] as List<dynamic>?)
              ?.map((e) => PopularItem.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$PopularContentToJson(_PopularContent instance) =>
    <String, dynamic>{
      'topCategories': instance.topCategories,
      'topProducts': instance.topProducts,
      'topServices': instance.topServices,
      'topOffers': instance.topOffers,
      'topSearchTerms': instance.topSearchTerms,
    };

_PopularItem _$PopularItemFromJson(Map<String, dynamic> json) => _PopularItem(
  id: json['id'] as String,
  name: json['name'] as String,
  count: (json['count'] as num).toInt(),
  percentage: (json['percentage'] as num).toDouble(),
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$PopularItemToJson(_PopularItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'count': instance.count,
      'percentage': instance.percentage,
      'metadata': instance.metadata,
    };

_ComparisonMetric _$ComparisonMetricFromJson(Map<String, dynamic> json) =>
    _ComparisonMetric(
      metricName: json['metricName'] as String,
      currentValue: (json['currentValue'] as num).toDouble(),
      compareValue: (json['compareValue'] as num).toDouble(),
      compareLabel: json['compareLabel'] as String,
      type: $enumDecode(_$ComparisonTypeEnumMap, json['type']),
    );

Map<String, dynamic> _$ComparisonMetricToJson(_ComparisonMetric instance) =>
    <String, dynamic>{
      'metricName': instance.metricName,
      'currentValue': instance.currentValue,
      'compareValue': instance.compareValue,
      'compareLabel': instance.compareLabel,
      'type': _$ComparisonTypeEnumMap[instance.type]!,
    };

const _$ComparisonTypeEnumMap = {
  ComparisonType.previousPeriod: 'previousPeriod',
  ComparisonType.industry: 'industry',
  ComparisonType.competitor: 'competitor',
  ComparisonType.goal: 'goal',
};
