import 'package:core/src/turbo_core_repositories/reservation_repository/interface/reservation_interface.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_time_slot.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/business_availability.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_settings.dart';

/// Repositorio de reservas - Punto de entrada principal
///
/// Proporciona una API completa para la gestión de reservas incluyendo:
/// - Creación y gestión de reservas para usuarios
/// - Panel de administración para negocios
/// - Configuración de disponibilidad y horarios
/// - Analytics y reportes de reservas
/// - Notificaciones automáticas
class ReservationRepository implements ReservationInterface {
  /// Constructor
  ReservationRepository({required ReservationInterface reservationService})
      : _reservationService = reservationService;

  /// Servicio de reservas (ahora acepta interfaz para flexibilidad de ambiente)
  final ReservationInterface _reservationService;

  // ================== GESTIÓN DE RESERVAS ==================

  @override
  Future<Reservation> createReservation(Reservation reservation) {
    return _reservationService.createReservation(reservation);
  }

  @override
  Future<Reservation?> getReservation(String reservationId) {
    return _reservationService.getReservation(reservationId);
  }

  @override
  Future<void> updateReservation(Reservation reservation) {
    return _reservationService.updateReservation(reservation);
  }

  @override
  Future<void> cancelReservation(String reservationId, {String? reason}) {
    return _reservationService.cancelReservation(reservationId, reason: reason);
  }

  @override
  Future<void> confirmReservation(
    String reservationId, {
    String? tableNumber,
    String? notes,
  }) {
    return _reservationService.confirmReservation(
      reservationId,
      tableNumber: tableNumber,
      notes: notes,
    );
  }

  @override
  Future<void> rejectReservation(String reservationId, {String? reason}) {
    return _reservationService.rejectReservation(reservationId, reason: reason);
  }

  @override
  Future<void> checkInReservation(String reservationId, {String? notes}) {
    return _reservationService.checkInReservation(reservationId, notes: notes);
  }

  @override
  Future<void> completeReservation(String reservationId, {String? notes}) {
    return _reservationService.completeReservation(reservationId, notes: notes);
  }

  @override
  Future<void> markNoShow(String reservationId, {String? notes}) {
    return _reservationService.markNoShow(reservationId, notes: notes);
  }

  // ================== CONSULTAS DE RESERVAS ==================

  @override
  Future<List<Reservation>> getUserReservations(
    String userId, {
    ReservationStatus? status,
  }) {
    return _reservationService.getUserReservations(userId, status: status);
  }

  @override
  Future<List<Reservation>> getPlaceReservations(
    String placeId, {
    ReservationStatus? status,
  }) {
    return _reservationService.getPlaceReservations(placeId, status: status);
  }

  @override
  Future<List<Reservation>> getReservationsByDate(
    String placeId,
    DateTime date,
  ) {
    return _reservationService.getReservationsByDate(placeId, date);
  }

  @override
  Future<List<Reservation>> getReservationsBetweenDates(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) {
    return _reservationService.getReservationsBetweenDates(
      placeId,
      startDate,
      endDate,
    );
  }

  @override
  Future<List<Reservation>> getTodayReservations(String placeId) {
    return _reservationService.getTodayReservations(placeId);
  }

  @override
  Future<List<Reservation>> getUserUpcomingReservations(String userId) {
    return _reservationService.getUserUpcomingReservations(userId);
  }

  @override
  Stream<List<Reservation>> watchPlaceReservations(String placeId) {
    return _reservationService.watchPlaceReservations(placeId);
  }

  // ================== DISPONIBILIDAD Y SLOTS ==================

  @override
  Future<List<ReservationTimeSlot>> getAvailableSlots(
    String placeId,
    DateTime date,
  ) {
    return _reservationService.getAvailableSlots(placeId, date);
  }

  @override
  Future<bool> isSlotAvailable(
    String placeId,
    DateTime startTime,
    DateTime endTime,
    int partySize,
  ) {
    return _reservationService.isSlotAvailable(
      placeId,
      startTime,
      endTime,
      partySize,
    );
  }

  @override
  Future<List<ReservationTimeSlot>> getNextAvailableSlots(
    String placeId, {
    int days = 7,
  }) {
    return _reservationService.getNextAvailableSlots(placeId, days: days);
  }

  @override
  Future<List<ReservationTimeSlot>> generateDaySlots(
    String placeId,
    DateTime date,
  ) {
    return _reservationService.generateDaySlots(placeId, date);
  }

  // ================== GESTIÓN DE DISPONIBILIDAD ==================

  @override
  Future<BusinessAvailability?> getBusinessAvailability(String placeId) {
    return _reservationService.getBusinessAvailability(placeId);
  }

