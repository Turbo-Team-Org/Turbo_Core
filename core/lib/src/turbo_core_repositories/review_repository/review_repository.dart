import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/interface/review_interface.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/paginated_reviews.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:core/src/turbo_core_repositories/review_repository/service/review_service.dart';

/// Repository responsible for managing reviews with pagination and moderation capabilities.
///
/// This repository provides a clean interface for review-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to review management, moderation, and analytics.
class ReviewRepository {
  /// Constructor
  ReviewRepository({required this.reviewService});

  /// Review service
  final ReviewService reviewService;

  /// Get reviews

  Future<List<Review>> getReviews() async {
    print('🔍 [DEBUG] ReviewRepository.getReviews() - LLAMADO CORRECTAMENTE');
    print('🔍 [DEBUG] reviewService: ${reviewService.runtimeType}');
    try {
      final result = await reviewService.getReviews();
      print(
          '✅ [DEBUG] ReviewRepository.getReviews() - Resultado obtenido: ${result.length} reviews');
      return result;
    } catch (e) {
      print('❌ [DEBUG] ReviewRepository.getReviews() - Error: $e');
      rethrow;
    }
  }

  /// Get reviews from a place

  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    return await reviewService.getReviewsFromAPlace(placeId);
  }

  /// Add review

  Future<String> addReview(Review review, String placeId) async {
    return await reviewService.addReview(review, placeId);
  }

  /// Update review

  Future<void> updateReview(Review review) async {
    return await reviewService.updateReview(review);
  }

  /// Delete review

  Future<void> deleteReview(String id) async {
    return await reviewService.deleteReview(id);
  }

  // ==================== PAGINATED OPERATIONS ====================

  Future<PagedResult<Review>> getAllReviews({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    // Validate pagination parameters
    _validatePaginationParams(page: page, limit: limit);

    return await reviewService.getAllReviews(
      page: page,
      limit: limit,
      status: status,
    );
  }

  Future<PaginatedReviews> getReviewsCursor({
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
    String? pageToken,
    bool includeTotalCount = false,
  }) async {
    // Validate cursor pagination parameters
    _validateCursorParams(limit: limit);

    return await reviewService.getReviewsCursor(
      limit: limit,
      status: status,
      placeId: placeId,
      userId: userId,
      pageToken: pageToken,
      includeTotalCount: includeTotalCount,
    );
  }

  Future<PagedResult<Review>> getReviewsPaginated({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
  }) async {
    // Validate pagination parameters
    _validatePaginationParams(page: page, limit: limit);

    return await reviewService.getReviewsPaginated(
      page: page,
      limit: limit,
      status: status,
      placeId: placeId,
      userId: userId,
    );
  }

  Future<PagedResult<Review>> getReviewsByPlaceId(
    String placeId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    // Validate pagination parameters
    _validatePaginationParams(page: page, limit: limit);
    // Validate placeId parameter
    _validateNonEmptyString(placeId, 'placeId');

    return await reviewService.getReviewsByPlaceId(
      placeId,
      page: page,
      limit: limit,
      status: status,
    );
  }

  Future<PagedResult<Review>> getReviewsByUserId(
    String userId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    // Validate pagination parameters
    _validatePaginationParams(page: page, limit: limit);
    // Validate userId parameter
    _validateNonEmptyString(userId, 'userId');

    return await reviewService.getReviewsByUserId(
      userId,
      page: page,
      limit: limit,
      status: status,
    );
  }

  Future<PagedResult<Review>> getReviewsByStatus(
    ReviewStatus status, {
    int page = 1,
    int limit = 20,
  }) async {
    // Validate pagination parameters
    _validatePaginationParams(page: page, limit: limit);

    return await reviewService.getReviewsByStatus(status,
        page: page, limit: limit);
  }

  // ==================== MODERATION OPERATIONS ====================

  Future<void> approveReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    // Validate reviewId parameter
    _validateNonEmptyString(reviewId, 'reviewId');

    return await reviewService.approveReview(
      reviewId,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  Future<void> rejectReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    // Validate reviewId parameter
    _validateNonEmptyString(reviewId, 'reviewId');

    return await reviewService.rejectReview(
      reviewId,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  Future<void> flagReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    // Validate reviewId parameter
    _validateNonEmptyString(reviewId, 'reviewId');

    return await reviewService.flagReview(
      reviewId,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  Future<void> updateReviewStatus(
    String reviewId,
    ReviewStatus status, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    // Validate reviewId parameter
    _validateNonEmptyString(reviewId, 'reviewId');

    return await reviewService.updateReviewStatus(
      reviewId,
      status,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  // ==================== ANALYTICS OPERATIONS ====================

  Future<Map<String, dynamic>> getReviewStats(String placeId) async {
    // Validate placeId parameter
    _validateNonEmptyString(placeId, 'placeId');

    return await reviewService.getReviewStats(placeId);
  }

  Future<int> getPendingReviewsCount() async {
    return await reviewService.getPendingReviewsCount();
  }

  Future<int> getFlaggedReviewsCount() async {
    return await reviewService.getFlaggedReviewsCount();
  }

  // ==================== PRIVATE VALIDATION METHODS ====================

  /// Validates pagination parameters for page-based pagination
  ///
  /// Throws [ArgumentError] if parameters are invalid:
  /// - page must be >= 1
  /// - limit must be > 0 and <= 1000 (to prevent excessive resource usage)
  void _validatePaginationParams({required int page, required int limit}) {
    if (page < 1) {
      throw ArgumentError.value(
        page,
        'page',
        'Page number must be greater than or equal to 1',
      );
    }

    if (limit <= 0) {
      throw ArgumentError.value(limit, 'limit', 'Limit must be greater than 0');
    }

    if (limit > 1000) {
      throw ArgumentError.value(
        limit,
        'limit',
        'Limit must not exceed 1000 to prevent excessive resource usage',
      );
    }
  }

  /// Validates parameters for cursor-based pagination
  ///
  /// Throws [ArgumentError] if parameters are invalid:
  /// - limit must be > 0 and <= 1000
  void _validateCursorParams({required int limit}) {
    if (limit <= 0) {
      throw ArgumentError.value(limit, 'limit', 'Limit must be greater than 0');
    }

    if (limit > 1000) {
      throw ArgumentError.value(
        limit,
        'limit',
        'Limit must not exceed 1000 to prevent excessive resource usage',
      );
    }
  }

  /// Validates that a string parameter is not null or empty
  ///
  /// Throws [ArgumentError] if the string is null, empty, or only whitespace
  void _validateNonEmptyString(String value, String parameterName) {
    if (value.trim().isEmpty) {
      throw ArgumentError.value(
        value,
        parameterName,
        '$parameterName cannot be null, empty, or only whitespace',
      );
    }
  }
}
