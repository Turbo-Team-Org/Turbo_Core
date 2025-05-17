import 'package:core/src/place_repository/models/place/place.dart';

/// Place interface
abstract class PlaceInterface {
  /// Get places
  Future<List<Place>> getPlaces();

  /// Get place by id
  Future<Place> getPlaceById(String id);

  /// Get place by name
  Future<Place> getPlaceByName(String name);
}
