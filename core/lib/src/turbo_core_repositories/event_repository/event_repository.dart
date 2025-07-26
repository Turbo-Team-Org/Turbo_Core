import 'package:core/src/turbo_core_repositories/event_repository/interface/event_interface.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/service/event_service.dart';

/// Repository for managing events and their operations.
///
/// This repository provides a clean interface for event-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to events, scheduling, and administrative access control.
class EventRepository implements EventInterface {
  /// Constructor for the EventRepository.
  EventRepository({required this.eventService});

  /// Event service instance for data operations
  final EventService eventService;

  // ==================== READ OPERATIONS ====================

  /// Gets all events from the data source.
  ///
  /// Returns a list of all available events.
  /// Throws an exception if the operation fails.
  @override
  Future<List<Event>> getEvents() async {
    try {
      return await eventService.getEvents();
    } catch (e) {
      throw Exception('Error al obtener eventos: $e');
    }
  }

  /// Gets all events scheduled for today.
  ///
  /// Returns a list of events that occur today.
  /// Throws an exception if the operation fails.
  @override
  Future<List<Event>> getTodayEvents() async {
    try {
      return await eventService.getTodayEvents();
    } catch (e) {
      throw Exception('Error al obtener eventos de hoy: $e');
    }
  }

  /// Gets all events of a specific type.
  ///
  /// [type] The type of events to retrieve.
  ///
  /// Returns a list of events matching the specified type.
  /// Throws an exception if the operation fails.
  @override
  Future<List<Event>> getEventsByType(EventType type) async {
    try {
      return await eventService.getEventsByType(type);
    } catch (e) {
      throw Exception('Error al obtener eventos por tipo: $e');
    }
  }

  /// Gets a specific event by its unique identifier.
  ///
  /// [id] The unique identifier of the event to retrieve.
  ///
  /// Returns the event with the specified ID.
  /// Throws an exception if the event is not found or operation fails.
  @override
  Future<Event> getEventById(String id) async {
    try {
      return await eventService.getEventById(id);
    } catch (e) {
      throw Exception('Error al obtener evento por ID: $e');
    }
  }

  /// Gets all events associated with a specific place.
  ///
  /// [placeId] The unique identifier of the place.
  ///
  /// Returns a list of events at the specified place.
  /// Throws an exception if the operation fails.
  @override
  Future<List<Event>> getEventsByPlaceId(String placeId) async {
    try {
      return await eventService.getEventsByPlaceId(placeId);
    } catch (e) {
      throw Exception('Error al obtener eventos por lugar: $e');
    }
  }

  /// Gets all highlighted/featured events.
  ///
  /// Returns a list of events marked as highlighted.
  /// Throws an exception if the operation fails.
  @override
  Future<List<Event>> getHighlightedEvents() async {
    try {
      return await eventService.getHighlightedEvents();
    } catch (e) {
      throw Exception('Error al obtener eventos destacados: $e');
    }
  }

  // ==================== ADMIN OPERATIONS ====================

  /// 🏢 Gets events from places owned by a specific admin user.
  ///
  /// [placeIds] List of place IDs owned by the admin user.
  ///
  /// Returns a list of events from all places owned by the admin.
  /// This method is used by the Admin Panel to show only events
  /// from places that a specific admin user can manage.
  Future<List<Event>> getEventsByPlaceIds(List<String> placeIds) async {
    try {
      return await eventService.getEventsByPlaceIds(placeIds);
    } catch (e) {
      throw Exception('Error al obtener eventos por lugares: $e');
    }
  }

  /// 🏢 Gets events managed by a specific admin user.
  ///
  /// [adminUserId] The unique identifier of the admin user.
  ///
  /// Returns a list of events from all places owned by the admin user.
  /// This is a convenience method that first retrieves the places
  /// owned by the admin and then gets events for those places.
  Future<List<Event>> getEventsByAdminUser(String adminUserId) async {
    try {
      return await eventService.getEventsByAdminUser(adminUserId);
    } catch (e) {
      throw Exception('Error al obtener eventos por administrador: $e');
    }
  }

