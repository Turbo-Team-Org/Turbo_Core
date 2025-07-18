import 'package:core/src/turbo_core_repositories/category_repository/interface/category_interface.dart';
import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Category service for Supabase
class CategoryServiceSupabase implements CategoryInterface {
  /// Constructor
  CategoryServiceSupabase({SupabaseClient? supabaseClient})
    : _supabase = supabaseClient ?? Supabase.instance.client;

  /// Supabase client instance
  final SupabaseClient _supabase;

  /// Get all categories
  @override
  Future<List<Category>> getCategories() async {
    try {
      final response = await _supabase
          .from('categories')
          .select('*')
          .order('name', ascending: true);

      return response.map<Category>((data) => _categoryFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting categories: $e');
    }
  }

  /// Get category by id
  @override
  Future<Category> getCategoryById(String id) async {
    try {
      final response = await _supabase
          .from('categories')
          .select('*')
          .eq('id', id)
          .maybeSingle();

      if (response == null) {
        throw Exception('Category not found');
      }

      return _categoryFromSupabase(response);
    } catch (e) {
      throw Exception('Error getting category by id: $e');
    }
  }

  /// Add category
  @override
  Future<void> addCategory(Category category) async {
    try {
      await _supabase.from('categories').insert(_categoryToSupabaseData(category));
    } catch (e) {
      throw Exception('Error adding category: $e');
    }
  }

  /// Update category
  @override
  Future<void> updateCategory(Category category) async {
    try {
      await _supabase
          .from('categories')
          .update(_categoryToSupabaseData(category))
          .eq('id', category.id);
    } catch (e) {
      throw Exception('Error updating category: $e');
    }
  }

  /// Delete category
  @override
  Future<void> deleteCategory(String id) async {
    try {
      await _supabase.from('categories').delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting category: $e');
    }
  }

  /// Get category by name
  @override
  Future<Category> getCategoryByName(String name) async {
    try {
      final response = await _supabase
          .from('categories')
          .select('*')
          .eq('name', name)
          .maybeSingle();

      if (response == null) {
        throw Exception('Category not found');
      }

      return _categoryFromSupabase(response);
    } catch (e) {
      throw Exception('Error getting category by name: $e');
    }
  }

  /// Converts Supabase data to Category model
  Category _categoryFromSupabase(Map<String, dynamic> data) {
    return Category.fromJson({
      'id': data['id'],
      'name': data['name'] ?? '',
      'description': data['description'] ?? '',
      'icon': data['icon'] ?? '',
      'color': data['color'] ?? '',
      'isActive': data['is_active'] ?? true,
      'sortOrder': data['sort_order'] ?? 0,
      'createdAt': data['created_at'],
      'updatedAt': data['updated_at'],
    });
  }

  /// Converts Category model to Supabase data
  Map<String, dynamic> _categoryToSupabaseData(Category category) {
    final json = category.toJson();
    return {
      'id': json['id'],
      'name': json['name'],
      'description': json['description'],
      'icon': json['icon'],
      'color': json['color'],
      'is_active': json['isActive'],
      'sort_order': json['sortOrder'],
      'created_at': json['createdAt'],
      'updated_at': json['updatedAt'] ?? DateTime.now().toIso8601String(),
    };
  }
}