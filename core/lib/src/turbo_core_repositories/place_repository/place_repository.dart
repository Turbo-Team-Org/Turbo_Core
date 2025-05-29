import 'dart:math';

import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/service/place_service.dart';

/// Repository for managing places and their operations.
///
/// This repository provides a clean interface for place-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to places.
class PlaceRepository {
  /// Constructor for the PlaceRepository.
  PlaceRepository({required this.placeService});

  /// Place service instance for data operations
  final PlaceService placeService;

  // ==================== READ OPERATIONS ====================

  /// Gets all places from the data source.
  ///
  /// Returns a list of all available places with their associated reviews.
  /// Throws an exception if the operation fails.
  Future<List<Place>> getPlaces() async {
    try {
      return await placeService.getPlaces();
    } catch (e) {
      throw Exception('Error al obtener lugares: $e');
    }
  }

  /// Gets a specific place by its unique identifier.
  ///
  /// [id] The unique identifier of the place to retrieve.
  ///
  /// Returns the place with the specified ID including its reviews.
  /// Throws an exception if the place is not found or operation fails.
  Future<Place> getPlaceById(String id) async {
    try {
      return await placeService.getPlaceById(id);
    } catch (e) {
      throw Exception('Error al obtener lugar por ID: $e');
    }
  }

  /// Gets a specific place by its name.
  ///
  /// [name] The name of the place to search for.
  ///
  /// Returns the place with the specified name including its reviews.
  /// Throws an exception if the place is not found or operation fails.
  Future<Place> getPlaceByName(String name) async {
    try {
      return await placeService.getPlaceByName(name);
    } catch (e) {
      throw Exception('Error al obtener lugar por nombre: $e');
    }
  }

