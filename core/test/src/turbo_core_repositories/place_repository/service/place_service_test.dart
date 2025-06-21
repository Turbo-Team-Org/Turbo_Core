// ignore_for_file: subtype_of_sealed_class

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/service/analytics_service.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/service/place_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFirebaseFirestore extends Mock implements FirebaseFirestore {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

class MockPlaceAuthorizationInterface extends Mock
    implements PlaceAuthorizationInterface {}

class MockCollectionReference extends Mock
    implements CollectionReference<Map<String, dynamic>> {}

class MockDocumentReference extends Mock
    implements DocumentReference<Map<String, dynamic>> {}

class MockQuerySnapshot extends Mock
    implements QuerySnapshot<Map<String, dynamic>> {}

class MockQueryDocumentSnapshot extends Mock
    implements QueryDocumentSnapshot<Map<String, dynamic>> {}

class MockQuery extends Mock implements Query<Map<String, dynamic>> {}

void main() {
  late PlaceService placeService;
  late MockFirebaseFirestore mockFirestore;
  late MockAnalyticsService mockAnalyticsService;
  late MockPlaceAuthorizationInterface mockAuthorization;
  late MockCollectionReference mockPlacesCollection;
  late MockCollectionReference mockReviewsCollection;
  late MockDocumentReference mockPlaceDoc;
  late MockQuerySnapshot mockPlacesSnapshot;
  late MockQuerySnapshot mockReviewsSnapshot;
  late MockQueryDocumentSnapshot mockPlaceSnapshot;
  late MockQuery mockQuery;
  late MockQuery mockPlaceQuery;
  late MockQuery mockReviewQuery;

  setUp(() {
    mockFirestore = MockFirebaseFirestore();
    mockAnalyticsService = MockAnalyticsService();
    mockAuthorization = MockPlaceAuthorizationInterface();
    mockPlacesCollection = MockCollectionReference();
    mockReviewsCollection = MockCollectionReference();
    mockPlaceDoc = MockDocumentReference();
    mockPlacesSnapshot = MockQuerySnapshot();
    mockReviewsSnapshot = MockQuerySnapshot();
    mockPlaceSnapshot = MockQueryDocumentSnapshot();
    mockQuery = MockQuery();
    mockPlaceQuery = MockQuery();
    mockReviewQuery = MockQuery();

    placeService = PlaceService(
      firestore: mockFirestore,
      analyticsService: mockAnalyticsService,
      authorization: mockAuthorization,
    );

    // Configurar mock de autorización
    when(() => mockAuthorization.canManagePlace(any())).thenReturn(true);

    // Solo configurar los mocks básicos
    when(
      () => mockFirestore.collection('places'),
    ).thenReturn(mockPlacesCollection);
    when(
      () => mockFirestore.collection('reviews'),
    ).thenReturn(mockReviewsCollection);
    when(() => mockPlacesCollection.doc(any())).thenReturn(mockPlaceDoc);
    when(() => mockPlaceSnapshot.id).thenReturn('test-place-id');

    // Configurar mocks para AnalyticsService
    when(
      () => mockAnalyticsService.initializeAnalyticsStructure(any()),
    ).thenAnswer((_) async => Future<void>.value());
    when(
      () => mockAnalyticsService.cleanupAnalyticsStructure(any()),
    ).thenAnswer((_) async => Future<void>.value());
  });

  group('PlaceService', () {
    const testPlaceId = 'test-place-id';
    const testPlaceName = 'Test Place';

    final testPlace = {
      'id': testPlaceId,
      'name': testPlaceName,
      'description': 'Test Description',
      'address': 'Test Address',
      'averagePrice': 50.0,
      'imageUrls': ['https://example.com/image.jpg'],
      'rating': 4.5,
      'isOpen': true,
      'mainImage': 'https://example.com/image.jpg',
      'favoriteCount': 10,
      'menuUrl': 'https://example.com/menu',
      'latitude': 0.0,
      'longitude': 0.0,
      'categoryId': 'test-category',
      'categoryName': 'Test Category',
      'categoryIcon': 'test-icon',
      'openingHours': <String, dynamic>{},
      'phone': '123456789',
      'website': 'https://example.com',
      'priceLevel': 2,
      'metadata': <String, dynamic>{},
      'reviews': <Map<String, dynamic>>[],
      'offers': <Map<String, dynamic>>[],
    };

    test('getPlaces success', () async {
      // Configurar mocks específicos para este test
      when(() => mockPlaceSnapshot.data()).thenReturn(testPlace);
      when(() => mockPlacesSnapshot.docs).thenReturn([mockPlaceSnapshot]);
      when(
        () => mockPlacesCollection.get(),
      ).thenAnswer((_) async => mockPlacesSnapshot);

      // Mock para reviews query
      when(
        () => mockReviewsCollection.where('placeId', isEqualTo: testPlaceId),
      ).thenReturn(mockQuery);
      when(
        () => mockQuery.orderBy('date', descending: true),
      ).thenReturn(mockQuery);
      when(() => mockQuery.limit(20)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockReviewsSnapshot);
      when(() => mockReviewsSnapshot.docs).thenReturn([]);

      final result = await placeService.getPlaces();

      print('Resultado de getPlaces: $result'); // Log del resultado

      expect(result, isNotEmpty);
      expect(result.first.id, equals(testPlaceId));
      expect(result.first.name, equals(testPlaceName));
    });

    test('getPlaces empty result', () async {
      when(() => mockPlacesSnapshot.docs).thenReturn([]);
      when(
        () => mockPlacesCollection.get(),
      ).thenAnswer((_) async => mockPlacesSnapshot);

      final result = await placeService.getPlaces();

      print('Resultado de getPlaces (vacío): $result'); // Log del resultado

      expect(result, isEmpty);
    });

    test('getPlaceById success', () async {
      when(() => mockPlaceSnapshot.data()).thenReturn(testPlace);
      when(() => mockPlaceSnapshot.exists).thenReturn(true);
      when(() => mockPlaceDoc.get()).thenAnswer((_) async => mockPlaceSnapshot);

      // Mock para reviews query
      when(
        () => mockReviewsCollection.where('placeId', isEqualTo: testPlaceId),
      ).thenReturn(mockQuery);
      when(
        () => mockQuery.orderBy('date', descending: true),
      ).thenReturn(mockQuery);
      when(() => mockQuery.limit(20)).thenReturn(mockQuery);
      when(() => mockQuery.get()).thenAnswer((_) async => mockReviewsSnapshot);
      when(() => mockReviewsSnapshot.docs).thenReturn([]);

      final result = await placeService.getPlaceById(testPlaceId);

      print('Resultado de getPlaceById: $result'); // Log del resultado

      expect(result.id, equals(testPlaceId));
      expect(result.name, equals(testPlaceName));
    });

    test('getPlaceById not found', () async {
      when(() => mockPlaceSnapshot.exists).thenReturn(false);
      when(() => mockPlaceDoc.get()).thenAnswer((_) async => mockPlaceSnapshot);

      expect(() => placeService.getPlaceById(testPlaceId), throwsException);
    });

    test('getPlaceByName success', () async {
      when(() => mockPlaceSnapshot.data()).thenReturn(testPlace);
      when(() => mockPlacesSnapshot.docs).thenReturn([mockPlaceSnapshot]);
      // Mock para query de lugares por nombre
      when(
        () => mockPlacesCollection.where('name', isEqualTo: testPlaceName),
      ).thenReturn(mockPlaceQuery);
      when(
        () => mockPlaceQuery.get(),
      ).thenAnswer((_) async => mockPlacesSnapshot);

      // Mock para reviews query
      when(
        () => mockReviewsCollection.where('placeId', isEqualTo: testPlaceId),
      ).thenReturn(mockReviewQuery);
      when(
        () => mockReviewQuery.orderBy('date', descending: true),
      ).thenReturn(mockReviewQuery);
      when(() => mockReviewQuery.limit(20)).thenReturn(mockReviewQuery);
      when(
        () => mockReviewQuery.get(),
      ).thenAnswer((_) async => mockReviewsSnapshot);
      when(() => mockReviewsSnapshot.docs).thenReturn([]);

      final result = await placeService.getPlaceByName(testPlaceName);

      expect(result.id, equals(testPlaceId));
      expect(result.name, equals(testPlaceName));
    });

    test('addPlace success', () async {
      final place = Place.fromJson(testPlace);
      when(
        () => mockPlaceDoc.set(any()),
      ).thenAnswer((_) async => Future<void>.value());

      await placeService.addPlace(place);

      print('Lugar añadido exitosamente: $place'); // Log de la operación

      verify(() => mockPlaceDoc.set(any())).called(1);

      verify(
        () => mockAnalyticsService.initializeAnalyticsStructure(place.id),
      ).called(1);
    });

    test('updatePlace success', () async {
      final place = Place.fromJson(testPlace);
      when(
        () => mockPlaceDoc.update(any()),
      ).thenAnswer((_) async => Future<void>.value());

      await placeService.updatePlace(place);

      print('Lugar actualizado exitosamente: $place'); // Log de la operación

      verify(() => mockPlaceDoc.update(any())).called(1);
    });

    test('deletePlace success', () async {
      when(
        () => mockPlaceDoc.delete(),
      ).thenAnswer((_) async => Future<void>.value());

      await placeService.deletePlace(testPlaceId);

      print(
        'Lugar eliminado exitosamente: $testPlaceId',
      ); // Log de la operación

      verify(
        () => mockAnalyticsService.cleanupAnalyticsStructure(testPlaceId),
      ).called(1);

      verify(() => mockPlaceDoc.delete()).called(1);
    });

    test('addPlace failure - analytics initialization fails', () async {
      final place = Place.fromJson(testPlace);

      // Mock successful place creation
      when(
        () => mockPlaceDoc.set(any()),
      ).thenAnswer((_) async => Future<void>.value());

      // Mock analytics initialization failure
      when(
        () => mockAnalyticsService.initializeAnalyticsStructure(any()),
      ).thenThrow(Exception('Analytics initialization failed'));

      // Mock place deletion for cleanup
      when(
        () => mockPlaceDoc.delete(),
      ).thenAnswer((_) async => Future<void>.value());

      // Should throw exception due to analytics failure
      expect(
        () => placeService.addPlace(place),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Error adding place with analytics'),
          ),
        ),
      );
    });

    test('deletePlace failure - analytics cleanup fails', () async {
      // Mock analytics cleanup failure
      when(
        () => mockAnalyticsService.cleanupAnalyticsStructure(any()),
      ).thenThrow(Exception('Analytics cleanup failed'));

      // Should throw exception due to analytics cleanup failure
      expect(
        () => placeService.deletePlace(testPlaceId),
        throwsA(
          isA<Exception>().having(
            (e) => e.toString(),
            'message',
            contains('Error deleting place with analytics'),
          ),
        ),
      );
    });
  });
}
