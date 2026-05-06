import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/service/place_service_edge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '_test_helpers.dart';

class _MockAnalytics extends Mock implements AnalyticsInterface {}

class _AlwaysAllowAuth implements PlaceAuthorizationInterface {
  const _AlwaysAllowAuth();
  @override
  bool canManagePlace(String placeId) => true;
}

void main() {
  const baseUrl = 'https://stub.functions.supabase.co';

  late MockDio dio;
  late _MockAnalytics analytics;
  late PlaceServiceEdge service;

  setUpAll(registerEdgeFallbacks);

  setUp(() {
    dio = MockDio();
    analytics = _MockAnalytics();
    when(() => analytics.initializeAnalyticsStructure(any()))
        .thenAnswer((_) async {});
    service = PlaceServiceEdge(
      baseUrl: baseUrl,
      httpClient: dio,
      analyticsService: analytics,
      authorization: const _AlwaysAllowAuth(),
    );
  });

  group('PlaceServiceEdge', () {
    final apiPlace = <String, dynamic>{
      'id': 'place-1',
      'name': 'Bodeguita',
      'description': 'Restaurante cubano',
      'address': 'La Habana',
      'rating': 4.5,
      'is_open': true,
      'category_id': 'cat-1',
      'image_urls': <String>[],
      'tags': <String>[],
      'metadata': <String, dynamic>{},
      'opening_hours': <String, dynamic>{},
      'owner_ids': <String>[],
    };

    test('getPlaces llama a /public_get_places', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<List<dynamic>>(<dynamic>[apiPlace]),
      );

      final result = await service.getPlaces();

      expect(result, hasLength(1));
      expect(result.first.id, 'place-1');
      expect(result.first.name, 'Bodeguita');
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_places',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('getPlaceById envia id en query', () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(apiPlace),
      );

      final result = await service.getPlaceById('place-1');

      expect(result.id, 'place-1');
      verify(
        () => dio.get<Map<String, dynamic>>(
          '$baseUrl/public_get_place_by_id',
          queryParameters: {'id': 'place-1'},
        ),
      ).called(1);
    });

    test('getPlaceByName envia name en query', () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(apiPlace),
      );

      final result = await service.getPlaceByName('Bodeguita');

      expect(result.name, 'Bodeguita');
      verify(
        () => dio.get<Map<String, dynamic>>(
          '$baseUrl/public_get_place_by_name',
          queryParameters: {'name': 'Bodeguita'},
        ),
      ).called(1);
    });

    test('getPlacesByCategory envia categoryId en query', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<List<dynamic>>(<dynamic>[]));

      final result = await service.getPlacesByCategory('cat-1');

      expect(result, isEmpty);
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_places_by_category',
          queryParameters: {'categoryId': 'cat-1'},
        ),
      ).called(1);
    });

    test('deletePlace POST a /admin_delete_place y respeta autorizacion',
        () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      await service.deletePlace('place-1');

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_delete_place',
          data: {'id': 'place-1'},
        ),
      ).called(1);
    });

    test('deletePlace lanza si la autorizacion lo bloquea', () async {
      final blockedService = PlaceServiceEdge(
        baseUrl: baseUrl,
        httpClient: dio,
        analyticsService: analytics,
        authorization: const _DenyAuth(),
      );

      expect(
        blockedService.deletePlace('place-1'),
        throwsA(isA<Exception>()),
      );
      verifyNever(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      );
    });

    test('getPlacesByOwnerId envia ownerId en query', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<List<dynamic>>(<dynamic>[]));

      await service.getPlacesByOwnerId('owner-1');

      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/admin_get_places_by_owner',
          queryParameters: {'ownerId': 'owner-1'},
        ),
      ).called(1);
    });
  });
}

class _DenyAuth implements PlaceAuthorizationInterface {
  const _DenyAuth();
  @override
  bool canManagePlace(String placeId) => false;
}
