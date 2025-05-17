import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/review_repository/models/review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/place_repository/models/offer/offer.dart';
import 'package:core/src/place_repository/models/schedule/schedule.dart';

part 'place.freezed.dart';
part 'place.g.dart';

@Freezed()
sealed class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String description,
    required String address,
    required double averagePrice,
    required List<String> imageUrls,
    required double rating,
    required List<Review> reviews,
    @Default([]) List<Offer> offers,
    @Default([]) List<String> tags,
    @Default(false) bool isOpen,
    @Default([]) List<Schedule> schedules,
    @Default('') String mainImage,
    @Default(0) int favoriteCount,
    @Default('') String menuUrl,
  }) = _Place;

  factory Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

  // Custom converter for Firestore
  factory Place.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    String asString(dynamic value) => value?.toString() ?? '';
    double asDouble(dynamic value) =>
        value == null
            ? 0.0
            : (value is num
                ? value.toDouble()
                : double.tryParse(value.toString()) ?? 0.0);
    int asInt(dynamic value) =>
        value == null
            ? 0
            : (value is int ? value : int.tryParse(value.toString()) ?? 0);
    bool asBool(dynamic value) => value is bool ? value : value == true;
    List<String> asStringList(dynamic value) =>
        value is Iterable ? value.map((e) => e.toString()).toList() : [];

    List<Map<String, dynamic>> asMapList(dynamic value) =>
        value is Iterable
            ? value
                .whereType<Map<String, dynamic>>()
                .cast<Map<String, dynamic>>()
                .toList()
            : [];

    return Place(
      id: doc.id,
      name: asString(data?['name']),
      description: asString(data?['description']),
      address: asString(data?['address']),
      averagePrice: asDouble(data?['averagePrice']),
      imageUrls: asStringList(data?['imageUrls']),
      rating: asDouble(data?['rating']),
      reviews: [], // You can implement review parsing if needed
      offers: asMapList(data?['offers']).map(Offer.fromJson).toList(),
      tags: asStringList(data?['tags']),
      isOpen: asBool(data?['isOpen']),
      schedules: asMapList(data?['schedules']).map(Schedule.fromJson).toList(),
      mainImage:
          asString(data?['mainImage']).isNotEmpty
              ? asString(data?['mainImage'])
              : (asStringList(data?['imageUrls']).isNotEmpty
                  ? asStringList(data?['imageUrls']).first
                  : ''),
      favoriteCount: asInt(data?['favoriteCount']),
      menuUrl: asString(data?['menuUrl']),
    );
  }
}