  /// Gets all places that belong to a specific category.
  ///
  /// [categoryId] The unique identifier of the category.
  ///
  /// Returns a list of places in the specified category with their reviews.
  /// Throws an exception if the operation fails.
  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    try {
      return await placeService.getPlacesByCategory(categoryId);
    } catch (e) {
      throw Exception('Error al obtener lugares por categoría: $e');
    }
  }

  // ==================== ADMIN OPERATIONS ====================

  /// 🏢 Gets places owned by a specific admin user.
  ///
  /// [ownerId] The unique identifier of the admin user.
  ///
  /// Returns a list of places owned by the specified admin user.
  /// This method is used by the Admin Panel to show only the places
  /// that a specific admin user can manage.
  Future<List<Place>> getPlacesByOwnerId(String ownerId) async {
    try {
      return await placeService.getPlacesByOwnerId(ownerId);
    } catch (e) {
      throw Exception('Error al obtener lugares por propietario: $e');
    }
  }

  /// 🏢 Gets places owned by multiple admin users.
  ///
  /// [ownerIds] List of admin user IDs.
  ///
  /// Returns a list of places owned by any of the specified admin users.
  /// Useful for super admins who want to see places from specific owners.
  Future<List<Place>> getPlacesByOwnerIds(List<String> ownerIds) async {
    try {
      return await placeService.getPlacesByOwnerIds(ownerIds);
    } catch (e) {
      throw Exception('Error al obtener lugares por propietarios: $e');
    }
  }

  /// 👑 Updates the ownership of a place (super admin only).
  ///
  /// [placeId] The unique identifier of the place.
  /// [ownerIds] List of admin user IDs who will own this place.
  ///
  /// Returns the updated place with new ownership information.
  /// This operation is restricted to super administrators.
  Future<Place> updatePlaceOwnership(
    String placeId,
    List<String> ownerIds,
  ) async {
    try {
      return await placeService.updatePlaceOwnership(placeId, ownerIds);
    } catch (e) {
      throw Exception('Error al actualizar propietarios del lugar: $e');
    }
  }

  /// 📊 Gets analytics summary for places owned by an admin.
  ///
  /// [ownerId] The unique identifier of the admin user.
  ///
  /// Returns aggregated analytics data for all places owned by the admin.
  /// Includes metrics like total views, reviews, ratings, etc.
  Future<PlaceOwnerAnalytics> getPlaceAnalyticsByOwnerId(String ownerId) async {
    try {
      return await placeService.getPlaceAnalyticsByOwnerId(ownerId);
    } catch (e) {
      throw Exception('Error al obtener analytics por propietario: $e');
    }
  }

  // ==================== CREATE OPERATIONS ====================

  /// Adds a new place to the data source.
  ///
  /// [place] The place object to be added.
  ///
  /// Returns true if the place was successfully added.
  /// Throws an exception if the operation fails.
  Future<bool> addPlace(Place place) async {
    try {
      await placeService.addPlace(place);
      return true;
    } catch (e) {
      throw Exception('Error al agregar lugar: $e');
    }
  }

  /// 🏢 Adds a new place with admin ownership.
  ///
  /// [place] The place object to be added.
  /// [ownerId] The admin user ID who will own this place.
  ///
  /// Returns true if the place was successfully added with ownership.
  /// This method ensures the place is automatically assigned to an admin.
  Future<bool> addPlaceWithOwner(Place place, String ownerId) async {
    try {
      await placeService.addPlaceWithOwner(place, ownerId);
      return true;
    } catch (e) {
      throw Exception('Error al agregar lugar con propietario: $e');
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Updates an existing place in the data source.
  ///
  /// [place] The place object with updated information.
  ///
  /// Returns true if the place was successfully updated.
  /// Throws an exception if the place is not found or operation fails.
  Future<bool> updatePlace(Place place) async {
    try {
      await placeService.updatePlace(place);
      return true;
    } catch (e) {
      throw Exception('Error al actualizar lugar: $e');
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Deletes a place from the data source.
  ///
  /// [id] The unique identifier of the place to delete.
  ///
  /// Returns true if the place was successfully deleted.
  /// Throws an exception if the place is not found or operation fails.
  Future<bool> deletePlace(String id) async {
    try {
      await placeService.deletePlace(id);
      return true;
    } catch (e) {
      throw Exception('Error al eliminar lugar: $e');
    }
  }

  // ==================== SEARCH OPERATIONS ====================

  /// Searches for places based on a query string.
  ///
  /// [query] The search term to look for in place names and descriptions.
  ///
  /// Returns a list of places that match the search criteria.
  /// This method filters places locally after fetching all places.
  Future<List<Place>> searchPlaces(String query) async {
    try {
      final allPlaces = await placeService.getPlaces();
      final lowercaseQuery = query.toLowerCase();

      return allPlaces.where((place) {
        return place.name.toLowerCase().contains(lowercaseQuery) ||
            place.description.toLowerCase().contains(lowercaseQuery) ||
            place.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
      }).toList();
    } catch (e) {
      throw Exception('Error al buscar lugares: $e');
    }
  }

  /// 🏢 Searches for places owned by a specific admin.
  ///
  /// [query] The search term to look for.
  /// [ownerId] The admin user ID to filter by.
  ///
  /// Returns places owned by the admin that match the search criteria.
  Future<List<Place>> searchPlacesByOwner(String query, String ownerId) async {
    try {
      final ownerPlaces = await placeService.getPlacesByOwnerId(ownerId);
      final lowercaseQuery = query.toLowerCase();

      return ownerPlaces.where((place) {
        return place.name.toLowerCase().contains(lowercaseQuery) ||
            place.description.toLowerCase().contains(lowercaseQuery) ||
            place.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
      }).toList();
    } catch (e) {
      throw Exception('Error al buscar lugares por propietario: $e');
    }
  }

  /// Gets places within a specific radius from a given location.
  ///
  /// [latitude] The latitude of the center point.
  /// [longitude] The longitude of the center point.
  /// [radiusInKm] The radius in kilometers to search within.
  ///
  /// Returns a list of places within the specified radius.
  /// This method filters places based on distance calculation.
  Future<List<Place>> getPlacesNearby({
    required double latitude,
    required double longitude,
    required double radiusInKm,
  }) async {
    try {
      final allPlaces = await placeService.getPlaces();

      return allPlaces.where((place) {
        final distance = _calculateDistance(
          latitude,
          longitude,
          place.latitude,
          place.longitude,
        );
        return distance <= radiusInKm;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener lugares cercanos: $e');
    }
  }

  /// Gets places filtered by rating range.
  ///
  /// [minRating] The minimum rating (inclusive).
  /// [maxRating] The maximum rating (inclusive).
  ///
  /// Returns a list of places within the specified rating range.
  Future<List<Place>> getPlacesByRating({
    required double minRating,
    required double maxRating,
  }) async {
    try {
      final allPlaces = await placeService.getPlaces();

      return allPlaces.where((place) {
        return place.rating >= minRating && place.rating <= maxRating;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener lugares por calificación: $e');
    }
  }

  /// Gets places filtered by price range.
  ///
  /// [minPrice] The minimum average price (inclusive).
  /// [maxPrice] The maximum average price (inclusive).
  ///
  /// Returns a list of places within the specified price range.
  Future<List<Place>> getPlacesByPriceRange({
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      final allPlaces = await placeService.getPlaces();

      return allPlaces.where((place) {
        return place.averagePrice >= minPrice && place.averagePrice <= maxPrice;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener lugares por rango de precio: $e');
    }
  }

  /// Gets only places that are currently open.
  ///
  /// Returns a list of places that are marked as open.
  Future<List<Place>> getOpenPlaces() async {
    try {
      final allPlaces = await placeService.getPlaces();
      return allPlaces.where((place) => place.isOpen).toList();
    } catch (e) {
      throw Exception('Error al obtener lugares abiertos: $e');
    }
  }

  // ==================== UTILITY METHODS ====================

  /// Calculates the distance between two geographic points using the Haversine formula.
  ///
  /// Returns the distance in kilometers.
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371; // Earth's radius in kilometers

    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_degreesToRadians(lat1)) *
            cos(_degreesToRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadius * c;
  }

  /// Converts degrees to radians.
  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}

/// 📊 Analytics data for places owned by an admin user
class PlaceOwnerAnalytics {
  const PlaceOwnerAnalytics({
    required this.ownerId,
    required this.totalPlaces,
    required this.totalViews,
    required this.totalReviews,
    required this.averageRating,
    required this.totalFavorites,
    required this.placesWithHighRating,
    required this.placesNeedingAttention,
    required this.monthlyMetrics,
  });

  /// ID del propietario admin
  final String ownerId;

  /// Número total de lugares que posee
  final int totalPlaces;

  /// Total de visualizaciones en todos sus lugares
  final int totalViews;

  /// Total de reseñas en todos sus lugares
  final int totalReviews;

  /// Calificación promedio de todos sus lugares
  final double averageRating;

  /// Total de favoritos en todos sus lugares
  final int totalFavorites;

  /// Lugares con calificación alta (>= 4.0)
  final int placesWithHighRating;

  /// Lugares que necesitan atención (< 3.0 rating o sin reviews)
  final int placesNeedingAttention;

  /// Métricas mensuales de rendimiento
  final Map<String, dynamic> monthlyMetrics;

  /// Factory para crear desde datos de Firebase
  factory PlaceOwnerAnalytics.fromAnalyticsData(
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
      placesWithHighRating: data['placesWithHighRating'] as int? ?? 0,
      placesNeedingAttention: data['placesNeedingAttention'] as int? ?? 0,
      monthlyMetrics: data['monthlyMetrics'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Convierte a JSON para storage
  Map<String, dynamic> toJson() {
    return {
      'ownerId': ownerId,
      'totalPlaces': totalPlaces,
      'totalViews': totalViews,
      'totalReviews': totalReviews,
      'averageRating': averageRating,
      'totalFavorites': totalFavorites,
      'placesWithHighRating': placesWithHighRating,
      'placesNeedingAttention': placesNeedingAttention,
      'monthlyMetrics': monthlyMetrics,
    };
  }
}
