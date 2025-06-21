import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_time_slot.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/business_availability.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_settings.dart';

/// Interfaz del repositorio de reservas
abstract class ReservationInterface {
  // ================== GESTIÓN DE RESERVAS ==================

  /// Crear nueva reserva
  Future<Reservation> createReservation(Reservation reservation);

  /// Obtener reserva por ID
  Future<Reservation?> getReservation(String reservationId);

  /// Actualizar reserva existente
  Future<void> updateReservation(Reservation reservation);

  /// Cancelar reserva
  Future<void> cancelReservation(String reservationId, {String? reason});

  /// Confirmar reserva (admin)
  Future<void> confirmReservation(
    String reservationId, {
    String? tableNumber,
    String? notes,
  });

  /// Rechazar reserva (admin)
  Future<void> rejectReservation(String reservationId, {String? reason});

  /// Check-in de cliente
  Future<void> checkInReservation(String reservationId, {String? notes});

  /// Completar reserva
  Future<void> completeReservation(String reservationId, {String? notes});

  /// Marcar como no-show
  Future<void> markNoShow(String reservationId, {String? notes});

  // ================== CONSULTAS DE RESERVAS ==================

  /// Obtener reservas por usuario
  Future<List<Reservation>> getUserReservations(
    String userId, {
    ReservationStatus? status,
  });

  /// Obtener reservas por lugar
  Future<List<Reservation>> getPlaceReservations(
    String placeId, {
    ReservationStatus? status,
  });

  /// Obtener reservas por fecha
  Future<List<Reservation>> getReservationsByDate(
    String placeId,
    DateTime date,
  );

  /// Obtener reservas entre fechas
  Future<List<Reservation>> getReservationsBetweenDates(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Obtener reservas del día actual para un lugar
  Future<List<Reservation>> getTodayReservations(String placeId);

  /// Obtener reservas futuras de un usuario
  Future<List<Reservation>> getUserUpcomingReservations(String userId);

  /// Stream de reservas en tiempo real para admin
  Stream<List<Reservation>> watchPlaceReservations(String placeId);

  // ================== DISPONIBILIDAD Y SLOTS ==================

  /// Obtener slots disponibles para una fecha
  Future<List<ReservationTimeSlot>> getAvailableSlots(
    String placeId,
    DateTime date,
  );

  /// Verificar disponibilidad para fecha/hora específica
  Future<bool> isSlotAvailable(
    String placeId,
    DateTime startTime,
    DateTime endTime,
    int partySize,
  );

  /// Obtener próximos slots disponibles
  Future<List<ReservationTimeSlot>> getNextAvailableSlots(
    String placeId, {
    int days = 7,
  });

  /// Generar slots para un día
  Future<List<ReservationTimeSlot>> generateDaySlots(
    String placeId,
    DateTime date,
  );

  // ================== GESTIÓN DE DISPONIBILIDAD ==================

  /// Obtener disponibilidad del negocio
  Future<BusinessAvailability?> getBusinessAvailability(String placeId);

  /// Crear/actualizar disponibilidad del negocio
  Future<void> setBusinessAvailability(BusinessAvailability availability);

  /// Actualizar horario semanal
  Future<void> updateWeeklySchedule(
    String placeId,
    List<WeeklySchedule> schedule,
  );

  /// Agregar día especial
  Future<void> addSpecialDay(String placeId, SpecialDay specialDay);

  /// Agregar fecha bloqueada
  Future<void> addBlackoutDate(String placeId, BlackoutDate blackoutDate);

  /// Eliminar fecha bloqueada
  Future<void> removeBlackoutDate(String placeId, String blackoutId);

  // ================== CONFIGURACIONES ==================

  /// Obtener configuraciones de reserva
  Future<ReservationSettings?> getReservationSettings(String placeId);

  /// Actualizar configuraciones de reserva
  Future<void> updateReservationSettings(ReservationSettings settings);

  /// Crear configuraciones por defecto
  Future<ReservationSettings> createDefaultSettings(
    String placeId, {
    String? createdBy,
  });

  // ================== ANALYTICS Y ESTADÍSTICAS ==================

  /// Obtener estadísticas de reservas
  Future<ReservationStats> getReservationStats(
    String placeId, {
    DateTime? startDate,
    DateTime? endDate,
  });

  /// Obtener tasa de ocupación
  Future<double> getOccupancyRate(String placeId, DateTime date);

  /// Obtener horarios más populares
  Future<List<PopularTimeSlot>> getPopularTimeSlots(
    String placeId, {
    int days = 30,
  });

  /// Obtener tendencias de reservas
  Future<List<ReservationTrend>> getReservationTrends(
    String placeId, {
    int days = 30,
  });

  // ================== NOTIFICACIONES ==================

  /// Enviar confirmación por email
  Future<void> sendConfirmationEmail(String reservationId);

  /// Enviar recordatorio por email
  Future<void> sendReminderEmail(String reservationId);

  /// Programar recordatorio automático
  Future<void> scheduleReminder(String reservationId);

  // ================== VALIDACIONES ==================

  /// Validar datos de reserva
  Future<ReservationValidationResult> validateReservation(
    Reservation reservation,
  );

  /// Verificar conflictos de horario
  Future<List<Reservation>> checkTimeConflicts(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  );

  /// Verificar capacidad disponible
  Future<int> getAvailableCapacity(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  );

  // ================== UTILS ==================

  /// Limpiar reservas antiguas
  Future<void> cleanupOldReservations({int olderThanDays = 90});

  /// Exportar reservas a CSV
  Future<String> exportReservationsToCSV(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  );

  /// Importar reservas desde CSV
  Future<void> importReservationsFromCSV(String placeId, String csvData);

  /// Liberar recursos
  void dispose();
}

/// Resultado de validación de reserva
class ReservationValidationResult {
  const ReservationValidationResult({
    required this.isValid,
    this.errors = const [],
    this.warnings = const [],
  });

  final bool isValid;
  final List<String> errors;
  final List<String> warnings;

  bool get hasErrors => errors.isNotEmpty;
  bool get hasWarnings => warnings.isNotEmpty;
}

/// Estadísticas de reservas
class ReservationStats {
  const ReservationStats({
    required this.totalReservations,
    required this.confirmedReservations,
    required this.cancelledReservations,
    required this.noShowReservations,
    required this.averagePartySize,
    required this.occupancyRate,
    required this.totalRevenue,
    required this.popularTimes,
  });

  final int totalReservations;
  final int confirmedReservations;
  final int cancelledReservations;
  final int noShowReservations;
  final double averagePartySize;
  final double occupancyRate;
  final double totalRevenue;
  final List<PopularTimeSlot> popularTimes;

  double get confirmationRate {
    if (totalReservations == 0) return 0.0;
    return (confirmedReservations / totalReservations) * 100;
  }

  double get cancellationRate {
    if (totalReservations == 0) return 0.0;
    return (cancelledReservations / totalReservations) * 100;
  }

  double get noShowRate {
    if (totalReservations == 0) return 0.0;
    return (noShowReservations / totalReservations) * 100;
  }
}

/// Slot de tiempo popular
class PopularTimeSlot {
  const PopularTimeSlot({
    required this.timeSlot,
    required this.reservationCount,
    required this.occupancyRate,
  });

  final String timeSlot;
  final int reservationCount;
  final double occupancyRate;
}

/// Tendencia de reservas
class ReservationTrend {
  const ReservationTrend({
    required this.date,
    required this.reservationCount,
    required this.occupancyRate,
    required this.revenue,
  });

  final DateTime date;
  final int reservationCount;
  final double occupancyRate;
  final double revenue;
}
