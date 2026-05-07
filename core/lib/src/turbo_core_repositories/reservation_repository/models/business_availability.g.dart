// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_availability.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessAvailability _$BusinessAvailabilityFromJson(
  Map<String, dynamic> json,
) => _BusinessAvailability(
  id: json['id'] as String,
  placeId: json['placeId'] as String,
  weeklySchedule: (json['weeklySchedule'] as List<dynamic>)
      .map((e) => WeeklySchedule.fromJson(e as Map<String, dynamic>))
      .toList(),
  specialDays:
      (json['specialDays'] as List<dynamic>?)
          ?.map((e) => SpecialDay.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  blackoutDates:
      (json['blackoutDates'] as List<dynamic>?)
          ?.map((e) => BlackoutDate.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  acceptsReservations: json['acceptsReservations'] as bool? ?? true,
  defaultSlotDuration: (json['defaultSlotDuration'] as num?)?.toInt() ?? 60,
  maxPartySizeDefault: (json['maxPartySizeDefault'] as num?)?.toInt() ?? 1,
  maxAdvanceBookingDays: (json['maxAdvanceBookingDays'] as num?)?.toInt() ?? 4,
  minAdvanceBookingHours:
      (json['minAdvanceBookingHours'] as num?)?.toInt() ?? 2,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  createdBy: json['createdBy'] as String?,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$BusinessAvailabilityToJson(
  _BusinessAvailability instance,
) => <String, dynamic>{
  'id': instance.id,
  'placeId': instance.placeId,
  'weeklySchedule': instance.weeklySchedule,
  'specialDays': instance.specialDays,
  'blackoutDates': instance.blackoutDates,
  'acceptsReservations': instance.acceptsReservations,
  'defaultSlotDuration': instance.defaultSlotDuration,
  'maxPartySizeDefault': instance.maxPartySizeDefault,
  'maxAdvanceBookingDays': instance.maxAdvanceBookingDays,
  'minAdvanceBookingHours': instance.minAdvanceBookingHours,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'createdBy': instance.createdBy,
  'metadata': instance.metadata,
};

_WeeklySchedule _$WeeklyScheduleFromJson(Map<String, dynamic> json) =>
    _WeeklySchedule(
      dayOfWeek: (json['dayOfWeek'] as num).toInt(),
      isOpen: json['isOpen'] as bool,
      timeRanges:
          (json['timeRanges'] as List<dynamic>?)
              ?.map((e) => TimeRange.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      notes: json['notes'] as String?,
    );

Map<String, dynamic> _$WeeklyScheduleToJson(_WeeklySchedule instance) =>
    <String, dynamic>{
      'dayOfWeek': instance.dayOfWeek,
      'isOpen': instance.isOpen,
      'timeRanges': instance.timeRanges,
      'notes': instance.notes,
    };

_SpecialDay _$SpecialDayFromJson(Map<String, dynamic> json) => _SpecialDay(
  date: DateTime.parse(json['date'] as String),
  isOpen: json['isOpen'] as bool,
  timeRanges:
      (json['timeRanges'] as List<dynamic>?)
          ?.map((e) => TimeRange.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  name: json['name'] as String?,
  description: json['description'] as String?,
);

Map<String, dynamic> _$SpecialDayToJson(_SpecialDay instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'isOpen': instance.isOpen,
      'timeRanges': instance.timeRanges,
      'name': instance.name,
      'description': instance.description,
    };

_BlackoutDate _$BlackoutDateFromJson(Map<String, dynamic> json) =>
    _BlackoutDate(
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      reason: json['reason'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$BlackoutDateToJson(_BlackoutDate instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'reason': instance.reason,
      'description': instance.description,
    };

_TimeRange _$TimeRangeFromJson(Map<String, dynamic> json) => _TimeRange(
  startTime: json['startTime'] as String,
  endTime: json['endTime'] as String,
  maxCapacity: (json['maxCapacity'] as num?)?.toInt() ?? 1,
);

Map<String, dynamic> _$TimeRangeToJson(_TimeRange instance) =>
    <String, dynamic>{
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'maxCapacity': instance.maxCapacity,
    };
