import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/interface/review_interface.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/paginated_reviews.dart';
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
    print('🔍 [DEBUG] ReviewService.getReviews() - LLAMADO CORRECTAMENTE');
    print('🔍 [DEBUG] firestore: ${firestore.runtimeType}');
    try {
      print('🔍 [DEBUG] Ejecutando consulta a Firestore...');
      final snapshot = await firestore.collection('reviews').get();
      print('✅ [DEBUG] Snapshot obtenido: ${snapshot.docs.length} documentos');
      final result =
          snapshot.docs.map((doc) => Review.fromFirestore(doc.data())).toList();
      print('✅ [DEBUG] Reviews procesadas: ${result.length}');
      return result;
    } catch (e) {
      print('❌ [DEBUG] ReviewService.getReviews() - Error: $e');
      throw Exception('Error al obtener las reseñas: $e');
    }
  }

  @override
  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    try {
      final snapshot = await firestore
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
  Future<String> addReview(Review review, String placeId) async {
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
        final newRating = ((currentRating * currentCount) + review.rating) /
            (currentCount + 1);

        transaction.update(placeRef, {
          'reviews_count': currentCount + 1,
          'rating': newRating,
        });
      });

      // Return the ID of the newly created review
      return review.id;
    } catch (e) {
      throw Exception('Error al añadir la reseña: $e');
    }
  }

  @override
  Future<void> updateReview(Review review) async {
    try {
      // First we need to find the place that the review belongs to
      final querySnapshot = await firestore
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
      final querySnapshot = await firestore
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
          final newRating = ((currentRating * currentCount) - review.rating) /
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

      // Apply ordering
      query = query.orderBy('date', descending: true);

      if (page == 1) {
        // First page - use limit directly
        query = query.limit(limit);
        final snapshot = await query.get();

        final reviews = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Review.fromFirestore(data);
        }).toList();

        // For first page, we don't know total count unless we do a separate query
        // This is a trade-off for performance
        return PagedResult(
          items: reviews,
          totalCount: -1, // Unknown for efficiency
          currentPage: page,
          pageSize: limit,
          totalPages: -1, // Unknown for efficiency
          hasNextPage: reviews.length ==
              limit, // Assume there's more if we got a full page
          hasPreviousPage: false,
        );
      } else {
        // For subsequent pages, we need to use offset which is less efficient
        // Consider using the new cursor-based method instead
        final skipCount = (page - 1) * limit;
        final allSnapshot = await query.limit(skipCount + limit).get();

        final startIndex = skipCount;
        final endIndex = (startIndex + limit).clamp(0, allSnapshot.docs.length);

        final paginatedDocs = startIndex < allSnapshot.docs.length
            ? allSnapshot.docs.sublist(startIndex, endIndex)
            : <QueryDocumentSnapshot>[];

        final reviews = paginatedDocs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Review.fromFirestore(data);
        }).toList();

        return PagedResult(
          items: reviews,
          totalCount: allSnapshot.docs.length,
          currentPage: page,
          pageSize: limit,
          totalPages: (allSnapshot.docs.length / limit).ceil(),
          hasNextPage: endIndex < allSnapshot.docs.length,
          hasPreviousPage: page > 1,
        );
      }
    } catch (e) {
      throw Exception('Error al obtener todas las reseñas paginadas: $e');
    }
  }

  /// 🚀 OPTIMIZED: Get reviews using cursor-based pagination
  /// This method provides O(1) performance regardless of dataset size
  @override
  Future<PaginatedReviews> getReviewsCursor({
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
    String? pageToken,
    bool includeTotalCount = false,
  }) async {
    try {
      Query query = firestore.collectionGroup('reviews');

      // Apply filters first (most selective)
      if (placeId != null) {
        // For place-specific reviews, use the specific collection for better performance
        query =
            firestore.collection('places').doc(placeId).collection('reviews');
      }

      if (status != null) {
        query = query.where('status', isEqualTo: status.value);
      }

      if (userId != null) {
        query = query.where('userId', isEqualTo: userId);
      }

      // Apply ordering (required for cursor pagination)
      query = query.orderBy('date', descending: true);

      // Apply cursor pagination
      if (pageToken != null) {
        // Decode cursor and get the starting point
        final cursorDoc = await _getCursorDocument(pageToken, query);
        if (cursorDoc != null) {
          query = query.startAfterDocument(cursorDoc);
        }
      }

      // Limit the results
      query = query.limit(limit);

      // Execute the query - this only reads the documents we need!
      final snapshot = await query.get();

      // Calculate total count only if requested (expensive operation)
      int? totalCount;
      if (includeTotalCount) {
        totalCount = await _getTotalCount(
          placeId: placeId,
          status: status,
          userId: userId,
        );
      }

      // Create query metadata for debugging
      final queryMeta = {
        'hasFilters': status != null || placeId != null || userId != null,
        'usedCursor': pageToken != null,
        'docsRead': snapshot.docs.length,
        'limit': limit,
      };

      return PaginatedReviews.fromSnapshot(
        snapshot: snapshot,
        requestedPageSize: limit,
        nextPageToken: pageToken,
        totalCount: totalCount,
        queryMeta: queryMeta,
      );
    } catch (e) {
      throw Exception('Error al obtener reseñas con cursor: $e');
    }
  }

  /// Helper method to get cursor document for pagination
  Future<DocumentSnapshot?> _getCursorDocument(
    String pageToken,
    Query query,
  ) async {
    try {
      // For a production app, you'd decode the token to get document reference
      // This is a simplified implementation
      final decoded = Uri.decodeComponent(pageToken);

      // Extract document ID from cursor (simplified)
      final match = RegExp(r'docId: ([^,}]+)').firstMatch(decoded);
      if (match != null) {
        final docId = match.group(1);

        // Try to get the document from the collection
        // Note: This is simplified - in production you'd store more metadata
        final docSnapshot = await firestore
            .collectionGroup('reviews')
            .where(FieldPath.documentId, isEqualTo: docId)
            .limit(1)
            .get();

        return docSnapshot.docs.isNotEmpty ? docSnapshot.docs.first : null;
      }

      return null;
    } catch (e) {
      // If cursor is invalid, start from beginning
      return null;
    }
  }

  /// Helper method to get total count (expensive operation)
  Future<int> _getTotalCount({
    String? placeId,
    ReviewStatus? status,
    String? userId,
  }) async {
    Query countQuery = firestore.collectionGroup('reviews');

    if (placeId != null) {
      countQuery =
          firestore.collection('places').doc(placeId).collection('reviews');
    }

    if (status != null) {
      countQuery = countQuery.where('status', isEqualTo: status.value);
    }

    if (userId != null) {
      countQuery = countQuery.where('userId', isEqualTo: userId);
    }

    final countSnapshot = await countQuery.get();
    return countSnapshot.docs.length;
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
        query =
            firestore.collection('places').doc(placeId).collection('reviews');
        if (status != null) {
          query = query.where('status', isEqualTo: status.value);
        }
      }
      if (userId != null) {
        query = query.where('userId', isEqualTo: userId);
      }

      // Apply ordering
      query = query.orderBy('date', descending: true);

      if (page == 1) {
        // First page - optimized path
        query = query.limit(limit);
        final snapshot = await query.get();

        final reviews = snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Review.fromFirestore(data);
        }).toList();

        return PagedResult(
          items: reviews,
          totalCount: -1, // Unknown for efficiency
          currentPage: page,
          pageSize: limit,
          totalPages: -1, // Unknown for efficiency
          hasNextPage: reviews.length == limit,
          hasPreviousPage: false,
        );
      } else {
        // Subsequent pages - less efficient but necessary for PagedResult compatibility
        final skipCount = (page - 1) * limit;
        final allSnapshot = await query.limit(skipCount + limit).get();

        final startIndex = skipCount;
        final endIndex = (startIndex + limit).clamp(0, allSnapshot.docs.length);

        final paginatedDocs = startIndex < allSnapshot.docs.length
            ? allSnapshot.docs.sublist(startIndex, endIndex)
            : <QueryDocumentSnapshot>[];

        final reviews = paginatedDocs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Review.fromFirestore(data);
        }).toList();

        return PagedResult(
          items: reviews,
          totalCount: allSnapshot.docs.length,
          currentPage: page,
          pageSize: limit,
          totalPages: (allSnapshot.docs.length / limit).ceil(),
          hasNextPage: endIndex < allSnapshot.docs.length,
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
      final querySnapshot = await firestore
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
      final snapshot = await firestore
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

      final averageRating = reviews.isNotEmpty
          ? reviews
                  .where((r) => r.status == ReviewStatus.approved)
                  .map((r) => r.rating)
                  .fold(0.0, (sum, rating) => sum + rating) /
              approvedReviews
          : 0.0;

      // Rating distribution
      final ratingDistribution = <int, int>{};
      for (int i = 1; i <= 5; i++) {
        ratingDistribution[i] = reviews
            .where(
              (r) => r.status == ReviewStatus.approved && r.rating.round() == i,
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
      final snapshot = await firestore
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
      final snapshot = await firestore
          .collectionGroup('reviews')
          .where('status', isEqualTo: ReviewStatus.flagged.value)
          .get();
      return snapshot.docs.length;
    } catch (e) {
      throw Exception('Error al obtener conteo de reseñas reportadas: $e');
    }
  }
}