  /// 📊 Gets event analytics for places owned by an admin.
  ///
  /// [adminUserId] The unique identifier of the admin user.
  /// [startDate] Start date for analytics period.
  /// [endDate] End date for analytics period.
  ///
  /// Returns aggregated event analytics for all places owned by the admin.
  Future<EventAnalytics> getEventAnalyticsByAdminUser(
    String adminUserId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      return await eventService.getEventAnalyticsByAdminUser(
        adminUserId,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      throw Exception('Error al obtener analytics de eventos: $e');
    }
  }

  /// 🔍 Searches events in places owned by a specific admin.
  ///
  /// [query] The search term to look for.
  /// [adminUserId] The admin user ID to filter by.
  /// [eventType] Optional event type filter.
  /// [startDate] Optional start date filter.
  /// [endDate] Optional end date filter.
  ///
  /// Returns events from admin's places that match the search criteria.
  Future<List<Event>> searchEventsByAdminUser(
    String query,
    String adminUserId, {
    EventType? eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      return await eventService.searchEventsByAdminUser(
        query,
        adminUserId,
        eventType: eventType,
        startDate: startDate,
        endDate: endDate,
      );
    } catch (e) {
      throw Exception('Error al buscar eventos por administrador: $e');
    }
  }

  // ==================== CREATE OPERATIONS ====================

  /// Adds a new event to the data source.
  ///
  /// [event] The event object to be added.
  ///
  /// Returns true if the event was successfully added.
  /// Throws an exception if the operation fails.
  @override
  Future<String> addEvent(Event event) async {
    try {
      return await eventService.addEvent(event);
    } catch (e) {
      throw Exception('Error al agregar evento: $e');
    }
  }

