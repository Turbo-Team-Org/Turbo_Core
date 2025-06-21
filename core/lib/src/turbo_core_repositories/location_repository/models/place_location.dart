import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';

part 'place_location.freezed.dart';
part 'place_location.g.dart';

/// Ubicación de un lugar/negocio con información completa
@freezed
sealed class PlaceLocation with _$PlaceLocation {
  const factory PlaceLocation({
    required String id,
    required String placeId, // ID del lugar/negocio
    required LocationData coordinates,
    required String formattedAddress,
    String? streetNumber,
    String? streetName,
    String? neighborhood,
    String? city,
    String? state,
    String? country,
    String? postalCode,
    String? googlePlaceId, // ID de Google Places API
    @Default([]) List<String> addressComponents,
    String? plusCode, // Google Plus Code
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    Map<String, dynamic>? metadata,
  }) = _PlaceLocation;

  const PlaceLocation._();

  factory PlaceLocation.fromJson(Map<String, dynamic> json) =>
      _$PlaceLocationFromJson(json);

  /// Dirección completa formateada
  String get fullAddress {
    final parts = <String>[];

    if (streetNumber?.isNotEmpty == true && streetName?.isNotEmpty == true) {
      parts.add('$streetNumber $streetName');
    } else if (streetName?.isNotEmpty == true) {
      parts.add(streetName!);
    }

    if (neighborhood?.isNotEmpty == true) parts.add(neighborhood!);
    if (city?.isNotEmpty == true) parts.add(city!);
    if (state?.isNotEmpty == true) parts.add(state!);
    if (country?.isNotEmpty == true) parts.add(country!);
    if (postalCode?.isNotEmpty == true) parts.add(postalCode!);

    return parts.join(', ');
  }

  /// Dirección resumida (solo ciudad, estado)
  String get shortAddress {
    final parts = <String>[];
    if (city?.isNotEmpty == true) parts.add(city!);
    if (state?.isNotEmpty == true) parts.add(state!);
    return parts.join(', ');
  }

  /// Crear PlaceLocation desde coordenadas básicas
  factory PlaceLocation.fromCoordinates({
    required String id,
    required String placeId,
    required double latitude,
    required double longitude,
    String? formattedAddress,
  }) {
    return PlaceLocation(
      id: id,
      placeId: placeId,
      coordinates: LocationData(
        latitude: latitude,
        longitude: longitude,
        timestamp: DateTime.now(),
      ),
      formattedAddress: formattedAddress ?? '$latitude, $longitude',
      createdAt: DateTime.now(),
    );
  }

  /// Crear PlaceLocation para Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'placeId': placeId,
      'coordinates': {
        'latitude': coordinates.latitude,
        'longitude': coordinates.longitude,
        'accuracy': coordinates.accuracy,
        'timestamp': coordinates.timestamp?.toIso8601String(),
      },
      'formattedAddress': formattedAddress,
      'streetNumber': streetNumber,
      'streetName': streetName,
      'neighborhood': neighborhood,
      'city': city,
      'state': state,
      'country': country,
      'postalCode': postalCode,
      'googlePlaceId': googlePlaceId,
      'addressComponents': addressComponents,
      'plusCode': plusCode,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'createdBy': createdBy,
      'metadata': metadata,
    };
  }

  /// Crear PlaceLocation desde Firestore
  factory PlaceLocation.fromFirestore(Map<String, dynamic> data) {
    final coords = data['coordinates'] as Map<String, dynamic>? ?? {};

    return PlaceLocation(
      id: data['id'] as String,
      placeId: data['placeId'] as String,
      coordinates: LocationData(
        latitude: (coords['latitude'] as num).toDouble(),
        longitude: (coords['longitude'] as num).toDouble(),
        accuracy: coords['accuracy'] as double?,
        timestamp:
            coords['timestamp'] != null
                ? DateTime.parse(coords['timestamp'] as String)
                : null,
      ),
      formattedAddress: data['formattedAddress'] as String,
      streetNumber: data['streetNumber'] as String?,
      streetName: data['streetName'] as String?,
      neighborhood: data['neighborhood'] as String?,
      city: data['city'] as String?,
      state: data['state'] as String?,
      country: data['country'] as String?,
      postalCode: data['postalCode'] as String?,
      googlePlaceId: data['googlePlaceId'] as String?,
      addressComponents:
          (data['addressComponents'] as List<dynamic>?)?.cast<String>() ?? [],
      plusCode: data['plusCode'] as String?,
      createdAt:
          data['createdAt'] != null
              ? DateTime.parse(data['createdAt'] as String)
              : null,
      updatedAt:
          data['updatedAt'] != null
              ? DateTime.parse(data['updatedAt'] as String)
              : null,
      createdBy: data['createdBy'] as String?,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }
}
