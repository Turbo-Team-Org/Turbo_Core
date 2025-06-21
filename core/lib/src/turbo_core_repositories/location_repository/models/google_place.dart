import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:core/src/turbo_core_repositories/location_repository/models/location_data.dart';

part 'google_place.freezed.dart';
part 'google_place.g.dart';

/// Resultado de búsqueda de Google Places API
@freezed
sealed class GooglePlace with _$GooglePlace {
  const factory GooglePlace({
    required String placeId,
    required String name,
    required String formattedAddress,
    required LocationData location,
    @Default([]) List<String> types,
    String? businessStatus,
    String? vicinity,
    double? rating,
    int? userRatingsTotal,
    String? photoReference,
    @Default([]) List<String> photoReferences,
    String? website,
    String? phoneNumber,
    String? internationalPhoneNumber,
    @Default([]) List<Map<String, dynamic>> openingHours,
    String? plusCode,
    @Default([]) List<Map<String, dynamic>> addressComponents,
    Map<String, dynamic>? geometry,
    String? icon,
    String? iconBackgroundColor,
    String? iconMaskBaseUri,
    bool? permanentlyClosed,
    @Default([]) List<String> secondaryOpeningsHours,
    String? utcOffset,
    String? adrAddress,
    String? formattedPhoneNumber,
    String? url,
  }) = _GooglePlace;

  const GooglePlace._();

  factory GooglePlace.fromJson(Map<String, dynamic> json) =>
      _$GooglePlaceFromJson(json);

  /// Crear desde respuesta de Google Places API
  factory GooglePlace.fromGoogleApi(Map<String, dynamic> data) {
    final geometry = data['geometry'] as Map<String, dynamic>?;
    final location = geometry?['location'] as Map<String, dynamic>?;

    final addressComponents =
        (data['address_components'] as List<dynamic>?)
            ?.map((e) => e as Map<String, dynamic>)
            .toList() ??
        [];

    final openingHours = <Map<String, dynamic>>[];
    final openingHoursData = data['opening_hours'] as Map<String, dynamic>?;
    if (openingHoursData?['periods'] != null) {
      for (final period in openingHoursData!['periods'] as List<dynamic>) {
        openingHours.add(period as Map<String, dynamic>);
      }
    }

    final photos =
        (data['photos'] as List<dynamic>?)
            ?.map(
              (photo) =>
                  (photo as Map<String, dynamic>)['photo_reference'] as String,
            )
            .toList() ??
        [];

    return GooglePlace(
      placeId: data['place_id'] as String,
      name: data['name'] as String? ?? '',
      formattedAddress: data['formatted_address'] as String? ?? '',
      location: LocationData(
        latitude: (location?['lat'] as num?)?.toDouble() ?? 0.0,
        longitude: (location?['lng'] as num?)?.toDouble() ?? 0.0,
        timestamp: DateTime.now(),
      ),
      types: (data['types'] as List<dynamic>?)?.cast<String>() ?? [],
      businessStatus: data['business_status'] as String?,
      vicinity: data['vicinity'] as String?,
      rating: (data['rating'] as num?)?.toDouble(),
      userRatingsTotal: data['user_ratings_total'] as int?,
      photoReference: photos.isNotEmpty ? photos.first : null,
      photoReferences: photos,
      website: data['website'] as String?,
      phoneNumber: data['formatted_phone_number'] as String?,
      internationalPhoneNumber: data['international_phone_number'] as String?,
      openingHours: openingHours,
      plusCode: data['plus_code']?['global_code'] as String?,
      addressComponents: addressComponents,
      geometry: geometry,
      icon: data['icon'] as String?,
      iconBackgroundColor: data['icon_background_color'] as String?,
      iconMaskBaseUri: data['icon_mask_base_uri'] as String?,
      permanentlyClosed: data['permanently_closed'] as bool?,
      utcOffset: data['utc_offset']?.toString(),
      adrAddress: data['adr_address'] as String?,
      formattedPhoneNumber: data['formatted_phone_number'] as String?,
      url: data['url'] as String?,
    );
  }

  /// Obtener componente de dirección específico
  String? getAddressComponent(String type) {
    try {
      final component = addressComponents.firstWhere(
        (comp) => (comp['types'] as List<dynamic>?)?.contains(type) == true,
      );
      return component['long_name'] as String?;
    } catch (e) {
      return null;
    }
  }

  /// Obtener ciudad
  String? get city {
    return getAddressComponent('locality') ??
        getAddressComponent('administrative_area_level_2');
  }

  /// Obtener estado/provincia
  String? get state {
    return getAddressComponent('administrative_area_level_1');
  }

  /// Obtener país
  String? get country {
    return getAddressComponent('country');
  }

  /// Obtener código postal
  String? get postalCode {
    return getAddressComponent('postal_code');
  }

  /// Verificar si está abierto actualmente
  bool get isOpenNow {
    return openingHours.isEmpty ? true : false;
  }

  /// Obtener horarios formateados
  List<String> get formattedOpeningHours {
    if (openingHours.isEmpty) return [];

    const days = [
      'Domingo',
      'Lunes',
      'Martes',
      'Miércoles',
      'Jueves',
      'Viernes',
      'Sábado',
    ];
    final formattedHours = <String>[];

    for (final period in openingHours) {
      final open = period['open'] as Map<String, dynamic>?;
      final close = period['close'] as Map<String, dynamic>?;

      if (open != null) {
        final day = open['day'] as int? ?? 0;
        final openTime = open['time'] as String?;
        final closeTime = close?['time'] as String?;

        final dayName = days[day % 7];
        final openTimeFormatted = _formatTime(openTime);
        final closeTimeFormatted = _formatTime(closeTime);

        if (openTimeFormatted.isNotEmpty && closeTimeFormatted.isNotEmpty) {
          formattedHours.add(
            '$dayName: $openTimeFormatted - $closeTimeFormatted',
          );
        } else if (openTimeFormatted.isNotEmpty) {
          formattedHours.add('$dayName: Abre desde $openTimeFormatted');
        }
      }
    }

    return formattedHours;
  }

  String _formatTime(String? time) {
    if (time == null || time.length != 4) return '';
    final hour = int.tryParse(time.substring(0, 2)) ?? 0;
    final minute = int.tryParse(time.substring(2, 4)) ?? 0;
    return '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
  }
}
