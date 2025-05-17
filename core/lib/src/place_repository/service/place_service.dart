import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:turbo/places/place_repository/interface/place_interface.dart';
import 'package:turbo/places/place_repository/models/place/place.dart';

import '../../../reviews/review_repository/models/review.dart';
import '../models/offer/offer.dart';

class PlaceService implements PlaceInterface {
  final FirebaseFirestore firestore;

  PlaceService({required this.firestore});
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

          final offers =
              offersSnapshot.docs
                  .map((offerDoc) => Offer.fromFirestore(offerDoc))
                  .toList();

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
}
