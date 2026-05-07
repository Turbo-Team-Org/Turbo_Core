import 'package:core/src/turbo_core_repositories/place_category_repository/service/place_category_service_edge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '_test_helpers.dart';

void main() {
  const baseUrl = 'https://stub.functions.supabase.co';

  late MockDio dio;
  late PlaceCategoryServiceEdge service;

  setUpAll(registerEdgeFallbacks);

  setUp(() {
    dio = MockDio();
    service = PlaceCategoryServiceEdge(baseUrl: baseUrl, httpClient: dio);
  });

  group('PlaceCategoryServiceEdge', () {
    test('assignCategoryToPlace POST con placeId y categoryId', () async {
      when(
        () => dio.post<Map<String, dynamic>>(
          any(),
          data: any<Object?>(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(
          <String, dynamic>{'ok': true},
        ),
      );

      final ok = await service.assignCategoryToPlace('place-1', 'cat-1');

      expect(ok, isTrue);
      verify(
        () => dio.post<Map<String, dynamic>>(
          '$baseUrl/admin_assign_category_to_place',
          data: {'placeId': 'place-1', 'categoryId': 'cat-1'},
        ),
      ).called(1);
    });

    test('removeCategoryFromPlace POST con placeId y categoryId', () async {
      when(
        () => dio.post<Map<String, dynamic>>(
          any(),
          data: any<Object?>(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(
          <String, dynamic>{'ok': true},
        ),
      );

      final ok = await service.removeCategoryFromPlace('place-1', 'cat-1');

      expect(ok, isTrue);
      verify(
        () => dio.post<Map<String, dynamic>>(
          '$baseUrl/admin_remove_category_from_place',
          data: {'placeId': 'place-1', 'categoryId': 'cat-1'},
        ),
      ).called(1);
    });

    test('updatePlaceCategories POST con lista', () async {
      when(
        () => dio.post<Map<String, dynamic>>(
          any(),
          data: any<Object?>(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(
          <String, dynamic>{'ok': true},
        ),
      );

      final ok = await service.updatePlaceCategories(
        'place-1',
        ['cat-1', 'cat-2'],
      );

      expect(ok, isTrue);
      verify(
        () => dio.post<Map<String, dynamic>>(
          '$baseUrl/admin_update_place_categories',
          data: {
            'placeId': 'place-1',
            'categoryIds': ['cat-1', 'cat-2'],
          },
        ),
      ).called(1);
    });

    test(
        'getPlacesInCategory GET a /public_get_places_in_category con categoryId',
        () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<List<dynamic>>(<dynamic>[]));

      final result = await service.getPlacesInCategory('cat-1');

      expect(result, isEmpty);
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_places_in_category',
          queryParameters: {'categoryId': 'cat-1'},
        ),
      ).called(1);
    });

    test(
        'getCategoriesForPlace GET a /public_get_categories_for_place con placeId',
        () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<List<dynamic>>(<dynamic>[]));

      final result = await service.getCategoriesForPlace('place-1');

      expect(result, isEmpty);
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_categories_for_place',
          queryParameters: {'placeId': 'place-1'},
        ),
      ).called(1);
    });
  });
}
