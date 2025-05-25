// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Schedule _$ScheduleFromJson(Map<String, dynamic> json) => _Schedule(
  opening: json['opening'] as String,
  closing: json['closing'] as String,
  isFullDay: json['isFullDay'] as bool? ?? false,
  dayName: json['dayName'] as String? ?? '',
);

Map<String, dynamic> _$ScheduleToJson(_Schedule instance) => <String, dynamic>{
  'opening': instance.opening,
  'closing': instance.closing,
  'isFullDay': instance.isFullDay,
  'dayName': instance.dayName,
};
