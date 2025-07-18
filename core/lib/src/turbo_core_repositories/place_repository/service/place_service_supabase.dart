import 'package:core/src/turbo_core_repositories/analytics_repository/service/analytics_service.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
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
  final AnalyticsService analyticsService;

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

        final reviews = reviewsResponse
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
      final placeResponse = await supabase
          .from('places')
          .select('*')
          .eq('id', id)
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

      final reviews = reviewsResponse
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
      final placeResponse = await supabase
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

      final reviews = reviewsResponse
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

        final reviews = reviewsResponse
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

        final reviews = reviewsResponse
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

          final reviews = reviewsResponse
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
      await supabase.from('places').update({
        'owner_ids': ownerIds,
        'updated_at': DateTime.now().toIso8601String(),
      }).eq('id', placeId);

      // Return the updated place
      return await getPlaceById(placeId);
    } catch (e) {
      throw Exception('Error updating place ownership: $e');
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
        print('✅ Lugar creado con analytics inicializados: ${placeWithId.name}');
      } catch (analyticsError) {
        print('⚠️ Lugar creado pero falló la inicialización de analytics: $analyticsError');
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
      final placeResponse = await supabase
          .from('places')
          .select('*')
          .eq('id', id)
          .maybeSingle();

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
        value == null ? 0.0 : (value is double ? value : double.tryParse(value.toString()) ?? 0.0);
    int asInt(dynamic value) =>
        value == null ? 0 : (value is int ? value : int.tryParse(value.toString()) ?? 0);
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
      openingHours: asMap(data['opening_hours']).cast<String, Map<String, String>>(),
      phone: asString(data['phone']),
      website: asString(data['website']),
      priceLevel: asInt(data['price_level']),
      metadata: asMap(data['metadata']),
      ownerIds: asStringList(data['owner_ids']),
      createdBy: asString(data['created_by']),
      createdAt: data['created_at'] != null ? DateTime.parse(data['created_at']) : null,
      lastUpdated: data['updated_at'] != null ? DateTime.parse(data['updated_at']) : null,
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
      'updated_at': place.lastUpdated?.toIso8601String() ?? DateTime.now().toIso8601String(),
    };
  }

  /// Converts Supabase review data to Review model
  Review _reviewFromSupabase(Map<String, dynamic> data) {
    // This is a simplified conversion - you might need to adjust based on actual Review model
    return Review(
      id: data['id'] ?? '',
      placeId: data['place_id'] ?? '',
      userId: data['user_id'] ?? '',
      rating: (data['rating'] ?? 0).toDouble(),
      comment: data['comment'] ?? '',
      date: data['created_at'] != null ? DateTime.parse(data['created_at']) : DateTime.now(),
      userName: data['user_name'] ?? '',
      userPhotoUrl: data['user_photo_url'] ?? '',
    );
  }
}