import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';

/// Review interface
abstract class ReviewInterface {
  /// Get reviews
  Future<List<Review>> getReviews();

  /// Add review
  Future<void> addReview(Review review, String placeId);

  /// Update review
  Future<void> updateReview(Review review);

  /// Delete review
  Future<void> deleteReview(String id);

  /// Get reviews from a place
  Future<List<Review>> getReviewsFromAPlace(String placeId);
}