  @override
  Future<void> setBusinessAvailability(BusinessAvailability availability) {
    return _reservationService.setBusinessAvailability(availability);
  }

  @override
  Future<void> updateWeeklySchedule(
    String placeId,
    List<WeeklySchedule> schedule,
  ) {
    return _reservationService.updateWeeklySchedule(placeId, schedule);
  }

  @override
  Future<void> addSpecialDay(String placeId, SpecialDay specialDay) {
    return _reservationService.addSpecialDay(placeId, specialDay);
  }

  @override
  Future<void> addBlackoutDate(String placeId, BlackoutDate blackoutDate) {
    return _reservationService.addBlackoutDate(placeId, blackoutDate);
  }

  @override
  Future<void> removeBlackoutDate(String placeId, String blackoutId) {
    return _reservationService.removeBlackoutDate(placeId, blackoutId);
  }

  // ================== CONFIGURACIONES ==================

  @override
  Future<ReservationSettings?> getReservationSettings(String placeId) {
    return _reservationService.getReservationSettings(placeId);
  }

  @override
  Future<void> updateReservationSettings(ReservationSettings settings) {
    return _reservationService.updateReservationSettings(settings);
  }

  @override
  Future<ReservationSettings> createDefaultSettings(
    String placeId, {
    String? createdBy,
  }) {
    return _reservationService.createDefaultSettings(
      placeId,
      createdBy: createdBy,
    );
  }

  // ================== ANALYTICS Y ESTADÍSTICAS ==================

  @override
  Future<ReservationStats> getReservationStats(
    String placeId, {
    DateTime? startDate,
    DateTime? endDate,
  }) {
    return _reservationService.getReservationStats(
      placeId,
      startDate: startDate,
      endDate: endDate,
    );
  }

  @override
  Future<double> getOccupancyRate(String placeId, DateTime date) {
    return _reservationService.getOccupancyRate(placeId, date);
  }

  @override
  Future<List<PopularTimeSlot>> getPopularTimeSlots(
    String placeId, {
    int days = 30,
  }) {
    return _reservationService.getPopularTimeSlots(placeId, days: days);
  }

  @override
  Future<List<ReservationTrend>> getReservationTrends(
    String placeId, {
    int days = 30,
  }) {
    return _reservationService.getReservationTrends(placeId, days: days);
  }

  // ================== NOTIFICACIONES ==================

  @override
  Future<void> sendConfirmationEmail(String reservationId) {
    return _reservationService.sendConfirmationEmail(reservationId);
  }

  @override
  Future<void> sendReminderEmail(String reservationId) {
    return _reservationService.sendReminderEmail(reservationId);
  }

  @override
  Future<void> scheduleReminder(String reservationId) {
    return _reservationService.scheduleReminder(reservationId);
  }

  // ================== VALIDACIONES ==================

  @override
  Future<ReservationValidationResult> validateReservation(
    Reservation reservation,
  ) {
    return _reservationService.validateReservation(reservation);
  }

  @override
  Future<List<Reservation>> checkTimeConflicts(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) {
    return _reservationService.checkTimeConflicts(placeId, startTime, endTime);
  }

  @override
  Future<int> getAvailableCapacity(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) {
    return _reservationService.getAvailableCapacity(
      placeId,
      startTime,
      endTime,
    );
  }

  // ================== UTILS ==================

  @override
  Future<void> cleanupOldReservations({int olderThanDays = 90}) {
    return _reservationService.cleanupOldReservations(
      olderThanDays: olderThanDays,
    );
  }

  @override
  Future<String> exportReservationsToCSV(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) {
    return _reservationService.exportReservationsToCSV(
      placeId,
      startDate,
      endDate,
    );
  }

  @override
  Future<void> importReservationsFromCSV(String placeId, String csvData) {
    return _reservationService.importReservationsFromCSV(placeId, csvData);
  }

  // ================== MÉTODOS AUXILIARES ESPECÍFICOS DE REPOSITORIO ==================

  /// Crear reserva rápida desde la app (usuario final)
  Future<Reservation> quickCreateReservation({
    required String placeId,
    required String userId,
    required DateTime dateTime,
    required int partySize,
    required String customerName,
    required String customerEmail,
    String? customerPhone,
    String? specialRequests,
  }) async {
    try {
      // Verificar disponibilidad automáticamente
      final isAvailable = await isSlotAvailable(
        placeId,
        dateTime,
        dateTime.add(const Duration(hours: 2)), // Duración por defecto
        partySize,
      );

      if (!isAvailable) {
        throw Exception('El horario seleccionado no está disponible');
      }

      // Crear reserva
      final reservation = Reservation.create(
        placeId: placeId,
        userId: userId,
        reservationDate: dateTime,
        startTime: dateTime,
        endTime: dateTime.add(const Duration(hours: 2)),
        partySize: partySize,
        customerName: customerName,
        customerEmail: customerEmail,
        customerPhone: customerPhone,
        specialRequests: specialRequests,
      );

      return await createReservation(reservation);
    } catch (e) {
      throw Exception('Error creando reserva rápida: $e');
    }
  }

