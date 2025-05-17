import 'package:turbo/reviews/review_repository/models/review.dart';
import 'service/review_service.dart';

class ReviewRepository {
  final ReviewService reviewService;

  ReviewRepository({required this.reviewService});

  Future<List<Review>> getReviews() async {
    return await reviewService.getReviews();
  }

  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    return await reviewService.getReviewsFromAPlace(placeId);
  }

  Future<void> addReview(Review review, String placeId) async {
    return await reviewService.addReview(review, placeId);
  }

  Future<void> updateReview(Review review) async {
    return await reviewService.updateReview(review);
  }

  Future<void> deleteReview(String id) async {
    return await reviewService.deleteReview(id);
  }
}
