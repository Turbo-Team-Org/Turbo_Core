import 'package:core/src/event_repository/models/event.dart';

/// Interface for event repository
abstract class EventInterface {
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
}
