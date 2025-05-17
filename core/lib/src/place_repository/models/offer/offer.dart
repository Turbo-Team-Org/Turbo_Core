import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/monorepo_utils/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'offer.freezed.dart';
part 'offer.g.dart';

@Freezed()
sealed class Offer with _$Offer {
  const factory Offer({
    required String offerTitle,
    required String offerDescription,
    @TimestampDateTimeConverter() required DateTime offerValidUntil,
    double? offerPrice,
    String? offerConditions,
    String? offerImage,
    @Default('') String name,
    @Default('') String description,
    @Default('') String image,
  }) = _Offer;

  factory Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

  // Custom converter for Firestore
  factory Offer.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    String asString(dynamic value) => value?.toString() ?? '';
    double? asDouble(dynamic value) =>
        value == null
            ? null
            : (value is num
                ? value.toDouble()
                : double.tryParse(value.toString()));

    DateTime validUntil;
    try {
      if (data?['offerValidUntil'] is Timestamp) {
        validUntil = (data?['offerValidUntil'] as Timestamp).toDate();
      } else if (data?['offerValidUntil'] is String) {
        validUntil = DateTime.parse(data?['offerValidUntil'] as String);
      } else {
        validUntil = DateTime.now().add(const Duration(days: 30));
      }
    } catch (_) {
      validUntil = DateTime.now().add(const Duration(days: 30));
    }

    return Offer(
      offerTitle: asString(data?['offerTitle']),
      offerDescription: asString(data?['offerDescription']),
      offerValidUntil: validUntil,
      offerPrice: asDouble(data?['offerPrice']) ?? 0,
      offerConditions:
          data?['offerConditions'] != null
              ? asString(data?['offerConditions'])
              : null,
      offerImage:
          data?['offerImage'] != null ? asString(data?['offerImage']) : null,
      name: asString(data?['name'] ?? data?['offerTitle']),
      description: asString(data?['description'] ?? data?['offerDescription']),
      image: asString(data?['image'] ?? data?['offerImage']),
    );
  }
}
