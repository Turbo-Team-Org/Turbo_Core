import 'package:core/src/turbo_core_repositories/event_repository/event_repository.dart';
import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/service/event_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEventService extends Mock implements EventService {}

void main() {
  late EventRepository eventRepository;
  late MockEventService mockEventService;

  setUp(() {
    mockEventService = MockEventService();
    eventRepository = EventRepository(eventService: mockEventService);
  });

  group('EventRepository', () {
    const testEventId = 'test-event-id';
    const testPlaceId = 'test-place-id';
    final testDate = DateTime(2024, 12, 25, 20, 0);

    final testEvent = Event(
      id: testEventId,
      title: 'Test Event',
      description: 'Test Description',
      date: testDate,
      location: 'Test Location',
      imageUrl: 'https://example.com/image.jpg',
      type: EventType.party,
      placeId: testPlaceId,
      price: 25.0,
      isHighlighted: true,
      tags: ['party', 'music'],
      organizerName: 'Test Organizer',
      organizerContact: 'test@example.com',
      endDate: testDate.add(const Duration(hours: 4)),
      link: 'https://example.com/event',
    );

    final testEvents = [testEvent];

    group('READ Operations', () {
      test('getEvents success', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getEvents();

        // Assert
        expect(result, equals(testEvents));
        verify(() => mockEventService.getEvents()).called(1);
      });

      test('getEvents failure', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getEvents(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos'),
            ),
          ),
        );
      });

      test('getTodayEvents success', () async {
        // Arrange
        when(
          () => mockEventService.getTodayEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getTodayEvents();

        // Assert
        expect(result, equals(testEvents));
        verify(() => mockEventService.getTodayEvents()).called(1);
      });

      test('getEventsByType success', () async {
        // Arrange
        when(
          () => mockEventService.getEventsByType(EventType.party),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getEventsByType(EventType.party);

        // Assert
        expect(result, equals(testEvents));
        verify(
          () => mockEventService.getEventsByType(EventType.party),
        ).called(1);
      });

      test('getEventById success', () async {
        // Arrange
        when(
          () => mockEventService.getEventById(testEventId),
        ).thenAnswer((_) async => testEvent);

        // Act
        final result = await eventRepository.getEventById(testEventId);

        // Assert
        expect(result, equals(testEvent));
        verify(() => mockEventService.getEventById(testEventId)).called(1);
      });

      test('getEventById failure', () async {
        // Arrange
        when(
          () => mockEventService.getEventById(testEventId),
        ).thenThrow(Exception('Event not found'));

        // Act & Assert
        expect(
          () => eventRepository.getEventById(testEventId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener evento por ID'),
            ),
          ),
        );
      });

      test('getEventsByPlaceId success', () async {
        // Arrange
        when(
          () => mockEventService.getEventsByPlaceId(testPlaceId),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getEventsByPlaceId(testPlaceId);

        // Assert
        expect(result, equals(testEvents));
        verify(
          () => mockEventService.getEventsByPlaceId(testPlaceId),
        ).called(1);
      });

      test('getHighlightedEvents success', () async {
        // Arrange
        when(
          () => mockEventService.getHighlightedEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getHighlightedEvents();

        // Assert
        expect(result, equals(testEvents));
        verify(() => mockEventService.getHighlightedEvents()).called(1);
      });
    });

    group('CREATE Operations', () {
      test('addEvent success', () async {
        // Arrange
        when(
          () => mockEventService.addEvent(testEvent),
        ).thenAnswer((_) async {});

        // Act
        final result = await eventRepository.addEvent(testEvent);

        // Assert
        expect(result, isTrue);
        verify(() => mockEventService.addEvent(testEvent)).called(1);
      });

      test('addEvent failure', () async {
        // Arrange
        when(
          () => mockEventService.addEvent(testEvent),
        ).thenThrow(Exception('Add failed'));

        // Act & Assert
        expect(
          () => eventRepository.addEvent(testEvent),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al agregar evento'),
            ),
          ),
        );
      });
    });

    group('UPDATE Operations', () {
      test('updateEvent success', () async {
        // Arrange
        when(
          () => mockEventService.updateEvent(testEvent),
        ).thenAnswer((_) async {});

        // Act
        final result = await eventRepository.updateEvent(testEvent);

        // Assert
        expect(result, isTrue);
        verify(() => mockEventService.updateEvent(testEvent)).called(1);
      });

      test('updateEvent failure', () async {
        // Arrange
        when(
          () => mockEventService.updateEvent(testEvent),
        ).thenThrow(Exception('Update failed'));

        // Act & Assert
        expect(
          () => eventRepository.updateEvent(testEvent),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al actualizar evento'),
            ),
          ),
        );
      });
    });

    group('DELETE Operations', () {
      test('deleteEvent success', () async {
        // Arrange
        when(
          () => mockEventService.deleteEvent(testEventId),
        ).thenAnswer((_) async {});

        // Act
        final result = await eventRepository.deleteEvent(testEventId);

        // Assert
        expect(result, isTrue);
        verify(() => mockEventService.deleteEvent(testEventId)).called(1);
      });

      test('deleteEvent failure', () async {
        // Arrange
        when(
          () => mockEventService.deleteEvent(testEventId),
        ).thenThrow(Exception('Delete failed'));

        // Act & Assert
        expect(
          () => eventRepository.deleteEvent(testEventId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al eliminar evento'),
            ),
          ),
        );
      });
    });

    group('SEARCH Operations', () {
      test('searchEvents by title success', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.searchEvents('test');

        // Assert
        expect(result, equals(testEvents));
        verify(() => mockEventService.getEvents()).called(1);
      });

      test('searchEvents by description success', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.searchEvents('description');

        // Assert
        expect(result, equals(testEvents));
      });

      test('searchEvents by tags success', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.searchEvents('party');

        // Assert
        expect(result, equals(testEvents));
      });

      test('searchEvents no results', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.searchEvents('nonexistent');

        // Assert
        expect(result, isEmpty);
      });

      test('getEventsByDateRange success', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getEventsByDateRange(
          startDate: DateTime(2024, 12, 20),
          endDate: DateTime(2024, 12, 30),
        );

        // Assert
        expect(result, equals(testEvents));
      });

      test('getEventsByDateRange no results', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getEventsByDateRange(
          startDate: DateTime(2025, 1, 1),
          endDate: DateTime(2025, 1, 31),
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getUpcomingEvents success', () async {
        // Arrange
        final futureEvent = testEvent.copyWith(
          date: DateTime.now().add(const Duration(days: 1)),
        );
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [futureEvent]);

        // Act
        final result = await eventRepository.getUpcomingEvents();

        // Assert
        expect(result, equals([futureEvent]));
      });

      test('getUpcomingEvents with limit', () async {
        // Arrange
        final futureEvent1 = testEvent.copyWith(
          id: 'event1',
          date: DateTime.now().add(const Duration(days: 1)),
        );
        final futureEvent2 = testEvent.copyWith(
          id: 'event2',
          date: DateTime.now().add(const Duration(days: 2)),
        );
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [futureEvent2, futureEvent1]);

        // Act
        final result = await eventRepository.getUpcomingEvents(limit: 1);

        // Assert
        expect(result.length, equals(1));
        expect(result.first.id, equals('event1')); // Should be sorted by date
      });

      test('getPastEvents success', () async {
        // Arrange
        final pastEvent = testEvent.copyWith(
          date: DateTime.now().subtract(const Duration(days: 1)),
        );
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [pastEvent]);

        // Act
        final result = await eventRepository.getPastEvents();

        // Assert
        expect(result, equals([pastEvent]));
      });

      test('getEventsByPriceRange success', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => testEvents);

        // Act
        final result = await eventRepository.getEventsByPriceRange(
          minPrice: 20.0,
          maxPrice: 30.0,
        );

        // Assert
        expect(result, equals(testEvents));
      });

      test('getEventsByPriceRange with null price', () async {
        // Arrange
        final freeEvent = testEvent.copyWith(price: null);
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [freeEvent]);

        // Act
        final result = await eventRepository.getEventsByPriceRange(
          minPrice: 0.0,
          maxPrice: 10.0,
        );

        // Assert
        expect(result, equals([freeEvent])); // null price treated as 0.0
      });

      test('getFreeEvents success', () async {
        // Arrange
        final freeEvent = testEvent.copyWith(price: 0.0);
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [freeEvent]);

        // Act
        final result = await eventRepository.getFreeEvents();

        // Assert
        expect(result, equals([freeEvent]));
      });

      test('getFreeEvents with null price', () async {
        // Arrange
        final freeEvent = testEvent.copyWith(price: null);
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [freeEvent]);

        // Act
        final result = await eventRepository.getFreeEvents();

        // Assert
        expect(result, isEmpty); // null price is not considered free
      });

      test('getEventsByMultipleTypes success', () async {
        // Arrange
        final concertEvent = testEvent.copyWith(type: EventType.concert);
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [testEvent, concertEvent]);

        // Act
        final result = await eventRepository.getEventsByMultipleTypes([
          EventType.party,
          EventType.concert,
        ]);

        // Assert
        expect(result.length, equals(2));
        expect(result, contains(testEvent));
        expect(result, contains(concertEvent));
      });

      test('getEventsSortedByDate success', () async {
        // Arrange
        final event1 = testEvent.copyWith(
          id: 'event1',
          date: DateTime(2024, 12, 20),
        );
        final event2 = testEvent.copyWith(
          id: 'event2',
          date: DateTime(2024, 12, 25),
        );
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [event1, event2]);

        // Act
        final result = await eventRepository.getEventsSortedByDate();

        // Assert
        expect(result.length, equals(2));
        expect(result.first.id, equals('event2')); // Most recent first
        expect(result.last.id, equals('event1'));
      });

      test('getEventsSortedByDate with limit', () async {
        // Arrange
        final event1 = testEvent.copyWith(
          id: 'event1',
          date: DateTime(2024, 12, 20),
        );
        final event2 = testEvent.copyWith(
          id: 'event2',
          date: DateTime(2024, 12, 25),
        );
        when(
          () => mockEventService.getEvents(),
        ).thenAnswer((_) async => [event1, event2]);

        // Act
        final result = await eventRepository.getEventsSortedByDate(limit: 1);

        // Assert
        expect(result.length, equals(1));
        expect(result.first.id, equals('event2')); // Most recent first
      });
    });

    group('Error Handling', () {
      test('searchEvents handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.searchEvents('test'),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al buscar eventos'),
            ),
          ),
        );
      });

      test('getEventsByDateRange handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getEventsByDateRange(
            startDate: DateTime.now(),
            endDate: DateTime.now().add(const Duration(days: 1)),
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos por rango de fechas'),
            ),
          ),
        );
      });

      test('getUpcomingEvents handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getUpcomingEvents(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos próximos'),
            ),
          ),
        );
      });

      test('getPastEvents handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getPastEvents(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos pasados'),
            ),
          ),
        );
      });

      test('getEventsByPriceRange handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getEventsByPriceRange(
            minPrice: 0.0,
            maxPrice: 100.0,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos por rango de precio'),
            ),
          ),
        );
      });

      test('getFreeEvents handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getFreeEvents(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos gratuitos'),
            ),
          ),
        );
      });

      test('getEventsByMultipleTypes handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getEventsByMultipleTypes([EventType.party]),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos por múltiples tipos'),
            ),
          ),
        );
      });

      test('getEventsSortedByDate handles service error', () async {
        // Arrange
        when(
          () => mockEventService.getEvents(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => eventRepository.getEventsSortedByDate(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener eventos ordenados por fecha'),
            ),
          ),
        );
      });
    });
  });
}
