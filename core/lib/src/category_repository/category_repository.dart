import 'package:core/src/place_repository/models/place/place.dart';
import 'model/category.dart';
import 'service/category_service.dart';
import 'service/places_category_service/places_categroy_service.dart';

class CategoryRepository {
  final CategoryService _categoryService;
  final PlaceCategoryService _placeCategoryService;

  CategoryRepository({
    required CategoryService categoryService,
    required PlaceCategoryService placeCategoryService,
  })  : _categoryService = categoryService,
        _placeCategoryService = placeCategoryService;

  Future<List<Category>> getAllCategories() async {
    try {
      return await _categoryService.getAllCategories();
    } catch (e) {
      throw Exception('Error al obtener categorías: ${e.toString()}');
    }
  }

  Future<Category?> getCategoryById(String id) async {
    try {
      return await _categoryService.getCategoryById(id);
    } catch (e) {
      throw Exception('Error al obtener categoría: ${e.toString()}');
    }
  }

  Future<bool> addCategory(Category category) async {
    try {
      await _categoryService.addCategory(category);
      return true;
    } catch (e) {
      throw Exception('Error al añadir categoría: ${e.toString()}');
    }
  }

  Future<bool> updateCategory(Category category) async {
    try {
      await _categoryService.updateCategory(category);
      return true;
    } catch (e) {
      throw Exception('Error al actualizar categoría: ${e.toString()}');
    }
  }

  Future<bool> deleteCategory(String id) async {
    try {
      await _categoryService.deleteCategory(id);
      return true;
    } catch (e) {
      throw Exception('Error al eliminar categoría: ${e.toString()}');
    }
  }

  ///Category and Place Association Methods
  Future<bool> assignCategoryToPlace(String placeId, String categoryId) async {
    try {
      return await _placeCategoryService.assignCategoryToPlace(
        placeId,
        categoryId,
      );
    } catch (e) {
      throw Exception('Error al asignar categoría a lugar: ${e.toString()}');
    }
  }

  Future<bool> updateCategoryAssociations(
    String placeId,
    List<String> categoryIds,
  ) async {
    try {
      return await _placeCategoryService.updatePlaceCategories(
        placeId,
        categoryIds,
      );
    } catch (e) {
      throw Exception(
        'Error al actualizar asociaciones de categorías: ${e.toString()}',
      );
    }
  }

  Future<bool> removeCategoryFromPlace(
    String placeId,
    String categoryId,
  ) async {
    try {
      return await _placeCategoryService.removeCategoryFromPlace(
        placeId,
        categoryId,
      );
    } catch (e) {
      throw Exception('Error al eliminar categoría de lugar: ${e.toString()}');
    }
  }

  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    try {
      return await _placeCategoryService.getPlacesInCategory(categoryId);
    } catch (e) {
      throw Exception(
        'Error al obtener lugares por categoría: ${e.toString()}',
      );
    }
  }
}
