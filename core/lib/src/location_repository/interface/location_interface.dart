import 'package:core/src/location_repository/models/location_data.dart';

/// Location repository interface
abstract class LocationInterface {
  /// Get current location
  Future<LocationData> getCurrentLocation();

  /// Start location tracking
  Future<void> startLocationTracking();

  /// Stop location tracking
  Future<void> stopLocationTracking();

  /// Stream that emits location updates
  Stream<LocationData> get locationStream;
}
