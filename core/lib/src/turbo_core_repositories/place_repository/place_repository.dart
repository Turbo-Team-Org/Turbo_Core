import 'dart:math';

import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place_owner_analytics.dart';

/// Repository for managing places and their operations.
///
/// This repository provides a clean interface for place-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to places.
class PlaceRepository {
  /// Constructor for the PlaceRepository.
  PlaceRepository({required this.placeService});

  /// Place service instance for data operations (now accepts interface for environment flexibility)
  final PlaceInterface placeService;

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
  /// Returns the ID of the newly added place.
  /// Throws an exception if the operation fails.
  Future<String> addPlace(Place place) async {
    try {
      return await placeService.addPlace(place);
    } catch (e) {
      throw Exception('Error al agregar lugar: $e');
    }
  }

  /// 🏢 Adds a new place with admin ownership.
  ///
  /// [place] The place to add.
  /// [ownerId] The unique identifier of the admin user who will own the place.
  ///
  /// This method is used by the Admin Panel when an admin user wants to
  /// add a new place to their portfolio.
  Future<void> addPlaceWithOwner(Place place, String ownerId) async {
    try {
      await placeService.addPlaceWithOwner(place, ownerId);
    } catch (e) {
      throw Exception('Error al agregar lugar con propietario: $e');
    }
  }

  // ==================== ADVANCED SEARCH METHODS ====================

  /// 🔍 Búsqueda robusta por texto con múltiples campos
  Future<List<Place>> searchPlacesByText(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      return await placeService.searchPlacesByText(
        query,
        categoryId: categoryId,
        minRating: minRating,
        maxPrice: maxPrice,
        minPrice: minPrice,
        isOpen: isOpen,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error al buscar lugares por texto: $e');
    }
  }

  /// 🎤 Búsqueda por voz (convierte texto a búsqueda)
  Future<List<Place>> searchPlacesByVoice(
    String voiceQuery, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      return await placeService.searchPlacesByVoice(
        voiceQuery,
        categoryId: categoryId,
        minRating: minRating,
        maxPrice: maxPrice,
        minPrice: minPrice,
        isOpen: isOpen,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error al buscar lugares por voz: $e');
    }
  }

  /// 🔍 Búsqueda inteligente con múltiples estrategias
  Future<List<Place>> intelligentSearch(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      return await placeService.intelligentSearch(
        query,
        categoryId: categoryId,
        minRating: minRating,
        maxPrice: maxPrice,
        minPrice: minPrice,
        isOpen: isOpen,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error en búsqueda inteligente: $e');
    }
  }

  /// 🎯 Búsqueda por ubicación con radio configurable
  Future<List<Place>> searchPlacesByLocation({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      return await placeService.searchPlacesByLocation(
        latitude: latitude,
        longitude: longitude,
        radiusKm: radiusKm,
        categoryId: categoryId,
        minRating: minRating,
        maxPrice: maxPrice,
        minPrice: minPrice,
        isOpen: isOpen,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error al buscar lugares por ubicación: $e');
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

  /// Gets places filtered by an approximate price band derived from
  /// [Place.priceLevel] (MVP: no `averagePrice` on the model). Each level is
  /// mapped to a nominal amount: `priceLevel * 25` within [minPrice, maxPrice].
  Future<List<Place>> getPlacesByPriceRange({
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      final allPlaces = await placeService.getPlaces();

      return allPlaces.where((place) {
        final nominal = place.priceLevel * 25.0;
        return nominal >= minPrice && nominal <= maxPrice;
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
