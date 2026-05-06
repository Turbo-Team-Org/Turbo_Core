import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';
import 'package:core/src/turbo_core_repositories/event_repository/service/event_service_edge.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '_test_helpers.dart';

void main() {
  const baseUrl = 'https://stub.functions.supabase.co';

  late MockDio dio;
  late EventServiceEdge service;

  setUpAll(registerEdgeFallbacks);

  setUp(() {
    dio = MockDio();
    service = EventServiceEdge(baseUrl: baseUrl, httpClient: dio);
  });

  group('EventServiceEdge', () {
    final apiEvent = <String, dynamic>{
      'id': 'event-1',
      'title': 'Concierto de Salsa',
      'description': 'Noche de salsa cubana',
      'date': DateTime(2026, 6).toIso8601String(),
      'location': 'La Habana',
      'imageUrl': 'https://example.com/image.jpg',
      'type': 'concert',
    };

    test('getEvents llama a /public_get_events', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<List<dynamic>>(<dynamic>[apiEvent]),
      );

      final result = await service.getEvents();

      expect(result, hasLength(1));
      expect(result.first.id, 'event-1');
      expect(result.first.type, EventType.concert);
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_events',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('getTodayEvents llama a /public_get_today_events', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<List<dynamic>>(<dynamic>[]));

      final result = await service.getTodayEvents();

      expect(result, isEmpty);
      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_today_events',
          queryParameters: any(named: 'queryParameters'),
        ),
      ).called(1);
    });

    test('getEventsByType envia type en query', () async {
      when(
        () => dio.get<List<dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer((_) async => okResponse<List<dynamic>>(<dynamic>[]));

      await service.getEventsByType(EventType.concert);

      verify(
        () => dio.get<List<dynamic>>(
          '$baseUrl/public_get_events_by_type',
          queryParameters: {'type': 'concert'},
        ),
      ).called(1);
    });

    test('getEventById envia id en query', () async {
      when(
        () => dio.get<Map<String, dynamic>>(
          any(),
          queryParameters: any(named: 'queryParameters'),
        ),
      ).thenAnswer(
        (_) async => okResponse<Map<String, dynamic>>(apiEvent),
      );

      final result = await service.getEventById('event-1');

      expect(result.id, 'event-1');
      verify(
        () => dio.get<Map<String, dynamic>>(
          '$baseUrl/public_get_event_by_id',
          queryParameters: {'id': 'event-1'},
        ),
      ).called(1);
    });

    test('addEvent hace POST a /admin_add_event', () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      final event = Event(
        id: 'event-1',
        title: 't',
        description: 'd',
        date: DateTime(2026, 6),
        location: 'l',
        imageUrl: 'i',
        type: EventType.party,
      );
      await service.addEvent(event);

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_add_event',
          data: any<Object?>(named: 'data'),
        ),
      ).called(1);
    });

    test('deleteEvent envia id en body POST', () async {
      when(
        () => dio.post<void>(any(), data: any<Object?>(named: 'data')),
      ).thenAnswer((_) async => okResponse<void>(null));

      await service.deleteEvent('event-1');

      verify(
        () => dio.post<void>(
          '$baseUrl/admin_delete_event',
          data: {'id': 'event-1'},
        ),
      ).called(1);
    });
  });
}
