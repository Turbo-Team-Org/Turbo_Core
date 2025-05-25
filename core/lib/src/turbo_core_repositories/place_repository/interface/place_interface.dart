import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';

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

  /// Add a new place
  Future<void> addPlace(Place place);

  /// Update an existing place
  Future<void> updatePlace(Place place);

  /// Delete a place
  Future<void> deletePlace(String id);
}
