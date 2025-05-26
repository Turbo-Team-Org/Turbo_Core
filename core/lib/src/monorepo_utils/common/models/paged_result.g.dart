// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paged_result.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PagedResult<T> _$PagedResultFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _PagedResult<T>(
  items: (json['items'] as List<dynamic>).map(fromJsonT).toList(),
  totalCount: (json['totalCount'] as num).toInt(),
  currentPage: (json['currentPage'] as num).toInt(),
  pageSize: (json['pageSize'] as num).toInt(),
  totalPages: (json['totalPages'] as num).toInt(),
  hasNextPage: json['hasNextPage'] as bool,
  hasPreviousPage: json['hasPreviousPage'] as bool,
);

Map<String, dynamic> _$PagedResultToJson<T>(
  _PagedResult<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{
  'items': instance.items.map(toJsonT).toList(),
  'totalCount': instance.totalCount,
  'currentPage': instance.currentPage,
  'pageSize': instance.pageSize,
  'totalPages': instance.totalPages,
  'hasNextPage': instance.hasNextPage,
  'hasPreviousPage': instance.hasPreviousPage,
};
