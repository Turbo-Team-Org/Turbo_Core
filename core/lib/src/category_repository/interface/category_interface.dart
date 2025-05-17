import 'package:core/src/category_repository/model/category.dart';

/// Interface for category repository
abstract class CategoryInterface {
  /// Get all categories
  Future<List<Category>> getCategories();

  /// Get category by id
  Future<Category> getCategoryById(String id);

  /// Add category
  Future<void> addCategory(Category category);

  /// Update category
  Future<void> updateCategory(Category category);

  /// Delete category
  Future<void> deleteCategory(String id);

  /// Get category by name
  Future<Category> getCategoryByName(String name);
}
