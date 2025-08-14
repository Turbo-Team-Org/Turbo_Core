import 'package:core/src/turbo_core_repositories/place_category_repository/interface/place_category_repository_interface.dart';
import 'package:core/src/turbo_core_repositories/place_category_repository/models/place_category.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class PlaceCategoryServiceSupabase implements PlaceCategoryRepositoryInterface {
  PlaceCategoryServiceSupabase({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabase;
  final String _tableName = 'place_categories';

  @override
  Future<void> upsertPlaceCategory(PlaceCategory placeCategory) async {
    try {
      await _supabase.from(_tableName).upsert({
        'place_id': placeCategory.placeId,
        'category_id': placeCategory.categoryId,
        'created_at': placeCategory.createdAt.toIso8601String(),
      });
    } catch (e) {
      throw Exception('Error al upsert place category: $e');
    }
  }

  /// Asigna una categoría a un lugar
  @override
  Future<bool> assignCategoryToPlace(String placeId, String categoryId) async {
    try {
      // Insert the place-category relationship
      await _supabase.from(_tableName).insert({
        'place_id': placeId,
        'category_id': categoryId,
        'created_at': DateTime.now().toIso8601String(),
      });

      // Update places count in category using RPC or direct SQL
      await _supabase.rpc('increment_category_places_count', params: {
        'category_id': categoryId,
      });

      return true;
    } catch (e) {
      throw Exception('Error al asignar categoría: $e');
    }
  }

  /// Elimina una categoría de un lugar
  @override
  Future<bool> removeCategoryFromPlace(
    String placeId,
    String categoryId,
  ) async {
    try {
      // Delete the relationship
      final response = await _supabase
          .from(_tableName)
          .delete()
          .eq('place_id', placeId)
          .eq('category_id', categoryId);

      // Decrement places count in category
      await _supabase.rpc('decrement_category_places_count', params: {
        'category_id': categoryId,
      });

      return true;
    } catch (e) {
      throw Exception('Error al eliminar categoría de lugar: $e');
    }
  }

  /// Actualiza todas las categorías de un lugar
  @override
  Future<bool> updatePlaceCategories(
    String placeId,
    List<String> categoryIds,
  ) async {
    try {
      // Get current categories for this place
      final currentResponse = await _supabase
          .from(_tableName)
          .select('category_id')
          .eq('place_id', placeId);

      final currentCategoryIds =
          currentResponse.map((item) => item['category_id'] as String).toList();

      // Remove all current relationships
      await _supabase.from(_tableName).delete().eq('place_id', placeId);

      // Decrement count for removed categories
      for (final categoryId in currentCategoryIds) {
        await _supabase.rpc('decrement_category_places_count', params: {
          'category_id': categoryId,
        });
      }

      // Add new relationships
      final newRelationships = categoryIds
          .map((categoryId) => {
                'place_id': placeId,
                'category_id': categoryId,
                'created_at': DateTime.now().toIso8601String(),
              })
          .toList();

      if (newRelationships.isNotEmpty) {
        await _supabase.from(_tableName).insert(newRelationships);

        // Increment count for new categories
        for (final categoryId in categoryIds) {
          await _supabase.rpc('increment_category_places_count', params: {
            'category_id': categoryId,
          });
        }
      }

      return true;
    } catch (e) {
      throw Exception('Error al actualizar categorías: $e');
    }
  }

  /// Obtiene todas las categorías de un lugar
  @override
  Future<List<Category>> getCategoriesForPlace(String placeId) async {
    try {
      // Get category IDs for this place
      final relationshipResponse = await _supabase
          .from(_tableName)
          .select('category_id')
          .eq('place_id', placeId);

      if (relationshipResponse.isEmpty) {
        return [];
      }

      final categoryIds = relationshipResponse
          .map((item) => item['category_id'] as String)
          .toList();

      // Get the actual categories
      final categoriesResponse = await _supabase
          .from('categories')
          .select('*')
          .inFilter('id', categoryIds);

      return categoriesResponse
          .map<Category>((data) => _categoryFromSupabase(data))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener categorías del lugar: $e');
    }
  }

  /// Obtiene todos los lugares de una categoría
  @override
  Future<List<Place>> getPlacesInCategory(String categoryId) async {
    try {
      // Get place IDs for this category
      final relationshipResponse = await _supabase
          .from(_tableName)
          .select('place_id')
          .eq('category_id', categoryId);

      if (relationshipResponse.isEmpty) {
        return [];
      }

      final placeIds = relationshipResponse
          .map((item) => item['place_id'] as String)
          .toList();

      // Get the actual places
      final placesResponse =
          await _supabase.from('places').select('*').inFilter('id', placeIds);

      return placesResponse
          .map<Place>((data) => _placeFromSupabase(data))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener lugares por categoría: $e');
    }
  }

  /// Converts Supabase data to Place model
  Place _placeFromSupabase(Map<String, dynamic> data) {
    String asString(dynamic value) => value?.toString() ?? '';
    double asDouble(dynamic value) => value == null
        ? 0.0
        : (value is double ? value : double.tryParse(value.toString()) ?? 0.0);
    int asInt(dynamic value) => value == null
        ? 0
        : (value is int ? value : int.tryParse(value.toString()) ?? 0);
    bool asBool(dynamic value) => value is bool ? value : value == true;
    List<String> asStringList(dynamic value) =>
        value is List ? List<String>.from(value) : [];
    Map<String, dynamic> asMap(dynamic value) =>
        value is Map<String, dynamic> ? value : {};

    return Place(
      id: asString(data['id']),
      name: asString(data['name']),
      description: asString(data['description']),
      address: asString(data['address']),
      averagePrice: asDouble(data['average_price']),
      imageUrls: asStringList(data['image_urls']),
      rating: asDouble(data['rating']),
      reviews: [], // Reviews are loaded separately
      tags: asStringList(data['tags']),
      isOpen: asBool(data['is_open']),
      mainImage: asString(data['main_image']),
      favoriteCount: asInt(data['favorite_count']),
      menuUrl: asString(data['menu_url']),
      latitude: asDouble(data['latitude']),
      longitude: asDouble(data['longitude']),
      categoryId: asString(data['category_id']),
      categoryName: asString(data['category_name']),
      categoryIcon: asString(data['category_icon']),
      openingHours:
          asMap(data['opening_hours']).cast<String, Map<String, String>>(),
      phone: asString(data['phone']),
      website: asString(data['website']),
      priceLevel: asInt(data['price_level']),
      metadata: asMap(data['metadata']),
      ownerIds: asStringList(data['owner_ids']),
      createdBy: asString(data['created_by']),
      createdAt: data['created_at'] != null
          ? DateTime.parse(data['created_at'].toString())
          : DateTime.now(),
      lastUpdated: data['updated_at'] != null
          ? DateTime.parse(data['updated_at'].toString())
          : DateTime.now(),
    );
  }

  /// Converts Supabase data to Category model
  Category _categoryFromSupabase(Map<String, dynamic> data) {
    String asString(dynamic value) => value?.toString() ?? '';
    int asInt(dynamic value) => value == null
        ? 0
        : (value is int ? value : int.tryParse(value.toString()) ?? 0);
    bool asBool(dynamic value) => value is bool ? value : value == true;
    Map<String, dynamic> asMap(dynamic value) =>
        value is Map<String, dynamic> ? value : {};

    return Category(
      id: asString(data['id']),
      name: asString(data['name']),
      icon: asString(data['icon']),
      description: asString(data['description']),
      imageUrl: asString(data['image_url']),
      placesCount: asInt(data['places_count']),
      isFeatured: asBool(data['is_featured']),
      metadata: asMap(data['metadata']),
    );
  }
}
