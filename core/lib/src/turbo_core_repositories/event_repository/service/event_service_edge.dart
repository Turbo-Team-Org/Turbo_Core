import 'package:core/src/turbo_core_repositories/event_repository/interface/event_interface.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event_analytics.dart';
import 'package:dio/dio.dart';

class EventServiceEdge implements EventInterface {
  EventServiceEdge({required this.baseUrl, required this.httpClient});

  final String baseUrl; // https://<project>.functions.supabase.co
  final Dio httpClient;
  String _url(String path) => '$baseUrl$path';

  @override
  Future<List<Event>> getEvents() async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_events'),
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Event>> getTodayEvents() async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_today_events'),
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Event>> getEventsByType(EventType type) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_events_by_type'),
      queryParameters: {'type': type.name},
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<Event> getEventById(String id) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/public_get_event_by_id'),
          queryParameters: {'id': id},
        );
    return Event.fromJson(res.data ?? <String, dynamic>{});
  }

  @override
  Future<List<Event>> getEventsByPlaceId(String placeId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_events_by_place'),
      queryParameters: {'placeId': placeId},
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Event>> getHighlightedEvents() async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/public_get_highlighted_events'),
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> addEvent(Event event) async {
    await httpClient.post<void>(_url('/admin_add_event'), data: event.toJson());
  }

  @override
  Future<void> updateEvent(Event event) async {
    await httpClient.post<void>(
      _url('/admin_update_event'),
      data: event.toJson(),
    );
  }

  @override
  Future<void> deleteEvent(String id) async {
    await httpClient.post<void>(_url('/admin_delete_event'), data: {'id': id});
  }

  @override
  Future<List<Event>> getEventsByPlaceIds(List<String> placeIds) async {
    final Response<List<dynamic>> res = await httpClient.post<List<dynamic>>(
      _url('/admin_get_events_by_places'),
      data: {'placeIds': placeIds},
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<List<Event>> getEventsByAdminUser(String adminUserId) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_get_events_by_admin'),
      queryParameters: {'adminUserId': adminUserId},
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<EventAnalytics> getEventAnalyticsByAdminUser(
    String adminUserId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final Response<Map<String, dynamic>> res = await httpClient
        .get<Map<String, dynamic>>(
          _url('/admin_get_event_analytics_by_admin'),
          queryParameters: {
            'adminUserId': adminUserId,
            if (startDate != null) 'startDate': startDate.toIso8601String(),
            if (endDate != null) 'endDate': endDate.toIso8601String(),
          },
        );
    return EventAnalytics.fromData(
      adminUserId,
      res.data ?? <String, dynamic>{},
    );
  }

  @override
  Future<List<Event>> searchEventsByAdminUser(
    String query,
    String adminUserId, {
    EventType? eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    final Response<List<dynamic>> res = await httpClient.get<List<dynamic>>(
      _url('/admin_search_events_by_admin'),
      queryParameters: {
        'query': query,
        'adminUserId': adminUserId,
        if (eventType != null) 'eventType': eventType.name,
        if (startDate != null) 'startDate': startDate.toIso8601String(),
        if (endDate != null) 'endDate': endDate.toIso8601String(),
      },
    );
    final data = res.data ?? <dynamic>[];
    return data.map((e) => Event.fromJson(e as Map<String, dynamic>)).toList();
  }

  @override
  Future<void> addEventByAdmin(Event event, String adminUserId) async {
    await httpClient.post<void>(
      _url('/admin_add_event_by_admin'),
      data: {'adminUserId': adminUserId, ...event.toJson()},
    );
  }

  @override
  Future<void> updateEventByAdmin(Event event, String adminUserId) async {
    await httpClient.post<void>(
      _url('/admin_update_event_by_admin'),
      data: {'adminUserId': adminUserId, ...event.toJson()},
    );
  }

  @override
  Future<void> deleteEventByAdmin(String eventId, String adminUserId) async {
    await httpClient.post<void>(
      _url('/admin_delete_event_by_admin'),
      data: {'eventId': eventId, 'adminUserId': adminUserId},
    );
  }
}
