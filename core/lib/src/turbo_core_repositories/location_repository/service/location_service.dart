import 'dart:async';
import 'dart:convert';
import 'dart:math' as math;
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';

import 'package:core/src/turbo_core_repositories/location_repository/interface/location_interface.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/place_location.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/google_place.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/distance_result.dart';

/// Location service with Google Maps integration
class LocationService implements LocationInterface {
  LocationService({FirebaseFirestore? firestore, String? googleMapsApiKey})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _googleMapsApiKey = googleMapsApiKey ?? _defaultApiKey {
    _initialize();
  }

  static const String _defaultApiKey =
      'YOUR_GOOGLE_MAPS_API_KEY'; // Replace with actual key

  final FirebaseFirestore _firestore;
  final String _googleMapsApiKey;
  final _locationController = StreamController<LocationData>.broadcast();
  StreamSubscription<Position>? _positionSubscription;

  // Firestore collections
  late final CollectionReference _placeLocationsRef;

  void _initialize() {
    _placeLocationsRef = _firestore.collection('place_locations');
    _checkInitialPermission();
  }

  Future<void> _checkInitialPermission() async {
    try {
      if (await hasLocationPermission()) {
        final position = await getCurrentLocation();
        _locationController.add(position);
      }
    } catch (e) {
      // Ignore initial location errors
    }
  }

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
    if (!await hasLocationPermission()) {
      throw Exception('Permisos de ubicación requeridos');
    }

    _positionSubscription?.cancel();

