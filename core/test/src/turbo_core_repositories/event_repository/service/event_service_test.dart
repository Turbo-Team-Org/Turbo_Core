import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/service/event_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

class MockTimestamp extends Mock implements Timestamp {}

void main() {
  late EventService eventService;
  late MockFirebaseFirestore mockFirestore;
  late MockCollectionReference mockEventsCollection;
  late MockDocumentReference mockEventDoc;
  late MockQuerySnapshot mockEventsSnapshot;
  late MockQueryDocumentSnapshot mockEventSnapshot;
  late MockQuery mockQuery;
  late MockTimestamp mockTimestamp;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockEventsCollection = MockCollectionReference();
    mockEventDoc = MockDocumentReference();
    mockEventsSnapshot = MockQuerySnapshot();
    mockEventSnapshot = MockQueryDocumentSnapshot();
    mockQuery = MockQuery();
    mockTimestamp = MockTimestamp();

    eventService = EventService(firestore: mockFirestore);

    when(
      () => mockFirestore.collection('events'),
    ).thenReturn(mockEventsCollection);
    when(() => mockEventsCollection.doc(any())).thenReturn(mockEventDoc);
    when(() => mockEventSnapshot.id).thenReturn('test-event-id');
    when(() => mockTimestamp.toDate()).thenReturn(DateTime.now());
  });

  group('EventService', () {
    const testEventId = 'test-event-id';
    const testPlaceId = 'test-place-id';

    Map<String, dynamic> getTestEvent() => {
      'id': testEventId,
      'title': 'Test Event',
      'description': 'Test Description',
      'date': mockTimestamp,
      'location': 'Test Location',
      'type': 'concert',
      'placeId': testPlaceId,
      'isHighlighted': true,
      'imageUrl': 'https://example.com/image.jpg',
      'price': 50.0,
      'tags': ['music', 'live'],
      'organizerName': 'Test Organizer',
      'organizerContact': 'test@example.com',
    };

    test('getEvents success', () async {
      when(() => mockEventSnapshot.data()).thenReturn(getTestEvent());
      when(() => mockEventsSnapshot.docs).thenReturn([mockEventSnapshot]);
      when(
        () => mockEventsCollection.get(),
      ).thenAnswer((_) async => mockEventsSnapshot);

      final result = await eventService.getEvents();

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testEventId));
      expect(result.first.title, equals('Test Event'));
    });

    test('getTodayEvents success', () async {
      when(() => mockEventSnapshot.data()).thenReturn(getTestEvent());
      when(() => mockEventsSnapshot.docs).thenReturn([mockEventSnapshot]);

      // Mock para query de eventos de hoy
      when(
        () => mockEventsCollection.where(
          'date',
          isGreaterThanOrEqualTo: any(named: 'isGreaterThanOrEqualTo'),
        ),
      ).thenReturn(mockQuery);
      when(
        () => mockQuery.where(
          'date',
          isLessThanOrEqualTo: any(named: 'isLessThanOrEqualTo'),
        ),
      ).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockEventsSnapshot);

      final result = await eventService.getTodayEvents();

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testEventId));
      expect(result.first.title, equals('Test Event'));
    });

    test('getEventsByType success', () async {
      when(() => mockEventSnapshot.data()).thenReturn(getTestEvent());
      when(() => mockEventsSnapshot.docs).thenReturn([mockEventSnapshot]);

      // Mock para query por tipo
      when(
        () => mockEventsCollection.where('type', isEqualTo: 'concert'),
      ).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockEventsSnapshot);

      final result = await eventService.getEventsByType(EventType.concert);

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testEventId));
      expect(result.first.title, equals('Test Event'));
    });

    test('getEventById success', () async {
      when(() => mockEventSnapshot.data()).thenReturn(getTestEvent());
      when(() => mockEventSnapshot.exists).thenReturn(true);
      when(() => mockEventDoc.get()).thenAnswer((_) async => mockEventSnapshot);

      final result = await eventService.getEventById(testEventId);

      expect(result.id, equals(testEventId));
      expect(result.title, equals('Test Event'));
    });

    test('getEventById not found', () async {
      when(() => mockEventSnapshot.exists).thenReturn(false);
      when(() => mockEventDoc.get()).thenAnswer((_) async => mockEventSnapshot);

      expect(() => eventService.getEventById(testEventId), throwsException);
    });

    test('getEventsByPlaceId success', () async {
      when(() => mockEventSnapshot.data()).thenReturn(getTestEvent());
      when(() => mockEventsSnapshot.docs).thenReturn([mockEventSnapshot]);

      // Mock para query por placeId
      when(
        () => mockEventsCollection.where('placeId', isEqualTo: testPlaceId),
      ).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockEventsSnapshot);

      final result = await eventService.getEventsByPlaceId(testPlaceId);

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testEventId));
      expect(result.first.title, equals('Test Event'));
    });

    test('getHighlightedEvents success', () async {
      when(() => mockEventSnapshot.data()).thenReturn(getTestEvent());
      when(() => mockEventsSnapshot.docs).thenReturn([mockEventSnapshot]);

      // Mock para query por eventos destacados
      when(
        () => mockEventsCollection.where('isHighlighted', isEqualTo: true),
      ).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockEventsSnapshot);

      final result = await eventService.getHighlightedEvents();

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testEventId));
      expect(result.first.title, equals('Test Event'));
    });
  });
}
