import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/paginated_reviews.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';

/// Review interface for managing reviews with pagination and moderation
abstract class ReviewInterface {
  // ==================== BASIC CRUD OPERATIONS ====================

  /// Get all reviews (basic method for backward compatibility)
  Future<List<Review>> getReviews();

  /// Add a new review to a place
  /// Returns the ID of the newly created review
  Future<String> addReview(Review review, String placeId);

  /// Update an existing review
  Future<void> updateReview(Review review);

  /// Delete a review by ID
  Future<void> deleteReview(String id);

  /// Get reviews from a specific place (basic method for backward compatibility)
  Future<List<Review>> getReviewsFromAPlace(String placeId);

  // ==================== PAGINATED OPERATIONS ====================

  /// Get all reviews with pagination (recommended method)
  Future<PagedResult<Review>> getAllReviews({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  });

  /// 🚀 OPTIMIZED: Get reviews using cursor-based pagination
  /// This method provides O(1) performance regardless of dataset size
  /// Use this method for better performance in production apps
  Future<PaginatedReviews> getReviewsCursor({
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
    String? pageToken,
    bool includeTotalCount = false,
  });

  /// Get paginated reviews with optional filtering
  Future<PagedResult<Review>> getReviewsPaginated({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
  });

  /// Get paginated reviews by place ID
  Future<PagedResult<Review>> getReviewsByPlaceId(
    String placeId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  });

  /// Get paginated reviews by user ID
  Future<PagedResult<Review>> getReviewsByUserId(
    String userId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  });

  /// Get paginated reviews by status
  Future<PagedResult<Review>> getReviewsByStatus(
    ReviewStatus status, {
    int page = 1,
    int limit = 20,
  });

  // ==================== MODERATION OPERATIONS ====================

  /// Approve a review (change status to approved)
  Future<void> approveReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  });

  /// Reject a review (change status to rejected)
  Future<void> rejectReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  });

  /// Flag a review for further review
  Future<void> flagReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  });

  /// Update review status with moderation details
  Future<void> updateReviewStatus(
    String reviewId,
    ReviewStatus status, {
    String? moderatorId,
    String? moderationNote,
  });

  // ==================== ANALYTICS OPERATIONS ====================

  /// Get review statistics for a place
  Future<Map<String, dynamic>> getReviewStats(String placeId);

  /// Get pending reviews count (for admin dashboard)
  Future<int> getPendingReviewsCount();

  /// Get flagged reviews count (for admin dashboard)
  Future<int> getFlaggedReviewsCount();
}
