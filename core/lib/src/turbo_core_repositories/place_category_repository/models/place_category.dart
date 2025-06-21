import 'package:freezed_annotation/freezed_annotation.dart';

part 'place_category.freezed.dart';
part 'place_category.g.dart';

@freezed
class PlaceCategory with _$PlaceCategory {
  const factory PlaceCategory({
    required String placeId,
    required String categoryId,
    required DateTime createdAt,
  }) = _PlaceCategory;

  factory PlaceCategory.fromJson(Map<String, dynamic> json) =>
      _$PlaceCategoryFromJson(json);

  @override
  // TODO: implement categoryId
  String get categoryId => throw UnimplementedError();

  @override
  // TODO: implement createdAt
  DateTime get createdAt => throw UnimplementedError();

  @override
  // TODO: implement placeId
  String get placeId => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
