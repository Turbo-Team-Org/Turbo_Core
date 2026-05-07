import 'package:core/src/turbo_core_repositories/location_repository/interface/location_interface.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/place_location.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/google_place.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/distance_result.dart';

/// Location repository with Google Maps integration
///
/// Provides comprehensive location services including:
/// - Device location tracking
/// - Google Places search and autocomplete
/// - Business location management
/// - Distance calculations and proximity search
/// - Geocoding and reverse geocoding
class LocationRepository implements LocationInterface {
  /// Constructor
  LocationRepository({
    required LocationInterface locationService,
  }) : _locationService = locationService;

  /// Location service (now accepts interface for environment flexibility)
  final LocationInterface _locationService;

  // ================== LOCATION TRACKING ==================

  @override
  Future<LocationData> getCurrentLocation() {
    return _locationService.getCurrentLocation();
  }

  @override
  Future<void> startLocationTracking() {
    return _locationService.startLocationTracking();
  }

  @override
  Future<void> stopLocationTracking() {
    return _locationService.stopLocationTracking();
  }

  @override
  Stream<LocationData> get locationStream => _locationService.locationStream;

  // ================== GOOGLE PLACES INTEGRATION ==================

  @override
  Future<List<GooglePlace>> searchPlaces({
    required String query,
    LocationData? location,
    double? radius,
    String? type,
    String? language,
  }) {
    return _locationService.searchPlaces(
      query: query,
      location: location,
      radius: radius,
      type: type,
      language: language,
    );
  }

  @override
  Future<GooglePlace?> getPlaceDetails(String placeId) {
    return _locationService.getPlaceDetails(placeId);
  }

  @override
  Future<List<GooglePlace>> searchNearbyPlaces({
    required LocationData location,
    double radius = 5000,
    String? type,
    String? keyword,
  }) {
    return _locationService.searchNearbyPlaces(
      location: location,
      radius: radius,
      type: type,
      keyword: keyword,
    );
  }

  @override
  Future<List<GooglePlace>> autocompletePlaces({
    required String input,
    LocationData? location,
    double? radius,
  }) {
    return _locationService.autocompletePlaces(
      input: input,
      location: location,
      radius: radius,
    );
  }

  // ================== PLACE LOCATION MANAGEMENT ==================

  @override
  Future<void> savePlaceLocation(PlaceLocation placeLocation) {
    return _locationService.savePlaceLocation(placeLocation);
  }

  @override
  Future<PlaceLocation?> getPlaceLocation(String placeId) {
    return _locationService.getPlaceLocation(placeId);
  }

  @override
  Future<void> updatePlaceLocation(PlaceLocation placeLocation) {
    return _locationService.updatePlaceLocation(placeLocation);
  }

  @override
  Future<void> deletePlaceLocation(String placeId) {
    return _locationService.deletePlaceLocation(placeId);
  }

  @override
  Future<List<PlaceLocation>> getAllPlaceLocations() {
    return _locationService.getAllPlaceLocations();
  }

  // ================== DISTANCE & PROXIMITY ==================

  @override
  Future<DistanceResult> calculateDistance({
    required LocationData origin,
    required LocationData destination,
    String travelMode = 'driving',
  }) {
    return _locationService.calculateDistance(
      origin: origin,
      destination: destination,
      travelMode: travelMode,
    );
  }

  @override
  Future<List<NearbySearchResult>> findPlacesWithinRadius({
    required LocationData center,
    required double radiusMeters,
    List<String>? categories,
    int limit = 20,
    String sortBy = 'distance',
  }) {
    return _locationService.findPlacesWithinRadius(
      center: center,
      radiusMeters: radiusMeters,
      categories: categories,
      limit: limit,
      sortBy: sortBy,
    );
  }

  @override
  Future<List<NearbySearchResult>> getPlacesByDistance({
    required LocationData userLocation,
    List<String>? placeIds,
    ProximityFilter? filter,
  }) {
    return _locationService.getPlacesByDistance(
      userLocation: userLocation,
      placeIds: placeIds,
      filter: filter,
    );
  }

  // ================== GEOCODING ==================

  @override
  Future<LocationData?> geocodeAddress(String address) {
    return _locationService.geocodeAddress(address);
  }

