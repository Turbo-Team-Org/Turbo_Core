import 'package:core/core.dart';
import 'package:dio/dio.dart';

class PlaceCategoryServiceEdge implements PlaceCategoryRepositoryInterface {
  PlaceCategoryServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  String _url(String path) => '$baseUrl$path';

  @override
  Future<void> upsertPlaceCategory(PlaceCategory placeCategory) async {
    await httpClient.post<void>(
      _url('/admin_upsert_place_category'),
      data: placeCategory.toJson(),
    );
  }

  @override
  Future<bool> assignCategoryToPlace(String placeId, String categoryId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_assign_category_to_place'),
          data: {'placeId': placeId, 'categoryId': categoryId},
        );
    return (res.data?['ok'] as bool?) ?? true;
  }

  @override
  Future<bool> removeCategoryFromPlace(
    String placeId,
    String categoryId,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_remove_category_from_place'),
          data: {'placeId': placeId, 'categoryId': categoryId},
        );
    return (res.data?['ok'] as bool?) ?? true;
  }

  @override
  Future<bool> updatePlaceCategories(
    String placeId,
    List<String> categoryIds,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_update_place_categories'),
          data: {'placeId': placeId, 'categoryIds': categoryIds},
        );
    return (res.data?['ok'] as bool?) ?? true;
  }

  @override
  Future<List<Place>> getPlacesInCategory(String categoryId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_places_in_category'),
      queryParameters: {'categoryId': categoryId},
    );
    final items = res.data ?? <dynamic>[];
    return items.map((e) => Place.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Category>> getCategoriesForPlace(String placeId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_categories_for_place'),
      queryParameters: {'placeId': placeId},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }
}
