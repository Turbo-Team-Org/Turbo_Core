import 'package:core/src/turbo_core_repositories/analytics_repository/interface/analytics_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place_owner_analytics.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';
import 'dart:math' as math;

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
  Future<void> addPlace(Place place) async {
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
      averagePrice: asDouble(data['average_price']),
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
      categoryIcon: asString(data['category_icon']),
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
      'average_price': place.averagePrice,
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
      'category_icon': place.categoryIcon,
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
      if (query.trim().isEmpty) {
        return [];
      }

      final searchQuery = query.trim().toLowerCase();

      // Búsqueda principal usando ILIKE para coincidencias parciales
      var supabaseQuery = supabase
          .from('places')
          .select('*')
          .eq('is_active', true)
          .or(
            'name.ilike.%$searchQuery%,description.ilike.%$searchQuery%,address.ilike.%$searchQuery%,tags.cs.{$searchQuery}',
          );

      // Aplicar filtros adicionales
      if (categoryId != null && categoryId.isNotEmpty) {
        supabaseQuery = supabaseQuery.eq('category_id', categoryId);
      }

      if (minRating != null && minRating > 0) {
        supabaseQuery = supabaseQuery.gte('rating', minRating);
      }

      if (maxPrice != null) {
        supabaseQuery = supabaseQuery.lte('average_price', maxPrice);
      }

      if (minPrice != null) {
        supabaseQuery = supabaseQuery.gte('average_price', minPrice);
      }

      if (isOpen != null) {
        supabaseQuery = supabaseQuery.eq('is_open', isOpen);
      }

      final placesResponse = await supabaseQuery
          .order('rating', ascending: false)
          .limit(limit);

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

      // Ordenar por relevancia (rating + coincidencia exacta en nombre)
      places.sort((a, b) {
        final aNameMatch = a.name.toLowerCase().contains(searchQuery);
        final bNameMatch = b.name.toLowerCase().contains(searchQuery);

        // Priorizar coincidencias exactas en nombre
        if (aNameMatch && !bNameMatch) return -1;
        if (!aNameMatch && bNameMatch) return 1;

        // Luego por rating
        return (b.rating).compareTo(a.rating);
      });

      return places;
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
      // Limpiar y normalizar la consulta de voz
      final cleanedQuery = _cleanVoiceQuery(voiceQuery);

      if (cleanedQuery.isEmpty) {
        return [];
      }

      // Usar el método de búsqueda por texto con la consulta limpia
      return await searchPlacesByText(
        cleanedQuery,
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
      if (query.trim().isEmpty) {
        return [];
      }

      final searchQuery = query.trim().toLowerCase();
      final places = <Place>[];

      // Estrategia 1: Búsqueda exacta por nombre
      try {
        final exactMatches = await supabase
            .from('places')
            .select('*')
            .eq('is_active', true)
            .eq('name', searchQuery)
            .limit(limit);

        for (final placeData in exactMatches) {
          final place = _placeFromSupabase(placeData);
          final reviews = await _getReviewsForPlace(place.id);
          places.add(place.copyWith(reviews: reviews));
        }
      } catch (e) {
        // Continuar con otras estrategias si falla
      }

      // Estrategia 2: Búsqueda por texto en múltiples campos
      if (places.length < limit) {
        final textResults = await searchPlacesByText(
          searchQuery,
          categoryId: categoryId,
          minRating: minRating,
          maxPrice: maxPrice,
          minPrice: minPrice,
          isOpen: isOpen,
          limit: limit - places.length,
        );

        // Agregar solo lugares que no estén ya en la lista
        final existingIds = places.map((p) => p.id).toSet();
        for (final place in textResults) {
          if (!existingIds.contains(place.id) && places.length < limit) {
            places.add(place);
          }
        }
      }

      // Estrategia 3: Búsqueda por tags si no hay suficientes resultados
      if (places.length < limit && searchQuery.length > 2) {
        final tagResults = await supabase
            .from('places')
            .select('*')
            .eq('is_active', true)
            .contains('tags', [searchQuery])
            .limit(limit - places.length);

        final existingIds = places.map((p) => p.id).toSet();
        for (final placeData in tagResults) {
          if (!existingIds.contains(placeData['id']) && places.length < limit) {
            final place = _placeFromSupabase(placeData);
            final reviews = await _getReviewsForPlace(place.id);
            places.add(place.copyWith(reviews: reviews));
          }
        }
      }

      // Aplicar filtros finales
      var filteredPlaces = places;

      if (categoryId != null && categoryId.isNotEmpty) {
        filteredPlaces =
            filteredPlaces
                .where((place) => place.categoryId == categoryId)
                .toList();
      }

      if (minRating != null && minRating > 0) {
        filteredPlaces =
            filteredPlaces.where((place) => place.rating >= minRating).toList();
      }

      if (maxPrice != null) {
        filteredPlaces =
            filteredPlaces
                .where((place) => place.averagePrice <= maxPrice)
                .toList();
      }

      if (minPrice != null) {
        filteredPlaces =
            filteredPlaces
                .where((place) => place.averagePrice >= minPrice)
                .toList();
      }

      if (isOpen != null) {
        filteredPlaces =
            filteredPlaces.where((place) => place.isOpen == isOpen).toList();
      }

      // Ordenar por relevancia
      filteredPlaces.sort((a, b) {
        final aNameMatch = a.name.toLowerCase().contains(searchQuery);
        final bNameMatch = b.name.toLowerCase().contains(searchQuery);

        // Priorizar coincidencias exactas en nombre
        if (aNameMatch && !bNameMatch) return -1;
        if (!aNameMatch && bNameMatch) return 1;

        // Luego por rating
        return (b.rating).compareTo(a.rating);
      });

      return filteredPlaces;
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
      // Construir la consulta base
      var query = supabase.from('places').select('*').eq('is_active', true);

      // Aplicar filtros básicos
      if (categoryId != null && categoryId.isNotEmpty) {
        query = query.eq('category_id', categoryId);
      }

      if (minRating != null && minRating > 0) {
        query = query.gte('rating', minRating);
      }

      if (maxPrice != null) {
        query = query.lte('average_price', maxPrice);
      }

      if (minPrice != null) {
        query = query.gte('average_price', minPrice);
      }

      if (isOpen != null) {
        query = query.eq('is_open', isOpen);
      }

      final placesResponse = await query
          .order('rating', ascending: false)
          .limit(limit);

      final places = <Place>[];

      for (final placeData in placesResponse) {
        final place = _placeFromSupabase(placeData);

        // Filtrar por distancia
        if (place.latitude != null && place.longitude != null) {
          final distance = _calculateDistance(
            latitude,
            longitude,
            place.latitude!,
            place.longitude!,
          );

          if (distance <= radiusKm) {
            // Get reviews for this place
            final reviews = await _getReviewsForPlace(place.id);
            places.add(place.copyWith(reviews: reviews));
          }
        }
      }

      // Ordenar por distancia
      places.sort((a, b) {
        if (a.latitude == null || a.longitude == null) return 1;
        if (b.latitude == null || b.longitude == null) return -1;

        final distanceA = _calculateDistance(
          latitude,
          longitude,
          a.latitude!,
          a.longitude!,
        );
        final distanceB = _calculateDistance(
          latitude,
          longitude,
          b.latitude!,
          b.longitude!,
        );

        return distanceA.compareTo(distanceB);
      });

      return places;
    } catch (e) {
      throw Exception('Error searching places by location: $e');
    }
  }

  // ==================== HELPER METHODS ====================

  /// Limpia y normaliza consultas de voz
  String _cleanVoiceQuery(String voiceQuery) {
    if (voiceQuery.isEmpty) return '';

    // Convertir a minúsculas
    String cleaned = voiceQuery.toLowerCase().trim();

    // Remover palabras comunes que no aportan valor de búsqueda
    final stopWords = [
      'buscar',
      'encuentra',
      'dónde',
      'donde',
      'hay',
      'quiero',
      'necesito',
      'busco',
      'busca',
      'encontrar',
      'lugar',
      'lugares',
      'restaurante',
      'café',
      'cafe',
      'bar',
      'club',
      'discoteca',
      'hotel',
      'tienda',
    ];

    for (final stopWord in stopWords) {
      cleaned = cleaned.replaceAll(' $stopWord ', ' ');
      cleaned = cleaned.replaceAll('$stopWord ', '');
      cleaned = cleaned.replaceAll(' $stopWord', '');
    }

    // Limpiar espacios múltiples
    cleaned = cleaned.replaceAll(RegExp(r'\s+'), ' ').trim();

    return cleaned;
  }

  /// Calcula distancia entre dos puntos usando fórmula de Haversine
  double _calculateDistance(
    double lat1,
    double lon1,
    double lat2,
    double lon2,
  ) {
    const double earthRadius = 6371.0; // Radio de la Tierra en km

    final double dLat = _degreesToRadians(lat2 - lat1);
    final double dLon = _degreesToRadians(lon2 - lon1);

    final double a =
        math.sin(dLat / 2) * math.sin(dLat / 2) +
        math.sin(_degreesToRadians(lat1)) *
            math.sin(_degreesToRadians(lat2)) *
            math.sin(dLon / 2) *
            math.sin(dLon / 2);

    final double c = 2 * math.atan(math.sqrt(a) / math.sqrt(1 - a));

    return earthRadius * c;
  }

  /// Convierte grados a radianes
  double _degreesToRadians(double degrees) {
    return degrees * (3.14159265359 / 180);
  }

  /// Obtiene reseñas para un lugar específico
  Future<List<Review>> _getReviewsForPlace(String placeId) async {
    try {
      final reviewsResponse = await supabase
          .from('reviews')
          .select('*')
          .eq('place_id', placeId)
          .order('created_at', ascending: false)
          .limit(20);

      return reviewsResponse
          .map((reviewData) => _reviewFromSupabase(reviewData))
          .toList();
    } catch (e) {
      return [];
    }
  }
}
