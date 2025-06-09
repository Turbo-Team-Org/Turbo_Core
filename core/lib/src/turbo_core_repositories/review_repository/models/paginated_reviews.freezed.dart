// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paginated_reviews.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaginatedReviews {

/// The reviews in the current page
 List<Review> get reviews;/// Number of reviews in this page
 int get pageSize;/// Whether there are more reviews available
 bool get hasMore;/// Cursor token for the next page (base64 encoded DocumentSnapshot)
/// Null if this is the last page
 String? get nextPageToken;/// Total count of reviews (optional, expensive to calculate)
/// Only calculated when explicitly requested
 int? get totalCount;/// Query metadata for debugging
 Map<String, dynamic>? get queryMeta;
/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaginatedReviewsCopyWith<PaginatedReviews> get copyWith => _$PaginatedReviewsCopyWithImpl<PaginatedReviews>(this as PaginatedReviews, _$identity);

  /// Serializes this PaginatedReviews to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaginatedReviews&&const DeepCollectionEquality().equals(other.reviews, reviews)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPageToken, nextPageToken) || other.nextPageToken == nextPageToken)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other.queryMeta, queryMeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(reviews),pageSize,hasMore,nextPageToken,totalCount,const DeepCollectionEquality().hash(queryMeta));

@override
String toString() {
  return 'PaginatedReviews(reviews: $reviews, pageSize: $pageSize, hasMore: $hasMore, nextPageToken: $nextPageToken, totalCount: $totalCount, queryMeta: $queryMeta)';
}


}

/// @nodoc
abstract mixin class $PaginatedReviewsCopyWith<$Res>  {
  factory $PaginatedReviewsCopyWith(PaginatedReviews value, $Res Function(PaginatedReviews) _then) = _$PaginatedReviewsCopyWithImpl;
@useResult
$Res call({
 List<Review> reviews, int pageSize, bool hasMore, String? nextPageToken, int? totalCount, Map<String, dynamic>? queryMeta
});




}
/// @nodoc
class _$PaginatedReviewsCopyWithImpl<$Res>
    implements $PaginatedReviewsCopyWith<$Res> {
  _$PaginatedReviewsCopyWithImpl(this._self, this._then);

  final PaginatedReviews _self;
  final $Res Function(PaginatedReviews) _then;

/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? reviews = null,Object? pageSize = null,Object? hasMore = null,Object? nextPageToken = freezed,Object? totalCount = freezed,Object? queryMeta = freezed,}) {
  return _then(_self.copyWith(
reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPageToken: freezed == nextPageToken ? _self.nextPageToken : nextPageToken // ignore: cast_nullable_to_non_nullable
as String?,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,queryMeta: freezed == queryMeta ? _self.queryMeta : queryMeta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PaginatedReviews implements PaginatedReviews {
  const _PaginatedReviews({required final  List<Review> reviews, required this.pageSize, required this.hasMore, this.nextPageToken, this.totalCount, final  Map<String, dynamic>? queryMeta}): _reviews = reviews,_queryMeta = queryMeta;
  factory _PaginatedReviews.fromJson(Map<String, dynamic> json) => _$PaginatedReviewsFromJson(json);

/// The reviews in the current page
 final  List<Review> _reviews;
/// The reviews in the current page
@override List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

/// Number of reviews in this page
@override final  int pageSize;
/// Whether there are more reviews available
@override final  bool hasMore;
/// Cursor token for the next page (base64 encoded DocumentSnapshot)
/// Null if this is the last page
@override final  String? nextPageToken;
/// Total count of reviews (optional, expensive to calculate)
/// Only calculated when explicitly requested
@override final  int? totalCount;
/// Query metadata for debugging
 final  Map<String, dynamic>? _queryMeta;
/// Query metadata for debugging
@override Map<String, dynamic>? get queryMeta {
  final value = _queryMeta;
  if (value == null) return null;
  if (_queryMeta is EqualUnmodifiableMapView) return _queryMeta;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaginatedReviewsCopyWith<_PaginatedReviews> get copyWith => __$PaginatedReviewsCopyWithImpl<_PaginatedReviews>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaginatedReviewsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaginatedReviews&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.hasMore, hasMore) || other.hasMore == hasMore)&&(identical(other.nextPageToken, nextPageToken) || other.nextPageToken == nextPageToken)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&const DeepCollectionEquality().equals(other._queryMeta, _queryMeta));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_reviews),pageSize,hasMore,nextPageToken,totalCount,const DeepCollectionEquality().hash(_queryMeta));

@override
String toString() {
  return 'PaginatedReviews(reviews: $reviews, pageSize: $pageSize, hasMore: $hasMore, nextPageToken: $nextPageToken, totalCount: $totalCount, queryMeta: $queryMeta)';
}


}

/// @nodoc
abstract mixin class _$PaginatedReviewsCopyWith<$Res> implements $PaginatedReviewsCopyWith<$Res> {
  factory _$PaginatedReviewsCopyWith(_PaginatedReviews value, $Res Function(_PaginatedReviews) _then) = __$PaginatedReviewsCopyWithImpl;
@override @useResult
$Res call({
 List<Review> reviews, int pageSize, bool hasMore, String? nextPageToken, int? totalCount, Map<String, dynamic>? queryMeta
});




}
/// @nodoc
class __$PaginatedReviewsCopyWithImpl<$Res>
    implements _$PaginatedReviewsCopyWith<$Res> {
  __$PaginatedReviewsCopyWithImpl(this._self, this._then);

  final _PaginatedReviews _self;
  final $Res Function(_PaginatedReviews) _then;

/// Create a copy of PaginatedReviews
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? reviews = null,Object? pageSize = null,Object? hasMore = null,Object? nextPageToken = freezed,Object? totalCount = freezed,Object? queryMeta = freezed,}) {
  return _then(_PaginatedReviews(
reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,hasMore: null == hasMore ? _self.hasMore : hasMore // ignore: cast_nullable_to_non_nullable
as bool,nextPageToken: freezed == nextPageToken ? _self.nextPageToken : nextPageToken // ignore: cast_nullable_to_non_nullable
as String?,totalCount: freezed == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int?,queryMeta: freezed == queryMeta ? _self._queryMeta : queryMeta // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
