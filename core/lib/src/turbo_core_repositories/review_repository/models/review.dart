import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/monorepo_utils/timestamp_converter.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'review.freezed.dart';
part 'review.g.dart';

/// Review model
@Freezed()
sealed class Review with _$Review {
  /// Constructor
  const factory Review({
    required String id,
    required String userId,
    required String userName,
    required String userAvatar,
    required String comment,
    required double rating,
    @TimestampDateTimeConverter() required DateTime date,
    @TimestampDateTimeConverter() DateTime? createdAt,
    @Default([]) List<String> imageUrls,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

  factory Review.fromFirestore(Map<String, dynamic> data) {
    String asString(dynamic value) => value?.toString() ?? '';
    double asDouble(dynamic value) =>
        value == null
            ? 0.0
            : (value is num
                ? value.toDouble()
                : double.tryParse(value.toString()) ?? 0.0);
    List<String> asStringList(dynamic value) =>
        value is Iterable ? value.map((e) => e.toString()).toList() : [];

    DateTime parsedDate;
    try {
      if (data['date'] is Timestamp) {
        parsedDate = (data['date'] as Timestamp).toDate();
      } else if (data['date'] is String) {
        parsedDate = DateTime.parse(data['date'] as String);
      } else {
        parsedDate = DateTime.now();
      }
    } catch (_) {
      parsedDate = DateTime.now();
    }

    DateTime? createdAt;
    try {
      if (data['createdAt'] is Timestamp) {
        createdAt = (data['createdAt'] as Timestamp).toDate();
      } else if (data['createdAt'] is String) {
        createdAt = DateTime.parse(data['createdAt'] as String);
      }
    } catch (_) {
      createdAt = parsedDate;
    }

    return Review(
      id: asString(data['id']),
      userId: asString(data['userId']),
      userName: asString(data['userName']),
      userAvatar: asString(data['userAvatar']),
      comment: asString(data['comment']),
      rating: asDouble(data['rating']),
      date: parsedDate,
      createdAt: createdAt ?? parsedDate,
      imageUrls: asStringList(data['imageUrls']),
    );
  }
}
