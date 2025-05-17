// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'schedule.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ScheduleImpl _$$ScheduleImplFromJson(Map<String, dynamic> json) =>
    _$ScheduleImpl(
      opening: json['opening'] as String,
      closing: json['closing'] as String,
      isFullDay: json['isFullDay'] as bool? ?? false,
      dayName: json['dayName'] as String? ?? '',
    );

Map<String, dynamic> _$$ScheduleImplToJson(_$ScheduleImpl instance) =>
    <String, dynamic>{
      'opening': instance.opening,
      'closing': instance.closing,
      'isFullDay': instance.isFullDay,
      'dayName': instance.dayName,
    };
