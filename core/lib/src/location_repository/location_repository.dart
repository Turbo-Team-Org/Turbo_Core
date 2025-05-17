import 'models/location_data.dart';
import 'interface/location_interface.dart';
import 'service/location_service.dart';

class LocationRepository implements LocationRepositoryInterface {
  final LocationService _locationService;

  LocationRepository({LocationService? locationService})
    : _locationService = locationService ?? LocationService();

  @override
  Future<LocationData> getCurrentLocation() {
    return _locationService.getCurrentLocation();
  }

  @override
  Future<bool> requestLocationPermission() {
    return _locationService.requestLocationPermission();
  }

  @override
  Future<bool> checkLocationPermission() {
    return _locationService.checkLocationPermission();
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

  void dispose() {
    _locationService.dispose();
  }
}
