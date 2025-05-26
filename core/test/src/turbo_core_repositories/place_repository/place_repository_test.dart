import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/place_repository.dart';
import 'package:core/src/turbo_core_repositories/place_repository/service/place_service.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockPlaceService extends Mock implements PlaceService {}

void main() {
  late PlaceRepository placeRepository;
  late MockPlaceService mockPlaceService;

  setUp(() {
    mockPlaceService = MockPlaceService();
    placeRepository = PlaceRepository(placeService: mockPlaceService);
  });

  group('PlaceRepository', () {
    const testPlaceId = 'test-place-id';
    const testCategoryId = 'test-category-id';
    const testPlaceName = 'Test Place';

    final testPlace = Place(
      id: testPlaceId,
      name: testPlaceName,
      description: 'Test Description',
      address: 'Test Address',
      averagePrice: 50.0,
      imageUrls: ['https://example.com/image.jpg'],
      rating: 4.5,
      reviews: [],
      offers: [],
      tags: ['restaurant', 'food'],
      isOpen: true,
      schedules: [],
      mainImage: 'https://example.com/image.jpg',
      favoriteCount: 10,
      menuUrl: 'https://example.com/menu',
      latitude: 40.7128,
      longitude: -74.0060,
      categoryId: testCategoryId,
      categoryName: 'Test Category',
      categoryIcon: 'test-icon',
      openingHours: {},
      phone: '123456789',
      website: 'https://example.com',
      priceLevel: 2,
      metadata: {},
    );

    final testPlaces = [testPlace];

    group('READ Operations', () {
      test('getPlaces success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.getPlaces();

        // Assert
        expect(result, equals(testPlaces));
        verify(() => mockPlaceService.getPlaces()).called(1);
      });

      test('getPlaces failure', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => placeRepository.getPlaces(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener lugares'),
            ),
          ),
        );
      });

      test('getPlaceById success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaceById(testPlaceId),
        ).thenAnswer((_) async => testPlace);

        // Act
        final result = await placeRepository.getPlaceById(testPlaceId);

        // Assert
        expect(result, equals(testPlace));
        verify(() => mockPlaceService.getPlaceById(testPlaceId)).called(1);
      });

      test('getPlaceById failure', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaceById(testPlaceId),
        ).thenThrow(Exception('Place not found'));

        // Act & Assert
        expect(
          () => placeRepository.getPlaceById(testPlaceId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener lugar por ID'),
            ),
          ),
        );
      });

      test('getPlaceByName success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaceByName(testPlaceName),
        ).thenAnswer((_) async => testPlace);

        // Act
        final result = await placeRepository.getPlaceByName(testPlaceName);

        // Assert
        expect(result, equals(testPlace));
        verify(() => mockPlaceService.getPlaceByName(testPlaceName)).called(1);
      });

      test('getPlacesByCategory success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlacesByCategory(testCategoryId),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.getPlacesByCategory(
          testCategoryId,
        );

        // Assert
        expect(result, equals(testPlaces));
        verify(
          () => mockPlaceService.getPlacesByCategory(testCategoryId),
        ).called(1);
      });
    });

    group('CREATE Operations', () {
      test('addPlace success', () async {
        // Arrange
        when(
          () => mockPlaceService.addPlace(testPlace),
        ).thenAnswer((_) async {});

        // Act
        final result = await placeRepository.addPlace(testPlace);

        // Assert
        expect(result, isTrue);
        verify(() => mockPlaceService.addPlace(testPlace)).called(1);
      });

      test('addPlace failure', () async {
        // Arrange
        when(
          () => mockPlaceService.addPlace(testPlace),
        ).thenThrow(Exception('Add failed'));

        // Act & Assert
        expect(
          () => placeRepository.addPlace(testPlace),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al agregar lugar'),
            ),
          ),
        );
      });
    });

    group('UPDATE Operations', () {
      test('updatePlace success', () async {
        // Arrange
        when(
          () => mockPlaceService.updatePlace(testPlace),
        ).thenAnswer((_) async {});

        // Act
        final result = await placeRepository.updatePlace(testPlace);

        // Assert
        expect(result, isTrue);
        verify(() => mockPlaceService.updatePlace(testPlace)).called(1);
      });

      test('updatePlace failure', () async {
        // Arrange
        when(
          () => mockPlaceService.updatePlace(testPlace),
        ).thenThrow(Exception('Update failed'));

        // Act & Assert
        expect(
          () => placeRepository.updatePlace(testPlace),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al actualizar lugar'),
            ),
          ),
        );
      });
    });

    group('DELETE Operations', () {
      test('deletePlace success', () async {
        // Arrange
        when(
          () => mockPlaceService.deletePlace(testPlaceId),
        ).thenAnswer((_) async {});

        // Act
        final result = await placeRepository.deletePlace(testPlaceId);

        // Assert
        expect(result, isTrue);
        verify(() => mockPlaceService.deletePlace(testPlaceId)).called(1);
      });

      test('deletePlace failure', () async {
        // Arrange
        when(
          () => mockPlaceService.deletePlace(testPlaceId),
        ).thenThrow(Exception('Delete failed'));

        // Act & Assert
        expect(
          () => placeRepository.deletePlace(testPlaceId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al eliminar lugar'),
            ),
          ),
        );
      });
    });

    group('SEARCH Operations', () {
      test('searchPlaces by name success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.searchPlaces('test');

        // Assert
        expect(result, equals(testPlaces));
        verify(() => mockPlaceService.getPlaces()).called(1);
      });

      test('searchPlaces by description success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.searchPlaces('description');

        // Assert
        expect(result, equals(testPlaces));
      });

      test('searchPlaces by tags success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.searchPlaces('restaurant');

        // Assert
        expect(result, equals(testPlaces));
      });

      test('searchPlaces no results', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.searchPlaces('nonexistent');

        // Assert
        expect(result, isEmpty);
      });

      test('getPlacesNearby success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act - Search within 10km of NYC coordinates
        final result = await placeRepository.getPlacesNearby(
          latitude: 40.7589,
          longitude: -73.9851,
          radiusInKm: 10.0,
        );

        // Assert
        expect(result, equals(testPlaces));
      });

      test('getPlacesNearby no results when too far', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act - Search very far from the test place
        final result = await placeRepository.getPlacesNearby(
          latitude: 0.0,
          longitude: 0.0,
          radiusInKm: 1.0,
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getPlacesByRating success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.getPlacesByRating(
          minRating: 4.0,
          maxRating: 5.0,
        );

        // Assert
        expect(result, equals(testPlaces));
      });

      test('getPlacesByRating no results', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.getPlacesByRating(
          minRating: 1.0,
          maxRating: 2.0,
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getPlacesByPriceRange success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.getPlacesByPriceRange(
          minPrice: 40.0,
          maxPrice: 60.0,
        );

        // Assert
        expect(result, equals(testPlaces));
      });

      test('getPlacesByPriceRange no results', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.getPlacesByPriceRange(
          minPrice: 100.0,
          maxPrice: 200.0,
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getOpenPlaces success', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => testPlaces);

        // Act
        final result = await placeRepository.getOpenPlaces();

        // Assert
        expect(result, equals(testPlaces));
      });

      test('getOpenPlaces no results when all closed', () async {
        // Arrange
        final closedPlace = testPlace.copyWith(isOpen: false);
        when(
          () => mockPlaceService.getPlaces(),
        ).thenAnswer((_) async => [closedPlace]);

        // Act
        final result = await placeRepository.getOpenPlaces();

        // Assert
        expect(result, isEmpty);
      });
    });

    group('Error Handling', () {
      test('searchPlaces handles service error', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => placeRepository.searchPlaces('test'),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al buscar lugares'),
            ),
          ),
        );
      });

      test('getPlacesNearby handles service error', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => placeRepository.getPlacesNearby(
            latitude: 0.0,
            longitude: 0.0,
            radiusInKm: 1.0,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener lugares cercanos'),
            ),
          ),
        );
      });

      test('getPlacesByRating handles service error', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () =>
              placeRepository.getPlacesByRating(minRating: 1.0, maxRating: 5.0),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener lugares por calificación'),
            ),
          ),
        );
      });

      test('getPlacesByPriceRange handles service error', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => placeRepository.getPlacesByPriceRange(
            minPrice: 0.0,
            maxPrice: 100.0,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener lugares por rango de precio'),
            ),
          ),
        );
      });

      test('getOpenPlaces handles service error', () async {
        // Arrange
        when(
          () => mockPlaceService.getPlaces(),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => placeRepository.getOpenPlaces(),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener lugares abiertos'),
            ),
          ),
        );
      });
    });
  });
}
