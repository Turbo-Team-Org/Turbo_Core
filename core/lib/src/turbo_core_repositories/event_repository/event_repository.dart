import 'package:core/src/turbo_core_repositories/event_repository/interface/event_interface.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/service/event_service.dart';

/// Repository for managing events and their operations.
///
/// This repository provides a clean interface for event-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to events.
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

  // ==================== CREATE OPERATIONS ====================

  /// Adds a new event to the data source.
  ///
  /// [event] The event object to be added.
  ///
  /// Returns true if the event was successfully added.
  /// Throws an exception if the operation fails.
  Future<bool> addEvent(Event event) async {
    try {
      await eventService.addEvent(event);
      return true;
    } catch (e) {
      throw Exception('Error al agregar evento: $e');
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Updates an existing event in the data source.
  ///
  /// [event] The event object with updated information.
  ///
  /// Returns true if the event was successfully updated.
  /// Throws an exception if the event is not found or operation fails.
  Future<bool> updateEvent(Event event) async {
    try {
      await eventService.updateEvent(event);
      return true;
    } catch (e) {
      throw Exception('Error al actualizar evento: $e');
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Deletes an event from the data source.
  ///
  /// [id] The unique identifier of the event to delete.
  ///
  /// Returns true if the event was successfully deleted.
  /// Throws an exception if the event is not found or operation fails.
  Future<bool> deleteEvent(String id) async {
    try {
      await eventService.deleteEvent(id);
      return true;
    } catch (e) {
      throw Exception('Error al eliminar evento: $e');
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
        return event.title.toLowerCase().contains(lowercaseQuery) ||
            event.description.toLowerCase().contains(lowercaseQuery) ||
            event.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
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
