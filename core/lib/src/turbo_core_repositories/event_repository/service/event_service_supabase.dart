import 'package:core/src/turbo_core_repositories/event_repository/interface/event_interface.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
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
      final response = await _supabase
          .from('events')
          .select('*')
          .eq('id', id)
          .maybeSingle();

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
  Future<List<Event>> getEventsByPlaceIds(List<String> placeIds) async {
    try {
      if (placeIds.isEmpty) return [];

      final response = await _supabase
          .from('events')
          .select('*')
          .in_('place_id', placeIds)
          .order('event_date', ascending: true);

      return response.map<Event>((data) => _eventFromSupabase(data)).toList();
    } catch (e) {
      throw Exception('Error getting events by place IDs: $e');
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