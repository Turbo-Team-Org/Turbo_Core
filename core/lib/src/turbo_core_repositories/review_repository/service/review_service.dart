import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/review_repository/interface/review_interface.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';

/// Review service
class ReviewService implements ReviewInterface {
  /// Constructor
  ReviewService({required this.firestore});

  /// Firebase firestore
  final FirebaseFirestore firestore;

  @override
  Future<List<Review>> getReviews() async {
    try {
      final snapshot = await firestore.collectionGroup('reviews').get();
      return snapshot.docs
          .map((doc) => Review.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener las reseñas: $e');
    }
  }

  @override
  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    try {
      final snapshot =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('reviews')
              .orderBy('date', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Review.fromFirestore(data);
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener las reseñas del lugar: $e');
    }
  }

  @override
  Future<void> addReview(Review review, String placeId) async {
    try {
      final placeRef = firestore.collection('places').doc(placeId);
      final reviewRef = placeRef.collection('reviews').doc(review.id);

      //Use a transaction to ensure the consistency of the data

      await firestore.runTransaction((transaction) async {
        // Add the review
        transaction.set(reviewRef, review.toJson());

        // Update the review count and the average rating
        final placeDoc = await transaction.get(placeRef);
        final currentData = placeDoc.data() ?? {};
        final currentCount = (currentData['reviews_count'] ?? 0) as int;
        final currentRating = (currentData['rating'] ?? 0.0) as double;

        // Calculate the new average rating
        final newRating =
            ((currentRating * currentCount) + review.rating) /
            (currentCount + 1);

        transaction.update(placeRef, {
          'reviews_count': currentCount + 1,
          'rating': newRating,
        });
      });
    } catch (e) {
      throw Exception('Error al añadir la reseña: $e');
    }
  }

  @override
  Future<void> updateReview(Review review) async {
    try {
      // First we need to find the place that the review belongs to
      final querySnapshot =
          await firestore
              .collectionGroup('reviews')
              .where('id', isEqualTo: review.id)
              .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Review not found');
      }

      final doc = querySnapshot.docs.first;
      await doc.reference.update(review.toJson());
    } catch (e) {
      throw Exception('Error al actualizar la reseña: $e');
    }
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    try {
      // First we need to find the place that the review belongs to
      final querySnapshot =
          await firestore
              .collectionGroup('reviews')
              .where('id', isEqualTo: reviewId)
              .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Review not found');
      }

      final doc = querySnapshot.docs.first;
      final placeRef = doc.reference.parent.parent!;

      // Use a transaction to also update the count and rating
      await firestore.runTransaction((transaction) async {
        final reviewDoc = await transaction.get(doc.reference);
        final review = Review.fromFirestore(reviewDoc.data()!);

        // Delete the review
        transaction.delete(doc.reference);

        // Update the count and rating of the place
        final placeDoc = await transaction.get(placeRef);
        final currentData = placeDoc.data() ?? {};
        final currentCount = (currentData['reviews_count'] ?? 0) as int;
        final currentRating = (currentData['rating'] ?? 0.0) as double;

        if (currentCount > 1) {
          // Recalculate the average rating excluding the deleted review
          final newRating =
              ((currentRating * currentCount) - review.rating) /
              (currentCount - 1);
          transaction.update(placeRef, {
            'reviews_count': currentCount - 1,
            'rating': newRating,
          });
        } else {
          // If it was the last review, reset the values
          transaction.update(placeRef, {'reviews_count': 0, 'rating': 0.0});
        }
      });
    } catch (e) {
      throw Exception('Error al eliminar la reseña: $e');
    }
  }
}
