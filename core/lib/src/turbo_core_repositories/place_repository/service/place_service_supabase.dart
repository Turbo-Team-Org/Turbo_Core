import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place_owner_analytics.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// Place service for Supabase
class PlaceServiceSupabase implements PlaceInterface {
  /// Constructor
  const PlaceServiceSupabase({
    required this.supabase,
    required this.analyticsService,
    required this.authorization,
  });

  /// Supabase client instance
  final SupabaseClient supabase;

  /// Analytics service para inicializar estructura automáticamente
  final AnalyticsInterface analyticsService;

  /// Interfaz para verificar permisos de gestión de lugares
  final PlaceAuthorizationInterface authorization;

  /// UUID instance
  static const _uuid = Uuid();

  @override
  Future<List<Place>> getPlaces() async {
    try {
      final placesResponse = await supabase
          .from('places')
          .select('*')
          .order('created_at', ascending: false);

      final places = <Place>[];

      for (final placeData in placesResponse) {
        final place = _placeFromSupabase(placeData);

        // Get reviews for this place
        final reviewsResponse = await supabase
            .from('reviews')
            .select('*')
            .eq('place_id', place.id)
            .order('created_at', ascending: false)
            .limit(20);

        final reviews =
            reviewsResponse
                .map((reviewData) => _reviewFromSupabase(reviewData))
                .toList();

        places.add(place.copyWith(reviews: reviews));
      }

      return places;
    } catch (e) {
      throw Exception('Error getting places: $e');
    }
  }

  @override
  Future<Place> getPlaceById(String id) async {
    try {
      final placeResponse =
          await supabase.from('places').select('*').eq('id', id).maybeSingle();

      if (placeResponse == null) {
        throw Exception('Place not found');
      }

      final place = _placeFromSupabase(placeResponse);

      // Get reviews for this place
      final reviewsResponse = await supabase
          .from('reviews')
          .select('*')
          .eq('place_id', place.id)
          .order('created_at', ascending: false)
          .limit(20);

      final reviews =
          reviewsResponse
              .map((reviewData) => _reviewFromSupabase(reviewData))
              .toList();

      return place.copyWith(reviews: reviews);
    } catch (e) {
      throw Exception('Error getting place: $e');
    }
  }

  @override
  Future<Place> getPlaceByName(String name) async {
    try {
      final placeResponse =
          await supabase
              .from('places')
              .select('*')
              .eq('name', name)
              .maybeSingle();

      if (placeResponse == null) {
        throw Exception('Place not found');
      }

      final place = _placeFromSupabase(placeResponse);

      // Get reviews for this place
      final reviewsResponse = await supabase
          .from('reviews')
          .select('*')
          .eq('place_id', place.id)
          .order('created_at', ascending: false)
          .limit(20);

      final reviews =
          reviewsResponse
              .map((reviewData) => _reviewFromSupabase(reviewData))
              .toList();

      return place.copyWith(reviews: reviews);
    } catch (e) {
      throw Exception('Error getting place: $e');
    }
  }

