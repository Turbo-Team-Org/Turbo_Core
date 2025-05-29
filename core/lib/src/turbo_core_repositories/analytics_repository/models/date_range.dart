import 'package:freezed_annotation/freezed_annotation.dart';

part 'date_range.freezed.dart';
part 'date_range.g.dart';

/// Modelo para representar un rango de fechas en analytics
@freezed
sealed class DateRange with _$DateRange {
  /// Constructor
  const factory DateRange({
    required DateTime startDate,
    required DateTime endDate,
    @Default(DateRangeType.custom) DateRangeType type,
  }) = _DateRange;

  /// Constructor desde JSON
  factory DateRange.fromJson(Map<String, dynamic> json) =>
      _$DateRangeFromJson(json);

  /// Constructores predefinidos para rangos comunes
  factory DateRange.today() {
    final now = DateTime.now();
    final startOfDay = DateTime(now.year, now.month, now.day);
    final endOfDay = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return DateRange(
      startDate: startOfDay,
      endDate: endOfDay,
      type: DateRangeType.today,
    );
  }

  factory DateRange.yesterday() {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    final startOfDay = DateTime(yesterday.year, yesterday.month, yesterday.day);
    final endOfDay = DateTime(
      yesterday.year,
      yesterday.month,
      yesterday.day,
      23,
      59,
      59,
    );
    return DateRange(
      startDate: startOfDay,
      endDate: endOfDay,
      type: DateRangeType.yesterday,
    );
  }

  factory DateRange.last7Days() {
    final now = DateTime.now();
    final startDate = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 6));
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return DateRange(
      startDate: startDate,
      endDate: endDate,
      type: DateRangeType.last7Days,
    );
  }

  factory DateRange.last30Days() {
    final now = DateTime.now();
    final startDate = DateTime(
      now.year,
      now.month,
      now.day,
    ).subtract(const Duration(days: 29));
    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);
    return DateRange(
      startDate: startDate,
      endDate: endDate,
      type: DateRangeType.last30Days,
    );
  }

  factory DateRange.thisMonth() {
    final now = DateTime.now();
    final startOfMonth = DateTime(now.year, now.month, 1);
    final endOfMonth = DateTime(now.year, now.month + 1, 0, 23, 59, 59);
    return DateRange(
      startDate: startOfMonth,
      endDate: endOfMonth,
      type: DateRangeType.thisMonth,
    );
  }

  factory DateRange.lastMonth() {
    final now = DateTime.now();
    final lastMonth = DateTime(now.year, now.month - 1, 1);
    final endOfLastMonth = DateTime(now.year, now.month, 0, 23, 59, 59);
    return DateRange(
      startDate: lastMonth,
      endDate: endOfLastMonth,
      type: DateRangeType.lastMonth,
    );
  }
}

/// Extensión para métodos útiles del DateRange
extension DateRangeExtension on DateRange {
  /// Duración del rango en días
  int get durationInDays => endDate.difference(startDate).inDays + 1;

  /// Verifica si una fecha está dentro del rango
  bool contains(DateTime date) {
    return date.isAfter(startDate.subtract(const Duration(milliseconds: 1))) &&
        date.isBefore(endDate.add(const Duration(milliseconds: 1)));
  }

  /// Obtiene el rango anterior con la misma duración
  DateRange get previousRange {
    final duration = endDate.difference(startDate);
    final newEndDate = startDate.subtract(const Duration(milliseconds: 1));
    final newStartDate = newEndDate.subtract(duration);
    return DateRange(
      startDate: newStartDate,
      endDate: newEndDate,
      type: DateRangeType.custom,
    );
  }

  /// Convierte a formato legible
  String get displayText {
    switch (type) {
      case DateRangeType.today:
        return 'Hoy';
      case DateRangeType.yesterday:
        return 'Ayer';
      case DateRangeType.last7Days:
        return 'Últimos 7 días';
      case DateRangeType.last30Days:
        return 'Últimos 30 días';
      case DateRangeType.thisMonth:
        return 'Este mes';
      case DateRangeType.lastMonth:
        return 'Mes pasado';
      case DateRangeType.custom:
        return '${_formatDate(startDate)} - ${_formatDate(endDate)}';
    }
  }

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/${date.month.toString().padLeft(2, '0')}/${date.year}';
  }
}

/// Tipos de rangos de fechas predefinidos
enum DateRangeType {
  today,
  yesterday,
  last7Days,
  last30Days,
  thisMonth,
  lastMonth,
  custom,
}
