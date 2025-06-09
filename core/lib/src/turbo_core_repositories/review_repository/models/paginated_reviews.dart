import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'paginated_reviews.freezed.dart';
part 'paginated_reviews.g.dart';

/// Model for cursor-based paginated review results.
///
/// This model provides efficient pagination using Firestore cursors
/// instead of reading all documents and slicing in memory.
@freezed
sealed class PaginatedReviews with _$PaginatedReviews {
  const factory PaginatedReviews({
    /// The reviews in the current page
    required List<Review> reviews,

    /// Number of reviews in this page
    required int pageSize,

    /// Whether there are more reviews available
    required bool hasMore,

    /// Cursor token for the next page (base64 encoded DocumentSnapshot)
    /// Null if this is the last page
    String? nextPageToken,

    /// Total count of reviews (optional, expensive to calculate)
    /// Only calculated when explicitly requested
    int? totalCount,

    /// Query metadata for debugging
    Map<String, dynamic>? queryMeta,
  }) = _PaginatedReviews;

  factory PaginatedReviews.fromJson(Map<String, dynamic> json) =>
      _$PaginatedReviewsFromJson(json);

  /// Factory to create from Firestore QuerySnapshot
  factory PaginatedReviews.fromSnapshot({
    required QuerySnapshot snapshot,
    required int requestedPageSize,
    String? nextPageToken,
    int? totalCount,
    Map<String, dynamic>? queryMeta,
  }) {
    final reviews =
        snapshot.docs.map((doc) {
          final data = doc.data() as Map<String, dynamic>;
          data['id'] = doc.id;
          return Review.fromFirestore(data);
        }).toList();

    // Create next page token from last document if we have more data
    String? nextToken;
    bool hasMore = false;

    if (reviews.length == requestedPageSize && snapshot.docs.isNotEmpty) {
      // We got exactly the requested size, likely there are more documents
      hasMore = true;
      // Encode the last document as cursor for next page
      final lastDoc = snapshot.docs.last;
      nextToken = _encodeDocumentCursor(lastDoc);
    }

    return PaginatedReviews(
      reviews: reviews,
      pageSize: reviews.length,
      hasMore: hasMore,
      nextPageToken: nextToken,
      totalCount: totalCount,
      queryMeta: queryMeta,
    );
  }

  /// Factory to create empty result
  factory PaginatedReviews.empty() {
    return const PaginatedReviews(
      reviews: [],
      pageSize: 0,
      hasMore: false,
      nextPageToken: null,
    );
  }

  /// Encode DocumentSnapshot to base64 cursor
  static String _encodeDocumentCursor(DocumentSnapshot doc) {
    // For now, we'll use the document ID and timestamp as cursor
    // In a production app, you might want to encode more metadata
    final cursorData = {
      'docId': doc.id,
      'timestamp': (doc.data() as Map<String, dynamic>?)?['date']?.toString(),
    };

    // Simple base64 encoding of JSON
    final jsonString = cursorData.toString();
    final bytes = jsonString.codeUnits;
    return Uri.encodeComponent(String.fromCharCodes(bytes));
  }

  /// Decode cursor to get document information
  static Map<String, dynamic>? _decodeCursor(String cursor) {
    try {
      final decoded = Uri.decodeComponent(cursor);
      // This is a simplified version - in production you'd use proper JSON parsing
      return {'docId': decoded};
    } catch (e) {
      return null;
    }
  }
}

/// Extension methods for PaginatedReviews
extension PaginatedReviewsExtensions on PaginatedReviews {
  /// Returns true if this is empty
  bool get isEmpty => reviews.isEmpty;

  /// Returns true if this has data
  bool get isNotEmpty => reviews.isNotEmpty;

  /// Returns true if this is the last page
  bool get isLastPage => !hasMore;

  /// Returns a summary description
  String get summary {
    if (isEmpty) return 'No reviews found';
    final countText = totalCount != null ? ' of $totalCount' : '';
    return '${reviews.length} reviews$countText';
  }

  /// Create a copy with additional reviews (for infinite scroll)
  PaginatedReviews appendPage(PaginatedReviews nextPage) {
    return copyWith(
      reviews: [...reviews, ...nextPage.reviews],
      pageSize: reviews.length + nextPage.reviews.length,
      hasMore: nextPage.hasMore,
      nextPageToken: nextPage.nextPageToken,
    );
  }
}
