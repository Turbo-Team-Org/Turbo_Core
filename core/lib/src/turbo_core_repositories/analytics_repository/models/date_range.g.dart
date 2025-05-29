// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'date_range.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_DateRange _$DateRangeFromJson(Map<String, dynamic> json) => _DateRange(
  startDate: DateTime.parse(json['startDate'] as String),
  endDate: DateTime.parse(json['endDate'] as String),
  type:
      $enumDecodeNullable(_$DateRangeTypeEnumMap, json['type']) ??
      DateRangeType.custom,
);

Map<String, dynamic> _$DateRangeToJson(_DateRange instance) =>
    <String, dynamic>{
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'type': _$DateRangeTypeEnumMap[instance.type]!,
    };

const _$DateRangeTypeEnumMap = {
  DateRangeType.today: 'today',
  DateRangeType.yesterday: 'yesterday',
  DateRangeType.last7Days: 'last7Days',
  DateRangeType.last30Days: 'last30Days',
  DateRangeType.thisMonth: 'thisMonth',
  DateRangeType.lastMonth: 'lastMonth',
  DateRangeType.custom: 'custom',
};
