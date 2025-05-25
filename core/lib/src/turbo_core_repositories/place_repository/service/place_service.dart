import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';

/// Place service
class PlaceService implements PlaceInterface {
  /// Constructor
  const PlaceService({required this.firestore});

  /// Firestore instance
  final FirebaseFirestore firestore;

  @override
  Future<List<Place>> getPlaces() async {
    try {
      final placesSnapshot = await firestore.collection('places').get();
      final places = <Place>[];

      for (final doc in placesSnapshot.docs) {
        final place = Place.fromFirestore(doc);
        final reviewsSnapshot =
            await firestore
                .collection('reviews')
                .where('placeId', isEqualTo: place.id)
                .orderBy('date', descending: true)
                .limit(20)
                .get();

        final reviews =
            reviewsSnapshot.docs
                .map((doc) => Review.fromFirestore(doc.data()))
                .toList();

        places.add(place.copyWith(reviews: reviews));
      }

      return places;
    } catch (e) {
      throw Exception('Error getting places: $e');
    }
  }

  @override
  Future<Place> getPlaceById(String id) async {
    try {
      final doc = await firestore.collection('places').doc(id).get();

      if (!doc.exists) {
        throw Exception('Place not found');
      }

      final place = Place.fromFirestore(doc);
      final reviewsSnapshot =
          await firestore
              .collection('reviews')
              .where('placeId', isEqualTo: place.id)
              .orderBy('date', descending: true)
              .limit(20)
              .get();

      final reviews =
          reviewsSnapshot.docs
              .map((doc) => Review.fromFirestore(doc.data()))
              .toList();

      return place.copyWith(reviews: reviews);
    } catch (e) {
      throw Exception('Error getting place: $e');
    }
  }

  @override
  Future<Place> getPlaceByName(String name) async {
    try {
      final querySnapshot =
          await firestore
              .collection('places')
              .where('name', isEqualTo: name)
              .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Place not found');
      }

      final place = Place.fromFirestore(querySnapshot.docs.first);
      final reviewsSnapshot =
          await firestore
              .collection('reviews')
              .where('placeId', isEqualTo: place.id)
              .orderBy('date', descending: true)
              .limit(20)
              .get();

      final reviews =
          reviewsSnapshot.docs
              .map((doc) => Review.fromFirestore(doc.data()))
              .toList();

      return place.copyWith(reviews: reviews);
    } catch (e) {
      throw Exception('Error getting place: $e');
    }
  }

  @override
  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    try {
      final querySnapshot =
          await firestore
              .collection('places')
              .where('categoryId', isEqualTo: categoryId)
              .get();

      final places = <Place>[];

      for (final doc in querySnapshot.docs) {
        final place = Place.fromFirestore(doc);
        final reviewsSnapshot =
            await firestore
                .collection('reviews')
                .where('placeId', isEqualTo: place.id)
                .orderBy('date', descending: true)
                .limit(20)
                .get();

        final reviews =
            reviewsSnapshot.docs
                .map((doc) => Review.fromFirestore(doc.data()))
                .toList();

        places.add(place.copyWith(reviews: reviews));
      }

      return places;
    } catch (e) {
      throw Exception('Error getting places by category: $e');
    }
  }

  @override
  Future<void> addPlace(Place place) async {
    try {
      await firestore.collection('places').doc(place.id).set(place.toJson());
    } catch (e) {
      throw Exception('Error adding place: $e');
    }
  }

  @override
  Future<void> updatePlace(Place place) async {
    try {
      await firestore.collection('places').doc(place.id).update(place.toJson());
    } catch (e) {
      throw Exception('Error updating place: $e');
    }
  }

  @override
  Future<void> deletePlace(String id) async {
    try {
      await firestore.collection('places').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting place: $e');
    }
  }
}
