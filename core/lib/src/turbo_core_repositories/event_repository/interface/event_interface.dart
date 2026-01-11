import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event_analytics.dart';

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

  // ==================== ADMIN OPERATIONS ====================

  /// 🏢 Gets events from multiple places (used by admins)
  Future<List<Event>> getEventsByPlaceIds(List<String> placeIds);

  /// 🏢 Gets events managed by a specific admin user
  Future<List<Event>> getEventsByAdminUser(String adminUserId);

  /// 📊 Gets event analytics for places owned by an admin
  Future<EventAnalytics> getEventAnalyticsByAdminUser(
    String adminUserId, {
    DateTime? startDate,
    DateTime? endDate,
  });

  /// 🔍 Searches events in places owned by a specific admin
  Future<List<Event>> searchEventsByAdminUser(
    String query,
    String adminUserId, {
    EventType? eventType,
    DateTime? startDate,
    DateTime? endDate,
  });

  /// 🏢 Adds a new event with admin ownership validation
  Future<void> addEventByAdmin(Event event, String adminUserId);

  /// 🏢 Updates an event with admin ownership validation
  Future<void> updateEventByAdmin(Event event, String adminUserId);

  /// 🏢 Deletes an event with admin ownership validation
  Future<void> deleteEventByAdmin(String eventId, String adminUserId);
}
