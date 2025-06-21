import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/place_location.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/google_place.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/distance_result.dart';

/// Location repository interface
abstract class LocationInterface {
  // ================== LOCATION TRACKING ==================

  /// Get current location
  Future<LocationData> getCurrentLocation();

  /// Start location tracking
  Future<void> startLocationTracking();

  /// Stop location tracking
  Future<void> stopLocationTracking();

  /// Stream that emits location updates
  Stream<LocationData> get locationStream;

  // ================== GOOGLE PLACES INTEGRATION ==================

  /// Search places using Google Places API
  Future<List<GooglePlace>> searchPlaces({
    required String query,
    LocationData? location,
    double? radius,
    String? type,
    String? language,
  });

  /// Get place details by Google Place ID
  Future<GooglePlace?> getPlaceDetails(String placeId);

  /// Search nearby places
  Future<List<GooglePlace>> searchNearbyPlaces({
    required LocationData location,
    double radius = 5000,
    String? type,
    String? keyword,
  });

  /// Autocomplete place search
  Future<List<GooglePlace>> autocompletePlaces({
    required String input,
    LocationData? location,
    double? radius,
  });

  // ================== PLACE LOCATION MANAGEMENT ==================

  /// Save place location to Firestore
  Future<void> savePlaceLocation(PlaceLocation placeLocation);

  /// Get place location by place ID
  Future<PlaceLocation?> getPlaceLocation(String placeId);

  /// Update place location
  Future<void> updatePlaceLocation(PlaceLocation placeLocation);

  /// Delete place location
  Future<void> deletePlaceLocation(String placeId);

  /// Get all place locations
  Future<List<PlaceLocation>> getAllPlaceLocations();

  // ================== DISTANCE & PROXIMITY ==================

  /// Calculate distance between two points
  Future<DistanceResult> calculateDistance({
    required LocationData origin,
    required LocationData destination,
    String travelMode = 'driving',
  });

  /// Find places within radius
  Future<List<NearbySearchResult>> findPlacesWithinRadius({
    required LocationData center,
    required double radiusMeters,
    List<String>? categories,
    int limit = 20,
    String sortBy = 'distance',
  });

  /// Get places sorted by distance from a point
  Future<List<NearbySearchResult>> getPlacesByDistance({
    required LocationData userLocation,
    List<String>? placeIds,
    ProximityFilter? filter,
  });

  // ================== GEOCODING ==================

  /// Convert address to coordinates (Geocoding)
  Future<LocationData?> geocodeAddress(String address);

  /// Convert coordinates to address (Reverse Geocoding)
  Future<String?> reverseGeocode({
    required double latitude,
    required double longitude,
  });

  /// Get formatted address from coordinates
  Future<PlaceLocation?> getFormattedAddress({
    required double latitude,
    required double longitude,
    String? placeId,
  });

  // ================== BUSINESS LOCATION SETUP ==================

  /// Set up business location for admin panel
  Future<PlaceLocation> setupBusinessLocation({
    required String placeId,
    required LocationData coordinates,
    String? googlePlaceId,
    String? userId,
  });

  /// Validate business location
  Future<bool> validateBusinessLocation({
    required LocationData location,
    String? expectedAddress,
  });

  /// Get location suggestions for business setup
  Future<List<GooglePlace>> getLocationSuggestions({
    required String businessName,
    String? address,
    LocationData? approximateLocation,
  });

  // ================== UTILS ==================

  /// Check if location permissions are granted
  Future<bool> hasLocationPermission();

  /// Request location permissions
  Future<bool> requestLocationPermission();

  /// Check if location services are enabled
  Future<bool> isLocationServiceEnabled();

  /// Get distance between two coordinates (Haversine formula)
  double calculateDistanceHaversine({
    required double lat1,
    required double lon1,
    required double lat2,
    required double lon2,
  });

  /// Dispose resources
  void dispose();
}
