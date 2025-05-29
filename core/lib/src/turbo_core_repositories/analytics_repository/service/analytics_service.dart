import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/business_dashboard.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/date_range.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/models/kpi_metric.dart';

/// Servicio de Analytics que implementa la lógica de negocio
/// NUEVA ARQUITECTURA: Collections separadas para escalabilidad empresarial
class AnalyticsService implements AnalyticsInterface {
  /// Constructor
  AnalyticsService({required this.firestore});

  /// Firebase Firestore instance
  final FirebaseFirestore firestore;

  // ==================== COLLECTIONS NAMES ====================

  /// Collection para resumen de analytics por lugar
  static const String _analyticsPlacesCollection = 'analytics_places';

  /// Collection para datos de tráfico time-series
  static const String _analyticsTrafficCollection = 'analytics_traffic';

  /// Collection para analytics de reviews por período
  static const String _analyticsReviewsCollection = 'analytics_reviews';

  /// Collection para eventos de conversión
  static const String _analyticsEventsCollection = 'analytics_events';

  /// Collection para datos de tiempo real
  static const String _analyticsRealtimeCollection = 'analytics_realtime';

  /// Collection para contenido popular
  static const String _analyticsContentCollection = 'analytics_content';

  /// Collection para benchmarks por categoría
  static const String _analyticsBenchmarksCollection = 'analytics_benchmarks';

  // ==================== DASHBOARD PRINCIPAL ====================