  /// 🏢 Adds a new event with admin ownership validation.
  ///
  /// [event] The event object to be added.
  /// [adminUserId] The admin user ID who is creating the event.
  ///
  /// This method validates that the admin user has permission
  /// to create events for the specified place before adding.
  Future<void> addEventByAdmin(Event event, String adminUserId) async {
    try {
      await eventService.addEventByAdmin(event, adminUserId);
    } catch (e) {
      throw Exception('Error al agregar evento por administrador: $e');
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Updates an existing event in the data source.
  ///
  /// [event] The event object with updated information.
  ///
  /// Returns true if the event was successfully updated.
  /// Throws an exception if the event is not found or operation fails.
  @override
  Future<void> updateEvent(Event event) async {
    try {
      await eventService.updateEvent(event);
    } catch (e) {
      throw Exception('Error al actualizar evento: $e');
    }
  }

  /// 🏢 Updates an event with admin ownership validation.
  ///
  /// [event] The updated event object.
  /// [adminUserId] The admin user ID who is updating the event.
  ///
  /// This method validates that the admin user has permission
  /// to update events for the specified place before updating.
  Future<void> updateEventByAdmin(Event event, String adminUserId) async {
    try {
      await eventService.updateEventByAdmin(event, adminUserId);
    } catch (e) {
      throw Exception('Error al actualizar evento por administrador: $e');
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Deletes an event from the data source.
  ///
  /// [id] The unique identifier of the event to delete.
  ///
  /// Returns true if the event was successfully deleted.
  /// Throws an exception if the event is not found or operation fails.
  @override
  Future<void> deleteEvent(String id) async {
    try {
      await eventService.deleteEvent(id);
    } catch (e) {
      throw Exception('Error al eliminar evento: $e');
    }
  }

  /// 🏢 Deletes an event with admin ownership validation.
  ///
  /// [eventId] The unique identifier of the event to delete.
  /// [adminUserId] The admin user ID who is deleting the event.
  ///
  /// This method validates that the admin user has permission
  /// to delete events for the specified place before deleting.
  Future<void> deleteEventByAdmin(String eventId, String adminUserId) async {
    try {
      await eventService.deleteEventByAdmin(eventId, adminUserId);
    } catch (e) {
      throw Exception('Error al eliminar evento por administrador: $e');
    }
  }

  // ==================== SEARCH OPERATIONS ====================

  /// Searches for events based on a query string.
  ///
  /// [query] The search term to look for in event names and descriptions.
  ///
  /// Returns a list of events that match the search criteria.
  /// This method filters events locally after fetching all events.
  Future<List<Event>> searchEvents(String query) async {
    try {
      final allEvents = await eventService.getEvents();
      final lowercaseQuery = query.toLowerCase();

      return allEvents.where((event) {
        // Safe null-aware checking for title
        final titleMatches = event.title.toLowerCase().contains(lowercaseQuery);

        // Safe checking for description (may be empty string from Firestore)
        final descriptionMatches =
            event.description.isNotEmpty &&
            event.description.toLowerCase().contains(lowercaseQuery);

        // Safe checking for tags (may be empty list from Firestore)
        final tagsMatch =
            event.tags.isNotEmpty &&
            event.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));

        return titleMatches || descriptionMatches || tagsMatch;
      }).toList();
    } catch (e) {
      throw Exception('Error al buscar eventos: $e');
    }
  }

  /// Gets events within a specific date range.
  ///
  /// [startDate] The start date of the range (inclusive).
  /// [endDate] The end date of the range (inclusive).
  ///
  /// Returns a list of events within the specified date range.
  Future<List<Event>> getEventsByDateRange({
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    try {
      final allEvents = await eventService.getEvents();

      return allEvents.where((event) {
        return event.date.isAfter(
              startDate.subtract(const Duration(days: 1)),
            ) &&
            event.date.isBefore(endDate.add(const Duration(days: 1)));
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener eventos por rango de fechas: $e');
    }
  }

  /// Gets upcoming events (events scheduled for the future).
  ///
  /// [limit] Optional limit for the number of events to return.
  ///
  /// Returns a list of upcoming events sorted by date.
  Future<List<Event>> getUpcomingEvents({int? limit}) async {
    try {
      final allEvents = await eventService.getEvents();
      final now = DateTime.now();

      final upcomingEvents =
          allEvents.where((event) => event.date.isAfter(now)).toList()
            ..sort((a, b) => a.date.compareTo(b.date));

      if (limit != null && limit > 0) {
        return upcomingEvents.take(limit).toList();
      }

      return upcomingEvents;
    } catch (e) {
      throw Exception('Error al obtener eventos próximos: $e');
    }
  }

  /// Gets past events (events that have already occurred).
  ///
  /// [limit] Optional limit for the number of events to return.
  ///
  /// Returns a list of past events sorted by date (most recent first).
  Future<List<Event>> getPastEvents({int? limit}) async {
    try {
      final allEvents = await eventService.getEvents();
      final now = DateTime.now();

      final pastEvents =
          allEvents.where((event) => event.date.isBefore(now)).toList()
            ..sort((a, b) => b.date.compareTo(a.date)); // Most recent first

      if (limit != null && limit > 0) {
        return pastEvents.take(limit).toList();
      }

      return pastEvents;
    } catch (e) {
      throw Exception('Error al obtener eventos pasados: $e');
    }
  }

  /// Gets events filtered by price range.
  ///
  /// [minPrice] The minimum price (inclusive).
  /// [maxPrice] The maximum price (inclusive).
  ///
  /// Returns a list of events within the specified price range.
  Future<List<Event>> getEventsByPriceRange({
    required double minPrice,
    required double maxPrice,
  }) async {
    try {
      final allEvents = await eventService.getEvents();

      return allEvents.where((event) {
        final eventPrice = event.price ?? 0.0;
        return eventPrice >= minPrice && eventPrice <= maxPrice;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener eventos por rango de precio: $e');
    }
  }

  /// Gets free events (events with price = 0).
  ///
  /// Returns a list of events that are free to attend.
  Future<List<Event>> getFreeEvents() async {
    try {
      final allEvents = await eventService.getEvents();
      return allEvents.where((event) => event.price == 0).toList();
    } catch (e) {
      throw Exception('Error al obtener eventos gratuitos: $e');
    }
  }

  /// Gets events by multiple types.
  ///
  /// [types] List of event types to filter by.
  ///
  /// Returns a list of events matching any of the specified types.
  Future<List<Event>> getEventsByMultipleTypes(List<EventType> types) async {
    try {
      final allEvents = await eventService.getEvents();

      return allEvents.where((event) {
        return types.contains(event.type);
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener eventos por múltiples tipos: $e');
    }
  }

  /// Gets events sorted by date (most recent first).
  ///
  /// [limit] Optional limit for the number of events to return.
  ///
  /// Returns a list of events sorted by date (most recent first).
  Future<List<Event>> getEventsSortedByDate({int? limit}) async {
    try {
      final allEvents = await eventService.getEvents();

      final sortedEvents =
          allEvents.toList()..sort((a, b) => b.date.compareTo(a.date));

      if (limit != null && limit > 0) {
        return sortedEvents.take(limit).toList();
      }

      return sortedEvents;
    } catch (e) {
      throw Exception('Error al obtener eventos ordenados por fecha: $e');
    }
  }
}

/// 📊 Analytics data for events managed by an admin user
class EventAnalytics {
  const EventAnalytics({
    required this.adminUserId,
    required this.totalEvents,
    required this.activeEvents,
    required this.pastEvents,
    required this.upcomingEvents,
    required this.totalAttendees,
    required this.averageAttendees,
    required this.eventsByType,
    required this.monthlyEventCount,
    required this.topPerformingEvents,
  });

  /// ID del administrador
  final String adminUserId;

  /// Total de eventos en todas sus propiedades
  final int totalEvents;

  /// Eventos actualmente activos
  final int activeEvents;

  /// Eventos pasados
  final int pastEvents;

  /// Eventos próximos
  final int upcomingEvents;

  /// Total de asistentes en todos los eventos
  final int totalAttendees;

  /// Promedio de asistentes por evento
  final double averageAttendees;

  /// Distribución de eventos por tipo
  final Map<EventType, int> eventsByType;

  /// Conteo de eventos por mes
  final Map<String, int> monthlyEventCount;

  /// Eventos con mejor rendimiento
  final List<EventPerformance> topPerformingEvents;

  /// Factory para crear desde datos de Firebase
  factory EventAnalytics.fromData(
    String adminUserId,
    Map<String, dynamic> data,
  ) {
    return EventAnalytics(
      adminUserId: adminUserId,
      totalEvents: data['totalEvents'] as int? ?? 0,
      activeEvents: data['activeEvents'] as int? ?? 0,
      pastEvents: data['pastEvents'] as int? ?? 0,
      upcomingEvents: data['upcomingEvents'] as int? ?? 0,
      totalAttendees: data['totalAttendees'] as int? ?? 0,
      averageAttendees: (data['averageAttendees'] as num?)?.toDouble() ?? 0.0,
      eventsByType: Map<EventType, int>.fromEntries(
        (data['eventsByType'] as Map<String, dynamic>? ?? {}).entries.map(
          (entry) => MapEntry(
            EventType.values.firstWhere(
              (type) => type.toString().split('.').last == entry.key,
              orElse: () => EventType.offer,
            ),
            entry.value as int,
          ),
        ),
      ),
      monthlyEventCount: Map<String, int>.from(
        data['monthlyEventCount'] as Map<String, dynamic>? ?? {},
      ),
      topPerformingEvents:
          (data['topPerformingEvents'] as List<dynamic>? ?? [])
              .map(
                (item) =>
                    EventPerformance.fromJson(item as Map<String, dynamic>),
              )
              .toList(),
    );
  }

  /// Convierte a JSON para storage
  Map<String, dynamic> toJson() {
    return {
      'adminUserId': adminUserId,
      'totalEvents': totalEvents,
      'activeEvents': activeEvents,
      'pastEvents': pastEvents,
      'upcomingEvents': upcomingEvents,
      'totalAttendees': totalAttendees,
      'averageAttendees': averageAttendees,
      'eventsByType': eventsByType.map(
        (type, count) => MapEntry(type.toString().split('.').last, count),
      ),
      'monthlyEventCount': monthlyEventCount,
      'topPerformingEvents':
          topPerformingEvents.map((e) => e.toJson()).toList(),
    };
  }
}

/// 🎯 Performance data for individual events
class EventPerformance {
  const EventPerformance({
    required this.eventId,
    required this.eventName,
    required this.attendees,
    required this.views,
    required this.conversionRate,
    required this.rating,
  });

  final String eventId;
  final String eventName;
  final int attendees;
  final int views;
  final double conversionRate;
  final double rating;

  factory EventPerformance.fromJson(Map<String, dynamic> json) {
    return EventPerformance(
      eventId: json['eventId'] as String,
      eventName: json['eventName'] as String,
      attendees: json['attendees'] as int,
      views: json['views'] as int,
      conversionRate: (json['conversionRate'] as num).toDouble(),
      rating: (json['rating'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventName': eventName,
      'attendees': attendees,
      'views': views,
      'conversionRate': conversionRate,
      'rating': rating,
    };
  }
}
