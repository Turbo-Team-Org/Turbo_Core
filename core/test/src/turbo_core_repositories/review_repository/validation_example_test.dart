import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:core/src/turbo_core_repositories/review_repository/review_repository.dart';
import 'package:core/src/turbo_core_repositories/review_repository/service/review_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Mocks
class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockReviewService extends Mock implements ReviewService {}

void main() {
  group('ReviewRepository Parameter Validation Tests', () {
    late ReviewRepository repository;
    late MockReviewService mockService;

    setUp(() {
      mockService = MockReviewService();
      repository = ReviewRepository(reviewService: mockService);
    });

    group('Pagination Parameter Validation', () {
      test('getAllReviews throws ArgumentError for page < 1', () async {
        // Act & Assert
        expect(
          () async => repository.getAllReviews(page: 0, limit: 20),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Page number must be greater than or equal to 1'),
            ),
          ),
        );
      });

      test('getAllReviews throws ArgumentError for negative page', () async {
        // Act & Assert
        expect(
          () async => repository.getAllReviews(page: -1, limit: 20),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Page number must be greater than or equal to 1'),
            ),
          ),
        );
      });

      test('getAllReviews throws ArgumentError for limit <= 0', () async {
        // Act & Assert
        expect(
          () async => repository.getAllReviews(page: 1, limit: 0),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Limit must be greater than 0'),
            ),
          ),
        );

        expect(
          () async => repository.getAllReviews(page: 1, limit: -5),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Limit must be greater than 0'),
            ),
          ),
        );
      });

      test('getAllReviews throws ArgumentError for excessive limit', () async {
        // Act & Assert
        expect(
          () async => repository.getAllReviews(page: 1, limit: 1001),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Limit must not exceed 1000'),
            ),
          ),
        );
      });

      test('getAllReviews accepts valid parameters', () async {
        // Arrange
        when(
          () => mockService.getAllReviews(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            status: any(named: 'status'),
          ),
        ).thenAnswer((_) async => throw Exception('Service called'));

        // Act & Assert - Should not throw validation error
        expect(
          () async => repository.getAllReviews(page: 1, limit: 20),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Service called'),
            ),
          ),
        );
      });
    });

    group('Cursor Pagination Validation', () {
      test('getReviewsCursor throws ArgumentError for limit <= 0', () async {
        // Act & Assert
        expect(
          () async => repository.getReviewsCursor(limit: 0),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('Limit must be greater than 0'),
            ),
          ),
        );
      });

      test(
        'getReviewsCursor throws ArgumentError for excessive limit',
        () async {
          // Act & Assert
          expect(
            () async => repository.getReviewsCursor(limit: 1500),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('Limit must not exceed 1000'),
              ),
            ),
          );
        },
      );
    });

    group('String Parameter Validation', () {
      test(
        'getReviewsByPlaceId throws ArgumentError for empty placeId',
        () async {
          // Act & Assert
          expect(
            () async => repository.getReviewsByPlaceId(''),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('placeId cannot be null, empty, or only whitespace'),
              ),
            ),
          );
        },
      );

      test(
        'getReviewsByPlaceId throws ArgumentError for whitespace placeId',
        () async {
          // Act & Assert
          expect(
            () async => repository.getReviewsByPlaceId('   '),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('placeId cannot be null, empty, or only whitespace'),
              ),
            ),
          );
        },
      );

      test(
        'getReviewsByUserId throws ArgumentError for empty userId',
        () async {
          // Act & Assert
          expect(
            () async => repository.getReviewsByUserId(''),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('userId cannot be null, empty, or only whitespace'),
              ),
            ),
          );
        },
      );

      test('approveReview throws ArgumentError for empty reviewId', () async {
        // Act & Assert
        expect(
          () async => repository.approveReview(''),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('reviewId cannot be null, empty, or only whitespace'),
            ),
          ),
        );
      });

      test('getReviewStats throws ArgumentError for empty placeId', () async {
        // Act & Assert
        expect(
          () async => repository.getReviewStats(''),
          throwsA(
            isA<ArgumentError>().having(
              (e) => e.message,
              'message',
              contains('placeId cannot be null, empty, or only whitespace'),
            ),
          ),
        );
      });
    });

    group('Combined Validation', () {
      test(
        'getReviewsByPlaceId validates both placeId and pagination',
        () async {
          // Test invalid placeId first
          expect(
            () async => repository.getReviewsByPlaceId('', page: 1, limit: 20),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('placeId cannot be null, empty, or only whitespace'),
              ),
            ),
          );

          // Test invalid page with valid placeId
          expect(
            () async =>
                repository.getReviewsByPlaceId('valid-id', page: 0, limit: 20),
            throwsA(
              isA<ArgumentError>().having(
                (e) => e.message,
                'message',
                contains('Page number must be greater than or equal to 1'),
              ),
            ),
          );
        },
      );
    });

    group('Edge Cases', () {
      test('accepts minimum valid values', () async {
        // Arrange
        when(
          () => mockService.getAllReviews(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            status: any(named: 'status'),
          ),
        ).thenAnswer((_) async => throw Exception('Service called'));

        // Act & Assert - Minimum valid values should work
        expect(
          () async => repository.getAllReviews(page: 1, limit: 1),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Service called'),
            ),
          ),
        );
      });

      test('accepts maximum valid values', () async {
        // Arrange
        when(
          () => mockService.getAllReviews(
            page: any(named: 'page'),
            limit: any(named: 'limit'),
            status: any(named: 'status'),
          ),
        ).thenAnswer((_) async => throw Exception('Service called'));

        // Act & Assert - Maximum valid values should work
        expect(
          () async => repository.getAllReviews(page: 999999, limit: 1000),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Service called'),
            ),
          ),
        );
      });
    });

    group('All Paginated Methods Validation', () {
      test(
        'all paginated methods validate page and limit parameters',
        () async {
          final invalidParams = [
            {'page': 0, 'limit': 20},
            {'page': -1, 'limit': 20},
            {'page': 1, 'limit': 0},
            {'page': 1, 'limit': -1},
            {'page': 1, 'limit': 1001},
          ];

          for (final params in invalidParams) {
            final page = params['page']!;
            final limit = params['limit']!;

            // Test getAllReviews
            expect(
              () async => repository.getAllReviews(page: page, limit: limit),
              throwsA(isA<ArgumentError>()),
              reason: 'getAllReviews should reject page=$page, limit=$limit',
            );

            // Test getReviewsPaginated
            expect(
              () async =>
                  repository.getReviewsPaginated(page: page, limit: limit),
              throwsA(isA<ArgumentError>()),
              reason:
                  'getReviewsPaginated should reject page=$page, limit=$limit',
            );

            // Test getReviewsByPlaceId
            expect(
              () async => repository.getReviewsByPlaceId(
                'valid-id',
                page: page,
                limit: limit,
              ),
              throwsA(isA<ArgumentError>()),
              reason:
                  'getReviewsByPlaceId should reject page=$page, limit=$limit',
            );

            // Test getReviewsByUserId
            expect(
              () async => repository.getReviewsByUserId(
                'valid-id',
                page: page,
                limit: limit,
              ),
              throwsA(isA<ArgumentError>()),
              reason:
                  'getReviewsByUserId should reject page=$page, limit=$limit',
            );

            // Test getReviewsByStatus
            expect(
              () async => repository.getReviewsByStatus(
                ReviewStatus.approved,
                page: page,
                limit: limit,
              ),
              throwsA(isA<ArgumentError>()),
              reason:
                  'getReviewsByStatus should reject page=$page, limit=$limit',
            );
          }
        },
      );
    });
  });
}
