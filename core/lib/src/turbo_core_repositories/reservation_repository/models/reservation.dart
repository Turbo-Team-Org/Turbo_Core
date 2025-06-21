import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';

part 'reservation.freezed.dart';
part 'reservation.g.dart';

/// Modelo principal de reserva
@freezed
sealed class Reservation with _$Reservation {
  const factory Reservation({
    required String id,
    required String placeId,
    required String userId,
    required DateTime reservationDate,
    required DateTime startTime,
    required DateTime endTime,
    required int partySize,
    required ReservationStatus status,
    @Default('') String customerName,
    @Default('') String customerEmail,
    @Default('') String customerPhone,
    String? placeName,
    String? specialRequests,
    String? notes,
    String? tableNumber,
    String? confirmationCode,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? confirmedAt,
    DateTime? checkedInAt,
    DateTime? cancelledAt,
    String? cancelReason,
    String? adminNotes,
    bool? reminderSent,
    @Default({}) Map<String, dynamic> customerInfo,
    @Default({}) Map<String, dynamic> metadata,
  }) = _Reservation;

  const Reservation._();

  factory Reservation.fromJson(Map<String, dynamic> json) =>
      _$ReservationFromJson(json);

  /// Crear desde datos de Firestore
  factory Reservation.fromFirestore(Map<String, dynamic> data) {
    return Reservation(
      id: data['id'] as String,
      placeId: data['placeId'] as String,
      placeName: data['placeName'] as String,
      userId: data['userId'] as String,
      reservationDate: (data['reservationDate'] as Timestamp).toDate(),
      startTime: (data['startTime'] as Timestamp).toDate(),
      endTime: (data['endTime'] as Timestamp).toDate(),
      partySize: data['partySize'] as int,
      status: ReservationStatus.fromString(data['status'] as String),
      customerName: data['customerName'] as String? ?? '',
      customerEmail: data['customerEmail'] as String? ?? '',
      customerPhone: data['customerPhone'] as String? ?? '',
      specialRequests: data['specialRequests'] as String?,
      notes: data['notes'] as String?,
      tableNumber: data['tableNumber'] as String?,
      confirmationCode: data['confirmationCode'] as String?,
      createdAt: data['createdAt'] != null
          ? (data['createdAt'] as Timestamp).toDate()
          : null,
      updatedAt: data['updatedAt'] != null
          ? (data['updatedAt'] as Timestamp).toDate()
          : null,
      confirmedAt: data['confirmedAt'] != null
          ? (data['confirmedAt'] as Timestamp).toDate()
          : null,
      checkedInAt: data['checkedInAt'] != null
          ? (data['checkedInAt'] as Timestamp).toDate()
          : null,
      cancelledAt: data['cancelledAt'] != null
          ? (data['cancelledAt'] as Timestamp).toDate()
          : null,
      cancelReason: data['cancelReason'] as String?,
      adminNotes: data['adminNotes'] as String?,
      reminderSent: data['reminderSent'] as bool?,
      customerInfo: data['customerInfo'] as Map<String, dynamic>? ?? {},
      metadata: data['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  /// Convertir a formato Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'placeId': placeId,
      'placeName': placeName,
      'userId': userId,
      'reservationDate': Timestamp.fromDate(reservationDate),
      'startTime': Timestamp.fromDate(startTime),
      'endTime': Timestamp.fromDate(endTime),
      'partySize': partySize,
      'status': status.value,
      'customerName': customerName,
      'customerEmail': customerEmail,
      'customerPhone': customerPhone,
      'specialRequests': specialRequests,
      'notes': notes,
      'tableNumber': tableNumber,
      'confirmationCode': confirmationCode,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'confirmedAt':
          confirmedAt != null ? Timestamp.fromDate(confirmedAt!) : null,
      'checkedInAt':
          checkedInAt != null ? Timestamp.fromDate(checkedInAt!) : null,
      'cancelledAt':
          cancelledAt != null ? Timestamp.fromDate(cancelledAt!) : null,
      'cancelReason': cancelReason,
      'adminNotes': adminNotes,
      'reminderSent': reminderSent,
      'customerInfo': customerInfo,
      'metadata': metadata,
    };
  }

  /// Duración de la reserva en minutos
  int get durationMinutes {
    return endTime.difference(startTime).inMinutes;
  }

  /// Tiempo formateado (ej: "14:30 - 15:30")
  String get formattedTime {
    final startFormatted =
        '${startTime.hour.toString().padLeft(2, '0')}:${startTime.minute.toString().padLeft(2, '0')}';
    final endFormatted =
        '${endTime.hour.toString().padLeft(2, '0')}:${endTime.minute.toString().padLeft(2, '0')}';
    return '$startFormatted - $endFormatted';
  }

  /// Fecha formateada (ej: "Lunes, 15 de Enero")
  String get formattedDate {
    const months = [
      'Enero',
      'Febrero',
      'Marzo',
      'Abril',
      'Mayo',
      'Junio',
      'Julio',
      'Agosto',
      'Septiembre',
      'Octubre',
      'Noviembre',
      'Diciembre',
    ];
    const weekdays = [
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
      'Domingo',
    ];

    final weekday = weekdays[reservationDate.weekday - 1];
    final month = months[reservationDate.month - 1];

    return '$weekday, ${reservationDate.day} de $month';
  }

  /// Verificar si se puede cancelar
  bool get canBeCancelled {
    if (status.isFinal) return false;

    // No se puede cancelar si faltan menos de 2 horas
    final now = DateTime.now();
    final timeDifference = startTime.difference(now).inHours;

    return timeDifference >= 2;
  }

  /// Verificar si se puede modificar
  bool get canBeModified {
    if (!status.canBeModified) return false;

    // No se puede modificar si faltan menos de 4 horas
    final now = DateTime.now();
    final timeDifference = startTime.difference(now).inHours;

    return timeDifference >= 4;
  }

  /// Verificar si es reserva de hoy
  bool get isToday {
    final now = DateTime.now();
    return reservationDate.year == now.year &&
        reservationDate.month == now.month &&
        reservationDate.day == now.day;
  }

  /// Verificar si es reserva futura
  bool get isFuture {
    return reservationDate.isAfter(DateTime.now());
  }

  /// Verificar si ya pasó
  bool get isPast {
    return endTime.isBefore(DateTime.now());
  }

  /// Tiempo restante hasta la reserva
  Duration? get timeUntilReservation {
    final now = DateTime.now();
    if (startTime.isBefore(now)) return null;
    return startTime.difference(now);
  }

  /// Generar código de confirmación único
  static String generateConfirmationCode() {
    final now = DateTime.now();
    final timestamp = now.millisecondsSinceEpoch.toString();
    return 'TRB${timestamp.substring(timestamp.length - 6)}';
  }

  /// Crear nueva reserva
  factory Reservation.create({
    required String placeId,
    required String userId,
    required DateTime reservationDate,
    required DateTime startTime,
    required DateTime endTime,
    required int partySize,
    required String customerName,
    required String customerEmail,
    String? customerPhone,
    String? specialRequests,
    Map<String, dynamic>? customerInfo,
  }) {
    final now = DateTime.now();
    final id = '${placeId}_${userId}_${now.millisecondsSinceEpoch}';

    return Reservation(
      id: id,
      placeId: placeId,
      userId: userId,
      reservationDate: reservationDate,
      startTime: startTime,
      endTime: endTime,
      partySize: partySize,
      status: ReservationStatus.pending,
      customerName: customerName,
      customerEmail: customerEmail,
      customerPhone: customerPhone ?? '',
      specialRequests: specialRequests,
      confirmationCode: generateConfirmationCode(),
      createdAt: now,
      updatedAt: now,
      customerInfo: customerInfo ?? {},
    );
  }

  /// Confirmar reserva
  Reservation confirm({String? tableNumber, String? adminNotes}) {
    return copyWith(
      status: ReservationStatus.confirmed,
      confirmedAt: DateTime.now(),
      updatedAt: DateTime.now(),
      tableNumber: tableNumber,
      adminNotes: adminNotes,
    );
  }

  /// Cancelar reserva
  Reservation cancel({String? reason, String? adminNotes}) {
    return copyWith(
      status: ReservationStatus.cancelled,
      cancelledAt: DateTime.now(),
      updatedAt: DateTime.now(),
      cancelReason: reason,
      adminNotes: adminNotes,
    );
  }

  /// Rechazar reserva
  Reservation reject({String? reason, String? adminNotes}) {
    return copyWith(
      status: ReservationStatus.rejected,
      cancelledAt: DateTime.now(),
      updatedAt: DateTime.now(),
      cancelReason: reason,
      adminNotes: adminNotes,
    );
  }

  /// Check-in del cliente
  Reservation checkIn({String? adminNotes}) {
    return copyWith(
      status: ReservationStatus.checkedIn,
      checkedInAt: DateTime.now(),
      updatedAt: DateTime.now(),
      adminNotes: adminNotes,
    );
  }

  /// Marcar como completada
  Reservation complete({String? adminNotes}) {
    return copyWith(
      status: ReservationStatus.completed,
      updatedAt: DateTime.now(),
      adminNotes: adminNotes,
    );
  }

  /// Marcar como no-show
  Reservation markNoShow({String? adminNotes}) {
    return copyWith(
      status: ReservationStatus.noShow,
      updatedAt: DateTime.now(),
      adminNotes: adminNotes,
    );
  }
}