  /// Configurar disponibilidad básica para un nuevo negocio
  Future<void> setupBasicAvailability({
    required String placeId,
    required String createdBy,
    String openTime = "09:00",
    String closeTime = "21:00",
    List<int> closedDays = const [7], // Domingo cerrado por defecto
    int maxCapacityPerSlot = 4,
  }) async {
    try {
      // Crear horario semanal básico
      final weeklySchedule = <WeeklySchedule>[];

      for (int day = 1; day <= 7; day++) {
        final isOpen = !closedDays.contains(day);

        weeklySchedule.add(
          WeeklySchedule(
            dayOfWeek: day,
            isOpen: isOpen,
            timeRanges: isOpen
                ? [
                    TimeRange(
                      startTime: openTime,
                      endTime: closeTime,
                      maxCapacity: maxCapacityPerSlot,
                    ),
                  ]
                : [],
          ),
        );
      }

      // Crear disponibilidad
      final availability = BusinessAvailability(
        id: '${placeId}_availability',
        placeId: placeId,
        weeklySchedule: weeklySchedule,
        createdAt: DateTime.now(),
        createdBy: createdBy,
      );

      await setBusinessAvailability(availability);

      // Crear configuraciones por defecto
      await createDefaultSettings(placeId, createdBy: createdBy);
    } catch (e) {
      throw Exception('Error configurando disponibilidad básica: $e');
    }
  }

  /// Obtener dashboard de reservas para admin
  Future<AdminReservationDashboard> getAdminDashboard(String placeId) async {
    try {
      final today = DateTime.now();

      // Obtener datos en paralelo
      final [
        todayReservations,
        upcomingReservations,
        recentReservations,
        settings,
      ] = await Future.wait([
        getTodayReservations(placeId),
        getReservationsBetweenDates(
          placeId,
          today,
          today.add(const Duration(days: 7)),
        ),
        getReservationsBetweenDates(
          placeId,
          today.subtract(const Duration(days: 7)),
          today,
        ),
        getReservationSettings(placeId),
      ]);

      return AdminReservationDashboard(
        placeId: placeId,
        todayReservations: todayReservations as List<Reservation>,
        upcomingReservations: upcomingReservations as List<Reservation>,
        recentReservations: recentReservations as List<Reservation>,
        settings: settings as ReservationSettings?,
        lastUpdated: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Error obteniendo dashboard: $e');
    }
  }

  @override
  void dispose() {
    // No hay implementación de dispose en la interfaz,
    // ya que el servicio de reservas podría ser un singleton o no tener estado.
    // Si el servicio de reservas tiene un método dispose, aquí se llamaría.
  }
}

/// Dashboard de reservas para administradores
class AdminReservationDashboard {
  const AdminReservationDashboard({
    required this.placeId,
    required this.todayReservations,
    required this.upcomingReservations,
    required this.recentReservations,
    required this.settings,
    required this.lastUpdated,
  });

  final String placeId;
  final List<Reservation> todayReservations;
  final List<Reservation> upcomingReservations;
  final List<Reservation> recentReservations;
  final ReservationSettings? settings;
  final DateTime lastUpdated;

  /// Reservas pendientes de confirmación
  List<Reservation> get pendingReservations {
    return todayReservations
        .where((r) => r.status == ReservationStatus.pending)
        .toList();
  }

  /// Reservas confirmadas para hoy
  List<Reservation> get confirmedTodayReservations {
    return todayReservations
        .where((r) => r.status == ReservationStatus.confirmed)
        .toList();
  }

  /// Total de clientes esperados hoy
  int get totalGuestsToday {
    return confirmedTodayReservations.fold(
      0,
      (sum, reservation) => sum + reservation.partySize,
    );
  }

  /// Próxima reserva
  Reservation? get nextReservation {
    final now = DateTime.now();
    final upcoming = todayReservations
        .where((r) => r.startTime.isAfter(now) && r.status.isActive)
        .toList();

    if (upcoming.isEmpty) return null;

    upcoming.sort((a, b) => a.startTime.compareTo(b.startTime));
    return upcoming.first;
  }

  /// ¿Acepta reservas actualmente?
  bool get acceptsReservations {
    return settings?.acceptsReservations ?? false;
  }
}
