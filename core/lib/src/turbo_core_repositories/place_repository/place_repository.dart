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

    final double c = 2 * asin(sqrt(a));

    return earthRadius * c;
  }

  /// Converts degrees to radians.
  double _degreesToRadians(double degrees) {
    return degrees * (pi / 180);
  }
}
