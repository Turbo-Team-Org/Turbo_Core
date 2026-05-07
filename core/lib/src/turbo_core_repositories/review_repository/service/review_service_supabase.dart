import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/interface/review_interface.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/paginated_reviews.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// Review service for Supabase
class ReviewServiceSupabase implements ReviewInterface {
  /// Constructor
  ReviewServiceSupabase({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  /// Supabase client
  final SupabaseClient _supabase;

  /// UUID instance
  static const _uuid = Uuid();

  @override
  Future<List<Review>> getReviews() async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('*')
          .order('created_at', ascending: false);

      return response.map<Review>((data) => _reviewFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error al obtener las reseñas: $e');
    }
  }

  @override
  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('*')
          .eq('place_id', placeId)
          .order('created_at', ascending: false);

      return response.map<Review>((data) => _reviewFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error al obtener las reseñas del lugar: $e');
    }
  }

  @override
  Future<String> addReview(Review review, String placeId) async {
    try {
      final reviewId = review.id.isNotEmpty ? review.id : _uuid.v4();
      final reviewData = _reviewToSupabaseData(review.copyWith(
        id: reviewId,
      ));

      // Add placeId to the data
      reviewData['place_id'] = placeId;

      await _supabase.from('reviews').insert(reviewData);
      return reviewId;
    } catch (e) {
      throw Exception('Error al agregar la reseña: $e');
    }
  }

  @override
  Future<void> updateReview(Review review) async {
    try {
      await _supabase
          .from('reviews')
          .update(_reviewToSupabaseData(review))
          .eq('id', review.id);
    } catch (e) {
      throw Exception('Error al actualizar la reseña: $e');
    }
  }

  @override
  Future<void> deleteReview(String id) async {
    try {
      await _supabase.from('reviews').delete().eq('id', id);
    } catch (e) {
      throw Exception('Error al eliminar la reseña: $e');
    }
  }

  // ==================== SIMPLIFIED PAGINATED OPERATIONS ====================

  @override
  Future<PagedResult<Review>> getAllReviews({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    try {
      final offset = (page - 1) * limit;

      var query = _supabase.from('reviews').select('*');

      if (status != null) {
        query = query.eq('status', status.name);
      }

      final response = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      final reviews =
          response.map<Review>((data) => _reviewFromSupabase(data)).toList();
      final totalCount = reviews.length + offset; // Simplified count

      return PagedResult(
        items: reviews,
        totalCount: totalCount,
        currentPage: page,
        pageSize: limit,
        totalPages: (totalCount / limit).ceil(),
        hasNextPage: reviews.length == limit,
        hasPreviousPage: page > 1,
      );
    } catch (e) {
      throw Exception('Error al obtener reseñas paginadas: $e');
    }
  }

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
      var query = _supabase.from('reviews').select('*');

      if (status != null) {
        query = query.eq('status', status.name);
      }
      if (placeId != null) {
        query = query.eq('place_id', placeId);
      }
      if (userId != null) {
        query = query.eq('user_id', userId);
      }
      if (pageToken != null) {
        query = query.lt('created_at', pageToken);
      }

      final response = await query
          .order('created_at', ascending: false)
          .limit(limit + 1); // Fetch one extra to check if there are more

      final List<Review> reviews = [];
      String? nextPageToken;

      if (response.length > limit) {
        // Remove the extra item and use its timestamp as next page token
        final extraItem = response.removeLast();
        nextPageToken = extraItem['created_at'] as String;
      }

      for (final data in response) {
        reviews.add(_reviewFromSupabase(data));
      }

      return PaginatedReviews(
        reviews: reviews,
        pageSize: reviews.length,
        nextPageToken: nextPageToken,
        hasMore: nextPageToken != null,
        totalCount: includeTotalCount ? reviews.length : null,
      );
    } catch (e) {
      throw Exception('Error al obtener reseñas con cursor: $e');
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
    return getAllReviews(page: page, limit: limit, status: status);
  }

  @override
  Future<PagedResult<Review>> getReviewsByPlaceId(
    String placeId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    try {
      final offset = (page - 1) * limit;

      var query = _supabase.from('reviews').select('*').eq('place_id', placeId);

      if (status != null) {
        query = query.eq('status', status.name);
      }

      final response = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      final reviews =
          response.map<Review>((data) => _reviewFromSupabase(data)).toList();

      return PagedResult(
        items: reviews,
        totalCount: reviews.length + offset,
        currentPage: page,
        pageSize: limit,
        totalPages: ((reviews.length + offset) / limit).ceil(),
        hasNextPage: reviews.length == limit,
        hasPreviousPage: page > 1,
      );
    } catch (e) {
      throw Exception('Error al obtener reseñas por lugar: $e');
    }
  }

