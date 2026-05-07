import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:core/src/turbo_core_repositories/review_repository/service/review_service_edge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '_test_helpers.dart';

void main() {
  const baseUrl = 'https://stub.functions.supabase.co';

  late MockDio dio;
  late ReviewServiceEdge service;

  setUpAll(registerEdgeFallbacks);

  setUp(() {
    dio = MockDio();
    service = ReviewServiceEdge(baseUrl: baseUrl, httpClient: dio);
  });

  group('ReviewServiceEdge', () {
    final apiReview = <String, dynamic>{
      'id': 'rev-1',
      'userId': 'user-1',
      'userName': 'David',
      'userAvatar': '',
      'comment': 'Excelente',
      'rating': 5.0,
      'date': DateTime(2026).toIso8601String(),
      'imageUrls': <String>[],
      'status': 'approved',
    };

    test('getReviews llama a /public_get_reviews', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<List<dynamic>>(<dynamic>[apiReview]),
      );

      final result = await service.getReviews();

      expect(result, hasLength(1));
      expect(result.first.id, 'rev-1');
      expect(result.first.status, ReviewStatus.approved);
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_reviews',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('getReviewsFromAPlace incluye placeId en query', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<List<dynamic>>(<dynamic>[]));

      await service.getReviewsFromAPlace('place-1');

      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_reviews_by_place',
          queryParameters: {'placeId': 'place-1'},
        ),
      ).called(1);
    });

    test('addReview hace POST a /public_add_review devolviendo id',
        () async {
      when(
        () => dio.post<Map<String, dynamic>>(
          any(),
          data: any<Object?>(named: 'data'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(
          <String, dynamic>{'id': 'rev-new'},
        ),
      );

      final review = Review(
        id: '',
        userId: 'user-1',
        userName: 'David',
        userAvatar: '',
        comment: 'Bueno',
        rating: 4.5,
        date: DateTime(2026),
      );

      final id = await service.addReview(review, 'place-1');

      expect(id, 'rev-new');
      verify(
        () => dio.post<Map<String, dynamic>>(
          '$baseUrl/public_add_review',
          data: any<Object?>(named: 'data'),
        ),
      ).called(1);
    });

    test('deleteReview hace POST a /admin_delete_review', () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      await service.deleteReview('rev-1');

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_delete_review',
          data: {'id': 'rev-1'},
        ),
      ).called(1);
    });

    test('approveReview envia reviewId y moderationNote', () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      await service.approveReview('rev-1', moderationNote: 'OK');

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_approve_review',
          data: {'reviewId': 'rev-1', 'moderationNote': 'OK'},
        ),
      ).called(1);
    });

    test('getReviewStats llama a /public_get_review_stats con placeId',
        () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(
          <String, dynamic>{'count': 3, 'avgRating': 4.5},
        ),
      );

      final stats = await service.getReviewStats('place-1');

      expect(stats['count'], 3);
      verify(
        () => dio.get<Map<String, dynamic>>(
          '$baseUrl/public_get_review_stats',
          queryParameters: {'placeId': 'place-1'},
        ),
      ).called(1);
    });
  });
}