  @override
  Future<String?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) {
    return _locationService.reverseGeocode(
      latitude: latitude,
      longitude: longitude,
    );
  }

  @override
  Future<PlaceLocation?> getFormattedAddress({
    required double latitude,
    required double longitude,
    String? placeId,
  }) {
    return _locationService.getFormattedAddress(
      latitude: latitude,
      longitude: longitude,
      placeId: placeId,
    );
  }

  // ================== BUSINESS LOCATION SETUP ==================

  @override
  Future<PlaceLocation> setupBusinessLocation({
    required String placeId,
    required LocationData coordinates,
    String? googlePlaceId,
    String? userId,
  }) {
    return _locationService.setupBusinessLocation(
      placeId: placeId,
      coordinates: coordinates,
      googlePlaceId: googlePlaceId,
      userId: userId,
    );
  }

  @override
  Future<bool> validateBusinessLocation({
    required LocationData location,
    String? expectedAddress,
  }) {
    return _locationService.validateBusinessLocation(
      location: location,
      expectedAddress: expectedAddress,
    );
  }

  @override
  Future<List<GooglePlace>> getLocationSuggestions({
    required String businessName,
    String? address,
    LocationData? approximateLocation,
  }) {
    return _locationService.getLocationSuggestions(
      businessName: businessName,
      address: address,
      approximateLocation: approximateLocation,
    );
  }

  // ================== UTILS ==================

  @override
  Future<bool> hasLocationPermission() {
    return _locationService.hasLocationPermission();
  }

  @override
  Future<bool> requestLocationPermission() {
    return _locationService.requestLocationPermission();
  }

  @override
  Future<bool> isLocationServiceEnabled() {
    return _locationService.isLocationServiceEnabled();
  }

  @override
  double calculateDistanceHaversine({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  }) {
    return _locationService.calculateDistanceHaversine(
      lat1: lat1,
      lon1: lon1,
      lat2: lat2,
      lon2: lon2,
    );
  }

  // ================== HELPER METHODS ==================

  /// Obtener lugares cercanos con filtros avanzados
  Future<List<NearbySearchResult>> getNearbyBusinesses({
    required LocationData userLocation,
    double radiusKm = 5.0,
    List<String>? categories,
    int maxResults = 20,
    double? minRating,
  }) async {
    final filter = ProximityFilter(
      latitude: userLocation.latitude,
      longitude: userLocation.longitude,
      radiusMeters: radiusKm * 1000,
      limit: maxResults,
      categories: categories ?? [],
      minRating: minRating,
      sortBy: 'distance',
    );

    return getPlacesByDistance(userLocation: userLocation, filter: filter);
  }

  /// Buscar lugares con autocompletado inteligente
  Future<List<GooglePlace>> searchWithAutocomplete({
    required String query,
    LocationData? userLocation,
    int maxResults = 5,
  }) async {
    if (query.length < 3) return [];

    // Try autocomplete first
    final autocompleteResults = await autocompletePlaces(
      input: query,
      location: userLocation,
      radius: userLocation != null ? 10000 : null,
    );

    if (autocompleteResults.isNotEmpty) {
      return autocompleteResults.take(maxResults).toList();
    }

    // Fallback to text search
    final searchResults = await searchPlaces(
      query: query,
      location: userLocation,
      radius: userLocation != null ? 10000 : null,
    );

    return searchResults.take(maxResults).toList();
  }

  /// Configurar ubicación de negocio con validación
  Future<PlaceLocation> setupAndValidateBusinessLocation({
    required String placeId,
    required String businessName,
    required LocationData coordinates,
    String? expectedAddress,
    String? userId,
  }) async {
    // 1. Validate the location if expected address is provided
    if (expectedAddress != null) {
      final isValid = await validateBusinessLocation(
        location: coordinates,
        expectedAddress: expectedAddress,
      );

      if (!isValid) {
        throw Exception('La ubicación no coincide con la dirección esperada');
      }
    }

    // 2. Try to get Google Place suggestions
    String? googlePlaceId;
    final suggestions = await getLocationSuggestions(
      businessName: businessName,
      approximateLocation: coordinates,
    );

    if (suggestions.isNotEmpty) {
      // Use the first suggestion that's close to the provided coordinates
      for (final suggestion in suggestions) {
        final distance = calculateDistanceHaversine(
          lat1: coordinates.latitude,
          lon1: coordinates.longitude,
          lat2: suggestion.location.latitude,
          lon2: suggestion.location.longitude,
        );

        // If within 100 meters, use this Google Place ID
        if (distance <= 100) {
          googlePlaceId = suggestion.placeId;
          break;
        }
      }
    }

    // 3. Setup the business location
    return setupBusinessLocation(
      placeId: placeId,
      coordinates: coordinates,
      googlePlaceId: googlePlaceId,
      userId: userId,
    );
  }

  /// Obtener distancia legible entre dos lugares
  Future<String> getReadableDistance({
    required LocationData origin,
    required LocationData destination,
    String travelMode = 'driving',
  }) async {
    final result = await calculateDistance(
      origin: origin,
      destination: destination,
      travelMode: travelMode,
    );

    return result.fullDescription;
  }

  @override
  void dispose() {
    _locationService.dispose();
  }
}
