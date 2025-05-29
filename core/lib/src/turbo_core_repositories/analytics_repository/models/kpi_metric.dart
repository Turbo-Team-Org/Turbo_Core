import 'package:freezed_annotation/freezed_annotation.dart';

part 'kpi_metric.freezed.dart';
part 'kpi_metric.g.dart';

/// Modelo para representar una métrica KPI en analytics
@freezed
sealed class KpiMetric with _$KpiMetric {
  /// Constructor
  const factory KpiMetric({
    required String id,
    required String title,
    required String description,
    required double value,
    required String unit,
    required double previousValue,
    required MetricTrend trend,
    required String icon,
    @Default('') String formattedValue,
    @Default('') String changeText,
    @Default(0.0) double changePercentage,
    Map<String, dynamic>? metadata,
  }) = _KpiMetric;

  /// Constructor desde JSON
  factory KpiMetric.fromJson(Map<String, dynamic> json) =>
      _$KpiMetricFromJson(json);

  /// Constructor desde datos de Firestore
  factory KpiMetric.fromFirestore(Map<String, dynamic> data) {
    return KpiMetric.fromJson(data);
  }
}

/// Extensión para métodos útiles del KpiMetric
extension KpiMetricExtension on KpiMetric {
  /// Calcula el porcentaje de cambio vs período anterior
  double get calculatedChangePercentage {
    if (previousValue == 0) return value > 0 ? 100 : 0;
    return ((value - previousValue) / previousValue) * 100;
  }

  /// Determina la tendencia basada en los valores
  MetricTrend get calculatedTrend {
    if (value > previousValue) return MetricTrend.up;
    if (value < previousValue) return MetricTrend.down;
    return MetricTrend.stable;
  }

  /// Texto formateado del cambio
  String get calculatedChangeText {
    final percentage = calculatedChangePercentage.abs();
    final symbol =
        calculatedTrend == MetricTrend.up
            ? '+'
            : calculatedTrend == MetricTrend.down
            ? '-'
            : '';
    return '$symbol${percentage.toStringAsFixed(1)}%';
  }

  /// Valor formateado según el tipo de unidad
  String get calculatedFormattedValue {
    switch (unit.toLowerCase()) {
      case 'currency':
      case 'money':
      case 'pesos':
        return '\$${_formatNumber(value)}';
      case 'percentage':
      case '%':
        return '${value.toStringAsFixed(1)}%';
      case 'rating':
        return '${value.toStringAsFixed(1)}/5';
      case 'time':
      case 'minutes':
        return '${value.toInt()} min';
      case 'hours':
        return '${value.toStringAsFixed(1)} hrs';
      default:
        return _formatNumber(value);
    }
  }

  String _formatNumber(double number) {
    if (number >= 1000000) {
      return '${(number / 1000000).toStringAsFixed(1)}M';
    } else if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(1)}K';
    } else {
      return number.toStringAsFixed(0);
    }
  }

  /// CopyWith con valores calculados automáticamente
  KpiMetric withCalculatedValues() {
    return copyWith(
      changePercentage: calculatedChangePercentage,
      trend: calculatedTrend,
      changeText: calculatedChangeText,
      formattedValue: calculatedFormattedValue,
    );
  }
}

/// Tendencia de la métrica
enum MetricTrend { up, down, stable }

/// Extensión para MetricTrend
extension MetricTrendExtension on MetricTrend {
  /// Color asociado a la tendencia
  String get color {
    switch (this) {
      case MetricTrend.up:
        return '#4CAF50'; // Verde
      case MetricTrend.down:
        return '#F44336'; // Rojo
      case MetricTrend.stable:
        return '#FF9800'; // Naranja
    }
  }

  /// Icono asociado a la tendencia
  String get icon {
    switch (this) {
      case MetricTrend.up:
        return 'trending_up';
      case MetricTrend.down:
        return 'trending_down';
      case MetricTrend.stable:
        return 'trending_flat';
    }
  }

  /// Texto descriptivo de la tendencia
  String get description {
    switch (this) {
      case MetricTrend.up:
        return 'Incremento';
      case MetricTrend.down:
        return 'Disminución';
      case MetricTrend.stable:
        return 'Sin cambios';
    }
  }
}
