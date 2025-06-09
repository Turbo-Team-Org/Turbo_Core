import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/review_repository.dart';

/// Example demonstrating the updated addReview method that returns the review ID
Future<void> exampleAddReviewUsage(ReviewRepository reviewRepository) async {
  // Create a new review
  final newReview = Review(
    id: 'review-123',
    userId: 'user-456',
    userName: 'John Doe',
    userAvatar: 'https://example.com/avatar.jpg',
    comment: 'Great place! Really enjoyed the atmosphere.',
    rating: 4.5,
    date: DateTime.now(),
  );

  const placeId = 'place-789';

  try {
    // Add the review and get the ID of the newly created review
    final createdReviewId = await reviewRepository.addReview(
      newReview,
      placeId,
    );

    print('✅ Review created successfully with ID: $createdReviewId');

    // Now you can immediately use the returned ID for other operations
    // without needing an additional network call

    // Example: Update the review status immediately
    await reviewRepository.approveReview(
      createdReviewId,
      moderatorId: 'admin-123',
      moderationNote: 'Auto-approved based on content analysis',
    );

    print('✅ Review $createdReviewId approved automatically');

    // Example: Get statistics that include the new review
    final stats = await reviewRepository.getReviewStats(placeId);
    print(
      '📊 Updated place stats: ${stats['totalReviews']} reviews, average rating: ${stats['averageRating']}',
    );
  } catch (e) {
    print('❌ Error adding review: $e');
  }
}

/// Example showing the benefits of the new API vs the old approach
void demonstrateAPIBenefits() {
  print('''
🚀 Benefits of the new addReview API:

OLD APPROACH (Future<void>):
1. Call addReview() -> void
2. Make additional query to get the review ID
3. Use the ID for further operations
❌ Requires extra network call
❌ More complex error handling
❌ Race conditions possible

NEW APPROACH (Future<String>):
1. Call addReview() -> String (review ID)
2. Immediately use the returned ID
✅ No extra network calls needed
✅ Simpler, more efficient code
✅ Immediate access to the created resource ID
✅ Better performance and user experience

Example use cases:
- Immediate moderation workflows
- Real-time UI updates with the new review ID
- Optimistic updates in mobile apps
- Analytics tracking with precise timing
''');
}
