import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/interface/review_interface.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';

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

  // ==================== PAGINATED OPERATIONS ====================

  @override
  Future<PagedResult<Review>> getAllReviews({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    try {
      Query query = firestore.collectionGroup('reviews');

      // Apply status filter if provided
      if (status != null) {
        query = query.where('status', isEqualTo: status.value);
      }

      // Get total count for pagination metadata
      final countSnapshot = await query.get();
      final totalCount = countSnapshot.docs.length;

      // Apply ordering
      query = query.orderBy('date', descending: true);

      // Apply pagination
      if (page > 1) {
        final skipCount = (page - 1) * limit;
        // Get all documents up to the current page and take only the needed ones
        final allSnapshot = await query.get();
        final allDocs = allSnapshot.docs;

        final startIndex = skipCount;
        final endIndex = (startIndex + limit).clamp(0, allDocs.length);

        final paginatedDocs =
            startIndex < allDocs.length
                ? allDocs.sublist(startIndex, endIndex)
                : <QueryDocumentSnapshot>[];

        final reviews =
            paginatedDocs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              return Review.fromFirestore(data);
            }).toList();

        final totalPages = (totalCount / limit).ceil();

        return PagedResult(
          items: reviews,
          totalCount: totalCount,
          currentPage: page,
          pageSize: limit,
          totalPages: totalPages,
          hasNextPage: page < totalPages,
          hasPreviousPage: page > 1,
        );
      } else {
        // First page - use limit directly
        query = query.limit(limit);
        final snapshot = await query.get();

        final reviews =
            snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              return Review.fromFirestore(data);
            }).toList();

        final totalPages = (totalCount / limit).ceil();

        return PagedResult(
          items: reviews,
          totalCount: totalCount,
          currentPage: page,
          pageSize: limit,
          totalPages: totalPages,
          hasNextPage: page < totalPages,
          hasPreviousPage: page > 1,
        );
      }
    } catch (e) {
      throw Exception('Error al obtener todas las reseñas paginadas: $e');
    }
  }

  @override
  Future<PagedResult<Review>> getReviewsPaginated({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
  }) async {
    try {
      Query query = firestore.collectionGroup('reviews');

      // Apply filters
      if (status != null) {
        query = query.where('status', isEqualTo: status.value);
      }
      if (placeId != null) {
        // For place-specific reviews, use the specific collection
        query = firestore
            .collection('places')
            .doc(placeId)
            .collection('reviews');
        if (status != null) {
          query = query.where('status', isEqualTo: status.value);
        }
      }
      if (userId != null) {
        query = query.where('userId', isEqualTo: userId);
      }

      // Get total count
      final countSnapshot = await query.get();
      final totalCount = countSnapshot.docs.length;

      // Apply pagination and ordering
      query = query.orderBy('date', descending: true);

      // For pagination, we'll use a simpler approach for now
      // In production, you'd want to use cursor-based pagination with startAfter
      if (page > 1) {
        final skipCount = (page - 1) * limit;
        // Get all documents up to the current page and take only the needed ones
        final allSnapshot = await query.get();
        final allDocs = allSnapshot.docs;

        final startIndex = skipCount;
        final endIndex = (startIndex + limit).clamp(0, allDocs.length);

        final paginatedDocs =
            startIndex < allDocs.length
                ? allDocs.sublist(startIndex, endIndex)
                : <QueryDocumentSnapshot>[];

        final reviews =
            paginatedDocs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              return Review.fromFirestore(data);
            }).toList();

        final totalPages = (totalCount / limit).ceil();

        return PagedResult(
          items: reviews,
          totalCount: totalCount,
          currentPage: page,
          pageSize: limit,
          totalPages: totalPages,
          hasNextPage: page < totalPages,
          hasPreviousPage: page > 1,
        );
      } else {
        // First page - use limit directly
        query = query.limit(limit);
        final snapshot = await query.get();

        final reviews =
            snapshot.docs.map((doc) {
              final data = doc.data() as Map<String, dynamic>;
              data['id'] = doc.id;
              return Review.fromFirestore(data);
            }).toList();

        final totalPages = (totalCount / limit).ceil();

        return PagedResult(
          items: reviews,
          totalCount: totalCount,
          currentPage: page,
          pageSize: limit,
          totalPages: totalPages,
          hasNextPage: page < totalPages,
          hasPreviousPage: page > 1,
        );
      }
    } catch (e) {
      throw Exception('Error al obtener reseñas paginadas: $e');
    }
  }

  @override
  Future<PagedResult<Review>> getReviewsByPlaceId(
    String placeId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    return getReviewsPaginated(
      page: page,
      limit: limit,
      status: status,
      placeId: placeId,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByUserId(
    String userId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    return getReviewsPaginated(
      page: page,
      limit: limit,
      status: status,
      userId: userId,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByStatus(
    ReviewStatus status, {
    int page = 1,
    int limit = 20,
  }) async {
    return getReviewsPaginated(page: page, limit: limit, status: status);
  }

  // ==================== MODERATION OPERATIONS ====================

  @override
  Future<void> approveReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    await updateReviewStatus(
      reviewId,
      ReviewStatus.approved,
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
    await updateReviewStatus(
      reviewId,
      ReviewStatus.rejected,
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
    await updateReviewStatus(
      reviewId,
      ReviewStatus.flagged,
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
    try {
      // Find the review document
      final querySnapshot =
          await firestore
              .collectionGroup('reviews')
              .where('id', isEqualTo: reviewId)
              .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Reseña no encontrada');
      }

      final doc = querySnapshot.docs.first;
      final updateData = <String, dynamic>{
        'status': status.value,
        'moderatedAt': FieldValue.serverTimestamp(),
      };

      if (moderatorId != null) {
        updateData['moderatedBy'] = moderatorId;
      }
      if (moderationNote != null) {
        updateData['moderationNote'] = moderationNote;
      }

      await doc.reference.update(updateData);
    } catch (e) {
      throw Exception('Error al actualizar estado de reseña: $e');
    }
  }

  // ==================== ANALYTICS OPERATIONS ====================

  @override
  Future<Map<String, dynamic>> getReviewStats(String placeId) async {
    try {
      final snapshot =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('reviews')
              .get();

      final reviews =
          snapshot.docs.map((doc) => Review.fromFirestore(doc.data())).toList();

      final totalReviews = reviews.length;
      final approvedReviews =
          reviews.where((r) => r.status == ReviewStatus.approved).length;
      final pendingReviews =
          reviews.where((r) => r.status == ReviewStatus.pending).length;
      final rejectedReviews =
          reviews.where((r) => r.status == ReviewStatus.rejected).length;
      final flaggedReviews =
          reviews.where((r) => r.status == ReviewStatus.flagged).length;

      final averageRating =
          reviews.isNotEmpty
              ? reviews
                      .where((r) => r.status == ReviewStatus.approved)
                      .map((r) => r.rating)
                      .fold(0.0, (sum, rating) => sum + rating) /
                  approvedReviews
              : 0.0;

      // Rating distribution
      final ratingDistribution = <int, int>{};
      for (int i = 1; i <= 5; i++) {
        ratingDistribution[i] =
            reviews
                .where(
                  (r) =>
                      r.status == ReviewStatus.approved &&
                      r.rating.round() == i,
                )
                .length;
      }

      return {
        'totalReviews': totalReviews,
        'approvedReviews': approvedReviews,
        'pendingReviews': pendingReviews,
        'rejectedReviews': rejectedReviews,
        'flaggedReviews': flaggedReviews,
        'averageRating': averageRating,
        'ratingDistribution': ratingDistribution,
      };
    } catch (e) {
      throw Exception('Error al obtener estadísticas de reseñas: $e');
    }
  }

  @override
  Future<int> getPendingReviewsCount() async {
    try {
      final snapshot =
          await firestore
              .collectionGroup('reviews')
              .where('status', isEqualTo: ReviewStatus.pending.value)
              .get();
      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Error al obtener conteo de reseñas pendientes: $e');
    }
  }

  @override
  Future<int> getFlaggedReviewsCount() async {
    try {
      final snapshot =
          await firestore
              .collectionGroup('reviews')
              .where('status', isEqualTo: ReviewStatus.flagged.value)
              .get();
      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Error al obtener conteo de reseñas reportadas: $e');
    }
  }
}
