import 'package:core/src/category_repository/model/category.dart';
import 'package:core/src/place_repository/models/place/place.dart';

class PlaceCategory {
  final List<Place> places;
  final Category categories;

  PlaceCategory({required this.places, required this.categories});

  factory PlaceCategory.fromJson(Map<String, dynamic> json) {
    return PlaceCategory(
      places: json['places'] as List<Place>,
      categories: json['categories'] as Category,
    );
  }
  Map<String, dynamic> toJson() {
    return {'places': places, 'categories': categories};
  }
}
