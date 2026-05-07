import 'package:core/src/turbo_core_repositories/favorite_repository/models/favorite.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/service/favorite_service_edge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '_test_helpers.dart';

void main() {
  const baseUrl = 'https://stub.functions.supabase.co';

  late MockDio dio;
  late FavoriteServiceEdge service;

  setUpAll(registerEdgeFallbacks);

  setUp(() {
    dio = MockDio();
    service = FavoriteServiceEdge(baseUrl: baseUrl, httpClient: dio);
  });

  group('FavoriteServiceEdge', () {
    final apiFavorite = <String, dynamic>{
      'id': 'fav-1',
      'userId': 'user-1',
      'placeId': 'place-1',
      'date': DateTime(2026).toIso8601String(),
    };

    test('getFavorites llama a /public_get_favorites con userId', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<List<dynamic>>(<dynamic>[apiFavorite]),
      );

      final result = await service.getFavorites('user-1');

      expect(result, hasLength(1));
      expect(result.first.userId, 'user-1');
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_favorites',
          queryParameters: {'userId': 'user-1'},
        ),
      ).called(1);
    });

    test('isFavorite llama a /public_is_favorite y mapea bool', () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(
          <String, dynamic>{'isFavorite': true},
        ),
      );

      final result = await service.isFavorite('user-1', 'place-1');

      expect(result, isTrue);
      verify(
        () => dio.get<Map<String, dynamic>>(
          '$baseUrl/public_is_favorite',
          queryParameters: {'userId': 'user-1', 'placeId': 'place-1'},
        ),
      ).called(1);
    });

    test('isFavorite devuelve false si la respuesta no trae el campo',
        () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async =>
            okResponse<Map<String, dynamic>>(<String, dynamic>{}),
      );

      final result = await service.isFavorite('user-1', 'place-1');

      expect(result, isFalse);
    });

    test('addFavorite hace POST a /public_add_favorite', () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      await service.addFavorite('user-1', 'place-1');

      verify(
        () => dio.post<void>(
          '$baseUrl/public_add_favorite',
          data: {'userId': 'user-1', 'placeId': 'place-1'},
        ),
      ).called(1);
    });

    test('toggleFavorite hace POST a /public_toggle_favorite', () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      final favorite = Favorite(
        id: 'fav-1',
        userId: 'user-1',
        placeId: 'place-1',
        date: DateTime(2026),
      );
      await service.toggleFavorite(favorite);

      verify(
        () => dio.post<void>(
          '$baseUrl/public_toggle_favorite',
          data: any<Object?>(named: 'data'),
        ),
      ).called(1);
    });

    test('removeFavorite hace POST a /public_remove_favorite', () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      await service.removeFavorite('user-1', 'place-1');

      verify(
        () => dio.post<void>(
          '$baseUrl/public_remove_favorite',
          data: {'userId': 'user-1', 'placeId': 'place-1'},
        ),
      ).called(1);
    });
  });
}
