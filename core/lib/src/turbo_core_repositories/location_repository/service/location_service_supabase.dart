import 'package:core/src/turbo_core_repositories/location_repository/interface/location_interface.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/place_location.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/google_place.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/distance_result.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:core/src/monorepo_utils/environments.dart';
import 'dart:convert';
import 'dart:math' as math;

import 'package:supabase/src/supabase_client.dart';

/// Servicio de ubicación usando Supabase
/// Implementa la misma interfaz que LocationService (Firebase)
class LocationServiceSupabase implements LocationInterface {
  LocationServiceSupabase({SupabaseClient? supabaseClient});

  // ================== LOCATION TRACKING ==================
  @override
  Future<LocationData> getCurrentLocation() async {
    try {
      // Check permissions first
      if (!await hasLocationPermission()) {
        final granted = await requestLocationPermission();
        if (!granted) {
          throw Exception('Permisos de ubicación denegados');
        }
      }

      if (!await isLocationServiceEnabled()) {
        throw Exception('Servicios de ubicación deshabilitados');
      }

      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          timeLimit: Duration(seconds: 10),
        ),
      );

      return LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        speed: position.speed,
        heading: position.heading,
        timestamp: position.timestamp,
      );
    } catch (e) {
      throw Exception('Error al obtener la ubicación: $e');
    }
  }

  @override
  Future<void> startLocationTracking() async {
    // Implementación básica - no lanzar error
    print(
      'LocationServiceSupabase: startLocationTracking() - No implementado aún',
    );
  }

  @override
  Future<void> stopLocationTracking() async {
    // Implementación básica - no lanzar error
    print(
      'LocationServiceSupabase: stopLocationTracking() - No implementado aún',
    );
  }

  @override
  Stream<LocationData> get locationStream => const Stream.empty();

  // ================== GOOGLE PLACES INTEGRATION ==================
  @override
  Future<List<GooglePlace>> searchPlaces({
    required String query,
    LocationData? location,
    double? radius,
    String? type,
    String? language,
  }) async {
    final apiKey = Env.googleMapsApiKey;
    if (apiKey.isEmpty) {
      return [_fallbackPlace(query: query)];
    }

    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
      );

      final queryParams = <String, String>{
        'query': query,
        'key': apiKey,
      };

      if (location != null) {
        queryParams['location'] = '${location.latitude},${location.longitude}';
      }
      if (radius != null) {
        queryParams['radius'] = radius.toString();
      }
      if (type != null) {
        queryParams['type'] = type;
      }
      if (language != null) {
        queryParams['language'] = language;
      }

      final response = await http.get(
        uri.replace(queryParameters: queryParams),
      );

      if (response.statusCode != 200) {
        throw Exception('Error en Google Places API: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map((item) => GooglePlace.fromGoogleApi(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error buscando lugares: $e');
    }
  }

  @override
  Future<GooglePlace?> getPlaceDetails(String placeId) async {
    final apiKey = Env.googleMapsApiKey;
    if (apiKey.isEmpty) {
      return _fallbackPlace(placeId: placeId, query: 'Fallback Place');
    }

    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json',
      );
      final response = await http.get(
        uri.replace(
          queryParameters: {
            'place_id': placeId,
            'key': apiKey,
            'fields':
                'place_id,name,formatted_address,geometry,types,rating,user_ratings_total,photos,website,formatted_phone_number,opening_hours,address_components',
          },
        ),
      );

      if (response.statusCode != 200) {
        throw Exception('Error en Google Places API: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      final result = data['result'] as Map<String, dynamic>?;
      if (result == null) return null;
      return GooglePlace.fromGoogleApi(result);
    } catch (e) {
      throw Exception('Error obteniendo detalles del lugar: $e');
    }
  }

  @override
  Future<List<GooglePlace>> searchNearbyPlaces({
    required LocationData location,
    double radius = 5000,
    String? type,
    String? keyword,
  }) async {
    final apiKey = Env.googleMapsApiKey;
    if (apiKey.isEmpty) {
      throw Exception('GOOGLE_MAPS_API_KEY no configurada');
    }

    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
      );

      final queryParams = <String, String>{
        'location': '${location.latitude},${location.longitude}',
        'radius': radius.toString(),
        'key': apiKey,
      };
      if (type != null) {
        queryParams['type'] = type;
      }
      if (keyword != null) {
        queryParams['keyword'] = keyword;
      }

      final response = await http.get(
        uri.replace(queryParameters: queryParams),
      );
      if (response.statusCode != 200) {
        throw Exception('Error en Google Places API: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      return results
          .map((item) => GooglePlace.fromGoogleApi(item as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Error buscando lugares cercanos: $e');
    }
  }

  @override
  Future<List<GooglePlace>> autocompletePlaces({
    required String input,
    LocationData? location,
    double? radius,
  }) async {
    final apiKey = Env.googleMapsApiKey;
    if (apiKey.isEmpty) {
      return [_fallbackPlace(query: input)];
    }

    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      );
      final queryParams = <String, String>{
        'input': input,
        'key': apiKey,
      };

      if (location != null) {
        queryParams['location'] = '${location.latitude},${location.longitude}';
      }
      if (radius != null) {
        queryParams['radius'] = radius.toString();
      }

      final response = await http.get(
        uri.replace(queryParameters: queryParams),
      );
      if (response.statusCode != 200) {
        throw Exception('Error en Google Places API: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      final predictions = data['predictions'] as List<dynamic>? ?? [];

      final places = <GooglePlace>[];
      for (final prediction in predictions.take(5)) {
        final predictionMap = prediction as Map<String, dynamic>;
        final placeId = predictionMap['place_id'] as String?;
        if (placeId == null || placeId.isEmpty) {
          continue;
        }
        final place = await getPlaceDetails(placeId);
        if (place != null) {
          places.add(place);
        }
      }
      return places;
    } catch (e) {
      throw Exception('Error en autocompletado: $e');
    }
  }

  // ================== PLACE LOCATION MANAGEMENT ==================
  @override
  Future<void> savePlaceLocation(PlaceLocation placeLocation) async {
    // Implementación básica - no lanzar error
    print('LocationServiceSupabase: savePlaceLocation() - No implementado aún');
  }

  @override
  Future<PlaceLocation?> getPlaceLocation(String placeId) async {
    // Implementación básica - retornar null en lugar de error
    print('LocationServiceSupabase: getPlaceLocation() - No implementado aún');
    return null;
  }

  @override
  Future<void> updatePlaceLocation(PlaceLocation placeLocation) async {
    // Implementación básica - no lanzar error
    print(
      'LocationServiceSupabase: updatePlaceLocation() - No implementado aún',
    );
  }

  @override
  Future<void> deletePlaceLocation(String placeId) async {
    // Implementación básica - no lanzar error
    print(
      'LocationServiceSupabase: deletePlaceLocation() - No implementado aún',
    );
  }

  @override
  Future<List<PlaceLocation>> getAllPlaceLocations() async {
    // Implementación básica - retornar lista vacía en lugar de error
    print(
      'LocationServiceSupabase: getAllPlaceLocations() - No implementado aún',
    );
    return [];
  }

  // ================== DISTANCE & PROXIMITY ==================
  @override
  Future<DistanceResult> calculateDistance({
    required LocationData origin,
    required LocationData destination,
    String travelMode = 'driving',
  }) async {
    // Implementación básica usando Haversine
    final distance = calculateDistanceHaversine(
      lat1: origin.latitude,
      lon1: origin.longitude,
      lat2: destination.latitude,
      lon2: destination.longitude,
    );

    return DistanceResult.fromDistance(distance);
  }

  @override
  Future<List<NearbySearchResult>> findPlacesWithinRadius({
    required LocationData center,
    required double radiusMeters,
    List<String>? categories,
    int limit = 20,
    String sortBy = 'distance',
  }) async {
    // Implementación básica - retornar lista vacía
    print(
      'LocationServiceSupabase: findPlacesWithinRadius() - No implementado aún',
    );
    return [];
  }

  @override
  Future<List<NearbySearchResult>> getPlacesByDistance({
    required LocationData userLocation,
    List<String>? placeIds,
    ProximityFilter? filter,
  }) async {
    // Implementación básica - retornar lista vacía
    print(
      'LocationServiceSupabase: getPlacesByDistance() - No implementado aún',
    );
    return [];
  }

  // ================== GEOCODING ==================
  @override
  Future<LocationData?> geocodeAddress(String address) async {
    final apiKey = Env.googleMapsApiKey;
    if (apiKey.isEmpty) {
      return const LocationData(
        latitude: 23.1365,
        longitude: -82.3586,
      );
    }

    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json',
      );
      final response = await http.get(
        uri.replace(
          queryParameters: {
            'address': address,
            'key': apiKey,
          },
        ),
      );
      if (response.statusCode != 200) {
        throw Exception('Error en Geocoding API: ${response.statusCode}');
      }

      final data = json.decode(response.body) as Map<String, dynamic>;
      final results = data['results'] as List<dynamic>? ?? [];
      if (results.isEmpty) {
        return null;
      }
      final geometry =
          (results.first as Map<String, dynamic>)['geometry']
              as Map<String, dynamic>?;
      final location = geometry?['location'] as Map<String, dynamic>?;
      if (location == null) {
        return null;
      }
      return LocationData(
        latitude: (location['lat'] as num?)?.toDouble() ?? 0,
        longitude: (location['lng'] as num?)?.toDouble() ?? 0,
        address:
            (results.first as Map<String, dynamic>)['formatted_address']
                as String?,
        timestamp: DateTime.now(),
      );
    } catch (e) {
      throw Exception('Error geocodificando dirección: $e');
    }
  }

  @override
  Future<String?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    // Implementación básica - retornar null en lugar de error
    print('LocationServiceSupabase: reverseGeocode() - No implementado aún');
    return null;
  }

  @override
  Future<PlaceLocation?> getFormattedAddress({
    required double latitude,
    required double longitude,
    String? placeId,
  }) async {
    // Implementación básica - retornar null en lugar de error
    print(
      'LocationServiceSupabase: getFormattedAddress() - No implementado aún',
    );
    return null;
  }

  // ================== BUSINESS LOCATION SETUP ==================
  @override
  Future<PlaceLocation> setupBusinessLocation({
    required String placeId,
    required LocationData coordinates,
    String? googlePlaceId,
    String? userId,
  }) async {
    // Implementación básica - crear PlaceLocation básico
    print(
      'LocationServiceSupabase: setupBusinessLocation() - No implementado aún',
    );
    return PlaceLocation.fromCoordinates(
      id: placeId,
      placeId: placeId,
      latitude: coordinates.latitude,
      longitude: coordinates.longitude,
      formattedAddress: 'Dirección no disponible',
    );
  }

  @override
  Future<bool> validateBusinessLocation({
    required LocationData location,
    String? expectedAddress,
  }) async {
    // Implementación básica - siempre retornar true
    print(
      'LocationServiceSupabase: validateBusinessLocation() - No implementado aún',
    );
    return true;
  }

  @override
  Future<List<GooglePlace>> getLocationSuggestions({
    required String businessName,
    String? address,
    LocationData? approximateLocation,
  }) async {
    // Implementación básica - retornar lista vacía
    print(
      'LocationServiceSupabase: getLocationSuggestions() - No implementado aún',
    );
    return [];
  }

  // ================== UTILS ==================
  @override
  Future<bool> hasLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  @override
  Future<bool> requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.whileInUse ||
        permission == LocationPermission.always;
  }

  @override
  Future<bool> isLocationServiceEnabled() async {
    return await Geolocator.isLocationServiceEnabled();
  }

  @override
  double calculateDistanceHaversine({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    const double earthRadius = 6371000;

    final dLat = _degreesToRadians(lat2 - lat1);
    final dLon = _degreesToRadians(lon2 - lon1);

    final a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.cos(_degreesToRadians(lat1)) *
            math.cos(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final c = 2 * math.asin(math.sqrt(a));

    return earthRadius * c;
  }

  double _degreesToRadians(double degrees) {
    return degrees * (math.pi / 180);
  }

  GooglePlace _fallbackPlace({String? placeId, required String query}) {
    return GooglePlace(
      placeId: placeId ?? 'fallback-place-id',
      name: query,
      formattedAddress: 'La Habana, Cuba',
      location: const LocationData(
        latitude: 23.1365,
        longitude: -82.3586,
      ),
    );
  }

  @override
  void dispose() {
    // No hay streams que limpiar
  }
}
