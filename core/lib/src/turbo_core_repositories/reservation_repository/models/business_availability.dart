import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'business_availability.freezed.dart';
part 'business_availability.g.dart';

/// Disponibilidad de un negocio para reservas
@freezed
sealed class BusinessAvailability with _$BusinessAvailability {
  const factory BusinessAvailability({
    required String id,
    required String placeId,
    required List<WeeklySchedule> weeklySchedule,
    @Default([]) List<SpecialDay> specialDays,
    @Default([]) List<BlackoutDate> blackoutDates,
    @Default(true) bool acceptsReservations,
    @Default(60) int defaultSlotDuration,
    @Default(1) int maxPartySizeDefault,
    @Default(4) int maxAdvanceBookingDays,
    @Default(2) int minAdvanceBookingHours,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    Map<String, dynamic>? metadata,
  }) = _BusinessAvailability;

  const BusinessAvailability._();

  factory BusinessAvailability.fromJson(Map<String, dynamic> json) =>
      _$BusinessAvailabilityFromJson(json);

  /// Crear desde datos de Firestore
  factory BusinessAvailability.fromFirestore(Map<String, dynamic> data) {
    return BusinessAvailability(
      id: data['id'] as String,
      placeId: data['placeId'] as String,
      weeklySchedule:
          (data['weeklySchedule'] as List<dynamic>?)
              ?.map((e) => WeeklySchedule.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      specialDays:
          (data['specialDays'] as List<dynamic>?)
              ?.map((e) => SpecialDay.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      blackoutDates:
          (data['blackoutDates'] as List<dynamic>?)
              ?.map((e) => BlackoutDate.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      acceptsReservations: data['acceptsReservations'] as bool? ?? true,
      defaultSlotDuration: data['defaultSlotDuration'] as int? ?? 60,
      maxPartySizeDefault: data['maxPartySizeDefault'] as int? ?? 1,
      maxAdvanceBookingDays: data['maxAdvanceBookingDays'] as int? ?? 4,
      minAdvanceBookingHours: data['minAdvanceBookingHours'] as int? ?? 2,
      createdAt:
          data['createdAt'] != null
              ? (data['createdAt'] as Timestamp).toDate()
              : null,
      updatedAt:
          data['updatedAt'] != null
              ? (data['updatedAt'] as Timestamp).toDate()
              : null,
      createdBy: data['createdBy'] as String?,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convertir a formato Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'placeId': placeId,
      'weeklySchedule': weeklySchedule.map((e) => e.toMap()).toList(),
      'specialDays': specialDays.map((e) => e.toMap()).toList(),
      'blackoutDates': blackoutDates.map((e) => e.toMap()).toList(),
      'acceptsReservations': acceptsReservations,
      'defaultSlotDuration': defaultSlotDuration,
      'maxPartySizeDefault': maxPartySizeDefault,
      'maxAdvanceBookingDays': maxAdvanceBookingDays,
      'minAdvanceBookingHours': minAdvanceBookingHours,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'createdBy': createdBy,
      'metadata': metadata,
    };
  }

  /// Verificar si está disponible en una fecha específica
  bool isAvailableOnDate(DateTime date) {
    if (!acceptsReservations) return false;

    // Verificar blackout dates
    final isBlackedOut = blackoutDates.any(
      (blackout) =>
          date.isAfter(blackout.startDate.subtract(const Duration(days: 1))) &&
          date.isBefore(blackout.endDate.add(const Duration(days: 1))),
    );

    if (isBlackedOut) return false;

    // Verificar día especial
    final specialDay = specialDays.where(
      (special) =>
          date.year == special.date.year &&
          date.month == special.date.month &&
          date.day == special.date.day,
    );

    if (specialDay.isNotEmpty) {
      return specialDay.first.isOpen;
    }

    // Verificar horario semanal regular
    final weekday = date.weekday; // 1 = Monday, 7 = Sunday
    final schedule = weeklySchedule.where((s) => s.dayOfWeek == weekday);

    return schedule.isNotEmpty && schedule.first.isOpen;
  }

  /// Obtener horarios disponibles para una fecha
  List<TimeRange> getAvailableHoursForDate(DateTime date) {
    if (!isAvailableOnDate(date)) return [];

    // Verificar día especial primero
    final specialDay = specialDays.where(
      (special) =>
          date.year == special.date.year &&
          date.month == special.date.month &&
          date.day == special.date.day,
    );

    if (specialDay.isNotEmpty) {
      return specialDay.first.isOpen ? specialDay.first.timeRanges : [];
    }

    // Usar horario semanal regular
    final weekday = date.weekday;
    final schedule = weeklySchedule.where((s) => s.dayOfWeek == weekday);

    return schedule.isNotEmpty ? schedule.first.timeRanges : [];
  }
}

/// Horario semanal por día
@freezed
sealed class WeeklySchedule with _$WeeklySchedule {
  const factory WeeklySchedule({
    required int dayOfWeek, // 1 = Monday, 7 = Sunday
    required bool isOpen,
    @Default([]) List<TimeRange> timeRanges,
    String? notes,
  }) = _WeeklySchedule;

  const WeeklySchedule._();

  factory WeeklySchedule.fromJson(Map<String, dynamic> json) =>
      _$WeeklyScheduleFromJson(json);

  factory WeeklySchedule.fromMap(Map<String, dynamic> map) {
    return WeeklySchedule(
      dayOfWeek: map['dayOfWeek'] as int,
      isOpen: map['isOpen'] as bool,
      timeRanges:
          (map['timeRanges'] as List<dynamic>?)
              ?.map((e) => TimeRange.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      notes: map['notes'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dayOfWeek': dayOfWeek,
      'isOpen': isOpen,
      'timeRanges': timeRanges.map((e) => e.toMap()).toList(),
      'notes': notes,
    };
  }
}

/// Día especial (feriados, eventos especiales)
@freezed
sealed class SpecialDay with _$SpecialDay {
  const factory SpecialDay({
    required DateTime date,
    required bool isOpen,
    @Default([]) List<TimeRange> timeRanges,
    String? name,
    String? description,
  }) = _SpecialDay;

  const SpecialDay._();

  factory SpecialDay.fromJson(Map<String, dynamic> json) =>
      _$SpecialDayFromJson(json);

  factory SpecialDay.fromMap(Map<String, dynamic> map) {
    return SpecialDay(
      date: (map['date'] as Timestamp).toDate(),
      isOpen: map['isOpen'] as bool,
      timeRanges:
          (map['timeRanges'] as List<dynamic>?)
              ?.map((e) => TimeRange.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      name: map['name'] as String?,
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'date': Timestamp.fromDate(date),
      'isOpen': isOpen,
      'timeRanges': timeRanges.map((e) => e.toMap()).toList(),
      'name': name,
      'description': description,
    };
  }
}

/// Fecha bloqueada (no disponible)
@freezed
sealed class BlackoutDate with _$BlackoutDate {
  const factory BlackoutDate({
    required DateTime startDate,
    required DateTime endDate,
    String? reason,
    String? description,
  }) = _BlackoutDate;

  const BlackoutDate._();

  factory BlackoutDate.fromJson(Map<String, dynamic> json) =>
      _$BlackoutDateFromJson(json);

  factory BlackoutDate.fromMap(Map<String, dynamic> map) {
    return BlackoutDate(
      startDate: (map['startDate'] as Timestamp).toDate(),
      endDate: (map['endDate'] as Timestamp).toDate(),
      reason: map['reason'] as String?,
      description: map['description'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startDate': Timestamp.fromDate(startDate),
      'endDate': Timestamp.fromDate(endDate),
      'reason': reason,
      'description': description,
    };
  }
}

/// Rango de tiempo
@freezed
sealed class TimeRange with _$TimeRange {
  const factory TimeRange({
    required String startTime, // "09:00"
    required String endTime, // "17:00"
    @Default(1) int maxCapacity,
  }) = _TimeRange;

  const TimeRange._();

  factory TimeRange.fromJson(Map<String, dynamic> json) =>
      _$TimeRangeFromJson(json);

  factory TimeRange.fromMap(Map<String, dynamic> map) {
    return TimeRange(
      startTime: map['startTime'] as String,
      endTime: map['endTime'] as String,
      maxCapacity: map['maxCapacity'] as int? ?? 1,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'startTime': startTime,
      'endTime': endTime,
      'maxCapacity': maxCapacity,
    };
  }
}
