import 'dart:math';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'distance_result.freezed.dart';
part 'distance_result.g.dart';

/// Resultado de cálculo de distancia entre dos puntos
@freezed
sealed class DistanceResult with _$DistanceResult {
  const factory DistanceResult({
    required double distanceKm,
    required double distanceMeters,
    required String formattedDistance,
    required Duration estimatedTravelTime,
    String? travelMode, // 'driving', 'walking', 'transit', 'bicycling'
    Map<String, dynamic>? additionalInfo,
  }) = _DistanceResult;

  const DistanceResult._();

  factory DistanceResult.fromJson(Map<String, dynamic> json) =>
      _$DistanceResultFromJson(json);

  /// Crear resultado de distancia básico
  factory DistanceResult.fromDistance(double distanceMeters) {
    final km = distanceMeters / 1000;

    return DistanceResult(
      distanceKm: km,
      distanceMeters: distanceMeters,
      formattedDistance: _formatDistance(distanceMeters),
      estimatedTravelTime: _estimateTravelTime(distanceMeters),
      travelMode: 'driving',
    );
  }

  /// Formatear distancia para mostrar al usuario
  static String _formatDistance(double meters) {
    if (meters < 1000) {
      return '${meters.round()} m';
    } else if (meters < 10000) {
      return '${(meters / 1000).toStringAsFixed(1)} km';
    } else {
      return '${(meters / 1000).round()} km';
    }
  }

  /// Estimar tiempo de viaje (básico)
  static Duration _estimateTravelTime(double meters) {
    // Velocidad promedio en ciudad: 30 km/h = 8.33 m/s
    const averageSpeedMps = 8.33;
    final seconds = (meters / averageSpeedMps).round();
    return Duration(seconds: seconds);
  }

  /// Verificar si está cerca (menos de 1km)
  bool get isNearby => distanceMeters < 1000;

  /// Verificar si está muy cerca (menos de 100m)
  bool get isVeryClose => distanceMeters < 100;

  /// Obtener tiempo de viaje formateado
  String get formattedTravelTime {
    final totalMinutes = estimatedTravelTime.inMinutes;

    if (totalMinutes < 1) {
      return '< 1 min';
    } else if (totalMinutes < 60) {
      return '$totalMinutes min';
    } else {
      final hours = totalMinutes ~/ 60;
      final minutes = totalMinutes % 60;
      if (minutes == 0) {
        return '$hours h';
      } else {
        return '$hours h $minutes min';
      }
    }
  }

  /// Obtener descripción completa
  String get fullDescription {
    return '$formattedDistance • $formattedTravelTime';
  }

  /// Crear desde respuesta de Google Distance Matrix API
  factory DistanceResult.fromGoogleApi(Map<String, dynamic> data) {
    final distance = data['distance'] as Map<String, dynamic>?;
    final duration = data['duration'] as Map<String, dynamic>?;

    final distanceMeters = (distance?['value'] as num?)?.toDouble() ?? 0.0;
    final durationSeconds = (duration?['value'] as num?)?.toInt() ?? 0;

    return DistanceResult(
      distanceKm: distanceMeters / 1000,
      distanceMeters: distanceMeters,
      formattedDistance:
          distance?['text'] as String? ?? _formatDistance(distanceMeters),
      estimatedTravelTime: Duration(seconds: durationSeconds),
      travelMode: 'driving',
      additionalInfo: {
        'status': data['status'],
        'duration_in_traffic': data['duration_in_traffic'],
      },
    );
  }
}

/// Resultado de búsqueda de lugares cercanos
@freezed
sealed class NearbySearchResult with _$NearbySearchResult {
  const factory NearbySearchResult({
    required String placeId,
    required String name,
    required DistanceResult distance,
    required double latitude,
    required double longitude,
    String? address,
    double? rating,
    @Default([]) List<String> types,
    String? photoReference,
    Map<String, dynamic>? additionalData,
  }) = _NearbySearchResult;

  factory NearbySearchResult.fromJson(Map<String, dynamic> json) =>
      _$NearbySearchResultFromJson(json);
}

/// Filtros para búsqueda por proximidad
@freezed
sealed class ProximityFilter with _$ProximityFilter {
  const factory ProximityFilter({
    required double latitude,
    required double longitude,
    @Default(5000) double radiusMeters, // Radio en metros
    @Default(10) int limit, // Límite de resultados
    @Default([]) List<String> categories, // Categorías a filtrar
    @Default([]) List<String> excludeIds, // IDs a excluir
    String? sortBy, // 'distance', 'rating', 'popularity'
    double? minRating,
    bool? openNow,
  }) = _ProximityFilter;

  const ProximityFilter._();

  factory ProximityFilter.fromJson(Map<String, dynamic> json) =>
      _$ProximityFilterFromJson(json);

  /// Obtener radio en kilómetros
  double get radiusKm => radiusMeters / 1000;

  /// Verificar si un punto está dentro del radio
  bool isWithinRadius(double lat, double lng) {
    final distance = _calculateDistance(latitude, longitude, lat, lng);
    return distance <= radiusMeters;
  }

  /// Calcular distancia usando fórmula Haversine
  static double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371000; // Radio de la Tierra en metros
    final double dLat = _toRadians(lat2 - lat1);
    final double dLon = _toRadians(lon2 - lon1);
    final double lat1Rad = _toRadians(lat1);
    final double lat2Rad = _toRadians(lat2);

    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(lat1Rad) * cos(lat2Rad) * sin(dLon / 2) * sin(dLon / 2);

    final double c = 2 * asin(sqrt(a));
    return earthRadius * c;
  }

  static double _toRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
