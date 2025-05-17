import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:core/src/event_repository/interface/event_interface.dart';
import 'package:core/src/event_repository/models/event.dart';

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

    final snapshot =
        await firestore
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
    final snapshot =
        await firestore
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
    final snapshot =
        await firestore
            .collection('events')
            .where('placeId', isEqualTo: placeId)
            .get();

    return snapshot.docs.map(Event.fromFirestore).toList();
  }

  /// Returns all highlighted events from Firestore.
  @override
  Future<List<Event>> getHighlightedEvents() async {
    final snapshot =
        await firestore
            .collection('events')
            .where('isHighlighted', isEqualTo: true)
            .get();

    return snapshot.docs.map(Event.fromFirestore).toList();
  }
}
