import 'package:turbo/places/place_repository/models/place/place.dart';

abstract class PlaceInterface {
  Future<List<Place>> getPlaces();
}