  @override
  Future<PagedResult<Review>> getReviewsByUserId(
    String userId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    try {
      final offset = (page - 1) * limit;

      var query = _supabase.from('reviews').select('*').eq('user_id', userId);

      if (status != null) {
        query = query.eq('status', status.name);
      }

      final response = await query
          .order('created_at', ascending: false)
          .range(offset, offset + limit - 1);

      final reviews =
          response.map<Review>((data) => _reviewFromSupabase(data)).toList();

      return PagedResult(
        items: reviews,
        totalCount: reviews.length + offset,
        currentPage: page,
        pageSize: limit,
        totalPages: ((reviews.length + offset) / limit).ceil(),
        hasNextPage: reviews.length == limit,
        hasPreviousPage: page > 1,
      );
    } catch (e) {
      throw Exception('Error al obtener reseñas por usuario: $e');
    }
  }

  @override
  Future<PagedResult<Review>> getReviewsByStatus(
    ReviewStatus status, {
    int page = 1,
    int limit = 20,
  }) async {
    return getAllReviews(page: page, limit: limit, status: status);
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
      final updateData = <String, dynamic>{
        'status': status.name,
        'updated_at': DateTime.now().toIso8601String(),
      };

      if (moderatorId != null) {
        updateData['moderator_id'] = moderatorId;
      }
      if (moderationNote != null) {
        updateData['moderation_note'] = moderationNote;
      }

      await _supabase.from('reviews').update(updateData).eq('id', reviewId);
    } catch (e) {
      throw Exception('Error al actualizar el estado de la reseña: $e');
    }
  }

  // ==================== ANALYTICS OPERATIONS ====================

  @override
  Future<Map<String, dynamic>> getReviewStats(String placeId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select('rating, status')
          .eq('place_id', placeId);

      final totalReviews = response.length;
      final approvedReviews =
          response.where((r) => r['status'] == 'approved').length;
      final pendingReviews =
          response.where((r) => r['status'] == 'pending').length;
      final flaggedReviews =
          response.where((r) => r['status'] == 'flagged').length;

      double averageRating = 0.0;
      if (approvedReviews > 0) {
        final approvedRatings = response
            .where((r) => r['status'] == 'approved')
            .map((r) => (r['rating'] as num).toDouble());
        averageRating =
            approvedRatings.reduce((a, b) => a + b) / approvedReviews;
      }

      return {
        'totalReviews': totalReviews,
        'approvedReviews': approvedReviews,
        'pendingReviews': pendingReviews,
        'flaggedReviews': flaggedReviews,
        'averageRating': averageRating,
      };
    } catch (e) {
      throw Exception('Error al obtener estadísticas de reseñas: $e');
    }
  }

  @override
  Future<int> getPendingReviewsCount() async {
    try {
      final response =
          await _supabase.from('reviews').select('id').eq('status', 'pending');

      return response.length;
    } catch (e) {
      throw Exception('Error al obtener conteo de reseñas pendientes: $e');
    }
  }

  @override
  Future<int> getFlaggedReviewsCount() async {
    try {
      final response =
          await _supabase.from('reviews').select('id').eq('status', 'flagged');

      return response.length;
    } catch (e) {
      throw Exception('Error al obtener conteo de reseñas marcadas: $e');
    }
  }

  /// Converts Supabase data to Review model
  Review _reviewFromSupabase(Map<String, dynamic> data) {
    return Review.fromFirestore({
      'id': data['id'] ?? '',
      'userId': data['user_id'] ?? '',
      'userName': data['user_name'] ?? '',
      'userAvatar': data['user_photo_url'] ?? '',
      'rating': (data['rating'] ?? 0).toDouble(),
      'comment': data['comment'] ?? '',
      'date': data['created_at'] ?? DateTime.now().toIso8601String(),
      'status': data['status'] ?? 'pending',
      'moderationNote': data['moderation_note'],
      'moderatedAt': data['moderated_at'],
      'moderatedBy': data['moderated_by'],
      'createdAt': data['created_at'],
    });
  }

  /// Converts Review model to Supabase data
  Map<String, dynamic> _reviewToSupabaseData(Review review) {
    return {
      'id': review.id,
      'user_id': review.userId,
      'user_name': review.userName,
      'user_photo_url': review.userAvatar,
      'rating': review.rating,
      'comment': review.comment,
      'status': review.status.name,
      'moderation_note': review.moderationNote,
      'moderated_by': review.moderatedBy,
      'created_at': review.date.toIso8601String(),
      'updated_at': DateTime.now().toIso8601String(),
    };
  }
}
