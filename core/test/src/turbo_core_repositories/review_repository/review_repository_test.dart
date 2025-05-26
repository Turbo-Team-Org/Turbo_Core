import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:core/src/turbo_core_repositories/review_repository/review_repository.dart';
import 'package:core/src/turbo_core_repositories/review_repository/service/review_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockReviewService extends Mock implements ReviewService {}

void main() {
  setUpAll(() {
    // Register fallback value for Review
    registerFallbackValue(
      Review(
        id: 'fallback-id',
        userId: 'fallback-user-id',
        userName: 'Fallback User',
        userAvatar: 'https://example.com/fallback.jpg',
        comment: 'Fallback comment',
        rating: 5.0,
        date: DateTime.now(),
      ),
    );
  });

  late ReviewRepository reviewRepository;
  late MockReviewService mockReviewService;

  setUp(() {
    mockReviewService = MockReviewService();
    reviewRepository = ReviewRepository(reviewService: mockReviewService);
  });

  group('ReviewRepository', () {
    const testPlaceId = 'test-place-id';
    const testReviewId = 'test-review-id';
    const testUserId = 'test-user-id';

    final testReview = Review(
      id: testReviewId,
      userId: testUserId,
      userName: 'Test User',
      userAvatar: 'https://example.com/avatar.jpg',
      comment: 'Test Review',
      rating: 4.5,
      date: DateTime.now(),
      status: ReviewStatus.approved,
    );

    test('getAllReviews delegates to service correctly', () async {
      // Arrange
      final expectedResult = PagedResult<Review>(
        items: [testReview],
        totalCount: 1,
        currentPage: 1,
        pageSize: 20,
        totalPages: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      );

      when(
        () => mockReviewService.getAllReviews(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          status: any(named: 'status'),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await reviewRepository.getAllReviews(
        page: 1,
        limit: 20,
        status: ReviewStatus.approved,
      );

      // Assert
      expect(result, equals(expectedResult));
      expect(result.items.length, equals(1));
      expect(result.items.first.id, equals(testReviewId));
      expect(result.totalCount, equals(1));
      expect(result.currentPage, equals(1));

      verify(
        () => mockReviewService.getAllReviews(
          page: 1,
          limit: 20,
          status: ReviewStatus.approved,
        ),
      ).called(1);
    });

    test('getAllReviews with default parameters', () async {
      // Arrange
      final expectedResult = PagedResult<Review>(
        items: [testReview],
        totalCount: 1,
        currentPage: 1,
        pageSize: 20,
        totalPages: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      );

      when(
        () => mockReviewService.getAllReviews(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          status: any(named: 'status'),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await reviewRepository.getAllReviews();

      // Assert
      expect(result, equals(expectedResult));

      verify(
        () => mockReviewService.getAllReviews(page: 1, limit: 20, status: null),
      ).called(1);
    });

    test('getAllReviews with custom pagination', () async {
      // Arrange
      final expectedResult = PagedResult<Review>(
        items: [],
        totalCount: 50,
        currentPage: 3,
        pageSize: 10,
        totalPages: 5,
        hasNextPage: true,
        hasPreviousPage: true,
      );

      when(
        () => mockReviewService.getAllReviews(
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          status: any(named: 'status'),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await reviewRepository.getAllReviews(page: 3, limit: 10);

      // Assert
      expect(result.currentPage, equals(3));
      expect(result.pageSize, equals(10));
      expect(result.totalPages, equals(5));
      expect(result.hasNextPage, isTrue);
      expect(result.hasPreviousPage, isTrue);

      verify(
        () => mockReviewService.getAllReviews(page: 3, limit: 10, status: null),
      ).called(1);
    });

    test('getReviews delegates to service', () async {
      // Arrange
      final expectedReviews = [testReview];
      when(
        () => mockReviewService.getReviews(),
      ).thenAnswer((_) async => expectedReviews);

      // Act
      final result = await reviewRepository.getReviews();

      // Assert
      expect(result, equals(expectedReviews));
      verify(() => mockReviewService.getReviews()).called(1);
    });

    test('addReview delegates to service', () async {
      // Arrange
      when(
        () => mockReviewService.addReview(any(), any()),
      ).thenAnswer((_) async {});

      // Act
      await reviewRepository.addReview(testReview, testPlaceId);

      // Assert
      verify(
        () => mockReviewService.addReview(testReview, testPlaceId),
      ).called(1);
    });

    test('updateReview delegates to service', () async {
      // Arrange
      when(
        () => mockReviewService.updateReview(any()),
      ).thenAnswer((_) async {});

      // Act
      await reviewRepository.updateReview(testReview);

      // Assert
      verify(() => mockReviewService.updateReview(testReview)).called(1);
    });

    test('deleteReview delegates to service', () async {
      // Arrange
      when(
        () => mockReviewService.deleteReview(any()),
      ).thenAnswer((_) async {});

      // Act
      await reviewRepository.deleteReview(testReviewId);

      // Assert
      verify(() => mockReviewService.deleteReview(testReviewId)).called(1);
    });

    test('getReviewsByPlaceId delegates to service', () async {
      // Arrange
      final expectedResult = PagedResult<Review>(
        items: [testReview],
        totalCount: 1,
        currentPage: 1,
        pageSize: 20,
        totalPages: 1,
        hasNextPage: false,
        hasPreviousPage: false,
      );

      when(
        () => mockReviewService.getReviewsByPlaceId(
          any(),
          page: any(named: 'page'),
          limit: any(named: 'limit'),
          status: any(named: 'status'),
        ),
      ).thenAnswer((_) async => expectedResult);

      // Act
      final result = await reviewRepository.getReviewsByPlaceId(testPlaceId);

      // Assert
      expect(result, equals(expectedResult));
      verify(
        () => mockReviewService.getReviewsByPlaceId(
          testPlaceId,
          page: 1,
          limit: 20,
          status: null,
        ),
      ).called(1);
    });

    test('approveReview delegates to service', () async {
      // Arrange
      when(
        () => mockReviewService.approveReview(
          any(),
          moderatorId: any(named: 'moderatorId'),
          moderationNote: any(named: 'moderationNote'),
        ),
      ).thenAnswer((_) async {});

      // Act
      await reviewRepository.approveReview(
        testReviewId,
        moderatorId: 'admin-123',
        moderationNote: 'Approved by admin',
      );

      // Assert
      verify(
        () => mockReviewService.approveReview(
          testReviewId,
          moderatorId: 'admin-123',
          moderationNote: 'Approved by admin',
        ),
      ).called(1);
    });

    test('getReviewStats delegates to service', () async {
      // Arrange
      final expectedStats = {
        'totalReviews': 10,
        'averageRating': 4.2,
        'approvedReviews': 8,
        'pendingReviews': 2,
      };

      when(
        () => mockReviewService.getReviewStats(any()),
      ).thenAnswer((_) async => expectedStats);

      // Act
      final result = await reviewRepository.getReviewStats(testPlaceId);

      // Assert
      expect(result, equals(expectedStats));
      verify(() => mockReviewService.getReviewStats(testPlaceId)).called(1);
    });
  });
}
