import 'package:core/src/turbo_core_repositories/location_repository/interface/location_interface.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/place_location.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/google_place.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/distance_result.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:math' as math;

/// Servicio de ubicación usando Supabase
/// Implementa la misma interfaz que LocationService (Firebase)
class LocationServiceSupabase implements LocationInterface {
  LocationServiceSupabase({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabase;

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
        timestamp: position.timestamp ?? DateTime.now(),
      );
    } catch (e) {
      throw Exception('Error al obtener la ubicación: $e');
    }
  }

  @override
  Future<void> startLocationTracking() async {
    // TODO: Implementar si aplica
    throw UnimplementedError();
  }

  @override
  Future<void> stopLocationTracking() async {
    // TODO: Implementar si aplica
    throw UnimplementedError();
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
    // TODO: Implementar integración si se requiere (o delegar a Google API)
    throw UnimplementedError();
  }

  @override
  Future<GooglePlace?> getPlaceDetails(String placeId) async {
    // TODO: Implementar integración si se requiere
    throw UnimplementedError();
  }

  @override
  Future<List<GooglePlace>> searchNearbyPlaces({
    required LocationData location,
    double radius = 5000,
    String? type,
    String? keyword,
  }) async {
    // TODO: Implementar integración si se requiere
    throw UnimplementedError();
  }

  @override
  Future<List<GooglePlace>> autocompletePlaces({
    required String input,
    LocationData? location,
    double? radius,
  }) async {
    // TODO: Implementar integración si se requiere
    throw UnimplementedError();
  }

  // ================== PLACE LOCATION MANAGEMENT ==================
  @override
  Future<void> savePlaceLocation(PlaceLocation placeLocation) async {
    // TODO: Implementar guardado en tabla de Supabase
    throw UnimplementedError();
  }

  @override
  Future<PlaceLocation?> getPlaceLocation(String placeId) async {
    // TODO: Implementar consulta en Supabase
    throw UnimplementedError();
  }

  @override
  Future<void> updatePlaceLocation(PlaceLocation placeLocation) async {
    // TODO: Implementar actualización en Supabase
    throw UnimplementedError();
  }

  @override
  Future<void> deletePlaceLocation(String placeId) async {
    // TODO: Implementar borrado en Supabase
    throw UnimplementedError();
  }

  @override
  Future<List<PlaceLocation>> getAllPlaceLocations() async {
    // TODO: Implementar consulta de todos los lugares en Supabase
    throw UnimplementedError();
  }

  // ================== DISTANCE & PROXIMITY ==================
  @override
  Future<DistanceResult> calculateDistance({
    required LocationData origin,
    required LocationData destination,
    String travelMode = 'driving',
  }) async {
    // TODO: Implementar cálculo usando funciones de PostGIS o lógica local
    throw UnimplementedError();
  }

  @override
  Future<List<NearbySearchResult>> findPlacesWithinRadius({
    required LocationData center,
    required double radiusMeters,
    List<String>? categories,
    int limit = 20,
    String sortBy = 'distance',
  }) async {
    // TODO: Implementar consulta geoespacial en Supabase/PostGIS
    throw UnimplementedError();
  }

  @override
  Future<List<NearbySearchResult>> getPlacesByDistance({
    required LocationData userLocation,
    List<String>? placeIds,
    ProximityFilter? filter,
  }) async {
    // TODO: Implementar consulta geoespacial en Supabase/PostGIS
    throw UnimplementedError();
  }

  // ================== GEOCODING ==================
  @override
  Future<LocationData?> geocodeAddress(String address) async {
    // TODO: Implementar si se requiere (o delegar a Google API)
    throw UnimplementedError();
  }

  @override
  Future<String?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    // TODO: Implementar si se requiere (o delegar a Google API)
    throw UnimplementedError();
  }

  @override
  Future<PlaceLocation?> getFormattedAddress({
    required double latitude,
    required double longitude,
    String? placeId,
  }) async {
    // TODO: Implementar si se requiere (o delegar a Google API)
    throw UnimplementedError();
  }

  // ================== BUSINESS LOCATION SETUP ==================
  @override
  Future<PlaceLocation> setupBusinessLocation({
    required String placeId,
    required LocationData coordinates,
    String? googlePlaceId,
    String? userId,
  }) async {
    // TODO: Implementar lógica de setup en Supabase
    throw UnimplementedError();
  }

  @override
  Future<bool> validateBusinessLocation({
    required LocationData location,
    String? expectedAddress,
  }) async {
    // TODO: Implementar validación si aplica
    throw UnimplementedError();
  }

  @override
  Future<List<GooglePlace>> getLocationSuggestions({
    required String businessName,
    String? address,
    LocationData? approximateLocation,
  }) async {
    // TODO: Implementar si se requiere (o delegar a Google API)
    throw UnimplementedError();
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

    final a = math.sin(dLat / 2) * math.sin(dLat / 2) +
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

  @override
  void dispose() {
    // No hay streams que limpiar
  }
}
