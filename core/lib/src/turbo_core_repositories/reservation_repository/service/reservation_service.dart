import 'dart:async';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/interface/reservation_interface.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_time_slot.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/business_availability.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_settings.dart';

/// Servicio de gestión de reservas
class ReservationService implements ReservationInterface {
  ReservationService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance {
    _initialize();
  }

  final FirebaseFirestore _firestore;

  // Firestore collections
  late final CollectionReference _reservationsRef;
  late final CollectionReference _availabilityRef;
  late final CollectionReference _settingsRef;
  late final CollectionReference _timeSlotsRef;

  void _initialize() {
    _reservationsRef = _firestore.collection('reservations');
    _availabilityRef = _firestore.collection('business_availability');
    _settingsRef = _firestore.collection('reservation_settings');
    _timeSlotsRef = _firestore.collection('reservation_time_slots');
  }

  // ================== GESTIÓN DE RESERVAS ==================

  @override
  Future<Reservation> createReservation(Reservation reservation) async {
    try {
      // Validar la reserva antes de crearla
      final validation = await validateReservation(reservation);
      if (!validation.isValid) {
        throw Exception('Reserva inválida: ${validation.errors.join(', ')}');
      }

      // Verificar disponibilidad
      final isAvailable = await isSlotAvailable(
        reservation.placeId,
        reservation.startTime,
        reservation.endTime,
        reservation.partySize,
      );

      if (!isAvailable) {
        throw Exception('El horario seleccionado no está disponible');
      }

      // Crear la reserva en Firestore
      await _reservationsRef.doc(reservation.id).set(reservation.toFirestore());

      // Actualizar el contador de slots si es necesario
      await _updateSlotCapacity(
        reservation.placeId,
        reservation.startTime,
        reservation.endTime,
        1,
      );

      // Programar recordatorio si está habilitado
      final settings = await getReservationSettings(reservation.placeId);
      if (settings?.sendReminderEmail == true) {
        await scheduleReminder(reservation.id);
      }

      return reservation;
    } catch (e) {
      throw Exception('Error creando reserva: $e');
    }
  }