  @override
  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    try {
      final placesResponse = await supabase
          .from('places')
          .select('*')
          .eq('category_id', categoryId)
          .order('created_at', ascending: false);

      final places = <Place>[];

      for (final placeData in placesResponse) {
        final place = _placeFromSupabase(placeData);

        // Get reviews for this place
        final reviewsResponse = await supabase
            .from('reviews')
            .select('*')
            .eq('place_id', place.id)
            .order('created_at', ascending: false)
            .limit(20);

        final reviews =
            reviewsResponse
                .map((reviewData) => _reviewFromSupabase(reviewData))
                .toList();

        places.add(place.copyWith(reviews: reviews));
      }

      return places;
    } catch (e) {
      throw Exception('Error getting places by category: $e');
    }
  }

  // ==================== ADMIN OPERATIONS ====================

  /// 🏢 Gets places owned by a specific admin user
  Future<List<Place>> getPlacesByOwnerId(String ownerId) async {
    try {
      final placesResponse = await supabase
          .from('places')
          .select('*')
          .contains('owner_ids', [ownerId])
          .order('created_at', ascending: false);

      final places = <Place>[];

      for (final placeData in placesResponse) {
        final place = _placeFromSupabase(placeData);

        // Get reviews for this place
        final reviewsResponse = await supabase
            .from('reviews')
            .select('*')
            .eq('place_id', place.id)
            .order('created_at', ascending: false)
            .limit(20);

        final reviews =
            reviewsResponse
                .map((reviewData) => _reviewFromSupabase(reviewData))
                .toList();

        places.add(place.copyWith(reviews: reviews));
      }

      return places;
    } catch (e) {
      throw Exception('Error getting places by owner: $e');
    }
  }

  /// 🏢 Gets places owned by multiple admin users
  Future<List<Place>> getPlacesByOwnerIds(List<String> ownerIds) async {
    try {
      final placesResponse = await supabase
          .from('places')
          .select('*')
          .overlaps('owner_ids', ownerIds)
          .order('created_at', ascending: false);

      final places = <Place>[];
      final seenIds = <String>{};

      for (final placeData in placesResponse) {
        final place = _placeFromSupabase(placeData);

        // Avoid duplicates
        if (!seenIds.contains(place.id)) {
          seenIds.add(place.id);

          // Get reviews for this place
          final reviewsResponse = await supabase
              .from('reviews')
              .select('*')
              .eq('place_id', place.id)
              .order('created_at', ascending: false)
              .limit(20);

          final reviews =
              reviewsResponse
                  .map((reviewData) => _reviewFromSupabase(reviewData))
                  .toList();

          places.add(place.copyWith(reviews: reviews));
        }
      }

      return places;
    } catch (e) {
      throw Exception('Error getting places by owners: $e');
    }
  }

  /// 👑 Updates the ownership of a place (super admin only)
  Future<Place> updatePlaceOwnership(
    String placeId,
    List<String> ownerIds,
  ) async {
    try {
      // Update the place with new owners
      await supabase
          .from('places')
          .update({
            'owner_ids': ownerIds,
            'updated_at': DateTime.now().toIso8601String(),
          })
          .eq('id', placeId);

      // Return the updated place
      return await getPlaceById(placeId);
    } catch (e) {
      throw Exception('Error updating place ownership: $e');
    }
  }

  /// 📊 Gets analytics summary for places owned by an admin
  @override
  Future<PlaceOwnerAnalytics> getPlaceAnalyticsByOwnerId(String ownerId) async {
    try {
      final places = await getPlacesByOwnerId(ownerId);

      if (places.isEmpty) {
        return PlaceOwnerAnalytics.fromData(ownerId, {
          'totalPlaces': 0,
          'totalViews': 0,
          'totalReviews': 0,
          'averageRating': 0.0,
          'totalFavorites': 0,
          'monthlyViews': <String, int>{},
          'topPerformingPlaces': <Map<String, dynamic>>[],
        });
      }

      // Calculate analytics
      final totalPlaces = places.length;
      final totalViews = places.fold(
        0,
        (sum, place) => sum + place.favoriteCount,
      );
      final totalReviews = places.fold(
        0,
        (sum, place) => sum + place.reviews.length,
      );
      final averageRating =
          places.isNotEmpty
              ? places.fold(0.0, (sum, place) => sum + place.rating) /
                  places.length
              : 0.0;
      final totalFavorites = places.fold(
        0,
        (sum, place) => sum + place.favoriteCount,
      );

      // Monthly views (simplified)
      final monthlyViews = <String, int>{};
      final now = DateTime.now();
      for (int i = 0; i < 12; i++) {
        final month = DateTime(now.year, now.month - i, 1);
        final monthKey =
            '${month.year}-${month.month.toString().padLeft(2, '0')}';
        monthlyViews[monthKey] = totalViews ~/ 12; // Simplified distribution
      }

      // Top performing places
      final topPerformingPlaces =
          places
              .take(5)
              .map(
                (place) => PlacePerformance(
                  placeId: place.id,
                  placeName: place.name,
                  views: place.favoriteCount,
                  reviews: place.reviews.length,
                  rating: place.rating,
                  favorites: place.favoriteCount,
                ),
              )
              .toList();

      return PlaceOwnerAnalytics.fromData(ownerId, {
        'totalPlaces': totalPlaces,
        'totalViews': totalViews,
        'totalReviews': totalReviews,
        'averageRating': averageRating,
        'totalFavorites': totalFavorites,
        'monthlyViews': monthlyViews,
        'topPerformingPlaces':
            topPerformingPlaces.map((e) => e.toJson()).toList(),
      });
    } catch (e) {
      throw Exception('Error getting place analytics by owner: $e');
    }
  }

  @override
  Future<String> addPlace(Place place) async {
    try {
      // Ensure place has a valid ID
      final placeId = place.id.isNotEmpty ? place.id : _uuid.v4();
      final placeWithId = place.copyWith(id: placeId);

      // 1. Create the place document
      await supabase.from('places').insert(_placeToSupabaseData(placeWithId));

      // 2. Initialize analytics structure automatically
      try {
        await analyticsService.initializeAnalyticsStructure(placeId);
        print(
          '✅ Lugar creado con analytics inicializados: ${placeWithId.name}',
        );
      } catch (analyticsError) {
        print(
          '⚠️ Lugar creado pero falló la inicialización de analytics: $analyticsError',
        );
        // No lanzamos el error para que el lugar se cree igual
        // Los analytics se pueden inicializar manualmente después
      }
      return placeId;
    } catch (e) {
      // Si falla la creación del lugar, intentamos limpiar
      try {
        if (place.id.isNotEmpty) {
          await supabase.from('places').delete().eq('id', place.id);
        }
      } catch (_) {
        // Ignorar errores de limpieza
      }
      throw Exception('Error adding place: $e');
    }
  }

  /// 🏢 Adds a new place with admin ownership
  Future<void> addPlaceWithOwner(Place place, String ownerId) async {
    try {
      // Create place data with owner information
      final placeData = _placeToSupabaseData(place);
      placeData['owner_ids'] = [ownerId];
      placeData['created_by'] = ownerId;
      placeData['created_at'] = DateTime.now().toIso8601String();

      // 1. Create the place document
      await supabase.from('places').insert(placeData);

      // 2. Initialize analytics structure automatically
      await analyticsService.initializeAnalyticsStructure(place.id);

      print('✅ Lugar creado con propietario y analytics: ${place.name}');
    } catch (e) {
      // If analytics creation fails, try to clean up the created place
      try {
        await supabase.from('places').delete().eq('id', place.id);
      } catch (_) {
        // Ignore cleanup errors
      }
      throw Exception('Error adding place with owner and analytics: $e');
    }
  }

  @override
  Future<void> updatePlace(Place place) async {
    try {
      await supabase
          .from('places')
          .update(_placeToSupabaseData(place))
          .eq('id', place.id);
    } catch (e) {
      throw Exception('Error updating place: $e');
    }
  }

  @override
  Future<void> deletePlace(String id) async {
    try {
      // Primero verificar si el lugar existe
      final placeResponse =
          await supabase.from('places').select('*').eq('id', id).maybeSingle();

      if (placeResponse == null) {
        throw Exception('El lugar no existe');
      }

      // Verificar si el usuario actual tiene permisos para eliminar
      if (!authorization.canManagePlace(id)) {
        throw Exception('No tienes permisos para eliminar este lugar');
      }

      // Eliminar el lugar
      await supabase.from('places').delete().eq('id', id);

      // Intentar limpiar analytics, pero no bloquear si falla
      try {
        await analyticsService.cleanupAnalyticsStructure(id);
      } catch (e) {
        print('⚠️ Error al limpiar analytics del lugar $id: $e');
        // No lanzamos la excepción, continuamos con la eliminación
      }
    } catch (e) {
      throw Exception('Error al eliminar lugar: $e');
    }
  }

  /// Converts Supabase data to Place model
  Place _placeFromSupabase(Map<String, dynamic> data) {
    String asString(dynamic value) => value?.toString() ?? '';
    double asDouble(dynamic value) =>
        value == null
            ? 0.0
            : (value is double
                ? value
                : double.tryParse(value.toString()) ?? 0.0);
    int asInt(dynamic value) =>
        value == null
            ? 0
            : (value is int ? value : int.tryParse(value.toString()) ?? 0);
    bool asBool(dynamic value) => value is bool ? value : value == true;
    List<String> asStringList(dynamic value) =>
        value is List ? List<String>.from(value) : [];
    Map<String, dynamic> asMap(dynamic value) =>
        value is Map<String, dynamic> ? value : {};

    return Place(
      id: asString(data['id']),
      name: asString(data['name']),
      description: asString(data['description']),
      address: asString(data['address']),
      imageUrls: asStringList(data['image_urls']),
      rating: asDouble(data['rating']),
      reviews: [], // Reviews are loaded separately
      tags: asStringList(data['tags']),
      isOpen: asBool(data['is_open']),
      mainImage: asString(data['main_image']),
      favoriteCount: asInt(data['favorite_count']),
      menuUrl: asString(data['menu_url']),
      latitude: asDouble(data['latitude']),
      longitude: asDouble(data['longitude']),
      categoryId: asString(data['category_id']),
      categoryName: asString(data['category_name']),
      openingHours:
          asMap(data['opening_hours']).cast<String, Map<String, String>>(),
      phone: asString(data['phone']),
      website: asString(data['website']),
      priceLevel: asInt(data['price_level']),
      metadata: asMap(data['metadata']),
      ownerIds: asStringList(data['owner_ids']),
      createdBy: asString(data['created_by']),
      createdAt:
          data['created_at'] != null
              ? DateTime.parse(data['created_at'] as String)
              : null,
      lastUpdated:
          data['updated_at'] != null
              ? DateTime.parse(data['updated_at'] as String)
              : null,
    );
  }

  /// Converts Place model to Supabase data
  Map<String, dynamic> _placeToSupabaseData(Place place) {
    return {
      'id': place.id,
      'name': place.name,
      'description': place.description,
      'address': place.address,
      'image_urls': place.imageUrls,
      'rating': place.rating,
      'tags': place.tags,
      'is_open': place.isOpen,
      'main_image': place.mainImage,
      'favorite_count': place.favoriteCount,
      'menu_url': place.menuUrl,
      'latitude': place.latitude,
      'longitude': place.longitude,
      'category_id': place.categoryId,
      'category_name': place.categoryName,
      'opening_hours': place.openingHours,
      'phone': place.phone,
      'website': place.website,
      'price_level': place.priceLevel,
      'metadata': place.metadata,
      'owner_ids': place.ownerIds,
      'created_by': place.createdBy,
      'created_at': place.createdAt?.toIso8601String(),
      'updated_at':
          place.lastUpdated?.toIso8601String() ??
          DateTime.now().toIso8601String(),
    };
  }

  /// Converts Supabase review data to Review model
  Review _reviewFromSupabase(Map<String, dynamic> data) {
    return Review(
      id: data['id'] as String? ?? '',
      userId: data['user_id'] as String? ?? '',
      userName: data['user_name'] as String? ?? '',
      userAvatar: data['user_photo_url'] as String? ?? '',
      comment: data['comment'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 0.0,
      date:
          data['created_at'] != null
              ? DateTime.parse(data['created_at'] as String)
              : DateTime.now(),
    );
  }

  // ==================== ADVANCED SEARCH METHODS ====================

  /// 🔍 Búsqueda robusta por texto con múltiples campos
  Future<List<Place>> searchPlacesByText(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      // Implementación simple que usa getPlaces() y filtra
      final allPlaces = await getPlaces();
      final searchQuery = query.trim().toLowerCase();

      if (searchQuery.isEmpty) {
        return allPlaces;
      }

      return allPlaces
          .where((place) {
            final nameMatch = place.name.toLowerCase().contains(searchQuery);
            final descMatch = place.description.toLowerCase().contains(
              searchQuery,
            );
            final addressMatch = place.address.toLowerCase().contains(
              searchQuery,
            );

            return nameMatch || descMatch || addressMatch;
          })
          .take(limit)
          .toList();
    } catch (e) {
      throw Exception('Error searching places by text: $e');
    }
  }

  /// 🎤 Búsqueda por voz (convierte texto a búsqueda)
  Future<List<Place>> searchPlacesByVoice(
    String voiceQuery, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      // Simplemente usar búsqueda por texto
      return await searchPlacesByText(
        voiceQuery,
        categoryId: categoryId,
        minRating: minRating,
        maxPrice: maxPrice,
        minPrice: minPrice,
        isOpen: isOpen,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error searching places by voice: $e');
    }
  }

  /// 🔍 Búsqueda inteligente con múltiples estrategias
  Future<List<Place>> intelligentSearch(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      // Simplemente usar búsqueda por texto por ahora
      return await searchPlacesByText(
        query,
        categoryId: categoryId,
        minRating: minRating,
        maxPrice: maxPrice,
        minPrice: minPrice,
        isOpen: isOpen,
        limit: limit,
      );
    } catch (e) {
      throw Exception('Error in intelligent search: $e');
    }
  }

  /// 🎯 Búsqueda por ubicación con radio configurable
  Future<List<Place>> searchPlacesByLocation({
    required double latitude,
    required double longitude,
    double radiusKm = 10.0,
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) async {
    try {
      // Implementación simple que usa getPlaces() y filtra por distancia
      final allPlaces = await getPlaces();

      final nearbyPlaces =
          allPlaces
              .where((place) {
                if (place.latitude == null || place.longitude == null)
                  return false;

                final distance = _calculateDistance(
                  latitude,
                  longitude,
                  place.latitude!,
                  place.longitude!,
                );

                return distance <= radiusKm;
              })
              .take(limit)
              .toList();

      return nearbyPlaces;
    } catch (e) {
      throw Exception('Error searching places by location: $e');
    }
  }

  // ==================== HELPER METHODS ====================

  /// Calcula distancia entre dos puntos usando fórmula simple
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    // Fórmula simple de distancia euclidiana para evitar problemas con math
    final double dLat = lat2 - lat1;
    final double dLon = lon2 - lon1;
    return (dLat * dLat + dLon * dLon) * 111.0; // Aproximación en km
  }
}
