import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place_owner_analytics.dart';

/// Place interface
abstract class PlaceInterface {
  /// Get all places
  Future<List<Place>> getPlaces();

  /// Get place by id
  Future<Place> getPlaceById(String id);

  /// Get place by name
  Future<Place> getPlaceByName(String name);

  /// Get places by category
  Future<List<Place>> getPlacesByCategory(String categoryId);

  /// Add a new place. Returns the persisted place id.
  Future<String> addPlace(Place place);

  /// Update an existing place
  Future<void> updatePlace(Place place);

  /// Delete a place
  Future<void> deletePlace(String id);

  // ==================== ADMIN OPERATIONS ====================

  /// 🏢 Gets places owned by a specific admin user
  Future<List<Place>> getPlacesByOwnerId(String ownerId);

  /// 🏢 Gets places owned by multiple admin users
  Future<List<Place>> getPlacesByOwnerIds(List<String> ownerIds);

  /// 👑 Updates the ownership of a place (super admin only)
  Future<Place> updatePlaceOwnership(String placeId, List<String> ownerIds);

  /// 📊 Gets analytics summary for places owned by an admin
  Future<PlaceOwnerAnalytics> getPlaceAnalyticsByOwnerId(String ownerId);

  /// 🏢 Adds a new place with admin ownership
  Future<void> addPlaceWithOwner(Place place, String ownerId);

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
  });

  /// 🎤 Búsqueda por voz (convierte texto a búsqueda)
  Future<List<Place>> searchPlacesByVoice(
    String voiceQuery, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  });

  /// 🔍 Búsqueda inteligente con múltiples estrategias
  Future<List<Place>> intelligentSearch(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  });

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
  });
}
