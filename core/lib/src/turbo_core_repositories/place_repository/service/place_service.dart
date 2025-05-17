import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/offer/offer.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';

/// Place service
class PlaceService implements PlaceInterface {
  /// Constructor
  PlaceService({required this.firestore});

  /// Firebase firestore
  final FirebaseFirestore firestore;

  @override
  Future<List<Place>> getPlaces() async {
    try {
      final snapshot = await firestore.collection('places').get();
      final places = await Future.wait(
        snapshot.docs.map((doc) async {
          final place = Place.fromFirestore(doc);

          final reviewsSnapshot =
              await firestore
                  .collection('reviews')
                  .where('placeId', isEqualTo: place.id)
                  .orderBy('date', descending: true)
                  .limit(20)
                  .get();

          final offersSnapshot =
              await firestore
                  .collection('offers')
                  .where('placeId', isEqualTo: place.id)
                  .get();

          final offers = offersSnapshot.docs.map(Offer.fromFirestore).toList();

          final reviews =
              reviewsSnapshot.docs
                  .map((reviewDoc) => Review.fromFirestore(reviewDoc.data()))
                  .toList();

          return place.copyWith(reviews: reviews, offers: offers);
        }).toList(),
      );

      return places;
    } catch (e) {
      throw Exception(e);
    }
  }

  @override
  Future<Place> getPlaceById(String id) {
    // TODO: implement getPlaceById
    throw UnimplementedError();
  }

  @override
  Future<Place> getPlaceByName(String name) {
    // TODO: implement getPlaceByName
    throw UnimplementedError();
  }
}
