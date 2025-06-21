// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_time_slot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReservationTimeSlot _$ReservationTimeSlotFromJson(Map<String, dynamic> json) =>
    _ReservationTimeSlot(
      id: json['id'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      maxCapacity: (json['maxCapacity'] as num).toInt(),
      currentReservations: (json['currentReservations'] as num).toInt(),
      isAvailable: json['isAvailable'] as bool? ?? true,
      durationMinutes: (json['durationMinutes'] as num?)?.toInt() ?? 60,
      specialNotes: json['specialNotes'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ReservationTimeSlotToJson(
  _ReservationTimeSlot instance,
) => <String, dynamic>{
  'id': instance.id,
  'startTime': instance.startTime.toIso8601String(),
  'endTime': instance.endTime.toIso8601String(),
  'maxCapacity': instance.maxCapacity,
  'currentReservations': instance.currentReservations,
  'isAvailable': instance.isAvailable,
  'durationMinutes': instance.durationMinutes,
  'specialNotes': instance.specialNotes,
  'metadata': instance.metadata,
};
