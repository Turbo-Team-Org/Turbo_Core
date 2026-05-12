import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/offer/offer.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'place.freezed.dart';
part 'place.g.dart';

/// Place model
@Freezed()
sealed class Place with _$Place {
  const factory Place({
    required String id,
    required String name,
    required String description,
    required String address,
    required List<String> imageUrls,
    required double rating,
    required List<Review> reviews,
    @Default([]) List<Offer> offers,
    @Default([]) List<String> tags,
    @Default(false) bool isOpen,
    @Default('') String mainImage,
    @Default(0) int favoriteCount,
    @Default('') String menuUrl,
    @Default(0.0) double latitude,
    @Default(0.0) double longitude,
    @Default('') String categoryId,
    @Default('') String categoryName,
    @Default({}) Map<String, Map<String, String>> openingHours,
    @Default('') String phone,
    @Default('') String website,
    @Default(0) int priceLevel,
    @Default({}) Map<String, dynamic> metadata,
    //Campos administrativos para ownership y auditoría
    @Default([]) List<String> ownerIds,
    @Default('') String createdBy,
    DateTime? createdAt,
    DateTime? lastUpdated,
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

    Map<String, Map<String, String>> asOpeningHours(dynamic value) {
      if (value is! Map) return {};
      return Map.fromEntries(
        value.entries.map(
          (e) => MapEntry(
            e.key.toString(),
            (e.value as Map).map(
              (k, v) => MapEntry(k.toString(), v.toString()),
            ),
          ),
        ),
      );
    }

    return Place(
      id: doc.id,
      name: asString(data?['name']),
      description: asString(data?['description']),
      address: asString(data?['address']),
      imageUrls: asStringList(data?['imageUrls']),
      rating: asDouble(data?['rating']),
      reviews: [], // You can implement review parsing if needed
      offers: asMapList(data?['offers']).map(Offer.fromJson).toList(),
      tags: asStringList(data?['tags']),
      isOpen: asBool(data?['isOpen']),
      mainImage:
          asString(data?['mainImage']).isNotEmpty
              ? asString(data?['mainImage'])
              : (asStringList(data?['imageUrls']).isNotEmpty
                  ? asStringList(data?['imageUrls']).first
                  : ''),
      favoriteCount: asInt(data?['favoriteCount']),
      menuUrl: asString(data?['menuUrl']),
      latitude: asDouble(data?['latitude']),
      longitude: asDouble(data?['longitude']),
      categoryId: asString(data?['categoryId']),
      categoryName: asString(data?['categoryName']),
      openingHours: asOpeningHours(data?['openingHours']),
      phone: asString(data?['phone']),
      website: asString(data?['website']),
      priceLevel: asInt(data?['priceLevel']),
      metadata: data?['metadata'] as Map<String, dynamic>? ?? {},
      ownerIds: asStringList(data?['ownerIds']),
      createdBy: asString(data?['createdBy']),
      createdAt:
          data?['createdAt'] != null
              ? (data?['createdAt'] is Timestamp
                  ? (data?['createdAt'] as Timestamp).toDate()
                  : DateTime.tryParse(data?['createdAt'].toString() ?? ''))
              : null,
      lastUpdated:
          data?['lastUpdated'] != null
              ? (data?['lastUpdated'] is Timestamp
                  ? (data?['lastUpdated'] as Timestamp).toDate()
                  : DateTime.tryParse(data?['lastUpdated'].toString() ?? ''))
              : null,
    );
  }
}
