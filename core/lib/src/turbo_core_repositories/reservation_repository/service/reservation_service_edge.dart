import 'package:core/src/turbo_core_repositories/reservation_repository/interface/reservation_interface.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_time_slot.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/business_availability.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_settings.dart';
import 'package:dio/dio.dart';

class ReservationServiceEdge implements ReservationInterface {
  ReservationServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  String _url(String path) => '$baseUrl$path';

  // ================== GESTIÓN DE RESERVAS ==================
  @override
  Future<Reservation> createReservation(Reservation reservation) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/public_create_reservation'),
          data: reservation.toJson(),
        );
    return Reservation.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<Reservation?> getReservation(String reservationId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_reservation'),
          queryParameters: {'reservationId': reservationId},
        );
    final data = res.data;
    return data == null ? null : Reservation.fromJson(data);
  }

  @override
  Future<void> updateReservation(Reservation reservation) async {
    await httpClient.post<void>(
      _url('/admin_update_reservation'),
      data: reservation.toJson(),
    );
  }

  @override
  Future<void> cancelReservation(String reservationId, {String? reason}) async {
    await httpClient.post<void>(
      _url('/public_cancel_reservation'),
      data: {
        'reservationId': reservationId,
        if (reason != null) 'reason': reason,
      },
    );
  }

  @override
  Future<void> confirmReservation(
    String reservationId, {
    String? tableNumber,
    String? notes,
  }) async {
    await httpClient.post<void>(
      _url('/admin_confirm_reservation'),
      data: {
        'reservationId': reservationId,
        if (tableNumber != null) 'tableNumber': tableNumber,
        if (notes != null) 'notes': notes,
      },
    );
  }

  @override
  Future<void> rejectReservation(String reservationId, {String? reason}) async {
    await httpClient.post<void>(
      _url('/admin_reject_reservation'),
      data: {
        'reservationId': reservationId,
        if (reason != null) 'reason': reason,
      },
    );
  }

  @override
  Future<void> checkInReservation(String reservationId, {String? notes}) async {
    await httpClient.post<void>(
      _url('/admin_checkin_reservation'),
      data: {'reservationId': reservationId, if (notes != null) 'notes': notes},
    );
  }

  @override
  Future<void> completeReservation(
    String reservationId, {
    String? notes,
  }) async {
    await httpClient.post<void>(
      _url('/admin_complete_reservation'),
      data: {'reservationId': reservationId, if (notes != null) 'notes': notes},
    );
  }

  @override
  Future<void> markNoShow(String reservationId, {String? notes}) async {
    await httpClient.post<void>(
      _url('/admin_noshow_reservation'),
      data: {'reservationId': reservationId, if (notes != null) 'notes': notes},
    );
  }

  // ================== CONSULTAS DE RESERVAS ==================
  @override
  Future<List<Reservation>> getUserReservations(
    String userId, {
    ReservationStatus? status,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_user_reservations'),
      queryParameters: {
        'userId': userId,
        if (status != null) 'status': status.name,
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Reservation>> getPlaceReservations(
    String placeId, {
    ReservationStatus? status,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_place_reservations'),
      queryParameters: {
        'placeId': placeId,
        if (status != null) 'status': status.name,
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Reservation>> getReservationsByDate(
    String placeId,
    DateTime date,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_reservations_by_date'),
      queryParameters: {'placeId': placeId, 'date': date.toIso8601String()},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Reservation>> getReservationsBetweenDates(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_reservations_between'),
      queryParameters: {
        'placeId': placeId,
        'startDate': startDate.toIso8601String(),
        'endDate': endDate.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Reservation>> getTodayReservations(String placeId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_today_reservations'),
      queryParameters: {'placeId': placeId},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<Reservation>> getUserUpcomingReservations(String userId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_user_upcoming_reservations'),
      queryParameters: {'userId': userId},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Stream<List<Reservation>> watchPlaceReservations(String placeId) {
    // Edge Function streaming: pendiente. Devolver Stream.empty() por compatibilidad
    return const Stream.empty();
  }

  // ================== DISPONIBILIDAD Y SLOTS ==================
  @override
  Future<List<ReservationTimeSlot>> getAvailableSlots(
    String placeId,
    DateTime date,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_available_slots'),
      queryParameters: {'placeId': placeId, 'date': date.toIso8601String()},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => ReservationTimeSlot.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<bool> isSlotAvailable(
    String placeId,
    DateTime startTime,
    DateTime endTime,
    int partySize,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_is_slot_available'),
          queryParameters: {
            'placeId': placeId,
            'startTime': startTime.toIso8601String(),
            'endTime': endTime.toIso8601String(),
            'partySize': partySize,
          },
        );
    return (res.data?['available'] as bool?) ?? false;
  }

  @override
  Future<List<ReservationTimeSlot>> getNextAvailableSlots(
    String placeId, {
    int days = 7,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_next_available_slots'),
      queryParameters: {'placeId': placeId, 'days': days},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => ReservationTimeSlot.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<List<ReservationTimeSlot>> generateDaySlots(
    String placeId,
    DateTime date,
  ) async {
    final Response<List<dynamic>> res = await httpClient.post<List<dynamic>>(
      _url('/admin_generate_day_slots'),
      data: {'placeId': placeId, 'date': date.toIso8601String()},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => ReservationTimeSlot.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  // ================== GESTIÓN DE DISPONIBILIDAD ==================
  @override
  Future<BusinessAvailability?> getBusinessAvailability(String placeId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_business_availability'),
          queryParameters: {'placeId': placeId},
        );
    final data = res.data;
    return data == null ? null : BusinessAvailability.fromJson(data);
  }

  @override
  Future<void> setBusinessAvailability(
    BusinessAvailability availability,
  ) async {
    await httpClient.post<void>(
      _url('/admin_set_business_availability'),
      data: availability.toJson(),
    );
  }

  @override
  Future<void> updateWeeklySchedule(
    String placeId,
    List<WeeklySchedule> schedule,
  ) async {
    await httpClient.post<void>(
      _url('/admin_update_weekly_schedule'),
      data: {
        'placeId': placeId,
        'schedule': schedule.map((e) => e.toJson()).toList(),
      },
    );
  }

  @override
  Future<void> addSpecialDay(String placeId, SpecialDay specialDay) async {
    await httpClient.post<void>(
      _url('/admin_add_special_day'),
      data: {'placeId': placeId, ...specialDay.toJson()},
    );
  }

  @override
  Future<void> addBlackoutDate(
    String placeId,
    BlackoutDate blackoutDate,
  ) async {
    await httpClient.post<void>(
      _url('/admin_add_blackout_date'),
      data: {'placeId': placeId, ...blackoutDate.toJson()},
    );
  }

  @override
  Future<void> removeBlackoutDate(String placeId, String blackoutId) async {
    await httpClient.post<void>(
      _url('/admin_remove_blackout_date'),
      data: {'placeId': placeId, 'blackoutId': blackoutId},
    );
  }

  // ================== CONFIGURACIONES ==================
  @override
  Future<ReservationSettings?> getReservationSettings(String placeId) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_reservation_settings'),
          queryParameters: {'placeId': placeId},
        );
    final data = res.data;
    return data == null ? null : ReservationSettings.fromJson(data);
  }

  @override
  Future<void> updateReservationSettings(ReservationSettings settings) async {
    await httpClient.post<void>(
      _url('/admin_update_reservation_settings'),
      data: settings.toJson(),
    );
  }

  @override
  Future<ReservationSettings> createDefaultSettings(
    String placeId, {
    String? createdBy,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/admin_create_default_reservation_settings'),
          data: {
            'placeId': placeId,
            if (createdBy != null) 'createdBy': createdBy,
          },
        );
    return ReservationSettings.fromJson(res.data ?? <String, dynamic>{});
  }

  // ================== ANALYTICS Y ESTADÍSTICAS ==================
  @override
  Future<ReservationStats> getReservationStats(
    String placeId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_reservation_stats'),
          queryParameters: {
            'placeId': placeId,
            if (startDate != null) 'startDate': startDate.toIso8601String(),
            if (endDate != null) 'endDate': endDate.toIso8601String(),
          },
        );
    final data = res.data ?? <String, dynamic>{};
    return ReservationStats(
      totalReservations: (data['totalReservations'] as int?) ?? 0,
      confirmedReservations: (data['confirmedReservations'] as int?) ?? 0,
      cancelledReservations: (data['cancelledReservations'] as int?) ?? 0,
      noShowReservations: (data['noShowReservations'] as int?) ?? 0,
      averagePartySize: (data['averagePartySize'] as num?)?.toDouble() ?? 0.0,
      occupancyRate: (data['occupancyRate'] as num?)?.toDouble() ?? 0.0,
      totalRevenue: (data['totalRevenue'] as num?)?.toDouble() ?? 0.0,
      popularTimes:
          (data['popularTimes'] as List<dynamic>? ?? [])
              .map(
                (e) => PopularTimeSlot(
                  timeSlot: (e['timeSlot'] as String?) ?? '',
                  reservationCount: (e['reservationCount'] as int?) ?? 0,
                  occupancyRate:
                      (e['occupancyRate'] as num?)?.toDouble() ?? 0.0,
                ),
              )
              .toList(),
    );
  }

  @override
  Future<double> getOccupancyRate(String placeId, DateTime date) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_occupancy_rate'),
          queryParameters: {'placeId': placeId, 'date': date.toIso8601String()},
        );
    return (res.data?['occupancyRate'] as num?)?.toDouble() ?? 0.0;
  }

  @override
  Future<List<PopularTimeSlot>> getPopularTimeSlots(
    String placeId, {
    int days = 30,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_popular_time_slots'),
      queryParameters: {'placeId': placeId, 'days': days},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map(
          (e) => PopularTimeSlot(
            timeSlot: (e['timeSlot'] as String?) ?? '',
            reservationCount: (e['reservationCount'] as int?) ?? 0,
            occupancyRate: (e['occupancyRate'] as num?)?.toDouble() ?? 0.0,
          ),
        )
        .toList();
  }

  @override
  Future<List<ReservationTrend>> getReservationTrends(
    String placeId, {
    int days = 30,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_reservation_trends'),
      queryParameters: {'placeId': placeId, 'days': days},
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map(
          (e) => ReservationTrend(
            date:
                DateTime.tryParse((e['date'] as String?) ?? '') ??
                DateTime.now(),
            reservationCount: (e['reservationCount'] as int?) ?? 0,
            occupancyRate: (e['occupancyRate'] as num?)?.toDouble() ?? 0.0,
            revenue: (e['revenue'] as num?)?.toDouble() ?? 0.0,
          ),
        )
        .toList();
  }

  // ================== NOTIFICACIONES ==================
  @override
  Future<void> sendConfirmationEmail(String reservationId) async {
    await httpClient.post<void>(
      _url('/admin_send_confirmation_email'),
      data: {'reservationId': reservationId},
    );
  }

  @override
  Future<void> sendReminderEmail(String reservationId) async {
    await httpClient.post<void>(
      _url('/admin_send_reminder_email'),
      data: {'reservationId': reservationId},
    );
  }

  @override
  Future<void> scheduleReminder(String reservationId) async {
    await httpClient.post<void>(
      _url('/admin_schedule_reservation_reminder'),
      data: {'reservationId': reservationId},
    );
  }

  // ================== VALIDACIONES ==================
  @override
  Future<ReservationValidationResult> validateReservation(
    Reservation reservation,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .post<Map<String, dynamic>>(
          _url('/public_validate_reservation'),
          data: reservation.toJson(),
        );
    final errors =
        (res.data?['errors'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList();
    final warnings =
        (res.data?['warnings'] as List<dynamic>? ?? [])
            .map((e) => e.toString())
            .toList();
    return ReservationValidationResult(
      isValid: (res.data?['isValid'] as bool?) ?? errors.isEmpty,
      errors: errors,
      warnings: warnings,
    );
  }

  @override
  Future<List<Reservation>> checkTimeConflicts(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_check_time_conflicts'),
      queryParameters: {
        'placeId': placeId,
        'startTime': startTime.toIso8601String(),
        'endTime': endTime.toIso8601String(),
      },
    );
    final items = res.data ?? <dynamic>[];
    return items
        .map((e) => Reservation.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  @override
  Future<int> getAvailableCapacity(
    String placeId,
    DateTime startTime,
    DateTime endTime,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_available_capacity'),
          queryParameters: {
            'placeId': placeId,
            'startTime': startTime.toIso8601String(),
            'endTime': endTime.toIso8601String(),
          },
        );
    return (res.data?['available'] as int?) ?? 0;
  }

  // ================== UTILS ==================
  @override
  Future<void> cleanupOldReservations({int olderThanDays = 90}) async {
    await httpClient.post<void>(
      _url('/admin_cleanup_old_reservations'),
      data: {'olderThanDays': olderThanDays},
    );
  }

  @override
  Future<String> exportReservationsToCSV(
    String placeId,
    DateTime startDate,
    DateTime endDate,
  ) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_export_reservations_csv'),
          queryParameters: {
            'placeId': placeId,
            'startDate': startDate.toIso8601String(),
            'endDate': endDate.toIso8601String(),
          },
        );
    return (res.data?['url'] as String?) ?? '';
  }

  @override
  Future<void> importReservationsFromCSV(String placeId, String csvData) async {
    await httpClient.post<void>(
      _url('/admin_import_reservations_csv'),
      data: {'placeId': placeId, 'csvData': csvData},
    );
  }

  @override
  void dispose() {}
}
