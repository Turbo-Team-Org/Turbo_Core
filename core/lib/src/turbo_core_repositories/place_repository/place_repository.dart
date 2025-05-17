import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/service/place_service.dart';

/// Place repository
class PlaceRepository {
  /// Constructor for the PlaceRepository.
  PlaceRepository({required this.placeService});

  /// Place service
  final PlaceService placeService;

  /// Gets all places.
  Future<List<Place>> getPlaces() async => placeService.getPlaces();
}
