import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'event.freezed.dart';
part 'event.g.dart';

/// Event type enum
enum EventType {
  /// Party event type
  party,

  /// Concert event type
  concert,

  /// Promotion event type
  promotion,

  /// Offer event type
  offer,

  /// Cultural event type
  cultural,
}

/// Event model
@freezed
sealed class Event with _$Event {
  const factory Event({
    required String id,
    required String title,
    required String description,
    required DateTime date,
    required String location,
    required String imageUrl,
    required EventType type,
    String? placeId,
    double? price,
    @Default(false) bool isHighlighted,
    @Default([]) List<String> tags,
    String? organizerName,
    String? organizerContact,
    DateTime? endDate,
    String? link,
    @Default('') String createdBy,
    DateTime? createdAt,
    String? lastUpdatedBy,
    DateTime? lastUpdatedAt,
  }) = _Event;

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

  factory Event.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>?;

    String asString(dynamic value) => value?.toString() ?? '';
    bool asBool(dynamic value) => value is bool ? value : value == true;
    double? asDouble(dynamic value) =>
        value == null
            ? null
            : (value is num
                ? value.toDouble()
                : double.tryParse(value.toString()));
    List<String> asStringList(dynamic value) =>
        value is Iterable ? value.map((e) => e.toString()).toList() : [];

    // Helper function to safely convert timestamp or string to DateTime
    DateTime? _parseDateTime(dynamic value) {
      if (value == null) return null;
      if (value is Timestamp) {
        return value.toDate();
      }
      if (value is String) {
        return DateTime.tryParse(value);
      }
      return null;
    }

    return Event(
      id: doc.id,
      title: asString(data?['title']),
      description: asString(data?['description']),
      date: _parseDateTime(data?['date']) ?? DateTime.now(),
      location: asString(data?['location']),
      imageUrl: asString(data?['imageUrl']),
      type: _parseEventType(asString(data?['type'])),
      placeId: data?['placeId'] != null ? asString(data?['placeId']) : null,
      price: asDouble(data?['price']),
      isHighlighted: asBool(data?['isHighlighted']),
      tags: asStringList(data?['tags']),
      organizerName:
          data?['organizerName'] != null
              ? asString(data?['organizerName'])
              : null,
      organizerContact:
          data?['organizerContact'] != null
              ? asString(data?['organizerContact'])
              : null,
      endDate: _parseDateTime(data?['endDate']),
      link: data?['link'] != null ? asString(data?['link']) : null,
      createdBy: asString(data?['createdBy']),
      lastUpdatedBy:
          data?['lastUpdatedBy'] != null
              ? asString(data?['lastUpdatedBy'])
              : null,
      createdAt: _parseDateTime(data?['createdAt']),
      lastUpdatedAt: _parseDateTime(data?['lastUpdatedAt']),
    );
  }
}

EventType _parseEventType(String type) {
  switch (type.toLowerCase()) {
    case 'party':
      return EventType.party;
    case 'concert':
      return EventType.concert;
    case 'promotion':
      return EventType.promotion;
    case 'cultural':
      return EventType.cultural;
    case 'offer':
    default:
      return EventType.offer;
  }
}
