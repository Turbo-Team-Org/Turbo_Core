import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/interface/reservation_interface.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_time_slot.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/business_availability.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_settings.dart';

/// Servicio de reservas para Supabase
class ReservationServiceSupabase implements ReservationInterface {
  ReservationServiceSupabase({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabase;
  static const _uuid = Uuid();

  // ==================== GESTIÓN DE RESERVAS ====================

  @override
  Future<Reservation> createReservation(Reservation reservation) async {
    try {
      final reservationData = _reservationToSupabase(reservation);
      await _supabase.from('reservations').insert(reservationData);
      return reservation;
    } catch (e) {
      throw Exception('Error creating reservation: $e');
    }
  }

  @override
  Future<Reservation?> getReservation(String reservationId) async {
    try {
      final response = await _supabase
          .from('reservations')
          .select('*')
          .eq('id', reservationId)
          .maybeSingle();

      if (response == null) return null;
      return _reservationFromSupabase(response);
    } catch (e) {
      throw Exception('Error getting reservation: $e');
    }
  }

  @override
  Future<void> updateReservation(Reservation reservation) async {
    try {
      await _supabase
          .from('reservations')
          .update(_reservationToSupabase(reservation))
          .eq('id', reservation.id);
    } catch (e) {
      throw Exception('Error updating reservation: $e');
    }
  }

  @override
  Future<void> cancelReservation(String reservationId, {String? reason}) async {
    try {
      await _supabase.from('reservations').update({
        'status': ReservationStatus.cancelled.value,
        'cancelReason': reason,
        'cancelledAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      }).eq('id', reservationId);
    } catch (e) {
      throw Exception('Error cancelling reservation: $e');
    }
  }

  @override
  Future<void> confirmReservation(
    String reservationId, {
    String? tableNumber,
    String? notes,
  }) async {
    try {
      await _supabase.from('reservations').update({
        'status': ReservationStatus.confirmed.value,
        'tableNumber': tableNumber,
        'notes': notes,
        'confirmedAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      }).eq('id', reservationId);
    } catch (e) {
      throw Exception('Error confirming reservation: $e');
    }
  }

  @override
  Future<void> rejectReservation(String reservationId, {String? reason}) async {
    try {
      await _supabase.from('reservations').update({
        'status': ReservationStatus.rejected.value,
        'cancelReason': reason,
        'cancelledAt': DateTime.now().toIso8601String(),
        'updatedAt': DateTime.now().toIso8601String(),
      }).eq('id', reservationId);
    } catch (e) {
      throw Exception('Error rejecting reservation: $e');
    }
  }

  @override
  Future<void> checkInReservation(String reservationId, {String? notes}) async {
    try {
      await _supabase.from('reservations').update({
        'status': ReservationStatus.checkedIn.value,
        'checkedInAt': DateTime.now().toIso8601String(),
        'adminNotes': notes,
        'updatedAt': DateTime.now().toIso8601String(),
      }).eq('id', reservationId);
    } catch (e) {
      throw Exception('Error checking in reservation: $e');
    }
  }

  @override
  Future<void> completeReservation(String reservationId,
      {String? notes}) async {
    try {
      await _supabase.from('reservations').update({
        'status': ReservationStatus.completed.value,
        'adminNotes': notes,
        'updatedAt': DateTime.now().toIso8601String(),
      }).eq('id', reservationId);
    } catch (e) {
      throw Exception('Error completing reservation: $e');
    }
  }

  @override
  Future<void> markNoShow(String reservationId, {String? notes}) async {
    try {
      await _supabase.from('reservations').update({
        'status': ReservationStatus.noShow.value,
        'adminNotes': notes,
        'updatedAt': DateTime.now().toIso8601String(),
      }).eq('id', reservationId);
    } catch (e) {
      throw Exception('Error marking no-show: $e');
    }
  }

  // ==================== CONSULTAS DE RESERVAS ====================

  @override
  Future<List<Reservation>> getUserReservations(
    String userId, {
    ReservationStatus? status,
  }) async {
    try {
      var query =
          _supabase.from('reservations').select('*').eq('userId', userId);

      if (status != null) {
        query = query.eq('status', status.value);
      }

      final response = await query.order('reservationDate', ascending: false);
      return response.map((data) => _reservationFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting user reservations: $e');
    }
  }

  @override
  Future<List<Reservation>> getPlaceReservations(
    String placeId, {
    ReservationStatus? status,
  }) async {
    try {
      var query =
          _supabase.from('reservations').select('*').eq('placeId', placeId);

      if (status != null) {
        query = query.eq('status', status.value);
      }

      final response = await query.order('reservationDate', ascending: false);
      return response.map((data) => _reservationFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting place reservations: $e');
    }
  }

  @override
  Future<List<Reservation>> getReservationsByDate(
    String placeId,
    DateTime date,
  ) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = DateTime(date.year, date.month, date.day, 23, 59, 59);

      final response = await _supabase
          .from('reservations')
          .select('*')
          .eq('placeId', placeId)
          .gte('reservationDate', startOfDay.toIso8601String())
          .lte('reservationDate', endOfDay.toIso8601String())
          .order('startTime');

      return response.map((data) => _reservationFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting reservations by date: $e');
    }
  }

  @override
  Future<List<Reservation>> getReservationsBetweenDates(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final response = await _supabase
          .from('reservations')
          .select('*')
          .eq('placeId', placeId)
          .gte('reservationDate', startDate.toIso8601String())
          .lte('reservationDate', endDate.toIso8601String())
          .order('reservationDate');

      return response.map((data) => _reservationFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting reservations between dates: $e');
    }
  }

  @override
  Future<List<Reservation>> getTodayReservations(String placeId) async {
    final today = DateTime.now();
    return getReservationsByDate(placeId, today);
  }

  @override
  Future<List<Reservation>> getUserUpcomingReservations(String userId) async {
    try {
      final now = DateTime.now();
      final response = await _supabase
          .from('reservations')
          .select('*')
          .eq('userId', userId)
          .gte('reservationDate', now.toIso8601String())
          .order('reservationDate');

      return response.map((data) => _reservationFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting user upcoming reservations: $e');
    }
  }

  @override
  Stream<List<Reservation>> watchPlaceReservations(String placeId) {
    return _supabase
        .from('reservations')
        .stream(primaryKey: ['id'])
        .eq('placeId', placeId)
        .order('reservationDate')
        .map((response) =>
            response.map((data) => _reservationFromSupabase(data)).toList());
  }

  // ==================== DISPONIBILIDAD Y SLOTS ====================

  @override
  Future<List<ReservationTimeSlot>> getAvailableSlots(
    String placeId,
    DateTime date,
  ) async {
    try {
      // Implementación simplificada
      final slots = <ReservationTimeSlot>[];
      for (int hour = 9; hour < 18; hour++) {
        slots.add(ReservationTimeSlot(
          id: _uuid.v4(),
          startTime: DateTime(date.year, date.month, date.day, hour),
          endTime: DateTime(date.year, date.month, date.day, hour + 1),
          currentReservations: 0,
          maxCapacity: 10,
          isAvailable: true,
        ));
      }
      return slots;
    } catch (e) {
      throw Exception('Error getting available slots: $e');
    }
  }

  @override
  Future<bool> isSlotAvailable(
    String placeId,
    DateTime startTime,
    DateTime endTime,
    int partySize,
  ) async {
    try {
      // Verificar si hay capacidad disponible
      final existingReservations = await _supabase
          .from('reservations')
          .select('partySize')
          .eq('placeId', placeId)
          .gte('startTime', startTime.toIso8601String())
          .lt('endTime', endTime.toIso8601String())
          .not('status', 'in', ['cancelled', 'rejected', 'noShow']);

      final totalExistingSize = existingReservations.fold<int>(
          0, (sum, reservation) => sum + (reservation['partySize'] as int));

      // Asumir capacidad máxima de 50 personas
      return (totalExistingSize + partySize) <= 50;
    } catch (e) {
      throw Exception('Error checking slot availability: $e');
    }
  }

  @override
  Future<List<ReservationTimeSlot>> getNextAvailableSlots(
    String placeId, {
    int days = 7,
  }) async {
    try {
      final slots = <ReservationTimeSlot>[];
      final now = DateTime.now();

      for (int day = 0; day < days; day++) {
        final date = now.add(Duration(days: day));
        final daySlots = await getAvailableSlots(placeId, date);
        slots.addAll(daySlots);
      }

      return slots;
    } catch (e) {
      throw Exception('Error getting next available slots: $e');
    }
  }

  @override
  Future<List<ReservationTimeSlot>> generateDaySlots(
    String placeId,
    DateTime date,
  ) async {
    return getAvailableSlots(placeId, date);
  }

  // ==================== GESTIÓN DE DISPONIBILIDAD ====================

  @override
  Future<BusinessAvailability?> getBusinessAvailability(String placeId) async {
    try {
      final response = await _supabase
          .from('business_availability')
          .select('*')
          .eq('placeId', placeId)
          .maybeSingle();

      if (response == null) return null;
      return _businessAvailabilityFromSupabase(response);
    } catch (e) {
      throw Exception('Error getting business availability: $e');
    }
  }

  @override
  Future<void> setBusinessAvailability(
      BusinessAvailability availability) async {
    try {
      await _supabase
          .from('business_availability')
          .upsert(_businessAvailabilityToSupabase(availability));
    } catch (e) {
      throw Exception('Error setting business availability: $e');
    }
  }

  @override
  Future<void> updateWeeklySchedule(
    String placeId,
    List<WeeklySchedule> schedule,
  ) async {
    try {
      final availability = await getBusinessAvailability(placeId);
      if (availability != null) {
        final updatedAvailability =
            availability.copyWith(weeklySchedule: schedule);
        await setBusinessAvailability(updatedAvailability);
      }
    } catch (e) {
      throw Exception('Error updating weekly schedule: $e');
    }
  }

  @override
  Future<void> addSpecialDay(String placeId, SpecialDay specialDay) async {
    try {
      // TODO: Implementar correctamente según la estructura de SpecialDay
      await _supabase.from('special_days').insert({
        'placeId': placeId,
        'date': DateTime.now().toIso8601String(),
        'isOpen': true,
        'notes': 'Special day',
      });
    } catch (e) {
      throw Exception('Error adding special day: $e');
    }
  }

  @override
  Future<void> addBlackoutDate(
      String placeId, BlackoutDate blackoutDate) async {
    try {
      // TODO: Implementar correctamente según la estructura de BlackoutDate
      await _supabase.from('blackout_dates').insert({
        'placeId': placeId,
        'date': DateTime.now().toIso8601String(),
        'reason': 'Blackout date',
      });
    } catch (e) {
      throw Exception('Error adding blackout date: $e');
    }
  }

  @override
  Future<void> removeBlackoutDate(String placeId, String blackoutId) async {
    try {
      await _supabase
          .from('blackout_dates')
          .delete()
          .eq('id', blackoutId)
          .eq('placeId', placeId);
    } catch (e) {
      throw Exception('Error removing blackout date: $e');
    }
  }

  // ==================== CONFIGURACIONES ====================

  @override
  Future<ReservationSettings?> getReservationSettings(String placeId) async {
    try {
      final response = await _supabase
          .from('reservation_settings')
          .select('*')
          .eq('placeId', placeId)
          .maybeSingle();

      if (response == null) return null;
      return _reservationSettingsFromSupabase(response);
    } catch (e) {
      throw Exception('Error getting reservation settings: $e');
    }
  }

  @override
  Future<void> updateReservationSettings(ReservationSettings settings) async {
    try {
      await _supabase
          .from('reservation_settings')
          .upsert(_reservationSettingsToSupabase(settings));
    } catch (e) {
      throw Exception('Error updating reservation settings: $e');
    }
  }

  @override
  Future<ReservationSettings> createDefaultSettings(
    String placeId, {
    String? createdBy,
  }) async {
    try {
      final settings = ReservationSettings(
        id: _uuid.v4(),
        placeId: placeId,
        acceptsReservations: true,
        maxAdvanceBookingDays: 30,
        minAdvanceBookingHours: 2,
        maxPartySize: 20,
        defaultSlotDuration: 60,
        requiresConfirmation: true,
        allowCancellation: true,
        allowModification: true,
        sendConfirmationEmail: true,
        sendReminderEmail: true,
        createdBy: createdBy,
        createdAt: DateTime.now(),
        updatedAt: DateTime.now(),
      );

      await updateReservationSettings(settings);
      return settings;
    } catch (e) {
      throw Exception('Error creating default settings: $e');
    }
  }

  // ==================== ANALYTICS Y ESTADÍSTICAS ====================

  @override
  Future<ReservationStats> getReservationStats(
    String placeId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final now = DateTime.now();
      final filterStartDate = startDate ?? DateTime(now.year, now.month, 1);
      final filterEndDate = endDate ?? now;

      final reservations = await getReservationsBetweenDates(
          placeId, filterStartDate, filterEndDate);

      final totalReservations = reservations.length;
      final confirmedReservations = reservations
          .where((r) => r.status == ReservationStatus.confirmed)
          .length;
      final cancelledReservations = reservations
          .where((r) => r.status == ReservationStatus.cancelled)
          .length;
      final noShowReservations = reservations
          .where((r) => r.status == ReservationStatus.noShow)
          .length;

      final averagePartySize = reservations.isNotEmpty
          ? reservations.fold(0.0, (sum, r) => sum + r.partySize) /
              reservations.length
          : 0.0;

      final occupancyRate = _calculateOccupancyRate(reservations);
      final totalRevenue = _calculateTotalRevenue(reservations);
      final popularTimes = _getPopularTimeSlots(reservations);

      return ReservationStats(
        totalReservations: totalReservations,
        confirmedReservations: confirmedReservations,
        cancelledReservations: cancelledReservations,
        noShowReservations: noShowReservations,
        averagePartySize: averagePartySize,
        occupancyRate: occupancyRate,
        totalRevenue: totalRevenue,
        popularTimes: popularTimes,
      );
    } catch (e) {
      throw Exception('Error getting reservation stats: $e');
    }
  }

  @override
  Future<double> getOccupancyRate(String placeId, DateTime date) async {
    try {
      final reservations = await getReservationsByDate(placeId, date);
      return _calculateOccupancyRate(reservations);
    } catch (e) {
      throw Exception('Error getting occupancy rate: $e');
    }
  }

  @override
  Future<List<PopularTimeSlot>> getPopularTimeSlots(
    String placeId, {
    int days = 30,
  }) async {
    try {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(Duration(days: days));
      final reservations =
          await getReservationsBetweenDates(placeId, startDate, endDate);
      return _getPopularTimeSlots(reservations);
    } catch (e) {
      throw Exception('Error getting popular time slots: $e');
    }
  }

  @override
  Future<List<ReservationTrend>> getReservationTrends(
    String placeId, {
    int days = 30,
  }) async {
    try {
      final endDate = DateTime.now();
      final startDate = endDate.subtract(Duration(days: days));
      final reservations =
          await getReservationsBetweenDates(placeId, startDate, endDate);

      final trends = <ReservationTrend>[];
      final groupedByDate = <String, List<Reservation>>{};

      for (final reservation in reservations) {
        final dateKey =
            '${reservation.reservationDate.year}-${reservation.reservationDate.month.toString().padLeft(2, '0')}-${reservation.reservationDate.day.toString().padLeft(2, '0')}';
        groupedByDate.putIfAbsent(dateKey, () => []).add(reservation);
      }

      for (final entry in groupedByDate.entries) {
        final date = DateTime.parse(entry.key);
        final dayReservations = entry.value;
        final reservationCount = dayReservations.length;
        final occupancyRate = _calculateOccupancyRate(dayReservations);
        final revenue = _calculateTotalRevenue(dayReservations);

        trends.add(ReservationTrend(
          date: date,
          reservationCount: reservationCount,
          occupancyRate: occupancyRate,
          revenue: revenue,
        ));
      }

      return trends;
    } catch (e) {
      throw Exception('Error getting reservation trends: $e');
    }
  }

  // ==================== NOTIFICACIONES ====================

  @override
  Future<void> sendConfirmationEmail(String reservationId) async {
    // TODO: Implementar envío de email
    print('Sending confirmation email for reservation: $reservationId');
  }

  @override
  Future<void> sendReminderEmail(String reservationId) async {
    // TODO: Implementar envío de email
    print('Sending reminder email for reservation: $reservationId');
  }

  @override
  Future<void> scheduleReminder(String reservationId) async {
    // TODO: Implementar programación de recordatorio
    print('Scheduling reminder for reservation: $reservationId');
  }

  // ==================== VALIDACIONES ====================

  @override
  Future<ReservationValidationResult> validateReservation(
    Reservation reservation,
  ) async {
    try {
      final errors = <String>[];
      final warnings = <String>[];

      // Validaciones básicas
      if (reservation.partySize <= 0) {
        errors.add('Party size must be greater than 0');
      }

      if (reservation.partySize > 20) {
        warnings.add('Large party size may require special arrangements');
      }

      if (reservation.startTime.isBefore(DateTime.now())) {
        errors.add('Reservation cannot be in the past');
      }

      if (reservation.startTime.isAfter(reservation.endTime)) {
        errors.add('Start time must be before end time');
      }

      // Verificar disponibilidad
      final isAvailable = await isSlotAvailable(
        reservation.placeId,
        reservation.startTime,
        reservation.endTime,
        reservation.partySize,
      );

      if (!isAvailable) {
        errors.add('Selected time slot is not available');
      }

      return ReservationValidationResult(
        isValid: errors.isEmpty,
        errors: errors,
        warnings: warnings,
      );
    } catch (e) {
      return ReservationValidationResult(
        isValid: false,
        errors: ['Validation error: $e'],
      );
    }
  }

  @override
  Future<List<Reservation>> checkTimeConflicts(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    try {
      final response = await _supabase
          .from('reservations')
          .select('*')
          .eq('placeId', placeId)
          .gte('startTime', startTime.toIso8601String())
          .lt('endTime', endTime.toIso8601String())
          .not('status', 'in', ['cancelled', 'rejected', 'noShow']);

      return response.map((data) => _reservationFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error checking time conflicts: $e');
    }
  }

  @override
  Future<int> getAvailableCapacity(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    try {
      final existingReservations =
          await checkTimeConflicts(placeId, startTime, endTime);
      final totalExistingSize = existingReservations.fold<int>(
          0, (sum, reservation) => sum + reservation.partySize);

      // Asumir capacidad máxima de 50 personas
      return 50 - totalExistingSize;
    } catch (e) {
      throw Exception('Error getting available capacity: $e');
    }
  }

  // ==================== UTILS ====================

  @override
  Future<void> cleanupOldReservations({int olderThanDays = 90}) async {
    try {
      final cutoffDate = DateTime.now().subtract(Duration(days: olderThanDays));
      await _supabase
          .from('reservations')
          .delete()
          .lt('reservationDate', cutoffDate.toIso8601String())
          .inFilter('status', ['cancelled', 'rejected', 'noShow']);
    } catch (e) {
      throw Exception('Error cleaning up old reservations: $e');
    }
  }

  @override
  Future<String> exportReservationsToCSV(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final reservations =
          await getReservationsBetweenDates(placeId, startDate, endDate);

      final csvData = StringBuffer();
      csvData.writeln(
          'ID,Place ID,User ID,Date,Start Time,End Time,Party Size,Status,Customer Name,Customer Email');

      for (final reservation in reservations) {
        csvData.writeln([
          reservation.id,
          reservation.placeId,
          reservation.userId,
          reservation.reservationDate.toIso8601String(),
          reservation.startTime.toIso8601String(),
          reservation.endTime.toIso8601String(),
          reservation.partySize,
          reservation.status.value,
          reservation.customerName,
          reservation.customerEmail,
        ].join(','));
      }

      return csvData.toString();
    } catch (e) {
      throw Exception('Error exporting reservations to CSV: $e');
    }
  }

  @override
  Future<void> importReservationsFromCSV(String placeId, String csvData) async {
    try {
      final lines = csvData.split('\n');
      if (lines.length < 2) return; // Skip header

      for (int i = 1; i < lines.length; i++) {
        final line = lines[i].trim();
        if (line.isEmpty) continue;

        final values = line.split(',');
        if (values.length < 10) continue;

        final reservation = Reservation(
          id: _uuid.v4(),
          placeId: placeId,
          userId: values[2],
          reservationDate: DateTime.parse(values[3]),
          startTime: DateTime.parse(values[4]),
          endTime: DateTime.parse(values[5]),
          partySize: int.parse(values[6]),
          status: ReservationStatus.fromString(values[7]),
          customerName: values[8],
          customerEmail: values[9],
        );

        await createReservation(reservation);
      }
    } catch (e) {
      throw Exception('Error importing reservations from CSV: $e');
    }
  }

  @override
  void dispose() {
    // No hay recursos específicos que liberar en Supabase
  }

  // ==================== MÉTODOS AUXILIARES ====================

  Reservation _reservationFromSupabase(Map<String, dynamic> data) {
    return Reservation(
      id: data['id'] as String,
      placeId: data['placeId'] as String,
      userId: data['userId'] as String,
      reservationDate: DateTime.parse(data['reservationDate'] as String),
      startTime: DateTime.parse(data['startTime'] as String),
      endTime: DateTime.parse(data['endTime'] as String),
      partySize: data['partySize'] as int,
      status: ReservationStatus.fromString(data['status'] as String),
      customerName: data['customerName'] as String? ?? '',
      customerEmail: data['customerEmail'] as String? ?? '',
      customerPhone: data['customerPhone'] as String? ?? '',
      placeName: data['placeName'] as String?,
      specialRequests: data['specialRequests'] as String?,
      notes: data['notes'] as String?,
      tableNumber: data['tableNumber'] as String?,
      confirmationCode: data['confirmationCode'] as String?,
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'] as String)
          : null,
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'] as String)
          : null,
      confirmedAt: data['confirmedAt'] != null
          ? DateTime.parse(data['confirmedAt'] as String)
          : null,
      checkedInAt: data['checkedInAt'] != null
          ? DateTime.parse(data['checkedInAt'] as String)
          : null,
      cancelledAt: data['cancelledAt'] != null
          ? DateTime.parse(data['cancelledAt'] as String)
          : null,
      cancelReason: data['cancelReason'] as String?,
      adminNotes: data['adminNotes'] as String?,
      reminderSent: data['reminderSent'] as bool?,
      customerInfo: data['customerInfo'] as Map<String, dynamic>? ?? {},
      metadata: data['metadata'] as Map<String, dynamic>? ?? {},
    );
  }

  Map<String, dynamic> _reservationToSupabase(Reservation reservation) {
    return {
      'id': reservation.id,
      'placeId': reservation.placeId,
      'userId': reservation.userId,
      'reservationDate': reservation.reservationDate.toIso8601String(),
      'startTime': reservation.startTime.toIso8601String(),
      'endTime': reservation.endTime.toIso8601String(),
      'partySize': reservation.partySize,
      'status': reservation.status.value,
      'customerName': reservation.customerName,
      'customerEmail': reservation.customerEmail,
      'customerPhone': reservation.customerPhone,
      'placeName': reservation.placeName,
      'specialRequests': reservation.specialRequests,
      'notes': reservation.notes,
      'tableNumber': reservation.tableNumber,
      'confirmationCode': reservation.confirmationCode,
      'createdAt': reservation.createdAt?.toIso8601String(),
      'updatedAt': reservation.updatedAt?.toIso8601String(),
      'confirmedAt': reservation.confirmedAt?.toIso8601String(),
      'checkedInAt': reservation.checkedInAt?.toIso8601String(),
      'cancelledAt': reservation.cancelledAt?.toIso8601String(),
      'cancelReason': reservation.cancelReason,
      'adminNotes': reservation.adminNotes,
      'reminderSent': reservation.reminderSent,
      'customerInfo': reservation.customerInfo,
      'metadata': reservation.metadata,
    };
  }

  BusinessAvailability _businessAvailabilityFromSupabase(
      Map<String, dynamic> data) {
    return BusinessAvailability(
      id: data['id'] as String,
      placeId: data['placeId'] as String,
      weeklySchedule:
          _parseWeeklySchedule(data['weeklySchedule'] as List<dynamic>? ?? []),
      acceptsReservations: data['acceptsReservations'] as bool? ?? true,
      defaultSlotDuration: data['defaultSlotDuration'] as int? ?? 60,
      maxPartySizeDefault: data['maxPartySizeDefault'] as int? ?? 4,
      maxAdvanceBookingDays: data['maxAdvanceBookingDays'] as int? ?? 7,
      minAdvanceBookingHours: data['minAdvanceBookingHours'] as int? ?? 2,
    );
  }

  Map<String, dynamic> _businessAvailabilityToSupabase(
      BusinessAvailability availability) {
    return {
      'id': availability.id,
      'placeId': availability.placeId,
      'weeklySchedule':
          availability.weeklySchedule.map((s) => s.toMap()).toList(),
      'acceptsReservations': availability.acceptsReservations,
      'defaultSlotDuration': availability.defaultSlotDuration,
      'maxPartySizeDefault': availability.maxPartySizeDefault,
      'maxAdvanceBookingDays': availability.maxAdvanceBookingDays,
      'minAdvanceBookingHours': availability.minAdvanceBookingHours,
    };
  }

  ReservationSettings _reservationSettingsFromSupabase(
      Map<String, dynamic> data) {
    return ReservationSettings(
      id: data['id'] as String,
      placeId: data['placeId'] as String,
      acceptsReservations: data['acceptsReservations'] as bool? ?? true,
      maxAdvanceBookingDays: data['maxAdvanceBookingDays'] as int? ?? 30,
      minAdvanceBookingHours: data['minAdvanceBookingHours'] as int? ?? 2,
      maxPartySize: data['maxPartySize'] as int? ?? 20,
      defaultSlotDuration: data['defaultSlotDuration'] as int? ?? 60,
      requiresConfirmation: data['requiresConfirmation'] as bool? ?? true,
      allowCancellation: data['allowCancellation'] as bool? ?? true,
      allowModification: data['allowModification'] as bool? ?? true,
      sendConfirmationEmail: data['sendConfirmationEmail'] as bool? ?? true,
      sendReminderEmail: data['sendReminderEmail'] as bool? ?? true,
      createdBy: data['createdBy'] as String?,
      createdAt: data['createdAt'] != null
          ? DateTime.parse(data['createdAt'] as String)
          : null,
      updatedAt: data['updatedAt'] != null
          ? DateTime.parse(data['updatedAt'] as String)
          : null,
    );
  }

  Map<String, dynamic> _reservationSettingsToSupabase(
      ReservationSettings settings) {
    return {
      'id': settings.id,
      'placeId': settings.placeId,
      'acceptsReservations': settings.acceptsReservations,
      'maxAdvanceBookingDays': settings.maxAdvanceBookingDays,
      'minAdvanceBookingHours': settings.minAdvanceBookingHours,
      'maxPartySize': settings.maxPartySize,
      'defaultSlotDuration': settings.defaultSlotDuration,
      'requiresConfirmation': settings.requiresConfirmation,
      'allowCancellation': settings.allowCancellation,
      'allowModification': settings.allowModification,
      'sendConfirmationEmail': settings.sendConfirmationEmail,
      'sendReminderEmail': settings.sendReminderEmail,
      'createdBy': settings.createdBy,
      'createdAt': settings.createdAt?.toIso8601String(),
      'updatedAt': settings.updatedAt?.toIso8601String(),
    };
  }

  List<WeeklySchedule> _parseWeeklySchedule(List<dynamic> data) {
    return data
        .map((item) => WeeklySchedule.fromMap(item as Map<String, dynamic>))
        .toList();
  }

  double _calculateOccupancyRate(List<Reservation> reservations) {
    if (reservations.isEmpty) return 0.0;

    final totalCapacity =
        reservations.length * 10; // Asumir 10 personas por slot
    final totalOccupied = reservations.fold(0, (sum, r) => sum + r.partySize);

    return totalCapacity > 0 ? (totalOccupied / totalCapacity) * 100 : 0.0;
  }

  double _calculateTotalRevenue(List<Reservation> reservations) {
    // Implementación simplificada - asumir $20 por persona
    return reservations.fold(0.0, (sum, r) => sum + (r.partySize * 20));
  }

  List<PopularTimeSlot> _getPopularTimeSlots(List<Reservation> reservations) {
    final timeSlotCounts = <String, int>{};

    for (final reservation in reservations) {
      final timeKey =
          '${reservation.startTime.hour.toString().padLeft(2, '0')}:00';
      timeSlotCounts[timeKey] = (timeSlotCounts[timeKey] ?? 0) + 1;
    }

    return timeSlotCounts.entries
        .map((entry) => PopularTimeSlot(
              timeSlot: entry.key,
              reservationCount: entry.value,
              occupancyRate: (entry.value / reservations.length) * 100,
            ))
        .toList()
      ..sort((a, b) => b.reservationCount.compareTo(a.reservationCount));
  }
}
