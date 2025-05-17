import 'package:core/src/review_repository/models/review.dart';
import 'package:core/src/review_repository/service/review_service.dart';

/// Review repository
class ReviewRepository {
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
}
