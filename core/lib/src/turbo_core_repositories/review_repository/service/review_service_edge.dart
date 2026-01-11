import 'package:core/src/monorepo_utils/common/models/paged_result.dart';
import 'package:core/src/turbo_core_repositories/review_repository/interface/review_interface.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/paginated_reviews.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review_status.dart';
import 'package:dio/dio.dart';

class ReviewServiceEdge implements ReviewInterface {
  ReviewServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  String _url(String path) => '$baseUrl$path';

  @override
  Future<List<Review>> getReviews() async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_reviews'),
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<String> addReview(Review review, String placeId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/public_add_review'),
          data: {'placeId': placeId, ...review.toJson()},
        );
    return (res.data?['id'] as String?) ?? '';
  }

  @override
  Future<void> updateReview(Review review) async {
    await httpClient.post<void>(
      _url('/admin_update_review'),
      data: review.toJson(),
    );
  }

  @override
  Future<void> deleteReview(String id) async {
    await httpClient.post<void>(_url('/admin_delete_review'), data: {'id': id});
  }

  @override
  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_reviews_by_place'),
      queryParameters: {'placeId': placeId},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Review.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<PagedResult<Review>> getAllReviews({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_reviews_paginated'),
          queryParameters: {
            'page': page,
            'limit': limit,
            if (status != null) 'status': status.name,
          },
        );
    final data = res.data ?? <String, dynamic>{};
    final items =
        (data['items'] as List? ?? <dynamic>[])
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
    final total = (data['total'] as int?) ?? items.length;
    final currentPage = (data['page'] as int?) ?? page;
    final pageSize = (data['limit'] as int?) ?? limit;
    final totalPages = (total / pageSize).ceil();
    return PagedResult<Review>(
      items: items,
      totalCount: total,
      currentPage: currentPage,
      pageSize: pageSize,
      totalPages: totalPages,
      hasNextPage: currentPage < totalPages,
      hasPreviousPage: currentPage > 1,
    );
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
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_reviews_cursor'),
          queryParameters: {
            'limit': limit,
            if (status != null) 'status': status.name,
            if (placeId != null) 'placeId': placeId,
            if (userId != null) 'userId': userId,
            if (pageToken != null) 'pageToken': pageToken,
            'includeTotalCount': includeTotalCount,
          },
        );
    return PaginatedReviews.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<PagedResult<Review>> getReviewsPaginated({
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
    String? placeId,
    String? userId,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_reviews_paginated'),
          queryParameters: {
            'page': page,
            'limit': limit,
            if (status != null) 'status': status.name,
            if (placeId != null) 'placeId': placeId,
            if (userId != null) 'userId': userId,
          },
        );
    final data = res.data ?? <String, dynamic>{};
    final items =
        (data['items'] as List? ?? <dynamic>[])
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
    final total = (data['total'] as int?) ?? items.length;
    final currentPage = (data['page'] as int?) ?? page;
    final pageSize = (data['limit'] as int?) ?? limit;
    final totalPages = (total / pageSize).ceil();
    return PagedResult<Review>(
      items: items,
      totalCount: total,
      currentPage: currentPage,
      pageSize: pageSize,
      totalPages: totalPages,
      hasNextPage: currentPage < totalPages,
      hasPreviousPage: currentPage > 1,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByPlaceId(
    String placeId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_reviews_by_place_paginated'),
          queryParameters: {
            'placeId': placeId,
            'page': page,
            'limit': limit,
            if (status != null) 'status': status.name,
          },
        );
    final data = res.data ?? <String, dynamic>{};
    final items =
        (data['items'] as List? ?? <dynamic>[])
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
    final total = (data['total'] as int?) ?? items.length;
    final currentPage = (data['page'] as int?) ?? page;
    final pageSize = (data['limit'] as int?) ?? limit;
    final totalPages = (total / pageSize).ceil();
    return PagedResult<Review>(
      items: items,
      totalCount: total,
      currentPage: currentPage,
      pageSize: pageSize,
      totalPages: totalPages,
      hasNextPage: currentPage < totalPages,
      hasPreviousPage: currentPage > 1,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByUserId(
    String userId, {
    int page = 1,
    int limit = 20,
    ReviewStatus? status,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_reviews_by_user_paginated'),
          queryParameters: {
            'userId': userId,
            'page': page,
            'limit': limit,
            if (status != null) 'status': status.name,
          },
        );
    final data = res.data ?? <String, dynamic>{};
    final items =
        (data['items'] as List? ?? <dynamic>[])
            .map((e) => Review.fromJson(e as Map<String, dynamic>))
            .toList();
    final total = (data['total'] as int?) ?? items.length;
    final currentPage = (data['page'] as int?) ?? page;
    final pageSize = (data['limit'] as int?) ?? limit;
    final totalPages = (total / pageSize).ceil();
    return PagedResult<Review>(
      items: items,
      totalCount: total,
      currentPage: currentPage,
      pageSize: pageSize,
      totalPages: totalPages,
      hasNextPage: currentPage < totalPages,
      hasPreviousPage: currentPage > 1,
    );
  }

  @override
  Future<PagedResult<Review>> getReviewsByStatus(
    ReviewStatus status, {
    int page = 1,
    int limit = 20,
  }) async {
    return getAllReviews(page: page, limit: limit, status: status);
  }

  @override
  Future<void> approveReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    await httpClient.post<void>(
      _url('/admin_approve_review'),
      data: {
        'reviewId': reviewId,
        if (moderatorId != null) 'moderatorId': moderatorId,
        if (moderationNote != null) 'moderationNote': moderationNote,
      },
    );
  }

  @override
  Future<void> rejectReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    await httpClient.post<void>(
      _url('/admin_reject_review'),
      data: {
        'reviewId': reviewId,
        if (moderatorId != null) 'moderatorId': moderatorId,
        if (moderationNote != null) 'moderationNote': moderationNote,
      },
    );
  }

  @override
  Future<void> flagReview(
    String reviewId, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    await httpClient.post<void>(
      _url('/admin_flag_review'),
      data: {
        'reviewId': reviewId,
        if (moderatorId != null) 'moderatorId': moderatorId,
        if (moderationNote != null) 'moderationNote': moderationNote,
      },
    );
  }

  @override
  Future<void> updateReviewStatus(
    String reviewId,
    ReviewStatus status, {
    String? moderatorId,
    String? moderationNote,
  }) async {
    await httpClient.post<void>(
      _url('/admin_update_review_status'),
      data: {
        'reviewId': reviewId,
        'status': status.name,
        if (moderatorId != null) 'moderatorId': moderatorId,
        if (moderationNote != null) 'moderationNote': moderationNote,
      },
    );
  }

  @override
  Future<Map<String, dynamic>> getReviewStats(String placeId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_review_stats'),
          queryParameters: {'placeId': placeId},
        );
    return res.data ?? <String, dynamic>{};
  }

  @override
  Future<int> getPendingReviewsCount() async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(_url('/admin_get_pending_reviews_count'));
    return (res.data?['count'] as int?) ?? 0;
  }

  @override
  Future<int> getFlaggedReviewsCount() async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(_url('/admin_get_flagged_reviews_count'));
    return (res.data?['count'] as int?) ?? 0;
  }
}
