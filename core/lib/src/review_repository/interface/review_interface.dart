import 'package:turbo/reviews/review_repository/models/review.dart';

abstract class ReviewInterface {
  Future<List<Review>> getReviews();
  Future<void> addReview(Review review, String placeId);
  Future<void> updateReview(Review review);
  Future<void> deleteReview(String id);
  Future<List<Review>> getReviewsFromAPlace(String placeId);
}
