import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/place_repository/models/place/place.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'favorite.freezed.dart';
part 'favorite.g.dart';

/// Favorite model
@freezed
sealed class Favorite with _$Favorite {
  const factory Favorite({
    required String id,
    required String userId,
    required String placeId,
    required DateTime date,
    @Default(null) Place? place,
  }) = _Favorite;

  factory Favorite.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;
    final timestamp = data?['date'] as Timestamp?;
    final createdAtTimestamp = data?['createdAt'] as Timestamp?;

    return Favorite(
      id: doc.id,
      userId: data?['userId'] as String,
      placeId: data?['placeId'] as String,
      date: (timestamp ?? createdAtTimestamp)?.toDate() ?? DateTime.now(),
    );
  }

  factory Favorite.fromJson(Map<String, dynamic> json) =>
      _$FavoriteFromJson(json);
}