    _positionSubscription = Geolocator.getPositionStream(
      locationSettings: const LocationSettings(
        accuracy: LocationAccuracy.high,
        distanceFilter: 10, // Update every 10 meters
      ),
    ).listen(
      (Position position) {
        final locationData = LocationData(
          latitude: position.latitude,
          longitude: position.longitude,
          accuracy: position.accuracy,
          altitude: position.altitude,
          speed: position.speed,
          heading: position.heading,
          timestamp: position.timestamp ?? DateTime.now(),
        );
        _locationController.add(locationData);
      },
      onError: (error) {
        // Handle location stream errors
      },
    );
  }

  @override
  Future<void> stopLocationTracking() async {
    await _positionSubscription?.cancel();
    _positionSubscription = null;
  }

  @override
  Stream<LocationData> get locationStream => _locationController.stream;

  // ================== GOOGLE PLACES INTEGRATION ==================

  @override
  Future<List<GooglePlace>> searchPlaces({
    required String query,
    LocationData? location,
    double? radius,
    String? type,
    String? language,
  }) async {
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json',
      );

      final queryParams = <String, String>{
        'query': query,
        'key': _googleMapsApiKey,
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

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>? ?? [];

        return results
            .map(
              (result) =>
                  GooglePlace.fromGoogleApi(result as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception('Error en Google Places API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error buscando lugares: $e');
    }
  }

  @override
  Future<GooglePlace?> getPlaceDetails(String placeId) async {
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/details/json',
      );

      final response = await http.get(
        uri.replace(
          queryParameters: {
            'place_id': placeId,
            'key': _googleMapsApiKey,
            'fields':
                'place_id,name,formatted_address,geometry,types,rating,user_ratings_total,photos,website,formatted_phone_number,opening_hours,address_components',
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final result = data['result'] as Map<String, dynamic>?;

        if (result != null) {
          return GooglePlace.fromGoogleApi(result);
        }
      }

      return null;
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
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/nearbysearch/json',
      );

      final queryParams = <String, String>{
        'location': '${location.latitude},${location.longitude}',
        'radius': radius.toString(),
        'key': _googleMapsApiKey,
      };

      if (type != null) queryParams['type'] = type;
      if (keyword != null) queryParams['keyword'] = keyword;

      final response = await http.get(
        uri.replace(queryParameters: queryParams),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>? ?? [];

        return results
            .map(
              (result) =>
                  GooglePlace.fromGoogleApi(result as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception('Error en Google Places API: ${response.statusCode}');
      }
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
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/autocomplete/json',
      );

      final queryParams = <String, String>{
        'input': input,
        'key': _googleMapsApiKey,
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

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final predictions = data['predictions'] as List<dynamic>? ?? [];

        // Para autocomplete, necesitamos obtener los detalles de cada predicción
        final places = <GooglePlace>[];
        for (final prediction in predictions.take(5)) {
          // Limitar a 5 resultados
          final placeId = prediction['place_id'] as String;
          final place = await getPlaceDetails(placeId);
          if (place != null) {
            places.add(place);
          }
        }

        return places;
      } else {
        throw Exception('Error en Google Places API: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error en autocompletado: $e');
    }
  }

  // ================== PLACE LOCATION MANAGEMENT ==================

  @override
  Future<void> savePlaceLocation(PlaceLocation placeLocation) async {
    try {
      await _placeLocationsRef
          .doc(placeLocation.placeId)
          .set(placeLocation.toFirestore());
    } catch (e) {
      throw Exception('Error guardando ubicación: $e');
    }
  }

  @override
  Future<PlaceLocation?> getPlaceLocation(String placeId) async {
    try {
      final doc = await _placeLocationsRef.doc(placeId).get();

      if (doc.exists && doc.data() != null) {
        return PlaceLocation.fromFirestore(doc.data()! as Map<String, dynamic>);
      }

      return null;
    } catch (e) {
      throw Exception('Error obteniendo ubicación: $e');
    }
  }

  @override
  Future<void> updatePlaceLocation(PlaceLocation placeLocation) async {
    try {
      final updatedLocation = placeLocation.copyWith(updatedAt: DateTime.now());

      await _placeLocationsRef
          .doc(placeLocation.placeId)
          .update(updatedLocation.toFirestore());
    } catch (e) {
      throw Exception('Error actualizando ubicación: $e');
    }
  }

  @override
  Future<void> deletePlaceLocation(String placeId) async {
    try {
      await _placeLocationsRef.doc(placeId).delete();
    } catch (e) {
      throw Exception('Error eliminando ubicación: $e');
    }
  }

  @override
  Future<List<PlaceLocation>> getAllPlaceLocations() async {
    try {
      final querySnapshot = await _placeLocationsRef.get();

      return querySnapshot.docs
          .map(
            (doc) => PlaceLocation.fromFirestore(
              doc.data()! as Map<String, dynamic>,
            ),
          )
          .toList();
    } catch (e) {
      throw Exception('Error obteniendo ubicaciones: $e');
    }
  }

  // ================== DISTANCE & PROXIMITY ==================

  @override
  Future<DistanceResult> calculateDistance({
    required LocationData origin,
    required LocationData destination,
    String travelMode = 'driving',
  }) async {
    try {
      // First calculate Haversine distance
      final haversineDistance = calculateDistanceHaversine(
        lat1: origin.latitude,
        lon1: origin.longitude,
        lat2: destination.latitude,
        lon2: destination.longitude,
      );

      // Try to get more accurate distance from Google Distance Matrix API
      try {
        final uri = Uri.parse(
          'https://maps.googleapis.com/maps/api/distancematrix/json',
        );

        final response = await http.get(
          uri.replace(
            queryParameters: {
              'origins': '${origin.latitude},${origin.longitude}',
              'destinations':
                  '${destination.latitude},${destination.longitude}',
              'mode': travelMode,
              'key': _googleMapsApiKey,
            },
          ),
        );

        if (response.statusCode == 200) {
          final data = json.decode(response.body) as Map<String, dynamic>;
          final rows = data['rows'] as List<dynamic>? ?? [];

          if (rows.isNotEmpty) {
            final elements = rows.first['elements'] as List<dynamic>? ?? [];
            if (elements.isNotEmpty) {
              final element = elements.first as Map<String, dynamic>;
              if (element['status'] == 'OK') {
                return DistanceResult.fromGoogleApi(element);
              }
            }
          }
        }
      } catch (e) {
        // Fall back to Haversine calculation
      }

      // Fallback to Haversine calculation
      return DistanceResult.fromDistance(haversineDistance);
    } catch (e) {
      throw Exception('Error calculando distancia: $e');
    }
  }

  @override
  Future<List<NearbySearchResult>> findPlacesWithinRadius({
    required LocationData center,
    required double radiusMeters,
    List<String>? categories,
    int limit = 20,
    String sortBy = 'distance',
  }) async {
    try {
      // Get all place locations from Firestore
      final allPlaces = await getAllPlaceLocations();
      final nearbyPlaces = <NearbySearchResult>[];

      for (final place in allPlaces) {
        final distance = calculateDistanceHaversine(
          lat1: center.latitude,
          lon1: center.longitude,
          lat2: place.coordinates.latitude,
          lon2: place.coordinates.longitude,
        );

        if (distance <= radiusMeters) {
          nearbyPlaces.add(
            NearbySearchResult(
              placeId: place.placeId,
              name: place.city ?? 'Lugar',
              distance: DistanceResult.fromDistance(distance),
              latitude: place.coordinates.latitude,
              longitude: place.coordinates.longitude,
              address: place.formattedAddress,
            ),
          );
        }
      }

      // Sort by distance
      if (sortBy == 'distance') {
        nearbyPlaces.sort(
          (a, b) =>
              a.distance.distanceMeters.compareTo(b.distance.distanceMeters),
        );
      }

      return nearbyPlaces.take(limit).toList();
    } catch (e) {
      throw Exception('Error buscando lugares cercanos: $e');
    }
  }

  @override
  Future<List<NearbySearchResult>> getPlacesByDistance({
    required LocationData userLocation,
    List<String>? placeIds,
    ProximityFilter? filter,
  }) async {
    try {
      List<PlaceLocation> places;

      if (placeIds != null && placeIds.isNotEmpty) {
        // Get specific places
        places = [];
        for (final placeId in placeIds) {
          final place = await getPlaceLocation(placeId);
          if (place != null) {
            places.add(place);
          }
        }
      } else {
        // Get all places
        places = await getAllPlaceLocations();
      }

      final results = <NearbySearchResult>[];

      for (final place in places) {
        final distance = calculateDistanceHaversine(
          lat1: userLocation.latitude,
          lon1: userLocation.longitude,
          lat2: place.coordinates.latitude,
          lon2: place.coordinates.longitude,
        );

        // Apply filter if provided
        if (filter != null &&
            !filter.isWithinRadius(
              place.coordinates.latitude,
              place.coordinates.longitude,
            )) {
          continue;
        }

        results.add(
          NearbySearchResult(
            placeId: place.placeId,
            name: place.city ?? 'Lugar',
            distance: DistanceResult.fromDistance(distance),
            latitude: place.coordinates.latitude,
            longitude: place.coordinates.longitude,
            address: place.formattedAddress,
          ),
        );
      }

      // Sort by distance
      results.sort(
        (a, b) =>
            a.distance.distanceMeters.compareTo(b.distance.distanceMeters),
      );

      final limit = filter?.limit ?? 20;
      return results.take(limit).toList();
    } catch (e) {
      throw Exception('Error obteniendo lugares por distancia: $e');
    }
  }

  // ================== GEOCODING ==================

  @override
  Future<LocationData?> geocodeAddress(String address) async {
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json',
      );

      final response = await http.get(
        uri.replace(
          queryParameters: {'address': address, 'key': _googleMapsApiKey},
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>? ?? [];

        if (results.isNotEmpty) {
          final result = results.first as Map<String, dynamic>;
          final geometry = result['geometry'] as Map<String, dynamic>;
          final location = geometry['location'] as Map<String, dynamic>;

          return LocationData(
            latitude: (location['lat'] as num).toDouble(),
            longitude: (location['lng'] as num).toDouble(),
            address: result['formatted_address'] as String?,
            timestamp: DateTime.now(),
          );
        }
      }

      return null;
    } catch (e) {
      throw Exception('Error en geocodificación: $e');
    }
  }

  @override
  Future<String?> reverseGeocode({
    required double latitude,
    required double longitude,
  }) async {
    try {
      final uri = Uri.parse(
        'https://maps.googleapis.com/maps/api/geocode/json',
      );

      final response = await http.get(
        uri.replace(
          queryParameters: {
            'latlng': '$latitude,$longitude',
            'key': _googleMapsApiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        final results = data['results'] as List<dynamic>? ?? [];

        if (results.isNotEmpty) {
          final result = results.first as Map<String, dynamic>;
          return result['formatted_address'] as String?;
        }
      }

      return null;
    } catch (e) {
      throw Exception('Error en geocodificación inversa: $e');
    }
  }

  @override
  Future<PlaceLocation?> getFormattedAddress({
    required double latitude,
    required double longitude,
    String? placeId,
  }) async {
    try {
      final address = await reverseGeocode(
        latitude: latitude,
        longitude: longitude,
      );

      if (address != null) {
        return PlaceLocation.fromCoordinates(
          id: placeId ?? DateTime.now().millisecondsSinceEpoch.toString(),
          placeId: placeId ?? '',
          latitude: latitude,
          longitude: longitude,
          formattedAddress: address,
        );
      }

      return null;
    } catch (e) {
      throw Exception('Error obteniendo dirección formateada: $e');
    }
  }

  // ================== BUSINESS LOCATION SETUP ==================

  @override
  Future<PlaceLocation> setupBusinessLocation({
    required String placeId,
    required LocationData coordinates,
    String? googlePlaceId,
    String? userId,
  }) async {
    try {
      // Get formatted address
      final formattedLocation = await getFormattedAddress(
        latitude: coordinates.latitude,
        longitude: coordinates.longitude,
        placeId: placeId,
      );

      PlaceLocation placeLocation;

      if (googlePlaceId != null) {
        // Get detailed information from Google Places
        final googlePlace = await getPlaceDetails(googlePlaceId);

        if (googlePlace != null) {
          placeLocation = PlaceLocation(
            id: DateTime.now().millisecondsSinceEpoch.toString(),
            placeId: placeId,
            coordinates: coordinates,
            formattedAddress: googlePlace.formattedAddress,
            streetNumber: googlePlace.getAddressComponent('street_number'),
            streetName: googlePlace.getAddressComponent('route'),
            neighborhood: googlePlace.getAddressComponent('neighborhood'),
            city: googlePlace.city,
            state: googlePlace.state,
            country: googlePlace.country,
            postalCode: googlePlace.postalCode,
            googlePlaceId: googlePlaceId,
            addressComponents:
                googlePlace.addressComponents
                    .map((c) => c['long_name'] as String? ?? '')
                    .toList(),
            plusCode: googlePlace.plusCode,
            createdAt: DateTime.now(),
            createdBy: userId,
          );
        } else {
          // Fallback to basic location
          placeLocation =
              formattedLocation?.copyWith(
                placeId: placeId,
                createdBy: userId,
              ) ??
              PlaceLocation.fromCoordinates(
                id: DateTime.now().millisecondsSinceEpoch.toString(),
                placeId: placeId,
                latitude: coordinates.latitude,
                longitude: coordinates.longitude,
                formattedAddress:
                    '${coordinates.latitude}, ${coordinates.longitude}',
              );
        }
      } else {
        // Use basic geocoding
        placeLocation =
            formattedLocation?.copyWith(placeId: placeId, createdBy: userId) ??
            PlaceLocation.fromCoordinates(
              id: DateTime.now().millisecondsSinceEpoch.toString(),
              placeId: placeId,
              latitude: coordinates.latitude,
              longitude: coordinates.longitude,
              formattedAddress:
                  '${coordinates.latitude}, ${coordinates.longitude}',
            );
      }

      // Save to Firestore
      await savePlaceLocation(placeLocation);

      return placeLocation;
    } catch (e) {
      throw Exception('Error configurando ubicación del negocio: $e');
    }
  }

  @override
  Future<bool> validateBusinessLocation({
    required LocationData location,
    String? expectedAddress,
  }) async {
    try {
      if (expectedAddress == null) return true;

      final actualAddress = await reverseGeocode(
        latitude: location.latitude,
        longitude: location.longitude,
      );

      if (actualAddress == null) return false;

      // Simple validation - check if key components match
      final expectedLower = expectedAddress.toLowerCase();
      final actualLower = actualAddress.toLowerCase();

      return actualLower.contains(expectedLower) ||
          expectedLower.contains(actualLower);
    } catch (e) {
      return false;
    }
  }

  @override
  Future<List<GooglePlace>> getLocationSuggestions({
    required String businessName,
    String? address,
    LocationData? approximateLocation,
  }) async {
    try {
      final searchQuery =
          address != null ? '$businessName $address' : businessName;

      return await searchPlaces(
        query: searchQuery,
        location: approximateLocation,
        radius: approximateLocation != null ? 5000 : null,
      );
    } catch (e) {
      throw Exception('Error obteniendo sugerencias de ubicación: $e');
    }
  }

  // ================== UTILS ==================

  @override
  Future<bool> hasLocationPermission() async {
    final permission = await Geolocator.checkPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
  }

  @override
  Future<bool> requestLocationPermission() async {
    final permission = await Geolocator.requestPermission();
    return permission == LocationPermission.always ||
        permission == LocationPermission.whileInUse;
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
    const double earthRadius = 6371000; // Earth radius in meters

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

  @override
  void dispose() {
    _positionSubscription?.cancel();
    _locationController.close();
  }
}
