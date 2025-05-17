import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

/// Custom converter to handle both Timestamp and String for DateTime
class TimestampDateTimeConverter implements JsonConverter<DateTime, dynamic> {
  /// Constructor
  const TimestampDateTimeConverter();

  @override
  DateTime fromJson(dynamic value) {
    if (value is Timestamp) {
      return value.toDate();
    } else if (value is String) {
      return DateTime.parse(value);
    } else if (value is DateTime) {
      return value;
    }
    return DateTime.now();
  }

  @override
  dynamic toJson(DateTime dateTime) => dateTime.toIso8601String();
}
