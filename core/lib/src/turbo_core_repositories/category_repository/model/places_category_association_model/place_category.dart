import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';

/// PlaceCategory model
class PlaceCategory {
  /// Constructor for the PlaceCategory model.
  PlaceCategory({required this.places, required this.categories});

  /// Factory method to create a PlaceCategory from a JSON object.
  factory PlaceCategory.fromJson(Map<String, dynamic> json) {
    return PlaceCategory(
      places: json['places'] as List<Place>,
      categories: json['categories'] as Category,
    );
  }

  /// List of places associated with the category.
  final List<Place> places;

  /// Category associated with the place.
  final Category categories;

  /// Method to convert the PlaceCategory to a JSON object.
  Map<String, dynamic> toJson() {
    return {'places': places, 'categories': categories};
  }
}
