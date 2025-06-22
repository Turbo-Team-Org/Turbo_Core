import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';

class PlaceCategoryRepository {
  PlaceCategoryRepository({PlaceCategoryService? placeCategoryService})
      : _service = placeCategoryService ?? PlaceCategoryService();

  final PlaceCategoryService _service;

  Future<void> upsertPlaceCategory(PlaceCategory placeCategory) async {
    return await _service.upsertPlaceCategory(placeCategory);
  }

  Future<bool> assignCategoryToPlace(String placeId, String categoryId) async {
    return await _service.assignCategoryToPlace(placeId, categoryId);
  }

  Future<List<Place>> getPlacesInCategory(String categoryId) async {
    return await _service.getPlacesInCategory(categoryId);
  }

  Future<bool> removeCategoryFromPlace(
      String placeId, String categoryId) async {
    return await removeCategoryFromPlace(placeId, categoryId);
  }

  Future<bool> updatePlaceCategories(
      String placeId, List<String> categoryIds) async {
    return await updatePlaceCategories(placeId, categoryIds);
  }
}
