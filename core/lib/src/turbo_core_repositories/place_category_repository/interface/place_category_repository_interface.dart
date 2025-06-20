import '../models/place_category.dart';

abstract class PlaceCategoryRepositoryInterface {
  Future<void> upsertPlaceCategory(PlaceCategory placeCategory);
}
