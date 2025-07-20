import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/event_repository/event_repository.dart';
import 'package:core/src/turbo_core_repositories/event_repository/interface/event_interface.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';

import '../models/event_analytics.dart';

/// Service responsible for managing events from Firestore.
class EventService implements EventInterface {
  /// Creates an [EventService] with the provided Firestore instance.
  EventService({required this.firestore});

  /// Firestore instance for event data.
  final FirebaseFirestore firestore;

  /// Returns all events from Firestore.
  @override
  Future<List<Event>> getEvents() async {
    final snapshot = await firestore.collection('events').get();
    return snapshot.docs.map(Event.fromFirestore).toList();
  }

  /// Returns today's events from Firestore.
  @override
  Future<List<Event>> getTodayEvents() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

    final snapshot = await firestore
        .collection('events')
        .where('date', isGreaterThanOrEqualTo: startOfDay)
        .where('date', isLessThanOrEqualTo: endOfDay)
        .get();

    return snapshot.docs.map(Event.fromFirestore).toList();
  }

  /// Returns all events of a specific [type] from Firestore.
  @override
  Future<List<Event>> getEventsByType(EventType type) async {
    final typeString = type.toString().split('.').last;
    final snapshot = await firestore
        .collection('events')
        .where('type', isEqualTo: typeString)
        .get();

    return snapshot.docs.map(Event.fromFirestore).toList();
  }

  /// Returns a single event by its [id] from Firestore.
  @override
  Future<Event> getEventById(String id) async {
    final doc = await firestore.collection('events').doc(id).get();
    if (!doc.exists) {
      throw Exception('Event not found');
    }
    return Event.fromFirestore(doc);
  }

  /// Returns all events for a specific [placeId] from Firestore.
  @override
  Future<List<Event>> getEventsByPlaceId(String placeId) async {
    final snapshot = await firestore
        .collection('events')
        .where('placeId', isEqualTo: placeId)
        .get();

    return snapshot.docs.map(Event.fromFirestore).toList();
  }

  /// Returns all highlighted events from Firestore.
  @override
  Future<List<Event>> getHighlightedEvents() async {
    final snapshot = await firestore
        .collection('events')
        .where('isHighlighted', isEqualTo: true)
        .get();

    return snapshot.docs.map(Event.fromFirestore).toList();
  }

  // ==================== CREATE OPERATIONS ====================

  /// Adds a new event to Firestore.
  @override
  Future<void> addEvent(Event event) async {
    try {
      await firestore.collection('events').doc(event.id).set(event.toJson());
    } catch (e) {
      throw Exception('Error adding event: $e');
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Updates an existing event in Firestore.
  @override
  Future<void> updateEvent(Event event) async {
    try {
      await firestore.collection('events').doc(event.id).update(event.toJson());
    } catch (e) {
      throw Exception('Error updating event: $e');
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Deletes an event from Firestore by its [id].
  @override
  Future<void> deleteEvent(String id) async {
    try {
      await firestore.collection('events').doc(id).delete();
    } catch (e) {
      throw Exception('Error deleting event: $e');
    }
  }

  // ==================== ADMIN OPERATIONS ====================

  /// 🏢 Gets events from multiple places (used by admins)
  Future<List<Event>> getEventsByPlaceIds(List<String> placeIds) async {
    try {
      if (placeIds.isEmpty) return [];

      final events = <Event>[];

      // Firebase 'in' queries are limited to 10 items, so we batch them
      const int batchSize = 10;
      for (int i = 0; i < placeIds.length; i += batchSize) {
        final batch = placeIds.skip(i).take(batchSize).toList();

        final snapshot = await firestore
            .collection('events')
            .where('placeId', whereIn: batch)
            .get();

        final batchEvents = snapshot.docs.map(Event.fromFirestore).toList();
        events.addAll(batchEvents);
      }

      return events;
    } catch (e) {
      throw Exception('Error getting events by place IDs: $e');
    }
  }

  /// 🏢 Gets events managed by a specific admin user
  Future<List<Event>> getEventsByAdminUser(String adminUserId) async {
    try {
      // First, get all places owned by this admin
      final placesSnapshot = await firestore
          .collection('places')
          .where('ownerIds', arrayContains: adminUserId)
          .get();

      final placeIds = placesSnapshot.docs.map((doc) => doc.id).toList();

      if (placeIds.isEmpty) return [];

      // Then get events for those places
      return await getEventsByPlaceIds(placeIds);
    } catch (e) {
      throw Exception('Error getting events by admin user: $e');
    }
  }

  /// 📊 Gets event analytics for places owned by an admin
  Future<EventAnalytics> getEventAnalyticsByAdminUser(
    String adminUserId, {
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final events = await getEventsByAdminUser(adminUserId);

      final now = DateTime.now();
      final filterStartDate = startDate ?? DateTime(now.year, now.month, 1);
      final filterEndDate = endDate ?? now;

      // Filter events by date range
      final filteredEvents = events.where((event) {
        return event.date.isAfter(
              filterStartDate.subtract(const Duration(days: 1)),
            ) &&
            event.date.isBefore(filterEndDate.add(const Duration(days: 1)));
      }).toList();

      // Calculate analytics
      final totalEvents = filteredEvents.length;
      final activeEvents =
          filteredEvents.where((e) => e.date.isAfter(now)).length;
      final pastEvents =
          filteredEvents.where((e) => e.date.isBefore(now)).length;
      final upcomingEvents = activeEvents;

      // Simulate attendees data (in real implementation, this would come from database)
      final totalAttendees = filteredEvents.length * 25; // Simulation
      final averageAttendees =
          totalEvents > 0 ? totalAttendees / totalEvents : 0.0;

      // Group by event type
      final eventsByType = <EventType, int>{};
      for (final event in filteredEvents) {
        eventsByType[event.type] = (eventsByType[event.type] ?? 0) + 1;
      }

      // Monthly count
      final monthlyEventCount = <String, int>{};
      for (final event in filteredEvents) {
        final monthKey =
            '${event.date.year}-${event.date.month.toString().padLeft(2, '0')}';
        monthlyEventCount[monthKey] = (monthlyEventCount[monthKey] ?? 0) + 1;
      }

      // Top performing events (simulation)
      final topPerformingEvents = filteredEvents
          .take(5)
          .map(
            (event) => EventPerformance(
              attendees: 100,
              eventId: event.id,
              eventTitle: event.title,
              revenue: 1000, // Simulation
              engagement: 0.16, // Simulation
              rating: 4.2,
            ),
          )
          .toList();

      return EventAnalytics(
        adminUserId: adminUserId,
        totalEvents: totalEvents,
        activeEvents: activeEvents,
        pastEvents: pastEvents,
        upcomingEvents: upcomingEvents,
        totalAttendees: totalAttendees,
        averageAttendees: averageAttendees,
        eventsByType: eventsByType,
        monthlyEventCount: monthlyEventCount,
        topPerformingEvents: topPerformingEvents,
      );
    } catch (e) {
      throw Exception('Error getting event analytics by admin user: $e');
    }
  }

  /// 🔍 Searches events in places owned by a specific admin
  Future<List<Event>> searchEventsByAdminUser(
    String query,
    String adminUserId, {
    EventType? eventType,
    DateTime? startDate,
    DateTime? endDate,
  }) async {
    try {
      final adminEvents = await getEventsByAdminUser(adminUserId);
      final lowercaseQuery = query.toLowerCase();

      var filteredEvents = adminEvents.where((event) {
        // Text search with safe checking for empty values
        final titleMatches = event.title.toLowerCase().contains(
              lowercaseQuery,
            );
        final descriptionMatches = event.description.isNotEmpty &&
            event.description.toLowerCase().contains(lowercaseQuery);
        final tagsMatch = event.tags.isNotEmpty &&
            event.tags.any(
              (tag) => tag.toLowerCase().contains(lowercaseQuery),
            );

        final matchesQuery = titleMatches || descriptionMatches || tagsMatch;

        // Type filter
        final matchesType = eventType == null || event.type == eventType;

        // Date filters
        final matchesStartDate =
            startDate == null || event.date.isAfter(startDate);
        final matchesEndDate = endDate == null || event.date.isBefore(endDate);

        return matchesQuery &&
            matchesType &&
            matchesStartDate &&
            matchesEndDate;
      }).toList();

      return filteredEvents;
    } catch (e) {
      throw Exception('Error searching events by admin user: $e');
    }
  }

  /// 🏢 Adds a new event with admin ownership validation
  Future<void> addEventByAdmin(Event event, String adminUserId) async {
    try {
      // Verify that the admin owns the place where the event will be created
      if (event.placeId != null) {
        final placeDoc =
            await firestore.collection('places').doc(event.placeId).get();

        if (!placeDoc.exists) {
          throw Exception('Place not found');
        }

        final placeData = placeDoc.data()!;
        final ownerIds = List<String>.from(
          placeData['ownerIds'] as List<dynamic>? ?? [],
        );

        if (!ownerIds.contains(adminUserId)) {
          throw Exception(
            'Admin does not have permission to add events to this place',
          );
        }
      }

      // Add metadata about who created the event
      final eventData = event.toJson();
      eventData['createdBy'] = adminUserId;
      eventData['createdAt'] = FieldValue.serverTimestamp();

      await firestore.collection('events').doc(event.id).set(eventData);
    } catch (e) {
      throw Exception('Error adding event by admin: $e');
    }
  }

  /// 🏢 Updates an event with admin ownership validation
  Future<void> updateEventByAdmin(Event event, String adminUserId) async {
    try {
      // Verify that the admin owns the place of this event
      if (event.placeId != null) {
        final placeDoc =
            await firestore.collection('places').doc(event.placeId).get();

        if (!placeDoc.exists) {
          throw Exception('Place not found');
        }

        final placeData = placeDoc.data()!;
        final ownerIds = List<String>.from(
          placeData['ownerIds'] as List<dynamic>? ?? [],
        );

        if (!ownerIds.contains(adminUserId)) {
          throw Exception(
            'Admin does not have permission to update events in this place',
          );
        }
      }

      // Add metadata about who updated the event
      final eventData = event.toJson();
      eventData['lastUpdatedBy'] = adminUserId;
      eventData['lastUpdatedAt'] = FieldValue.serverTimestamp();

      await firestore.collection('events').doc(event.id).update(eventData);
    } catch (e) {
      throw Exception('Error updating event by admin: $e');
    }
  }

  /// 🏢 Deletes an event with admin ownership validation
  Future<void> deleteEventByAdmin(String eventId, String adminUserId) async {
    try {
      // Get the event first to check permissions
      final eventDoc = await firestore.collection('events').doc(eventId).get();

      if (!eventDoc.exists) {
        throw Exception('Event not found');
      }

      final eventData = eventDoc.data()!;
      final placeId = eventData['placeId'] as String?;

      // Verify that the admin owns the place of this event
      if (placeId != null) {
        final placeDoc =
            await firestore.collection('places').doc(placeId).get();

        if (!placeDoc.exists) {
          throw Exception('Place not found');
        }

        final placeData = placeDoc.data()!;
        final ownerIds = List<String>.from(
          placeData['ownerIds'] as List<dynamic>? ?? [],
        );

        if (!ownerIds.contains(adminUserId)) {
          throw Exception(
            'Admin does not have permission to delete events from this place',
          );
        }
      }

      await firestore.collection('events').doc(eventId).delete();
    } catch (e) {
      throw Exception('Error deleting event by admin: $e');
    }
  }
}
