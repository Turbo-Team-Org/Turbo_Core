import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:core/src/turbo_core_repositories/category_repository/service/category_service_edge.dart';
import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '_test_helpers.dart';

void main() {
  const baseUrl = 'https://stub.functions.supabase.co';

  late MockDio dio;
  late CategoryServiceEdge service;

  setUpAll(registerEdgeFallbacks);

  setUp(() {
    dio = MockDio();
    service = CategoryServiceEdge(baseUrl: baseUrl, httpClient: dio);
  });

  group('CategoryServiceEdge', () {
    final apiCategory = <String, dynamic>{
      'id': 'cat-1',
      'name': 'Restaurantes',
      'icon': 'restaurant',
    };

    test('getCategories llama a /public_get_categories y mapea respuesta',
        () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<List<dynamic>>(<dynamic>[apiCategory]),
      );

      final result = await service.getCategories();

      expect(result, hasLength(1));
      expect(result.first, isA<Category>());
      expect(result.first.id, 'cat-1');
      expect(result.first.name, 'Restaurantes');
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_categories',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('getCategoryById llama a /public_get_category_by_id con id en query',
        () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<Map<String, dynamic>>(apiCategory));

      final result = await service.getCategoryById('cat-1');

      expect(result.id, 'cat-1');
      verify(
        () => dio.get<Map<String, dynamic>>(
          '$baseUrl/public_get_category_by_id',
          queryParameters: {'id': 'cat-1'},
        ),
      ).called(1);
    });

    test('getCategoryByName llama a /public_get_category_by_name con name',
        () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<Map<String, dynamic>>(apiCategory));

      final result = await service.getCategoryByName('Restaurantes');

      expect(result.name, 'Restaurantes');
      verify(
        () => dio.get<Map<String, dynamic>>(
          '$baseUrl/public_get_category_by_name',
          queryParameters: {'name': 'Restaurantes'},
        ),
      ).called(1);
    });

    test('addCategory hace POST a /admin_add_category con body', () async {
      when(
        () => dio.post<void>(
          any(),
          data: any<Object?>(named: 'data'),
        ),
      ).thenAnswer((_) async => okResponse<void>(null));

      const category = Category(id: 'cat-1', name: 'Bares', icon: 'bar');
      await service.addCategory(category);

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_add_category',
          data: any<Object?>(named: 'data'),
        ),
      ).called(1);
    });

    test('updateCategory hace POST a /admin_update_category', () async {
      when(
        () => dio.post<void>(
          any(),
          data: any<Object?>(named: 'data'),
        ),
      ).thenAnswer((_) async => okResponse<void>(null));

      const category = Category(id: 'cat-1', name: 'Bares', icon: 'bar');
      await service.updateCategory(category);

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_update_category',
          data: any<Object?>(named: 'data'),
        ),
      ).called(1);
    });

    test('deleteCategory hace POST a /admin_delete_category con id',
        () async {
      when(
        () => dio.post<void>(
          any(),
          data: any<Object?>(named: 'data'),
        ),
      ).thenAnswer((_) async => okResponse<void>(null));

      await service.deleteCategory('cat-1');

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_delete_category',
          data: {'id': 'cat-1'},
        ),
      ).called(1);
    });

    test('getCategories propaga errores del cliente', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenThrow(
        DioException(
          requestOptions: RequestOptions(path: '/public_get_categories'),
          message: 'boom',
        ),
      );

      expect(service.getCategories(), throwsA(isA<DioException>()));
    });
  });
}
