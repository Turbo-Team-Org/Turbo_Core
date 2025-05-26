import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/interface/review_interface.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:core/src/turbo_core_repositories/review_repository/service/review_service.dart';

/// Repository responsible for managing reviews with pagination and moderation capabilities.
///
/// This repository provides a clean interface for review-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to review management, moderation, and analytics.
class ReviewRepository implements ReviewInterface {
  /// Constructor
  ReviewRepository({required this.reviewService});

  /// Review service
  final ReviewService reviewService;

  /// Get reviews
  Future<List<Review>> getReviews() async {
    return reviewService.getReviews();
  }

  /// Get reviews from a place
  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    return reviewService.getReviewsFromAPlace(placeId);
  }

  /// Add review
  Future<void> addReview(Review review, String placeId) async {
    return reviewService.addReview(review, placeId);
  }

  /// Update review
  Future<void> updateReview(Review review) async {
    return reviewService.updateReview(review);
  }

  /// Delete review
  Future<void> deleteReview(String id) async {
    return reviewService.deleteReview(id);
  }

  // ==================== PAGINATED OPERATIONS ====================

  @override
  Future<PagedResult<Review>> getReviewsPaginated({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
  }) async {
    return reviewService.getReviewsPaginated(
      page: page,
      limit: limit,
      status: status,
      placeId: placeId,
      userId: userId,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByPlaceId(
    String placeId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    return reviewService.getReviewsByPlaceId(
      placeId,
      page: page,
      limit: limit,
      status: status,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByUserId(
    String userId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    return reviewService.getReviewsByUserId(
      userId,
      page: page,
      limit: limit,
      status: status,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByStatus(
    ReviewStatus status, {
    int page = 1,
    int limit = 20,
  }) async {
    return reviewService.getReviewsByStatus(status, page: page, limit: limit);
  }

  // ==================== MODERATION OPERATIONS ====================

  @override
  Future<void> approveReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    return reviewService.approveReview(
      reviewId,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  @override
  Future<void> rejectReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    return reviewService.rejectReview(
      reviewId,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  @override
  Future<void> flagReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    return reviewService.flagReview(
      reviewId,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  @override
  Future<void> updateReviewStatus(
    String reviewId,
    ReviewStatus status, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    return reviewService.updateReviewStatus(
      reviewId,
      status,
      moderatorId: moderatorId,
      moderationNote: moderationNote,
    );
  }

  // ==================== ANALYTICS OPERATIONS ====================

  @override
  Future<Map<String, dynamic>> getReviewStats(String placeId) async {
    return reviewService.getReviewStats(placeId);
  }

  @override
  Future<int> getPendingReviewsCount() async {
    return reviewService.getPendingReviewsCount();
  }

  @override
  Future<int> getFlaggedReviewsCount() async {
    return reviewService.getFlaggedReviewsCount();
  }
}
