import 'package:core/core.dart';

abstract class PlaceCategoryRepositoryInterface {
  Future<void> upsertPlaceCategory(PlaceCategory placeCategory);
  Future<bool> assignCategoryToPlace(String placeId, String categoryId);
  Future<bool> removeCategoryFromPlace(
    String placeId,
    String categoryId,
  );
  Future<bool> updatePlaceCategories(
    String placeId,
    List<String> categoryIds,
  );
  Future<List<Place>> getPlacesInCategory(String categoryId);
  Future<List<Category>> getCategoriesForPlace(String placeId);
}
