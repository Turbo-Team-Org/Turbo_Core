import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:core/src/turbo_core_repositories/category_repository/service/category_service.dart';
import 'package:core/src/turbo_core_repositories/place_category_repository/place_category_repository_imports.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';

/// Repository for managing categories and their associations with places.
class CategoryRepository {
  /// Constructor for the CategoryRepository.
  CategoryRepository({
    required CategoryService categoryService,
    required PlaceCategoryService placeCategoryService,
  })  : _categoryService = categoryService,
        _placeCategoryService = placeCategoryService;
  final CategoryService _categoryService;
  final PlaceCategoryService _placeCategoryService;

  /// Gets all categories.
  Future<List<Category>> getAllCategories() async {
    try {
      return await _categoryService.getAllCategories();
    } catch (e) {
      throw Exception('Error al obtener categorías: $e');
    }
  }

  /// Gets a category by its ID.
  Future<Category?> getCategoryById(String id) async {
    try {
      return await _categoryService.getCategoryById(id);
    } catch (e) {
      throw Exception('Error al obtener categoría: $e');
    }
  }

  /// Adds a new category.
  Future<bool> addCategory(Category category) async {
    try {
      await _categoryService.addCategory(category);
      return true;
    } catch (e) {
      throw Exception('Error al añadir categoría: $e');
    }
  }

  /// Updates a category.
  Future<bool> updateCategory(Category category) async {
    try {
      await _categoryService.updateCategory(category);
      return true;
    } catch (e) {
      throw Exception('Error al actualizar categoría: $e');
    }
  }

  /// Deletes a category by its ID.
  Future<bool> deleteCategory(String id) async {
    try {
      await _categoryService.deleteCategory(id);
      return true;
    } catch (e) {
      throw Exception('Error al eliminar categoría: $e');
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
      throw Exception('Error al asignar categoría a lugar: $e');
    }
  }

  /// Updates the associations of a place with categories.
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
      throw Exception('Error al actualizar asociaciones de categorías: $e');
    }
  }

  /// Removes a category from a place.
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
      throw Exception('Error al eliminar categoría de lugar: $e');
    }
  }

  /// Gets places by category.
  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    try {
      return await _placeCategoryService.getPlacesInCategory(categoryId);
    } catch (e) {
      throw Exception('Error al obtener lugares por categoría: $e');
    }
  }
}
