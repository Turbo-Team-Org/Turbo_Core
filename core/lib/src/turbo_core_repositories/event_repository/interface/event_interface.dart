import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';

/// Interface for event repository
abstract class EventInterface {
  // ==================== READ OPERATIONS ====================

  /// Get all events
  Future<List<Event>> getEvents();

  /// Get today's events
  Future<List<Event>> getTodayEvents();

  /// Get events by type
  Future<List<Event>> getEventsByType(EventType type);

  /// Get event by id
  Future<Event> getEventById(String id);

  /// Get events by place id
  Future<List<Event>> getEventsByPlaceId(String placeId);

  /// Get highlighted events
  Future<List<Event>> getHighlightedEvents();

  // ==================== CREATE OPERATIONS ====================

  /// Add a new event
  Future<void> addEvent(Event event);

  // ==================== UPDATE OPERATIONS ====================

  /// Update an existing event
  Future<void> updateEvent(Event event);

  // ==================== DELETE OPERATIONS ====================

  /// Delete an event by id
  Future<void> deleteEvent(String id);
}
