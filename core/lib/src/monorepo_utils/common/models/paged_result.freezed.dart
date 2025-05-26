// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paged_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PagedResult<T> {

/// The items in the current page
 List<T> get items;/// Total number of items across all pages
 int get totalCount;/// Current page number (1-based)
 int get currentPage;/// Number of items per page
 int get pageSize;/// Total number of pages
 int get totalPages;/// Whether there is a next page
 bool get hasNextPage;/// Whether there is a previous page
 bool get hasPreviousPage;
/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PagedResultCopyWith<T, PagedResult<T>> get copyWith => _$PagedResultCopyWithImpl<T, PagedResult<T>>(this as PagedResult<T>, _$identity);

  /// Serializes this PagedResult to a JSON map.
  Map<String, dynamic> toJson(Object? Function(T) toJsonT);


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PagedResult<T>&&const DeepCollectionEquality().equals(other.items, items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(items),totalCount,currentPage,pageSize,totalPages,hasNextPage,hasPreviousPage);

@override
String toString() {
  return 'PagedResult<$T>(items: $items, totalCount: $totalCount, currentPage: $currentPage, pageSize: $pageSize, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class $PagedResultCopyWith<T,$Res>  {
  factory $PagedResultCopyWith(PagedResult<T> value, $Res Function(PagedResult<T>) _then) = _$PagedResultCopyWithImpl;
@useResult
$Res call({
 List<T> items, int totalCount, int currentPage, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class _$PagedResultCopyWithImpl<T,$Res>
    implements $PagedResultCopyWith<T, $Res> {
  _$PagedResultCopyWithImpl(this._self, this._then);

  final PagedResult<T> _self;
  final $Res Function(PagedResult<T>) _then;

/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? items = null,Object? totalCount = null,Object? currentPage = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_self.copyWith(
items: null == items ? _self.items : items // ignore: cast_nullable_to_non_nullable
as List<T>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// @nodoc
@JsonSerializable(genericArgumentFactories: true)

class _PagedResult<T> implements PagedResult<T> {
  const _PagedResult({required final  List<T> items, required this.totalCount, required this.currentPage, required this.pageSize, required this.totalPages, required this.hasNextPage, required this.hasPreviousPage}): _items = items;
  factory _PagedResult.fromJson(Map<String, dynamic> json,T Function(Object?) fromJsonT) => _$PagedResultFromJson(json,fromJsonT);

/// The items in the current page
 final  List<T> _items;
/// The items in the current page
@override List<T> get items {
  if (_items is EqualUnmodifiableListView) return _items;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_items);
}

/// Total number of items across all pages
@override final  int totalCount;
/// Current page number (1-based)
@override final  int currentPage;
/// Number of items per page
@override final  int pageSize;
/// Total number of pages
@override final  int totalPages;
/// Whether there is a next page
@override final  bool hasNextPage;
/// Whether there is a previous page
@override final  bool hasPreviousPage;

/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PagedResultCopyWith<T, _PagedResult<T>> get copyWith => __$PagedResultCopyWithImpl<T, _PagedResult<T>>(this, _$identity);

@override
Map<String, dynamic> toJson(Object? Function(T) toJsonT) {
  return _$PagedResultToJson<T>(this, toJsonT);
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PagedResult<T>&&const DeepCollectionEquality().equals(other._items, _items)&&(identical(other.totalCount, totalCount) || other.totalCount == totalCount)&&(identical(other.currentPage, currentPage) || other.currentPage == currentPage)&&(identical(other.pageSize, pageSize) || other.pageSize == pageSize)&&(identical(other.totalPages, totalPages) || other.totalPages == totalPages)&&(identical(other.hasNextPage, hasNextPage) || other.hasNextPage == hasNextPage)&&(identical(other.hasPreviousPage, hasPreviousPage) || other.hasPreviousPage == hasPreviousPage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_items),totalCount,currentPage,pageSize,totalPages,hasNextPage,hasPreviousPage);

@override
String toString() {
  return 'PagedResult<$T>(items: $items, totalCount: $totalCount, currentPage: $currentPage, pageSize: $pageSize, totalPages: $totalPages, hasNextPage: $hasNextPage, hasPreviousPage: $hasPreviousPage)';
}


}

/// @nodoc
abstract mixin class _$PagedResultCopyWith<T,$Res> implements $PagedResultCopyWith<T, $Res> {
  factory _$PagedResultCopyWith(_PagedResult<T> value, $Res Function(_PagedResult<T>) _then) = __$PagedResultCopyWithImpl;
@override @useResult
$Res call({
 List<T> items, int totalCount, int currentPage, int pageSize, int totalPages, bool hasNextPage, bool hasPreviousPage
});




}
/// @nodoc
class __$PagedResultCopyWithImpl<T,$Res>
    implements _$PagedResultCopyWith<T, $Res> {
  __$PagedResultCopyWithImpl(this._self, this._then);

  final _PagedResult<T> _self;
  final $Res Function(_PagedResult<T>) _then;

/// Create a copy of PagedResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? items = null,Object? totalCount = null,Object? currentPage = null,Object? pageSize = null,Object? totalPages = null,Object? hasNextPage = null,Object? hasPreviousPage = null,}) {
  return _then(_PagedResult<T>(
items: null == items ? _self._items : items // ignore: cast_nullable_to_non_nullable
as List<T>,totalCount: null == totalCount ? _self.totalCount : totalCount // ignore: cast_nullable_to_non_nullable
as int,currentPage: null == currentPage ? _self.currentPage : currentPage // ignore: cast_nullable_to_non_nullable
as int,pageSize: null == pageSize ? _self.pageSize : pageSize // ignore: cast_nullable_to_non_nullable
as int,totalPages: null == totalPages ? _self.totalPages : totalPages // ignore: cast_nullable_to_non_nullable
as int,hasNextPage: null == hasNextPage ? _self.hasNextPage : hasNextPage // ignore: cast_nullable_to_non_nullable
as bool,hasPreviousPage: null == hasPreviousPage ? _self.hasPreviousPage : hasPreviousPage // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
