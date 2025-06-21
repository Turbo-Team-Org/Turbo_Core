import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'reservation_time_slot.freezed.dart';
part 'reservation_time_slot.g.dart';

/// Slot de tiempo disponible para reservas
@freezed
sealed class ReservationTimeSlot with _$ReservationTimeSlot {
  const factory ReservationTimeSlot({
    required String id,
    required DateTime startTime,
    required DateTime endTime,
    required int maxCapacity,
    required int currentReservations,
    @Default(true) bool isAvailable,
    @Default(60) int durationMinutes,
    String? specialNotes,
    Map<String, dynamic>? metadata,
  }) = _ReservationTimeSlot;

  const ReservationTimeSlot._();

  factory ReservationTimeSlot.fromJson(Map<String, dynamic> json) =>
      _$ReservationTimeSlotFromJson(json);

  /// Crear desde datos de Firestore
  factory ReservationTimeSlot.fromFirestore(Map<String, dynamic> data) {
    return ReservationTimeSlot(
      id: data['id'] as String,
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      maxCapacity: data['maxCapacity'] as int,
      currentReservations: data['currentReservations'] as int? ?? 0,
      isAvailable: data['isAvailable'] as bool? ?? true,
      durationMinutes: data['durationMinutes'] as int? ?? 60,
      specialNotes: data['specialNotes'] as String?,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convertir a formato Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'maxCapacity': maxCapacity,
      'currentReservations': currentReservations,
      'isAvailable': isAvailable,
      'durationMinutes': durationMinutes,
      'specialNotes': specialNotes,
      'metadata': metadata,
    };
  }

  /// Slots disponibles restantes
  int get availableSlots => maxCapacity - currentReservations;

  /// Verificar si hay disponibilidad
  bool get hasAvailability => isAvailable && availableSlots > 0;

  /// Porcentaje de ocupación
  double get occupancyPercentage {
    if (maxCapacity == 0) return 0.0;
    return (currentReservations / maxCapacity) * 100;
  }

  /// Tiempo formateado (ej: "14:30 - 15:30")
  String get formattedTime {
    final startFormatted =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    final endFormatted =
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$startFormatted - $endFormatted';
  }

  /// Crear slot para horario específico
  factory ReservationTimeSlot.forTime({
    required DateTime date,
    required int hour,
    required int minute,
    required int durationMinutes,
    required int maxCapacity,
    String? specialNotes,
  }) {
    final startTime = DateTime(date.year, date.month, date.day, hour, minute);
    final endTime = startTime.add(Duration(minutes: durationMinutes));

    return ReservationTimeSlot(
      id:
          '${date.year}${date.month.toString().padLeft(2, '0')}${date.day.toString().padLeft(2, '0')}_${hour.toString().padLeft(2, '0')}${minute.toString().padLeft(2, '0')}',
      startTime: startTime,
      endTime: endTime,
      maxCapacity: maxCapacity,
      currentReservations: 0,
      durationMinutes: durationMinutes,
      specialNotes: specialNotes,
    );
  }
}
