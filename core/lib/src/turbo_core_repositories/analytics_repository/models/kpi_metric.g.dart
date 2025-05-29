// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'kpi_metric.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_KpiMetric _$KpiMetricFromJson(Map<String, dynamic> json) => _KpiMetric(
  id: json['id'] as String,
  title: json['title'] as String,
  description: json['description'] as String,
  value: (json['value'] as num).toDouble(),
  unit: json['unit'] as String,
  previousValue: (json['previousValue'] as num).toDouble(),
  trend: $enumDecode(_$MetricTrendEnumMap, json['trend']),
  icon: json['icon'] as String,
  formattedValue: json['formattedValue'] as String? ?? '',
  changeText: json['changeText'] as String? ?? '',
  changePercentage: (json['changePercentage'] as num?)?.toDouble() ?? 0.0,
  metadata: json['metadata'] as Map<String, dynamic>?,
);

Map<String, dynamic> _$KpiMetricToJson(_KpiMetric instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'value': instance.value,
      'unit': instance.unit,
      'previousValue': instance.previousValue,
      'trend': _$MetricTrendEnumMap[instance.trend]!,
      'icon': instance.icon,
      'formattedValue': instance.formattedValue,
      'changeText': instance.changeText,
      'changePercentage': instance.changePercentage,
      'metadata': instance.metadata,
    };

const _$MetricTrendEnumMap = {
  MetricTrend.up: 'up',
  MetricTrend.down: 'down',
  MetricTrend.stable: 'stable',
};
