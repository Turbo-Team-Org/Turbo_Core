import 'package:core/src/turbo_core_repositories/favorite_repository/interface/favorite_interface.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/models/favorite.dart';
import 'package:dio/dio.dart';

class FavoriteServiceEdge implements FavoriteInterface {
  FavoriteServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  String _url(String path) => '$baseUrl$path';

  @override
  Future<List<Favorite>> getFavorites(String userId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_favorites'),
      queryParameters: {'userId': userId},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Favorite.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> isFavorite(String userId, String placeId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_is_favorite'),
          queryParameters: {'userId': userId, 'placeId': placeId},
        );
    return (res.data?['isFavorite'] as bool?) ?? false;
  }

  @override
  Future<void> addFavorite(String userId, String placeId) async {
    await httpClient.post<void>(
      _url('/public_add_favorite'),
      data: {'userId': userId, 'placeId': placeId},
    );
  }

  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    await httpClient.post<void>(
      _url('/public_toggle_favorite'),
      data: favorite.toJson(),
    );
  }

  @override
  Future<void> removeFavorite(String userId, String placeId) async {
    await httpClient.post<void>(
      _url('/public_remove_favorite'),
      data: {'userId': userId, 'placeId': placeId},
    );
  }
}
