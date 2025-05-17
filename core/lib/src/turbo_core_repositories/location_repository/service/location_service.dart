import 'dart:async';

import 'package:core/src/turbo_core_repositories/location_repository/interface/location_interface.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';
import 'package:geolocator/geolocator.dart';

/// Location service
class LocationService implements LocationInterface {
  /// Constructor
  LocationService() {
    // Initialize the service
    _checkPermission();
  }
  final _locationController = StreamController<LocationData>.broadcast();

  Future<void> _checkPermission() async {
    // Assuming we already have permission, get the initial location
    try {
      final position = await getCurrentLocation();
      _locationController.add(position);
    } catch (e) {
      // Ignore initial location errors
    }
  }

  @override
  Future<LocationData> getCurrentLocation() async {
    try {
      final position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
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
    // Start location tracking
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // update every 10 meters of movement
      ),
    ).listen((Position position) {
      // Convert to our model and emit to the stream
      final locationData = LocationData(
        latitude: position.latitude,
        longitude: position.longitude,
        accuracy: position.accuracy,
        altitude: position.altitude,
        speed: position.speed,
        heading: position.heading,
        timestamp: position.timestamp,
      );

      _locationController.add(locationData);
    });
  }

  @override
  Future<void> stopLocationTracking() async {
    // We don't need to do anything specific to stop the tracking
    // since the Flutter/Dart system will clean up the listeners
    // when the instance is destroyed
  }

  @override
  Stream<LocationData> get locationStream => _locationController.stream;

  /// Dispose
  void dispose() {
    _locationController.close();
  }
}
