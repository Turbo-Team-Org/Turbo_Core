/// 📊 Analytics data for places owned by an admin user
class PlaceOwnerAnalytics {
  const PlaceOwnerAnalytics({
    required this.ownerId,
    required this.totalPlaces,
    required this.totalViews,
    required this.totalReviews,
    required this.averageRating,
    required this.totalFavorites,
    required this.monthlyViews,
    required this.topPerformingPlaces,
  });

  /// ID del propietario
  final String ownerId;

  /// Total de lugares
  final int totalPlaces;

  /// Total de vistas
  final int totalViews;

  /// Total de reseñas
  final int totalReviews;

  /// Calificación promedio
  final double averageRating;

  /// Total de favoritos
  final int totalFavorites;

  /// Vistas mensuales
  final Map<String, int> monthlyViews;

  /// Lugares con mejor rendimiento
  final List<PlacePerformance> topPerformingPlaces;

  /// Factory para crear desde datos
  factory PlaceOwnerAnalytics.fromData(
    String ownerId,
    Map<String, dynamic> data,
  ) {
    return PlaceOwnerAnalytics(
      ownerId: ownerId,
      totalPlaces: data['totalPlaces'] as int? ?? 0,
      totalViews: data['totalViews'] as int? ?? 0,
      totalReviews: data['totalReviews'] as int? ?? 0,
      averageRating: (data['averageRating'] as num?)?.toDouble() ?? 0.0,
      totalFavorites: data['totalFavorites'] as int? ?? 0,
      monthlyViews: Map<String, int>.from(
        (data['monthlyViews'] as Map<String, dynamic>?) ?? {},
      ),
      topPerformingPlaces: (data['topPerformingPlaces'] as List<dynamic>? ?? [])
          .map(
              (item) => PlacePerformance.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }

  /// Convierte a JSON
  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'totalPlaces': totalPlaces,
      'totalViews': totalViews,
      'totalReviews': totalReviews,
      'averageRating': averageRating,
      'totalFavorites': totalFavorites,
      'monthlyViews': monthlyViews,
      'topPerformingPlaces':
          topPerformingPlaces.map((e) => e.toJson()).toList(),
    };
  }
}

/// 📈 Performance data for a single place
class PlacePerformance {
  const PlacePerformance({
    required this.placeId,
    required this.placeName,
    required this.views,
    required this.reviews,
    required this.rating,
    required this.favorites,
  });

  /// ID del lugar
  final String placeId;

  /// Nombre del lugar
  final String placeName;

  /// Número de vistas
  final int views;

  /// Número de reseñas
  final int reviews;

  /// Calificación promedio
  final double rating;

  /// Número de favoritos
  final int favorites;

  /// Factory para crear desde JSON
  factory PlacePerformance.fromJson(Map<String, dynamic> json) {
    return PlacePerformance(
      placeId: json['placeId'] as String? ?? '',
      placeName: json['placeName'] as String? ?? '',
      views: json['views'] as int? ?? 0,
      reviews: json['reviews'] as int? ?? 0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      favorites: json['favorites'] as int? ?? 0,
    );
  }

  /// Convierte a JSON
  Map<String, dynamic> toJson() {
    return {
      'placeId': placeId,
      'placeName': placeName,
      'views': views,
      'reviews': reviews,
      'rating': rating,
      'favorites': favorites,
    };
  }
}
