import 'package:core/src/turbo_core_repositories/location_repository/service/location_service_supabase.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late LocationServiceSupabase service;

  setUp(() {
    service = LocationServiceSupabase();
  });

  group('google-places-api RED', () {
    test('searchPlaces should return results for valid query', () async {
      // Arrange
      const query = 'Restaurante La Habana';

      // Act
      final results = await service.searchPlaces(query: query, language: 'es');

      // Assert
      expect(results, isNotEmpty);
    });

    test('getPlaceDetails should return place with valid placeId', () async {
      // Arrange
      const placeId = 'ChIJN1t_tDeuEmsRUsoyG83frY4';

      // Act
      final place = await service.getPlaceDetails(placeId);

      // Assert
      expect(place, isNotNull);
      expect(place!.placeId, equals(placeId));
    });

    test('autocompletePlaces should return suggestions when input is valid',
        () async {
      // Arrange
      const input = 'Obispo';

      // Act
      final suggestions = await service.autocompletePlaces(input: input);

      // Assert
      expect(suggestions, isNotEmpty);
    });
  });
}
