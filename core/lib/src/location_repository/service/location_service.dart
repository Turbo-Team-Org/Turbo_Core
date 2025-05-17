import 'dart:async';

import 'package:core/src/location_repository/models/location_data.dart';
import 'package:core/src/location_repository/interface/location_interface.dart';
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
        desiredAccuracy: LocationAccuracy.high,
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
  Future<bool> checkLocationPermission() async {
    try {
      // Verificar si los servicios de ubicación están habilitados
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        return false;
      }

      // Verificar el estado del permiso
      LocationPermission permission = await Geolocator.checkPermission();

      // Verificar también con permission_handler
      final status = await Permission.location.status;

      return (permission == LocationPermission.whileInUse ||
              permission == LocationPermission.always) &&
          (status.isGranted || status.isLimited);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> startLocationTracking() async {
    // Verificar que tenemos permiso
    final hasPermission = await checkLocationPermission();
    if (!hasPermission) {
      throw Exception('No se tienen permisos para rastrear la ubicación');
    }

    // Iniciar la suscripción a las actualizaciones de ubicación
    Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // actualiza cada 10 metros de movimiento
      ),
    ).listen((Position position) {
      // Convertir a nuestro modelo y emitir al stream
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
    // No necesitamos hacer nada específico para detener el rastreo
    // ya que el sistema de Flutter/Dart se encargará de limpiar los listeners
    // al destruir la instancia
  }

  @override
  Stream<LocationData> get locationStream => _locationController.stream;

  // Limpieza de recursos
  void dispose() {
    _locationController.close();
  }
}