  @override
  Future<Reservation?> getReservation(String reservationId) async {
    try {
      final doc = await _reservationsRef.doc(reservationId).get();

      if (doc.exists && doc.data() != null) {
        return Reservation.fromFirestore(doc.data()! as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      throw Exception('Error obteniendo reserva: $e');
    }
  }

  @override
  Future<void> updateReservation(Reservation reservation) async {
    try {
      await _reservationsRef
          .doc(reservation.id)
          .update(reservation.toFirestore());
    } catch (e) {
      throw Exception('Error actualizando reserva: $e');
    }
  }

  @override
  Future<void> cancelReservation(String reservationId, {String? reason}) async {
    try {
      final reservation = await getReservation(reservationId);
      if (reservation == null) {
        throw Exception('Reserva no encontrada');
      }

      if (!reservation.canBeCancelled) {
        throw Exception('La reserva no se puede cancelar en este momento');
      }

      final cancelledReservation = reservation.cancel(reason: reason);
      await updateReservation(cancelledReservation);

      // Liberar capacidad del slot
      await _updateSlotCapacity(
        reservation.placeId,
        reservation.startTime,
        reservation.endTime,
        -1,
      );
    } catch (e) {
      throw Exception('Error cancelando reserva: $e');
    }
  }

  @override
  Future<void> confirmReservation(
    String reservationId, {
    String? tableNumber,
    String? notes,
  }) async {
    try {
      final reservation = await getReservation(reservationId);
      if (reservation == null) {
        throw Exception('Reserva no encontrada');
      }

      final confirmedReservation = reservation.confirm(
        tableNumber: tableNumber,
        adminNotes: notes,
      );
      await updateReservation(confirmedReservation);

      // Enviar email de confirmación si está habilitado
      final settings = await getReservationSettings(reservation.placeId);
      if (settings?.sendConfirmationEmail == true) {
        await sendConfirmationEmail(reservationId);
      }
    } catch (e) {
      throw Exception('Error confirmando reserva: $e');
    }
  }

  @override
  Future<void> rejectReservation(String reservationId, {String? reason}) async {
    try {
      final reservation = await getReservation(reservationId);
      if (reservation == null) {
        throw Exception('Reserva no encontrada');
      }

      final rejectedReservation = reservation.reject(reason: reason);
      await updateReservation(rejectedReservation);

      // Liberar capacidad del slot
      await _updateSlotCapacity(
        reservation.placeId,
        reservation.startTime,
        reservation.endTime,
        -1,
      );
    } catch (e) {
      throw Exception('Error rechazando reserva: $e');
    }
  }

  @override
  Future<void> checkInReservation(String reservationId, {String? notes}) async {
    try {
      final reservation = await getReservation(reservationId);
      if (reservation == null) {
        throw Exception('Reserva no encontrada');
      }

      final checkedInReservation = reservation.checkIn(adminNotes: notes);
      await updateReservation(checkedInReservation);
    } catch (e) {
      throw Exception('Error en check-in: $e');
    }
  }

  @override
  Future<void> completeReservation(
    String reservationId, {
    String? notes,
  }) async {
    try {
      final reservation = await getReservation(reservationId);
      if (reservation == null) {
        throw Exception('Reserva no encontrada');
      }

      final completedReservation = reservation.complete(adminNotes: notes);
      await updateReservation(completedReservation);
    } catch (e) {
      throw Exception('Error completando reserva: $e');
    }
  }

  @override
  Future<void> markNoShow(String reservationId, {String? notes}) async {
    try {
      final reservation = await getReservation(reservationId);
      if (reservation == null) {
        throw Exception('Reserva no encontrada');
      }

      final noShowReservation = reservation.markNoShow(adminNotes: notes);
      await updateReservation(noShowReservation);
    } catch (e) {
      throw Exception('Error marcando no-show: $e');
    }
  }

  // ================== CONSULTAS DE RESERVAS ==================

  @override
  Future<List<Reservation>> getUserReservations(
    String userId, {
    ReservationStatus? status,
  }) async {
    try {
      Query query = _reservationsRef.where('userId', isEqualTo: userId);

      if (status != null) {
        query = query.where('status', isEqualTo: status.value);
      }

      query = query.orderBy('startTime', descending: true);

      final querySnapshot = await query.get();

      return querySnapshot.docs
          .map(
            (doc) =>
                Reservation.fromFirestore(doc.data()! as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo reservas del usuario: $e');
    }
  }

  @override
  Future<List<Reservation>> getPlaceReservations(
    String placeId, {
    ReservationStatus? status,
  }) async {
    try {
      Query query = _reservationsRef.where('placeId', isEqualTo: placeId);

      if (status != null) {
        query = query.where('status', isEqualTo: status.value);
      }

      query = query.orderBy('startTime', descending: false);

      final querySnapshot = await query.get();

      return querySnapshot.docs
          .map(
            (doc) =>
                Reservation.fromFirestore(doc.data()! as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo reservas del lugar: $e');
    }
  }

  @override
  Future<List<Reservation>> getReservationsByDate(
    String placeId,
    DateTime date,
  ) async {
    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final querySnapshot = await _reservationsRef
          .where('placeId', isEqualTo: placeId)
          .where(
            'reservationDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startOfDay),
          )
          .where(
            'reservationDate',
            isLessThan: Timestamp.fromDate(endOfDay),
          )
          .orderBy('reservationDate')
          .orderBy('startTime')
          .get();

      return querySnapshot.docs
          .map(
            (doc) =>
                Reservation.fromFirestore(doc.data()! as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo reservas por fecha: $e');
    }
  }

  @override
  Future<List<Reservation>> getReservationsBetweenDates(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    try {
      final querySnapshot = await _reservationsRef
          .where('placeId', isEqualTo: placeId)
          .where(
            'reservationDate',
            isGreaterThanOrEqualTo: Timestamp.fromDate(startDate),
          )
          .where(
            'reservationDate',
            isLessThanOrEqualTo: Timestamp.fromDate(endDate),
          )
          .orderBy('reservationDate')
          .orderBy('startTime')
          .get();

      return querySnapshot.docs
          .map(
            (doc) =>
                Reservation.fromFirestore(doc.data()! as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo reservas entre fechas: $e');
    }
  }

  @override
  Future<List<Reservation>> getTodayReservations(String placeId) async {
    return getReservationsByDate(placeId, DateTime.now());
  }

  @override
  Future<List<Reservation>> getUserUpcomingReservations(String userId) async {
    try {
      final now = DateTime.now();

      final querySnapshot = await _reservationsRef
          .where('userId', isEqualTo: userId)
          .where('startTime', isGreaterThan: Timestamp.fromDate(now))
          .where('status', whereIn: ['pending', 'confirmed'])
          .orderBy('startTime')
          .get();

      return querySnapshot.docs
          .map(
            (doc) =>
                Reservation.fromFirestore(doc.data()! as Map<String, dynamic>),
          )
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo reservas futuras: $e');
    }
  }

  @override
  Stream<List<Reservation>> watchPlaceReservations(String placeId) {
    return _reservationsRef
        .where('placeId', isEqualTo: placeId)
        .orderBy('startTime')
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map(
                (doc) => Reservation.fromFirestore(
                  doc.data()! as Map<String, dynamic>,
                ),
              )
              .toList(),
        );
  }

  // ================== DISPONIBILIDAD Y SLOTS ==================

  @override
  Future<List<ReservationTimeSlot>> getAvailableSlots(
    String placeId,
    DateTime date,
  ) async {
    try {
      // Generar slots para el día si no existen
      await generateDaySlots(placeId, date);

      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      // CONSULTA SIMPLIFICADA - Solo por placeId para evitar error de índice
      final querySnapshot =
          await _timeSlotsRef.where('placeId', isEqualTo: placeId).get();

      // Filtrar en memoria por ahora
      final slots = querySnapshot.docs
          .map(
            (doc) => ReservationTimeSlot.fromFirestore(
              doc.data()! as Map<String, dynamic>,
            ),
          )
          .where((slot) =>
              slot.startTime.isAfter(startOfDay) &&
              slot.startTime.isBefore(endOfDay) &&
              slot.isAvailable &&
              slot.hasAvailability)
          .toList();

      // Ordenar en memoria
      slots.sort((a, b) => a.startTime.compareTo(b.startTime));

      return slots;
    } catch (e) {
      throw Exception('Error obteniendo slots disponibles: $e');
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
      // Verificar configuraciones del lugar
      final settings = await getReservationSettings(placeId);
      if (settings?.canMakeReservation(startTime, partySize) != true) {
        return false;
      }

      // Verificar disponibilidad del negocio
      final availability = await getBusinessAvailability(placeId);
      if (availability?.isAvailableOnDate(startTime) != true) {
        return false;
      }

      // Verificar conflictos de horario
      final conflicts = await checkTimeConflicts(placeId, startTime, endTime);
      if (conflicts.isNotEmpty) {
        // Verificar si hay capacidad suficiente
        final availableCapacity = await getAvailableCapacity(
          placeId,
          startTime,
          endTime,
        );
        return availableCapacity >= partySize;
      }

      return true;
    } catch (e) {
      throw Exception('Error verificando disponibilidad: $e');
    }
  }

  @override
  Future<List<ReservationTimeSlot>> getNextAvailableSlots(
    String placeId, {
    int days = 7,
  }) async {
    try {
      final availableSlots = <ReservationTimeSlot>[];
      final now = DateTime.now();

      for (int i = 0; i < days; i++) {
        final date = now.add(Duration(days: i));
        final daySlots = await getAvailableSlots(placeId, date);
        availableSlots.addAll(daySlots);
      }

      return availableSlots;
    } catch (e) {
      throw Exception('Error obteniendo próximos slots: $e');
    }
  }

  @override
  Future<List<ReservationTimeSlot>> generateDaySlots(
    String placeId,
    DateTime date,
  ) async {
    try {
      // Obtener disponibilidad del negocio
      final availability = await getBusinessAvailability(placeId);
      if (availability == null || !availability.isAvailableOnDate(date)) {
        return [];
      }

      // Obtener configuraciones
      final settings = await getReservationSettings(placeId) ??
          await createDefaultSettings(placeId);

      // Obtener horarios disponibles para el día
      final timeRanges = availability.getAvailableHoursForDate(date);
      if (timeRanges.isEmpty) return [];

      final slots = <ReservationTimeSlot>[];

      for (final timeRange in timeRanges) {
        final startParts = timeRange.startTime.split(':');
        final endParts = timeRange.endTime.split(':');

        final startHour = int.parse(startParts[0]);
        final startMinute = int.parse(startParts[1]);
        final endHour = int.parse(endParts[0]);
        final endMinute = int.parse(endParts[1]);

        DateTime currentTime = DateTime(
          date.year,
          date.month,
          date.day,
          startHour,
          startMinute,
        );
        final endTime = DateTime(
          date.year,
          date.month,
          date.day,
          endHour,
          endMinute,
        );

        while (currentTime.isBefore(endTime)) {
          final slotEndTime = currentTime.add(
            Duration(minutes: settings.defaultSlotDuration),
          );

          if (slotEndTime.isAfter(endTime)) break;

          final slot = ReservationTimeSlot(
            id: '${placeId}_${currentTime.millisecondsSinceEpoch}',
            startTime: currentTime,
            endTime: slotEndTime,
            maxCapacity: timeRange.maxCapacity,
            currentReservations: 0,
            durationMinutes: settings.defaultSlotDuration,
          );

          // Verificar si el slot ya existe
          final existingSlot = await _getExistingSlot(placeId, currentTime);
          if (existingSlot == null) {
            await _timeSlotsRef.doc(slot.id).set(slot.toFirestore());
            slots.add(slot);
          } else {
            slots.add(existingSlot);
          }

          currentTime = currentTime.add(
            Duration(minutes: settings.defaultSlotDuration),
          );
        }
      }

      return slots;
    } catch (e) {
      throw Exception('Error generando slots del día: $e');
    }
  }

  // ================== GESTIÓN DE DISPONIBILIDAD ==================

  @override
  Future<BusinessAvailability?> getBusinessAvailability(String placeId) async {
    try {
      final doc =
          await _availabilityRef.where('placeId', isEqualTo: placeId).get();

      if (doc.docs.isNotEmpty) {
        return BusinessAvailability.fromFirestore(
          doc.docs.first.data()! as Map<String, dynamic>,
        );
      }

      return null;
    } catch (e) {
      throw Exception('Error obteniendo disponibilidad: $e');
    }
  }

  @override
  Future<void> setBusinessAvailability(
    BusinessAvailability availability,
  ) async {
    try {
      await _availabilityRef
          .doc(availability.placeId)
          .set(availability.toFirestore());
    } catch (e) {
      throw Exception('Error configurando disponibilidad: $e');
    }
  }

  @override
  Future<void> updateWeeklySchedule(
    String placeId,
    List<WeeklySchedule> schedule,
  ) async {
    try {
      final availability = await getBusinessAvailability(placeId);
      if (availability == null) {
        throw Exception('Disponibilidad no encontrada');
      }

      final updatedAvailability = availability.copyWith(
        weeklySchedule: schedule,
        updatedAt: DateTime.now(),
      );

      await setBusinessAvailability(updatedAvailability);
    } catch (e) {
      throw Exception('Error actualizando horario semanal: $e');
    }
  }

  @override
  Future<void> addSpecialDay(String placeId, SpecialDay specialDay) async {
    try {
      final availability = await getBusinessAvailability(placeId);
      if (availability == null) {
        throw Exception('Disponibilidad no encontrada');
      }

      final updatedSpecialDays = [...availability.specialDays, specialDay];
      final updatedAvailability = availability.copyWith(
        specialDays: updatedSpecialDays,
        updatedAt: DateTime.now(),
      );

      await setBusinessAvailability(updatedAvailability);
    } catch (e) {
      throw Exception('Error agregando día especial: $e');
    }
  }

  @override
  Future<void> addBlackoutDate(
    String placeId,
    BlackoutDate blackoutDate,
  ) async {
    try {
      final availability = await getBusinessAvailability(placeId);
      if (availability == null) {
        throw Exception('Disponibilidad no encontrada');
      }

      final updatedBlackoutDates = [
        ...availability.blackoutDates,
        blackoutDate,
      ];
      final updatedAvailability = availability.copyWith(
        blackoutDates: updatedBlackoutDates,
        updatedAt: DateTime.now(),
      );

      await setBusinessAvailability(updatedAvailability);
    } catch (e) {
      throw Exception('Error agregando fecha bloqueada: $e');
    }
  }

  @override
  Future<void> removeBlackoutDate(String placeId, String blackoutId) async {
    try {
      final availability = await getBusinessAvailability(placeId);
      if (availability == null) {
        throw Exception('Disponibilidad no encontrada');
      }

      final updatedBlackoutDates = availability.blackoutDates
          .where((blackout) => blackout.reason != blackoutId)
          .toList();

      final updatedAvailability = availability.copyWith(
        blackoutDates: updatedBlackoutDates,
        updatedAt: DateTime.now(),
      );

      await setBusinessAvailability(updatedAvailability);
    } catch (e) {
      throw Exception('Error eliminando fecha bloqueada: $e');
    }
  }

  // ================== CONFIGURACIONES ==================

  @override
  Future<ReservationSettings?> getReservationSettings(String placeId) async {
    try {
      final querySnapshot =
          await _settingsRef.where('placeId', isEqualTo: placeId).get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return ReservationSettings.fromFirestore(
          doc.data()! as Map<String, dynamic>,
        );
      }

      return null;
    } catch (e) {
      throw Exception('Error obteniendo configuraciones: $e');
    }
  }

  @override
  Future<void> updateReservationSettings(ReservationSettings settings) async {
    try {
      final updatedSettings = settings.copyWith(updatedAt: DateTime.now());
      await _settingsRef
          .doc(settings.placeId)
          .set(updatedSettings.toFirestore());
    } catch (e) {
      throw Exception('Error actualizando configuraciones: $e');
    }
  }

  @override
  Future<ReservationSettings> createDefaultSettings(
    String placeId, {
    String? createdBy,
  }) async {
    try {
      final settings = ReservationSettings.defaultFor(
        placeId,
        createdBy: createdBy,
      );
      await _settingsRef.doc(placeId).set(settings.toFirestore());
      return settings;
    } catch (e) {
      throw Exception('Error creando configuraciones por defecto: $e');
    }
  }

  // ================== HELPERS PRIVADOS ==================

  Future<void> _updateSlotCapacity(
    String placeId,
    DateTime startTime,
    DateTime endTime,
    int change,
  ) async {
    try {
      // Buscar slot que coincida con el horario
      final querySnapshot = await _timeSlotsRef
          .where('placeId', isEqualTo: placeId)
          .where('startTime', isEqualTo: Timestamp.fromDate(startTime))
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        final slot = ReservationTimeSlot.fromFirestore(
          doc.data() as Map<String, dynamic>,
        );

        final updatedSlot = slot.copyWith(
          currentReservations: (slot.currentReservations + change).clamp(
            0,
            slot.maxCapacity,
          ),
        );

        await doc.reference.update(updatedSlot.toFirestore());
      }
    } catch (e) {
      // Log error pero no fallar la operación principal
      print('Warning: Could not update slot capacity: $e');
    }
  }

  Future<ReservationTimeSlot?> _getExistingSlot(
    String placeId,
    DateTime startTime,
  ) async {
    try {
      final querySnapshot = await _timeSlotsRef
          .where('placeId', isEqualTo: placeId)
          .where('startTime', isEqualTo: Timestamp.fromDate(startTime))
          .limit(1)
          .get();

      if (querySnapshot.docs.isNotEmpty) {
        final doc = querySnapshot.docs.first;
        return ReservationTimeSlot.fromFirestore(
          doc.data() as Map<String, dynamic>,
        );
      }

      return null;
    } catch (e) {
      return null;
    }
  }

  // ================== MÉTODOS NO IMPLEMENTADOS (TODO) ==================

  @override
  Future<ReservationStats> getReservationStats(
    String placeId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    // TODO: Implementar estadísticas
    throw UnimplementedError('getReservationStats no implementado aún');
  }

  @override
  Future<double> getOccupancyRate(String placeId, DateTime date) async {
    // TODO: Implementar tasa de ocupación
    throw UnimplementedError('getOccupancyRate no implementado aún');
  }

  @override
  Future<List<PopularTimeSlot>> getPopularTimeSlots(
    String placeId, {
    int days = 30,
  }) async {
    // TODO: Implementar horarios populares
    throw UnimplementedError('getPopularTimeSlots no implementado aún');
  }

  @override
  Future<List<ReservationTrend>> getReservationTrends(
    String placeId, {
    int days = 30,
  }) async {
    // TODO: Implementar tendencias
    throw UnimplementedError('getReservationTrends no implementado aún');
  }

  @override
  Future<void> sendConfirmationEmail(String reservationId) async {
    // TODO: Implementar envío de email
    throw UnimplementedError('sendConfirmationEmail no implementado aún');
  }

  @override
  Future<void> sendReminderEmail(String reservationId) async {
    // TODO: Implementar recordatorio por email
    throw UnimplementedError('sendReminderEmail no implementado aún');
  }

  @override
  Future<void> scheduleReminder(String reservationId) async {
    // TODO: Implementar programación de recordatorio
    throw UnimplementedError('scheduleReminder no implementado aún');
  }

  @override
  Future<ReservationValidationResult> validateReservation(
    Reservation reservation,
  ) async {
    // TODO: Implementar validación completa
    return const ReservationValidationResult(isValid: true);
  }

  @override
  Future<List<Reservation>> checkTimeConflicts(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    // TODO: Implementar verificación de conflictos
    return [];
  }

  @override
  Future<int> getAvailableCapacity(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    // TODO: Implementar verificación de capacidad
    return 1;
  }

  @override
  Future<void> cleanupOldReservations({int olderThanDays = 90}) async {
    // TODO: Implementar limpieza automática
    throw UnimplementedError('cleanupOldReservations no implementado aún');
  }

  @override
  Future<String> exportReservationsToCSV(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    // TODO: Implementar exportación
    throw UnimplementedError('exportReservationsToCSV no implementado aún');
  }

  @override
  Future<void> importReservationsFromCSV(String placeId, String csvData) async {
    // TODO: Implementar importación
    throw UnimplementedError('importReservationsFromCSV no implementado aún');
  }

  @override
  void dispose() {
    // Limpiar recursos si es necesario
  }
}
