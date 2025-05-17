import 'package:core/src/turbo_core_repositories/event_repository/interface/event_interface.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/service/event_service.dart';

/// Implementation of the event repository
class EventRepository implements EventInterface {
  /// Constructor
  EventRepository({required this.eventService});

  /// Event service
  final EventService eventService;

  /// Get all events
  @override
  Future<List<Event>> getEvents() {
    return eventService.getEvents();
  }

  @override
  Future<List<Event>> getTodayEvents() {
    return eventService.getTodayEvents();
  }

  @override
  Future<List<Event>> getEventsByType(EventType type) {
    return eventService.getEventsByType(type);
  }

  @override
  Future<Event> getEventById(String id) {
    return eventService.getEventById(id);
  }

  @override
  Future<List<Event>> getEventsByPlaceId(String placeId) {
    return eventService.getEventsByPlaceId(placeId);
  }

  @override
  Future<List<Event>> getHighlightedEvents() {
    return eventService.getHighlightedEvents();
  }
}
