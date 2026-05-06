// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paginated_reviews.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PaginatedReviews _$PaginatedReviewsFromJson(Map<String, dynamic> json) =>
    _PaginatedReviews(
      reviews: (json['reviews'] as List<dynamic>)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList(),
      pageSize: (json['pageSize'] as num).toInt(),
      hasMore: json['hasMore'] as bool,
      nextPageToken: json['nextPageToken'] as String?,
      totalCount: (json['totalCount'] as num?)?.toInt(),
      queryMeta: json['queryMeta'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$PaginatedReviewsToJson(_PaginatedReviews instance) =>
    <String, dynamic>{
      'reviews': instance.reviews,
      'pageSize': instance.pageSize,
      'hasMore': instance.hasMore,
      'nextPageToken': instance.nextPageToken,
      'totalCount': instance.totalCount,
      'queryMeta': instance.queryMeta,
    };
