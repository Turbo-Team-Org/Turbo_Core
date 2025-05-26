import 'package:core/src/turbo_core_repositories/favorite_repository/favorite_repository.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/models/favorite.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/service/favorite_service.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockFavoriteService extends Mock implements FavoriteService {}

void main() {
  late FavoriteRepository favoriteRepository;
  late MockFavoriteService mockFavoriteService;

  setUp(() {
    mockFavoriteService = MockFavoriteService();
    favoriteRepository = FavoriteRepository(
      favoriteService: mockFavoriteService,
    );
  });

  group('FavoriteRepository', () {
    const testUserId = 'test-user-id';
    const testPlaceId = 'test-place-id';
    const testCategoryId = 'test-category-id';
    final testDate = DateTime(2024, 12, 25);

    final testPlace = Place(
      id: testPlaceId,
      name: 'Test Place',
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

    final testFavorite = Favorite(
      id: 'test-favorite-id',
      userId: testUserId,
      placeId: testPlaceId,
      date: testDate,
      place: testPlace,
    );

    final testFavorites = [testFavorite];

    group('READ Operations', () {
      test('getFavorites success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavorites(testUserId);

        // Assert
        expect(result, equals(testFavorites));
        verify(() => mockFavoriteService.getFavorites(testUserId)).called(1);
      });

      test('getFavorites failure', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.getFavorites(testUserId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener favoritos'),
            ),
          ),
        );
      });

      test('isFavorite success - true', () async {
        // Arrange
        when(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async => true);

        // Act
        final result = await favoriteRepository.isFavorite(
          testUserId,
          testPlaceId,
        );

        // Assert
        expect(result, isTrue);
        verify(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).called(1);
      });

      test('isFavorite success - false', () async {
        // Arrange
        when(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async => false);

        // Act
        final result = await favoriteRepository.isFavorite(
          testUserId,
          testPlaceId,
        );

        // Assert
        expect(result, isFalse);
      });

      test('isFavorite failure', () async {
        // Arrange
        when(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.isFavorite(testUserId, testPlaceId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al verificar favorito'),
            ),
          ),
        );
      });
    });

    group('CREATE Operations', () {
      test('addFavorite success', () async {
        // Arrange
        when(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async => false);
        when(
          () => mockFavoriteService.addFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async {});

        // Act
        final result = await favoriteRepository.addFavorite(
          testUserId,
          testPlaceId,
        );

        // Assert
        expect(result, isTrue);
        verify(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).called(1);
        verify(
          () => mockFavoriteService.addFavorite(testUserId, testPlaceId),
        ).called(1);
      });

      test('addFavorite failure - already exists', () async {
        // Arrange
        when(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async => true);

        // Act & Assert
        expect(
          () => favoriteRepository.addFavorite(testUserId, testPlaceId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('El lugar ya está en favoritos'),
            ),
          ),
        );
        verify(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).called(1);
        verifyNever(
          () => mockFavoriteService.addFavorite(testUserId, testPlaceId),
        );
      });

      test('addFavorite failure - service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.isFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async => false);
        when(
          () => mockFavoriteService.addFavorite(testUserId, testPlaceId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.addFavorite(testUserId, testPlaceId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al agregar favorito'),
            ),
          ),
        );
      });
    });

    group('UPDATE Operations', () {
      test('toggleFavorite success', () async {
        // Arrange
        when(
          () => mockFavoriteService.toggleFavorite(testFavorite),
        ).thenAnswer((_) async {});

        // Act
        await favoriteRepository.toggleFavorite(testFavorite);

        // Assert
        verify(
          () => mockFavoriteService.toggleFavorite(testFavorite),
        ).called(1);
      });

      test('toggleFavorite failure', () async {
        // Arrange
        when(
          () => mockFavoriteService.toggleFavorite(testFavorite),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.toggleFavorite(testFavorite),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al alternar favorito'),
            ),
          ),
        );
      });
    });

    group('DELETE Operations', () {
      test('removeFavorite success', () async {
        // Arrange
        when(
          () => mockFavoriteService.removeFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async {});

        // Act
        final result = await favoriteRepository.removeFavorite(
          testUserId,
          testPlaceId,
        );

        // Assert
        expect(result, isTrue);
        verify(
          () => mockFavoriteService.removeFavorite(testUserId, testPlaceId),
        ).called(1);
      });

      test('removeFavorite failure', () async {
        // Arrange
        when(
          () => mockFavoriteService.removeFavorite(testUserId, testPlaceId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.removeFavorite(testUserId, testPlaceId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al eliminar favorito'),
            ),
          ),
        );
      });
    });

    group('SEARCH Operations', () {
      test('getFavoritesByCategory success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavoritesByCategory(
          testUserId,
          testCategoryId,
        );

        // Assert
        expect(result, equals(testFavorites));
        verify(() => mockFavoriteService.getFavorites(testUserId)).called(1);
      });

      test('getFavoritesByCategory no results', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavoritesByCategory(
          testUserId,
          'different-category',
        );

        // Assert
        expect(result, isEmpty);
      });

      test('searchFavorites by name success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.searchFavorites(
          testUserId,
          'test',
        );

        // Assert
        expect(result, equals(testFavorites));
      });

      test('searchFavorites by description success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.searchFavorites(
          testUserId,
          'description',
        );

        // Assert
        expect(result, equals(testFavorites));
      });

      test('searchFavorites by tags success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.searchFavorites(
          testUserId,
          'restaurant',
        );

        // Assert
        expect(result, equals(testFavorites));
      });

      test('searchFavorites no results', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.searchFavorites(
          testUserId,
          'nonexistent',
        );

        // Assert
        expect(result, isEmpty);
      });

      test('searchFavorites with null place', () async {
        // Arrange
        final favoriteWithoutPlace = testFavorite.copyWith(place: null);
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => [favoriteWithoutPlace]);

        // Act
        final result = await favoriteRepository.searchFavorites(
          testUserId,
          'test',
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getFavoritesSortedByDate success', () async {
        // Arrange
        final favorite1 = testFavorite.copyWith(
          id: 'favorite1',
          date: DateTime(2024, 12, 20),
        );
        final favorite2 = testFavorite.copyWith(
          id: 'favorite2',
          date: DateTime(2024, 12, 25),
        );
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => [favorite1, favorite2]);

        // Act
        final result = await favoriteRepository.getFavoritesSortedByDate(
          testUserId,
        );

        // Assert
        expect(result.length, equals(2));
        expect(result.first.id, equals('favorite2')); // Most recent first
        expect(result.last.id, equals('favorite1'));
      });

      test('getFavoritesSortedByDate with limit', () async {
        // Arrange
        final favorite1 = testFavorite.copyWith(
          id: 'favorite1',
          date: DateTime(2024, 12, 20),
        );
        final favorite2 = testFavorite.copyWith(
          id: 'favorite2',
          date: DateTime(2024, 12, 25),
        );
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => [favorite1, favorite2]);

        // Act
        final result = await favoriteRepository.getFavoritesSortedByDate(
          testUserId,
          limit: 1,
        );

        // Assert
        expect(result.length, equals(1));
        expect(result.first.id, equals('favorite2')); // Most recent first
      });

      test('getFavoritesByRating success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavoritesByRating(
          userId: testUserId,
          minRating: 4.0,
          maxRating: 5.0,
        );

        // Assert
        expect(result, equals(testFavorites));
      });

      test('getFavoritesByRating no results', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavoritesByRating(
          userId: testUserId,
          minRating: 1.0,
          maxRating: 2.0,
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getFavoritesByRating with null place', () async {
        // Arrange
        final favoriteWithoutPlace = testFavorite.copyWith(place: null);
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => [favoriteWithoutPlace]);

        // Act
        final result = await favoriteRepository.getFavoritesByRating(
          userId: testUserId,
          minRating: 4.0,
          maxRating: 5.0,
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getFavoritesByPriceRange success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavoritesByPriceRange(
          userId: testUserId,
          minPrice: 40.0,
          maxPrice: 60.0,
        );

        // Assert
        expect(result, equals(testFavorites));
      });

      test('getFavoritesByPriceRange no results', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavoritesByPriceRange(
          userId: testUserId,
          minPrice: 100.0,
          maxPrice: 200.0,
        );

        // Assert
        expect(result, isEmpty);
      });

      test('getOpenFavorites success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getOpenFavorites(testUserId);

        // Assert
        expect(result, equals(testFavorites));
      });

      test('getOpenFavorites no results when closed', () async {
        // Arrange
        final closedPlace = testPlace.copyWith(isOpen: false);
        final favoriteWithClosedPlace = testFavorite.copyWith(
          place: closedPlace,
        );
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => [favoriteWithClosedPlace]);

        // Act
        final result = await favoriteRepository.getOpenFavorites(testUserId);

        // Assert
        expect(result, isEmpty);
      });

      test('getFavoritesCount success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.getFavoritesCount(testUserId);

        // Assert
        expect(result, equals(1));
      });

      test('getFavoritesCount empty', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => []);

        // Act
        final result = await favoriteRepository.getFavoritesCount(testUserId);

        // Assert
        expect(result, equals(0));
      });

      test('hasFavorites success - true', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);

        // Act
        final result = await favoriteRepository.hasFavorites(testUserId);

        // Assert
        expect(result, isTrue);
      });

      test('hasFavorites success - false', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => []);

        // Act
        final result = await favoriteRepository.hasFavorites(testUserId);

        // Assert
        expect(result, isFalse);
      });

      test('clearAllFavorites success', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => testFavorites);
        when(
          () => mockFavoriteService.removeFavorite(testUserId, testPlaceId),
        ).thenAnswer((_) async {});

        // Act
        final result = await favoriteRepository.clearAllFavorites(testUserId);

        // Assert
        expect(result, isTrue);
        verify(() => mockFavoriteService.getFavorites(testUserId)).called(1);
        verify(
          () => mockFavoriteService.removeFavorite(testUserId, testPlaceId),
        ).called(1);
      });

      test('clearAllFavorites with empty list', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenAnswer((_) async => []);

        // Act
        final result = await favoriteRepository.clearAllFavorites(testUserId);

        // Assert
        expect(result, isTrue);
        verify(() => mockFavoriteService.getFavorites(testUserId)).called(1);
        verifyNever(() => mockFavoriteService.removeFavorite(any(), any()));
      });
    });

    group('Error Handling', () {
      test('getFavoritesByCategory handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.getFavoritesByCategory(
            testUserId,
            testCategoryId,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener favoritos por categoría'),
            ),
          ),
        );
      });

      test('searchFavorites handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.searchFavorites(testUserId, 'test'),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al buscar favoritos'),
            ),
          ),
        );
      });

      test('getFavoritesSortedByDate handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.getFavoritesSortedByDate(testUserId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener favoritos ordenados por fecha'),
            ),
          ),
        );
      });

      test('getFavoritesByRating handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.getFavoritesByRating(
            userId: testUserId,
            minRating: 1.0,
            maxRating: 5.0,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener favoritos por calificación'),
            ),
          ),
        );
      });

      test('getFavoritesByPriceRange handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.getFavoritesByPriceRange(
            userId: testUserId,
            minPrice: 0.0,
            maxPrice: 100.0,
          ),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener favoritos por rango de precio'),
            ),
          ),
        );
      });

      test('getOpenFavorites handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.getOpenFavorites(testUserId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener favoritos abiertos'),
            ),
          ),
        );
      });

      test('getFavoritesCount handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.getFavoritesCount(testUserId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al obtener conteo de favoritos'),
            ),
          ),
        );
      });

      test('hasFavorites handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.hasFavorites(testUserId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al verificar si tiene favoritos'),
            ),
          ),
        );
      });

      test('clearAllFavorites handles service error', () async {
        // Arrange
        when(
          () => mockFavoriteService.getFavorites(testUserId),
        ).thenThrow(Exception('Service error'));

        // Act & Assert
        expect(
          () => favoriteRepository.clearAllFavorites(testUserId),
          throwsA(
            isA<Exception>().having(
              (e) => e.toString(),
              'message',
              contains('Error al limpiar todos los favoritos'),
            ),
          ),
        );
      });
    });
  });
}
