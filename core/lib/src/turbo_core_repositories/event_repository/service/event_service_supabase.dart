import 'package:core/src/turbo_core_repositories/event_repository/interface/event_interface.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event_analytics.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Service responsible for managing events from Supabase.
class EventServiceSupabase implements EventInterface {
  /// Creates an [EventServiceSupabase] with the provided Supabase client.
  EventServiceSupabase({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  /// Supabase client instance for event data.
  final SupabaseClient _supabase;

  /// Returns all events from Supabase.
  @override
  Future<List<Event>> getEvents() async {
    try {
      final response = await _supabase
          .from('events')
          .select('*')
          .order('created_at', ascending: false);

      return response.map<Event>((data) => _eventFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting events: $e');
    }
  }

  /// Returns today's events from Supabase.
  @override
  Future<List<Event>> getTodayEvents() async {
    try {
      final today = DateTime.now();
      final startOfDay = DateTime(today.year, today.month, today.day);
      final endOfDay = DateTime(today.year, today.month, today.day, 23, 59, 59);

      final response = await _supabase
          .from('events')
          .select('*')
          .gte('event_date', startOfDay.toIso8601String())
          .lte('event_date', endOfDay.toIso8601String())
          .order('event_date', ascending: true);

      return response.map<Event>((data) => _eventFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting today events: $e');
    }
  }

  /// Returns all events of a specific [type] from Supabase.
  @override
  Future<List<Event>> getEventsByType(EventType type) async {
    try {
      final typeString = type.toString().split('.').last;
      final response = await _supabase
          .from('events')
          .select('*')
          .eq('event_type', typeString)
          .order('event_date', ascending: true);

      return response.map<Event>((data) => _eventFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting events by type: $e');
    }
  }

  /// Returns a single event by its [id] from Supabase.
  @override
  Future<Event> getEventById(String id) async {
    try {
      final response =
          await _supabase.from('events').select('*').eq('id', id).maybeSingle();

      if (response == null) {
        throw Exception('Event not found');
      }

      return _eventFromSupabase(response);
    } catch (e) {
      throw Exception('Error getting event by id: $e');
    }
  }

  /// Returns all events for a specific [placeId] from Supabase.
  @override
  Future<List<Event>> getEventsByPlaceId(String placeId) async {
    try {
      final response = await _supabase
          .from('events')
          .select('*')
          .eq('place_id', placeId)
          .order('event_date', ascending: true);

      return response.map<Event>((data) => _eventFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting events by place id: $e');
    }
  }

  /// Returns all highlighted events from Supabase.
  @override
  Future<List<Event>> getHighlightedEvents() async {
    try {
      final response = await _supabase
          .from('events')
          .select('*')
          .eq('is_highlighted', true)
          .order('event_date', ascending: true);

      return response.map<Event>((data) => _eventFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting highlighted events: $e');
    }
  }

  // ==================== CREATE OPERATIONS ====================

  /// Adds a new event to Supabase.
  @override
  Future<void> addEvent(Event event) async {
    try {
      await _supabase.from('events').insert(_eventToSupabaseData(event));
    } catch (e) {
      throw Exception('Error adding event: $e');
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Updates an existing event in Supabase.
  @override
  Future<void> updateEvent(Event event) async {
    try {
      await _supabase
          .from('events')
          .update(_eventToSupabaseData(event))
          .eq('id', event.id);
    } catch (e) {
      throw Exception('Error updating event: $e');
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Deletes an event from Supabase by its [id].
  @override
  Future<void> deleteEvent(String id) async {
    try {
      await _supabase.from('events').delete().eq('id', id);
    } catch (e) {
      throw Exception('Error deleting event: $e');
    }
  }

  // ==================== ADMIN OPERATIONS ====================

  /// 🏢 Gets events from multiple places (used by admins)
  @override
  Future<List<Event>> getEventsByPlaceIds(List<String> placeIds) async {
    try {
      if (placeIds.isEmpty) return [];

      final response = await _supabase
          .from('events')
          .select('*')
          .inFilter('place_id', placeIds)
          .order('event_date', ascending: true);

      return response.map<Event>((data) => _eventFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting events by place IDs: $e');
    }
  }

  /// 🏢 Gets events managed by a specific admin user
  @override
  Future<List<Event>> getEventsByAdminUser(String adminUserId) async {
    try {
      // First, get all places owned by this admin
      final placesResponse = await _supabase
          .from('places')
          .select('id')
          .contains('owner_ids', [adminUserId.toString()]);

      final placeIds =
          placesResponse.map((place) => place['id'] as String).toList();

      if (placeIds.isEmpty) return [];

      // Then get events for those places
      return await getEventsByPlaceIds(placeIds);
    } catch (e) {
      throw Exception('Error getting events by admin user: $e');
    }
  }

  /// 📊 Gets event analytics for places owned by an admin
  @override
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
        return event.date
                .isAfter(filterStartDate.subtract(const Duration(days: 1))) &&
            event.date.isBefore(filterEndDate.add(const Duration(days: 1)));
      }).toList();

      // Calculate analytics
      final totalEvents = filteredEvents.length;
      final activeEvents =
          filteredEvents.where((e) => e.date.isAfter(now)).length;
      final pastEvents =
          filteredEvents.where((e) => e.date.isBefore(now)).length;
      final upcomingEvents = activeEvents;

      // Simulate attendees data
      final totalAttendees = filteredEvents.length * 25;
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
          .map((event) => EventPerformance(
                eventId: event.id,
                eventTitle: event.title,
                attendees: 25,
                revenue: event.price ?? 0.0,
                rating: 4.5,
                engagement: 0.8,
              ))
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
  @override
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

      return adminEvents.where((event) {
        // Text search
        final titleMatches = event.title.toLowerCase().contains(lowercaseQuery);
        final descriptionMatches = event.description.isNotEmpty &&
            event.description.toLowerCase().contains(lowercaseQuery);
        final tagsMatch = event.tags.isNotEmpty &&
            event.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));

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
    } catch (e) {
      throw Exception('Error searching events by admin user: $e');
    }
  }

  /// 🏢 Adds a new event with admin ownership validation
  @override
  Future<void> addEventByAdmin(Event event, String adminUserId) async {
    try {
      // Verify that the admin owns the place where the event will be created
      if (event.placeId != null && event.placeId!.isNotEmpty) {
        final placeResponse = await _supabase
            .from('places')
            .select('owner_ids')
            .eq('id', event.placeId!)
            .maybeSingle();

        if (placeResponse == null) {
          throw Exception('Place not found');
        }

        final ownerIds = List<String>.from(
            placeResponse['owner_ids'] as List<dynamic>? ?? []);

        if (!ownerIds.contains(adminUserId)) {
          throw Exception(
              'Admin does not have permission to add events to this place');
        }
      }

      // Add metadata about who created the event
      final eventData = _eventToSupabaseData(event);
      eventData['created_by'] = adminUserId;
      eventData['created_at'] = DateTime.now().toIso8601String();

      await _supabase.from('events').insert(eventData);
    } catch (e) {
      throw Exception('Error adding event by admin: $e');
    }
  }

  /// 🏢 Updates an event with admin ownership validation
  @override
  Future<void> updateEventByAdmin(Event event, String adminUserId) async {
    try {
      // Verify that the admin owns the place of this event
      if (event.placeId != null && event.placeId!.isNotEmpty) {
        final placeResponse = await _supabase
            .from('places')
            .select('owner_ids')
            .eq('id', event.placeId!)
            .maybeSingle();

        if (placeResponse == null) {
          throw Exception('Place not found');
        }

        final ownerIds = List<String>.from(
            placeResponse['owner_ids'] as List<dynamic>? ?? []);

        if (!ownerIds.contains(adminUserId)) {
          throw Exception(
              'Admin does not have permission to update events in this place');
        }
      }

      // Add metadata about who updated the event
      final eventData = _eventToSupabaseData(event);
      eventData['last_updated_by'] = adminUserId;
      eventData['updated_at'] = DateTime.now().toIso8601String();

      await _supabase.from('events').update(eventData).eq('id', event.id);
    } catch (e) {
      throw Exception('Error updating event by admin: $e');
    }
  }

  /// 🏢 Deletes an event with admin ownership validation
  @override
  Future<void> deleteEventByAdmin(String eventId, String adminUserId) async {
    try {
      // Get the event first to check permissions
      final eventResponse = await _supabase
          .from('events')
          .select('place_id')
          .eq('id', eventId)
          .maybeSingle();

      if (eventResponse == null) {
        throw Exception('Event not found');
      }

      final placeId = eventResponse['place_id'] as String?;

      // Verify that the admin owns the place of this event
      if (placeId != null) {
        final placeResponse = await _supabase
            .from('places')
            .select('owner_ids')
            .eq('id', placeId)
            .maybeSingle();

        if (placeResponse == null) {
          throw Exception('Place not found');
        }

        final ownerIds = List<String>.from(
            placeResponse['owner_ids'] as List<dynamic>? ?? []);

        if (!ownerIds.contains(adminUserId)) {
          throw Exception(
              'Admin does not have permission to delete events from this place');
        }
      }

      await _supabase.from('events').delete().eq('id', eventId);
    } catch (e) {
      throw Exception('Error deleting event by admin: $e');
    }
  }

  /// Converts Supabase data to Event model
  Event _eventFromSupabase(Map<String, dynamic> data) {
    // This is a simplified conversion - you might need to adjust based on actual Event model structure
    return Event.fromJson({
      'id': data['id'],
      'title': data['title'] ?? '',
      'description': data['description'] ?? '',
      'placeId': data['place_id'] ?? '',
      'date': data['event_date'] ?? DateTime.now().toIso8601String(),
      'type': data['event_type'] ?? 'general',
      'isHighlighted': data['is_highlighted'] ?? false,
      'imageUrl': data['image_url'] ?? '',
      'price': data['price'] ?? 0.0,
      'capacity': data['capacity'] ?? 0,
      'attendees': data['attendees'] ?? 0,
      'tags': data['tags'] ?? [],
      'metadata': data['metadata'] ?? {},
      'createdAt': data['created_at'],
      'updatedAt': data['updated_at'],
    });
  }

  /// Converts Event model to Supabase data
  Map<String, dynamic> _eventToSupabaseData(Event event) {
    final json = event.toJson();
    return {
      'id': json['id'],
      'title': json['title'],
      'description': json['description'],
      'place_id': json['placeId'],
      'event_date': json['date'],
      'event_type': json['type'],
      'is_highlighted': json['isHighlighted'],
      'image_url': json['imageUrl'],
      'price': json['price'],
      'capacity': json['capacity'],
      'attendees': json['attendees'],
      'tags': json['tags'],
      'metadata': json['metadata'],
      'created_at': json['createdAt'] ?? DateTime.now().toIso8601String(),
      'updated_at': json['updatedAt'] ?? DateTime.now().toIso8601String(),
    };
  }
}
