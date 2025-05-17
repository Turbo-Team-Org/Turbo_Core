import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

/// Category model
@freezed
sealed class Category with _$Category {
  const factory Category({
    required String id,
    required String name,
    required String icon,
    String? description,
    String? imageUrl,
    @Default(0) int placesCount,
    @Default(false) bool isFeatured,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
