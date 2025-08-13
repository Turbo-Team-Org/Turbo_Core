import 'package:core/src/turbo_core_repositories/category_repository/interface/category_interface.dart';
import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:dio/dio.dart';

class CategoryServiceEdge implements CategoryInterface {
  CategoryServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;

  String _url(String path) => '$baseUrl$path';

  @override
  Future<List<Category>> getCategories() async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_categories'),
    );
    final data = res.data ?? <dynamic>[];
    return data
        .map((e) => Category.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<Category> getCategoryById(String id) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_category_by_id'),
          queryParameters: {'id': id},
        );
    return Category.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<void> addCategory(Category category) async {
    await httpClient.post<void>(
      _url('/admin_add_category'),
      data: category.toJson(),
    );
  }

  @override
  Future<void> updateCategory(Category category) async {
    await httpClient.post<void>(
      _url('/admin_update_category'),
      data: category.toJson(),
    );
  }

  @override
  Future<void> deleteCategory(String id) async {
    await httpClient.post<void>(
      _url('/admin_delete_category'),
      data: {'id': id},
    );
  }

  @override
  Future<Category> getCategoryByName(String name) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_category_by_name'),
          queryParameters: {'name': name},
        );
    return Category.fromJson(res.data ?? <String, dynamic>{});
  }
}
