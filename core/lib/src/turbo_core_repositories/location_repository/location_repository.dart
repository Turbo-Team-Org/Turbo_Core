import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';
import 'package:core/src/turbo_core_repositories/location_repository/service/location_service.dart';

/// Location repository
class LocationRepository {
  /// Constructor
  LocationRepository({LocationService? locationService})
    : _locationService = locationService ?? LocationService();

  /// Location service
  final LocationService _locationService;

  /// Get current location
  Future<LocationData> getCurrentLocation() {
    return _locationService.getCurrentLocation();
  }

  /// Start location tracking
  Future<void> startLocationTracking() {
    return _locationService.startLocationTracking();
  }

  /// Stop location tracking
  Future<void> stopLocationTracking() {
    return _locationService.stopLocationTracking();
  }

  /// Get location stream
  Stream<LocationData> get locationStream => _locationService.locationStream;

  /// Dispose
  void dispose() {
    _locationService.dispose();
  }
}