  @override
  Future<BusinessDashboard> getDashboardData(
    String placeId,
    DateRange dateRange,
  ) async {
    try {
      // Obtener datos en paralelo para mejor performance
      final results = await Future.wait([
        _getDashboardSummary(placeId, dateRange),
        _getKpiMetrics(placeId, dateRange),
        getHourlyTraffic(placeId, dateRange),
        getDailyTraffic(placeId, dateRange),
        getReviewInsights(placeId, dateRange),
        getPopularContent(placeId, dateRange),
      ]);

      final summary = results[0] as DashboardSummary;
      final kpiMetrics = results[1] as List<KpiMetric>;
      final hourlyTraffic = results[2] as List<HourlyData>;
      final dailyTraffic = results[3] as List<DailyData>;
      final reviewInsights = results[4] as ReviewInsights;
      final popularContent = results[5] as PopularContent;

      // Obtener información del lugar
      final placeDoc = await firestore.collection('places').doc(placeId).get();
      final placeData = placeDoc.data() ?? <String, dynamic>{};
      final placeName = placeData['name'] as String? ?? 'Lugar sin nombre';

      return BusinessDashboard(
        placeId: placeId,
        placeName: placeName,
        dateRange: dateRange,
        kpiMetrics: kpiMetrics,
        summary: summary,
        hourlyTraffic: hourlyTraffic,
        dailyTraffic: dailyTraffic,
        reviewInsights: reviewInsights,
        popularContent: popularContent,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Error al obtener datos del dashboard: $e');
    }
  }

  @override
  Future<void> updateRealTimeMetrics(String placeId) async {
    try {
      final now = DateTime.now();

      // Actualizar métricas en tiempo real en collection separada
      await firestore
          .collection(_analyticsRealtimeCollection)
          .doc(placeId)
          .set({
            'placeId': placeId,
            'lastUpdated': FieldValue.serverTimestamp(),
            'activeUsers': FieldValue.increment(1),
            'currentSessions': FieldValue.increment(1),
            'updatedAt': now,
          }, SetOptions(merge: true));

      print('📊 Métricas en tiempo real actualizadas para: $placeId');
    } catch (e) {
      throw Exception('Error al actualizar métricas en tiempo real: $e');
    }
  }

  // ==================== TRÁFICO Y ANALYTICS ====================

  @override
  Future<List<HourlyData>> getHourlyTraffic(
    String placeId,
    DateRange dateRange,
  ) async {
    try {
      // Query en collection separada con filtros eficientes
      final snapshot =
          await firestore
              .collection(_analyticsTrafficCollection)
              .where('placeId', isEqualTo: placeId)
              .where('type', isEqualTo: 'hourly')
              .where('timestamp', isGreaterThanOrEqualTo: dateRange.startDate)
              .where('timestamp', isLessThanOrEqualTo: dateRange.endDate)
              .orderBy('timestamp')
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return HourlyData(
          hour: (data['hour'] as num?)?.toInt() ?? 0,
          views: (data['views'] as num?)?.toInt() ?? 0,
          uniqueVisitors: (data['unique_visitors'] as num?)?.toInt() ?? 0,
          date: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
          interactions: (data['interactions'] as num?)?.toInt() ?? 0,
        );
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener tráfico por horas: $e');
    }
  }

  @override
  Future<List<DailyData>> getDailyTraffic(
    String placeId,
    DateRange dateRange,
  ) async {
    try {
      // Query optimizado en collection separada
      final snapshot =
          await firestore
              .collection(_analyticsTrafficCollection)
              .where('placeId', isEqualTo: placeId)
              .where('type', isEqualTo: 'daily')
              .where('date', isGreaterThanOrEqualTo: dateRange.startDate)
              .where('date', isLessThanOrEqualTo: dateRange.endDate)
              .orderBy('date')
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        return DailyData(
          date: (data['date'] as Timestamp?)?.toDate() ?? DateTime.now(),
          views: (data['views'] as num?)?.toInt() ?? 0,
          uniqueVisitors: (data['unique_visitors'] as num?)?.toInt() ?? 0,
          newReviews: (data['new_reviews'] as num?)?.toInt() ?? 0,
          newFavorites: (data['new_favorites'] as num?)?.toInt() ?? 0,
          interactions: (data['interactions'] as num?)?.toInt() ?? 0,
          avgRating: (data['avg_rating'] as num?)?.toDouble() ?? 0.0,
        );
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener tráfico diario: $e');
    }
  }

  @override
  Future<ReviewInsights> getReviewInsights(
    String placeId,
    DateRange dateRange,
  ) async {
    try {
      // Obtener analytics de reviews desde collection separada
      final period = _getPeriodKey(dateRange);
      final reviewAnalyticsDoc =
          await firestore
              .collection(_analyticsReviewsCollection)
              .doc('${placeId}_$period')
              .get();

      if (!reviewAnalyticsDoc.exists) {
        // Si no existe, calcular desde reviews originales y guardar
        return await _calculateAndSaveReviewInsights(
          placeId,
          dateRange,
          period,
        );
      }

      final data = reviewAnalyticsDoc.data() ?? <String, dynamic>{};

      return ReviewInsights(
        totalReviews: (data['total_reviews'] as num?)?.toInt() ?? 0,
        averageRating: (data['average_rating'] as num?)?.toDouble() ?? 0.0,
        ratingDistribution: Map<int, int>.from(
          (data['rating_distribution'] as Map<dynamic, dynamic>?) ??
              <dynamic, dynamic>{},
        ),
        topKeywords: List<String>.from(
          (data['top_keywords'] as List<dynamic>?) ?? <dynamic>[],
        ),
        topComplaints: List<String>.from(
          (data['top_complaints'] as List<dynamic>?) ?? <dynamic>[],
        ),
        topPraises: List<String>.from(
          (data['top_praises'] as List<dynamic>?) ?? <dynamic>[],
        ),
        sentimentAnalysis: SentimentAnalysis.fromJson(
          Map<String, dynamic>.from(
            (data['sentiment_analysis'] as Map<dynamic, dynamic>?) ??
                <dynamic, dynamic>{},
          ),
        ),
        thisWeekReviews: (data['this_week_reviews'] as num?)?.toInt() ?? 0,
      );
    } catch (e) {
      throw Exception('Error al obtener insights de reseñas: $e');
    }
  }

  @override
  Future<PopularContent> getPopularContent(
    String placeId,
    DateRange dateRange,
  ) async {
    try {
      // Obtener contenido popular desde collection separada
      final contentDoc =
          await firestore
              .collection(_analyticsContentCollection)
              .doc(placeId)
              .get();

      final data = contentDoc.data() ?? <String, dynamic>{};

      return PopularContent(
        topCategories: _parsePopularItems(data['top_categories']),
        topProducts: _parsePopularItems(data['top_products']),
        topServices: _parsePopularItems(data['top_services']),
        topOffers: _parsePopularItems(data['top_offers']),
        topSearchTerms: _parsePopularItems(data['top_search_terms']),
      );
    } catch (e) {
      throw Exception('Error al obtener contenido popular: $e');
    }
  }

  // ==================== TRACKING DE EVENTOS ====================

  @override
  Future<void> trackVisit(String placeId, Map<String, dynamic> metadata) async {
    try {
      final now = DateTime.now();
      final hour = now.hour;
      final date = DateTime(now.year, now.month, now.day);

      final batch = firestore.batch();

      // 1. Crear evento individual en collection de eventos
      final eventRef = firestore.collection(_analyticsEventsCollection).doc();
      batch.set(eventRef, {
        'placeId': placeId,
        'type': 'visit',
        'timestamp': now,
        'metadata': metadata,
        'hour': hour,
        'date': date,
      });

      // 2. Actualizar tráfico por hora en collection separada
      final hourlyTrafficId = '${placeId}_${date.millisecondsSinceEpoch}_$hour';
      final hourlyRef = firestore
          .collection(_analyticsTrafficCollection)
          .doc(hourlyTrafficId);

      batch.set(hourlyRef, {
        'placeId': placeId,
        'type': 'hourly',
        'hour': hour,
        'timestamp': now,
        'date': date,
        'views': FieldValue.increment(1),
        'unique_visitors': FieldValue.increment(1),
        'interactions': FieldValue.increment(1),
      }, SetOptions(merge: true));

      // 3. Actualizar tráfico diario
      final dailyTrafficId = '${placeId}_${date.millisecondsSinceEpoch}';
      final dailyRef = firestore
          .collection(_analyticsTrafficCollection)
          .doc(dailyTrafficId);

      batch.set(dailyRef, {
        'placeId': placeId,
        'type': 'daily',
        'date': date,
        'views': FieldValue.increment(1),
        'unique_visitors': FieldValue.increment(1),
      }, SetOptions(merge: true));

      // 4. Actualizar resumen del lugar
      final summaryRef = firestore
          .collection(_analyticsPlacesCollection)
          .doc(placeId);

      batch.set(summaryRef, {
        'placeId': placeId,
        'total_views': FieldValue.increment(1),
        'last_visit': now,
        'updated_at': now,
      }, SetOptions(merge: true));

      await batch.commit();
      print('📈 Visita registrada para lugar: $placeId');
    } catch (e) {
      throw Exception('Error al registrar visita: $e');
    }
  }

  @override
  Future<void> trackConversion(
    String placeId,
    String conversionType,
    Map<String, dynamic> metadata,
  ) async {
    try {
      final now = DateTime.now();
      final batch = firestore.batch();

      // 1. Registrar evento de conversión
      final eventRef = firestore.collection(_analyticsEventsCollection).doc();
      batch.set(eventRef, {
        'placeId': placeId,
        'type': 'conversion',
        'conversion_type': conversionType,
        'timestamp': now,
        'metadata': metadata,
      });

      // 2. Actualizar contadores de conversión en resumen del lugar
      final summaryRef = firestore
          .collection(_analyticsPlacesCollection)
          .doc(placeId);

      batch.set(summaryRef, {
        'placeId': placeId,
        'total_conversions': FieldValue.increment(1),
        'conversions_$conversionType': FieldValue.increment(1),
        'last_conversion': now,
        'updated_at': now,
      }, SetOptions(merge: true));

      await batch.commit();
      print('🎯 Conversión registrada: $conversionType para lugar: $placeId');
    } catch (e) {
      throw Exception('Error al registrar conversión: $e');
    }
  }

  // ==================== MÉTODOS DE INICIALIZACIÓN ====================

  /// Inicializa la estructura completa de analytics para un lugar nuevo
  /// NUEVA ARQUITECTURA: Collections separadas
  Future<void> initializeAnalyticsStructure(String placeId) async {
    try {
      final batch = firestore.batch();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // 1. Inicializar resumen del lugar en collection separada
      final summaryRef = firestore
          .collection(_analyticsPlacesCollection)
          .doc(placeId);

      batch.set(summaryRef, {
        'placeId': placeId,
        'total_views': 0,
        'unique_visitors': 0,
        'total_conversions': 0,
        'average_rating': 0.0,
        'total_reviews': 0,
        'total_favorites': 0,
        'conversion_rate': 0.0,
        'total_events': 0,
        'avg_session_duration': 0.0,
        'created_at': now,
        'updated_at': now,
      });

      // 2. Inicializar datos de tiempo real
      final realtimeRef = firestore
          .collection(_analyticsRealtimeCollection)
          .doc(placeId);

      batch.set(realtimeRef, {
        'placeId': placeId,
        'activeUsers': 0,
        'currentSessions': 0,
        'lastUpdated': now,
      });

      // 3. Inicializar contenido popular
      final contentRef = firestore
          .collection(_analyticsContentCollection)
          .doc(placeId);

      batch.set(contentRef, {
        'placeId': placeId,
        'top_categories': <Map<String, dynamic>>[],
        'top_products': <Map<String, dynamic>>[],
        'top_services': <Map<String, dynamic>>[],
        'top_offers': <Map<String, dynamic>>[],
        'top_search_terms': <Map<String, dynamic>>[],
        'updated_at': now,
      });

      // 4. Inicializar primer registro de tráfico diario
      final dailyTrafficId = '${placeId}_${today.millisecondsSinceEpoch}';
      final dailyTrafficRef = firestore
          .collection(_analyticsTrafficCollection)
          .doc(dailyTrafficId);

      batch.set(dailyTrafficRef, {
        'placeId': placeId,
        'type': 'daily',
        'date': today,
        'views': 0,
        'unique_visitors': 0,
        'new_reviews': 0,
        'new_favorites': 0,
        'interactions': 0,
        'avg_rating': 0.0,
      });

      await batch.commit();
      print(
        '✅ Estructura de analytics inicializada (collections separadas) para: $placeId',
      );
    } catch (e) {
      throw Exception('Error al inicializar estructura de analytics: $e');
    }
  }

  /// Limpia completamente la estructura de analytics de un lugar
  Future<void> cleanupAnalyticsStructure(String placeId) async {
    try {
      final batch = firestore.batch();

      // 1. Eliminar resumen del lugar
      batch.delete(
        firestore.collection(_analyticsPlacesCollection).doc(placeId),
      );

      // 2. Eliminar datos de tiempo real
      batch.delete(
        firestore.collection(_analyticsRealtimeCollection).doc(placeId),
      );

      // 3. Eliminar contenido popular
      batch.delete(
        firestore.collection(_analyticsContentCollection).doc(placeId),
      );

      await batch.commit();

      // 4. Eliminar datos de tráfico (no se pueden hacer en batch debido a queries)
      await _deleteTrafficData(placeId);

      // 5. Eliminar eventos
      await _deleteEvents(placeId);

      print(
        '🗑️ Estructura de analytics limpiada (collections separadas) para: $placeId',
      );
    } catch (e) {
      throw Exception('Error al limpiar estructura de analytics: $e');
    }
  }

  // ==================== MÉTODOS AUXILIARES PRIVADOS ====================

  Future<DashboardSummary> _getDashboardSummary(
    String placeId,
    DateRange dateRange,
  ) async {
    try {
      // Obtener resumen desde collection separada
      final summaryDoc =
          await firestore
              .collection(_analyticsPlacesCollection)
              .doc(placeId)
              .get();

      final analyticsData = summaryDoc.data() ?? <String, dynamic>{};

      // Obtener datos básicos del lugar
      final placeDoc = await firestore.collection('places').doc(placeId).get();
      final placeData = placeDoc.data() ?? <String, dynamic>{};

      return DashboardSummary(
        totalViews: (analyticsData['total_views'] as num?)?.toInt() ?? 0,
        uniqueVisitors:
            (analyticsData['unique_visitors'] as num?)?.toInt() ?? 0,
        averageRating: (placeData['rating'] as num?)?.toDouble() ?? 0.0,
        totalReviews: (placeData['reviews_count'] as num?)?.toInt() ?? 0,
        totalFavorites: (placeData['favorite_count'] as num?)?.toInt() ?? 0,
        conversionRate:
            (analyticsData['conversion_rate'] as num?)?.toDouble() ?? 0.0,
        totalEvents: (analyticsData['total_events'] as num?)?.toInt() ?? 0,
        avgSessionDuration:
            (analyticsData['avg_session_duration'] as num?)?.toDouble() ?? 0.0,
      );
    } catch (e) {
      throw Exception('Error al obtener resumen del dashboard: $e');
    }
  }

  Future<List<KpiMetric>> _getKpiMetrics(
    String placeId,
    DateRange dateRange,
  ) async {
    final summary = await _getDashboardSummary(placeId, dateRange);

    return [
      KpiMetric(
        id: 'total_views',
        title: 'Vistas Totales',
        description: 'Número total de visitas al lugar',
        value: summary.totalViews.toDouble(),
        unit: 'views',
        previousValue: summary.previousTotalViews.toDouble(),
        trend: MetricTrend.up,
        icon: 'visibility',
      ).withCalculatedValues(),

      KpiMetric(
        id: 'average_rating',
        title: 'Rating Promedio',
        description: 'Calificación promedio del lugar',
        value: summary.averageRating,
        unit: 'rating',
        previousValue: summary.previousAverageRating,
        trend: MetricTrend.stable,
        icon: 'star',
      ).withCalculatedValues(),

      KpiMetric(
        id: 'total_reviews',
        title: 'Total Reseñas',
        description: 'Número total de reseñas recibidas',
        value: summary.totalReviews.toDouble(),
        unit: 'reviews',
        previousValue: summary.previousTotalReviews.toDouble(),
        trend: MetricTrend.up,
        icon: 'rate_review',
      ).withCalculatedValues(),
    ];
  }

  Future<ReviewInsights> _calculateAndSaveReviewInsights(
    String placeId,
    DateRange dateRange,
    String period,
  ) async {
    // Obtener reseñas del período
    final reviewsSnapshot =
        await firestore
            .collection('places')
            .doc(placeId)
            .collection('reviews')
            .where('date', isGreaterThanOrEqualTo: dateRange.startDate)
            .where('date', isLessThanOrEqualTo: dateRange.endDate)
            .get();

    final reviews = reviewsSnapshot.docs;
    final totalReviews = reviews.length;

    if (totalReviews == 0) {
      return ReviewInsights(
        totalReviews: 0,
        averageRating: 0.0,
        ratingDistribution: {},
        topKeywords: [],
        topComplaints: [],
        topPraises: [],
        sentimentAnalysis: const SentimentAnalysis(
          positiveScore: 0.0,
          neutralScore: 0.0,
          negativeScore: 0.0,
          trend: SentimentTrend.stable,
        ),
      );
    }

    // Calcular métricas y guardar en collection separada
    final ratings =
        reviews.map((doc) {
          final data = doc.data();
          return (data['rating'] as num?)?.toDouble() ?? 0.0;
        }).toList();

    final averageRating =
        ratings.isNotEmpty
            ? ratings.reduce((a, b) => a + b) / ratings.length
            : 0.0;

    final ratingDistribution = <int, int>{};
    for (int i = 1; i <= 5; i++) {
      ratingDistribution[i] = ratings.where((r) => r.round() == i).length;
    }

    final sentimentAnalysis = await _analyzeSentiments(reviews);
    final topKeywords = await _extractTopKeywords(reviews);
    final topComplaints = await _extractComplaints(reviews);
    final topPraises = await _extractPraises(reviews);

    final insights = ReviewInsights(
      totalReviews: totalReviews,
      averageRating: averageRating,
      ratingDistribution: ratingDistribution,
      topKeywords: topKeywords,
      topComplaints: topComplaints,
      topPraises: topPraises,
      sentimentAnalysis: sentimentAnalysis,
      thisWeekReviews: await _getThisWeekReviews(placeId),
    );

    // Guardar en collection separada para futuras consultas
    await firestore
        .collection(_analyticsReviewsCollection)
        .doc('${placeId}_$period')
        .set({
          'placeId': placeId,
          'period': period,
          'total_reviews': totalReviews,
          'average_rating': averageRating,
          'rating_distribution': ratingDistribution,
          'top_keywords': topKeywords,
          'top_complaints': topComplaints,
          'top_praises': topPraises,
          'sentiment_analysis': sentimentAnalysis.toJson(),
          'this_week_reviews': insights.thisWeekReviews,
          'calculated_at': DateTime.now(),
        });

    return insights;
  }

  String _getPeriodKey(DateRange dateRange) {
    // Generar clave del período basada en el rango
    switch (dateRange.type) {
      case DateRangeType.today:
        return 'today_${DateTime.now().millisecondsSinceEpoch ~/ 86400000}';
      case DateRangeType.last7Days:
        return 'week_${DateTime.now().millisecondsSinceEpoch ~/ 604800000}';
      case DateRangeType.last30Days:
        return 'month_${DateTime.now().year}_${DateTime.now().month}';
      case DateRangeType.thisMonth:
        return 'month_${DateTime.now().year}_${DateTime.now().month}';
      default:
        return 'custom_${dateRange.startDate.millisecondsSinceEpoch}_${dateRange.endDate.millisecondsSinceEpoch}';
    }
  }

  Future<void> _deleteTrafficData(String placeId) async {
    // Eliminar datos de tráfico relacionados con el lugar
    final trafficSnapshot =
        await firestore
            .collection(_analyticsTrafficCollection)
            .where('placeId', isEqualTo: placeId)
            .get();

    final batch = firestore.batch();
    for (final doc in trafficSnapshot.docs) {
      batch.delete(doc.reference);
    }

    if (trafficSnapshot.docs.isNotEmpty) {
      await batch.commit();
    }
  }

  Future<void> _deleteEvents(String placeId) async {
    // Eliminar eventos relacionados con el lugar
    final eventsSnapshot =
        await firestore
            .collection(_analyticsEventsCollection)
            .where('placeId', isEqualTo: placeId)
            .get();

    final batch = firestore.batch();
    for (final doc in eventsSnapshot.docs) {
      batch.delete(doc.reference);
    }

    if (eventsSnapshot.docs.isNotEmpty) {
      await batch.commit();
    }
  }

  List<PopularItem> _parsePopularItems(dynamic data) {
    if (data == null || data is! List) return [];

    return (data as List).map((item) {
      if (item is Map<String, dynamic>) {
        return PopularItem(
          id: item['id'] as String? ?? '',
          name: item['name'] as String? ?? '',
          count: (item['count'] as num?)?.toInt() ?? 0,
          percentage: (item['percentage'] as num?)?.toDouble() ?? 0.0,
          metadata: item['metadata'] as Map<String, dynamic>?,
        );
      }
      return PopularItem(id: '', name: '', count: 0, percentage: 0.0);
    }).toList();
  }

  // ==================== MÉTODOS DE ANÁLISIS EXISTENTES ====================

  Future<SentimentAnalysis> _analyzeSentiments(
    List<QueryDocumentSnapshot> reviews,
  ) async {
    var positive = 0;
    var neutral = 0;
    var negative = 0;

    for (final review in reviews) {
      final data = review.data() as Map<String, dynamic>;
      final rating = (data['rating'] as num?)?.toDouble() ?? 0.0;

      if (rating >= 4.0) {
        positive++;
      } else if (rating >= 3.0) {
        neutral++;
      } else {
        negative++;
      }
    }

    final total = reviews.length;
    return SentimentAnalysis(
      positiveScore: total > 0 ? (positive / total) * 100 : 0.0,
      neutralScore: total > 0 ? (neutral / total) * 100 : 0.0,
      negativeScore: total > 0 ? (negative / total) * 100 : 0.0,
      trend: SentimentTrend.stable,
    );
  }

  Future<List<String>> _extractTopKeywords(
    List<QueryDocumentSnapshot> reviews,
  ) async {
    final words = <String, int>{};

    for (final review in reviews) {
      final data = review.data() as Map<String, dynamic>;
      final comment = (data['comment'] as String?) ?? '';
      final reviewWords = comment.toLowerCase().split(' ');

      for (final word in reviewWords) {
        if (word.length > 3) {
          words[word] = (words[word] ?? 0) + 1;
        }
      }
    }

    final sortedWords =
        words.entries.toList()..sort((a, b) => b.value.compareTo(a.value));

    return sortedWords.take(10).map((e) => e.key).toList();
  }

  Future<List<String>> _extractComplaints(
    List<QueryDocumentSnapshot> reviews,
  ) async {
    final complaints = <String>[];
    const negativeKeywords = ['malo', 'terrible', 'lento', 'caro', 'sucio'];

    for (final review in reviews) {
      final data = review.data() as Map<String, dynamic>;
      final rating = (data['rating'] as num?)?.toDouble() ?? 0.0;
      final comment = (data['comment'] as String?) ?? '';

      if (rating < 3.0) {
        for (final keyword in negativeKeywords) {
          if (comment.toLowerCase().contains(keyword)) {
            complaints.add(keyword);
          }
        }
      }
    }

    return complaints.toSet().toList();
  }

  Future<List<String>> _extractPraises(
    List<QueryDocumentSnapshot> reviews,
  ) async {
    final praises = <String>[];
    const positiveKeywords = [
      'excelente',
      'bueno',
      'rápido',
      'limpio',
      'recomendado',
    ];

    for (final review in reviews) {
      final data = review.data() as Map<String, dynamic>;
      final rating = (data['rating'] as num?)?.toDouble() ?? 0.0;
      final comment = (data['comment'] as String?) ?? '';

      if (rating >= 4.0) {
        for (final keyword in positiveKeywords) {
          if (comment.toLowerCase().contains(keyword)) {
            praises.add(keyword);
          }
        }
      }
    }

    return praises.toSet().toList();
  }

  Future<int> _getThisWeekReviews(String placeId) async {
    final now = DateTime.now();
    final weekStart = now.subtract(Duration(days: now.weekday - 1));

    final snapshot =
        await firestore
            .collection('places')
            .doc(placeId)
            .collection('reviews')
            .where('date', isGreaterThanOrEqualTo: weekStart)
            .get();

    return snapshot.docs.length;
  }

  // ==================== MÉTODOS PENDIENTES (TODO) ====================

  @override
  Future<List<ComparisonMetric>> compareWithPreviousPeriod(
    String placeId,
    DateRange currentRange,
  ) async {
    // TODO: Implementar comparación con período anterior usando collections separadas
    return [];
  }

  @override
  Future<List<ComparisonMetric>> compareWithIndustry(
    String placeId,
    DateRange dateRange,
    String categoryId,
  ) async {
    // TODO: Implementar comparación con industria - AHORA ES POSIBLE con collections separadas
    return [];
  }

  @override
  Future<List<ComparisonMetric>> compareWithCompetitors(
    String placeId,
    DateRange dateRange,
    List<String> competitorIds,
  ) async {
    // TODO: Implementar comparación con competidores - AHORA ES POSIBLE con collections separadas
    return [];
  }

  @override
  Future<Map<String, dynamic>> getPredictiveAnalytics(
    String placeId,
    int daysToPredict,
  ) async {
    // TODO: Implementar analytics predictivos
    return {};
  }

  @override
  Future<Map<String, dynamic>> getTrendAnalysis(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar análisis de tendencias
    return {};
  }

  @override
  Future<List<String>> getImprovementOpportunities(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar oportunidades de mejora
    return [];
  }

  @override
  Future<void> trackSessionDuration(
    String placeId,
    Duration sessionDuration,
    Map<String, dynamic> metadata,
  ) async {
    // TODO: Implementar tracking de duración de sesión
  }

  @override
  Future<Map<String, dynamic>> generateCustomReport(
    String placeId,
    DateRange dateRange,
    List<String> selectedMetrics,
    String reportFormat,
  ) async {
    // TODO: Implementar generación de reportes personalizados
    return {};
  }

  @override
  Future<String> exportAnalyticsData(
    String placeId,
    DateRange dateRange,
    String format,
  ) async {
    // TODO: Implementar exportación de datos
    return '';
  }

  @override
  Future<void> setupMetricAlert(
    String placeId,
    String metricName,
    double threshold,
    String alertType,
  ) async {
    // TODO: Implementar configuración de alertas
  }

  @override
  Future<List<Map<String, dynamic>>> getMetricAlerts(String placeId) async {
    // TODO: Implementar obtención de alertas
    return [];
  }

  @override
  Future<void> removeMetricAlert(String placeId, String alertId) async {
    // TODO: Implementar eliminación de alertas
  }

  @override
  Future<SentimentAnalysis> analyzeSentiments(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar análisis de sentimientos específico
    return const SentimentAnalysis(
      positiveScore: 0.0,
      neutralScore: 0.0,
      negativeScore: 0.0,
      trend: SentimentTrend.stable,
    );
  }

  @override
  Future<List<String>> getTopKeywords(
    String placeId,
    DateRange dateRange, {
    int limit = 10,
  }) async {
    // TODO: Implementar obtención de palabras clave
    return [];
  }

  @override
  Future<List<String>> detectCommonIssues(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar detección de problemas comunes
    return [];
  }

  @override
  Future<double> calculateCustomerLifetimeValue(String placeId) async {
    // TODO: Implementar cálculo de CLV
    return 0.0;
  }

  @override
  Future<double> calculateRetentionRate(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar cálculo de retention rate
    return 0.0;
  }

  @override
  Future<Map<String, double>> getUserEngagementMetrics(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar métricas de engagement
    return {};
  }

  @override
  Future<Map<String, dynamic>> analyzeCustomerJourney(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar análisis de customer journey
    return {};
  }

  @override
  Future<double> getAverageLoadTime(String placeId, DateRange dateRange) async {
    // TODO: Implementar tiempo de carga promedio
    return 0.0;
  }

  @override
  Future<Map<String, int>> getDeviceAnalytics(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar analytics de dispositivos
    return {};
  }

  @override
  Future<Map<String, int>> getGeoAnalytics(
    String placeId,
    DateRange dateRange,
  ) async {
    // TODO: Implementar analytics geográficos
    return {};
  }
}
