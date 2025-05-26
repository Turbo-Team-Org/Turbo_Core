import 'package:freezed_annotation/freezed_annotation.dart';

part 'paged_result.freezed.dart';
part 'paged_result.g.dart';

/// Generic model for paginated results.
///
/// This model is used across all repositories to provide consistent
/// pagination functionality for admin interfaces and large datasets.
@Freezed(genericArgumentFactories: true)
sealed class PagedResult<T> with _$PagedResult<T> {
  /// Constructor for PagedResult
  const factory PagedResult({
    /// The items in the current page
    required List<T> items,

    /// Total number of items across all pages
    required int totalCount,

    /// Current page number (1-based)
    required int currentPage,

    /// Number of items per page
    required int pageSize,

    /// Total number of pages
    required int totalPages,

    /// Whether there is a next page
    required bool hasNextPage,

    /// Whether there is a previous page
    required bool hasPreviousPage,
  }) = _PagedResult<T>;

  /// Factory constructor to create PagedResult from JSON
  factory PagedResult.fromJson(
    Map<String, dynamic> json,
    T Function(Object?) fromJsonT,
  ) => _$PagedResultFromJson(json, fromJsonT);

  /// Factory constructor to create PagedResult from a list of items
  /// and pagination parameters
  factory PagedResult.fromList({
    required List<T> allItems,
    required int page,
    required int pageSize,
  }) {
    final totalCount = allItems.length;
    final totalPages = (totalCount / pageSize).ceil();
    final startIndex = (page - 1) * pageSize;
    final endIndex = (startIndex + pageSize).clamp(0, totalCount);

    final items =
        startIndex < totalCount
            ? allItems.sublist(startIndex, endIndex)
            : <T>[];

    return PagedResult(
      items: items,
      totalCount: totalCount,
      currentPage: page,
      pageSize: pageSize,
      totalPages: totalPages,
      hasNextPage: page < totalPages,
      hasPreviousPage: page > 1,
    );
  }

  /// Factory constructor to create an empty PagedResult
  factory PagedResult.empty({int page = 1, int pageSize = 20}) {
    return PagedResult(
      items: [],
      totalCount: 0,
      currentPage: page,
      pageSize: pageSize,
      totalPages: 0,
      hasNextPage: false,
      hasPreviousPage: false,
    );
  }
}

/// Extension methods for PagedResult
extension PagedResultExtensions<T> on PagedResult<T> {
  /// Returns true if this is the first page
  bool get isFirstPage => currentPage == 1;

  /// Returns true if this is the last page
  bool get isLastPage => currentPage == totalPages;

  /// Returns true if there are no items
  bool get isEmpty => items.isEmpty;

  /// Returns true if there are items
  bool get isNotEmpty => items.isNotEmpty;

  /// Returns the starting item number for the current page (1-based)
  int get startItemNumber => isEmpty ? 0 : ((currentPage - 1) * pageSize) + 1;

  /// Returns the ending item number for the current page (1-based)
  int get endItemNumber => isEmpty ? 0 : startItemNumber + items.length - 1;

  /// Returns a description of the current page range
  String get pageRangeDescription {
    if (isEmpty) return '0 de 0';
    return '$startItemNumber-$endItemNumber de $totalCount';
  }
}
