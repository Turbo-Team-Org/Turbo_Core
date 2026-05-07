import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/service/analytics_service.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_authorization_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/interface/place_interface.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:core/src/turbo_core_repositories/place_repository/place_repository.dart';
import 'package:core/src/turbo_core_repositories/review_repository/models/review.dart';

import '../models/place_owner_analytics.dart';

/// Place service
class PlaceService implements PlaceInterface {
  /// Constructor
  const PlaceService({
    required this.firestore,
    required this.analyticsService,
    required this.authorization,
  });

  /// Firestore instance
  final FirebaseFirestore firestore;

  /// Analytics service para inicializar estructura automáticamente
  final AnalyticsService analyticsService;

  /// Interfaz para verificar permisos de gestión de lugares
  final PlaceAuthorizationInterface authorization;

  @override
  Future<List<Place>> getPlaces() async {
    try {
      final placesSnapshot = await firestore.collection('places').get();
      final places = <Place>[];

      for (final doc in placesSnapshot.docs) {
        final place = Place.fromFirestore(doc);
        final reviewsSnapshot =
            await firestore
                .collection('reviews')
                .where('placeId', isEqualTo: place.id)
                .orderBy('date', descending: true)
                .limit(20)
                .get();

        final reviews =
            reviewsSnapshot.docs
                .map((doc) => Review.fromFirestore(doc.data()))
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
      final doc = await firestore.collection('places').doc(id).get();

      if (!doc.exists) {
        throw Exception('Place not found');
      }

      final place = Place.fromFirestore(doc);
      final reviewsSnapshot =
          await firestore
              .collection('reviews')
              .where('placeId', isEqualTo: place.id)
              .orderBy('date', descending: true)
              .limit(20)
              .get();

      final reviews =
          reviewsSnapshot.docs
              .map((doc) => Review.fromFirestore(doc.data()))
              .toList();

      return place.copyWith(reviews: reviews);
    } catch (e) {
      throw Exception('Error getting place: $e');
    }
  }

  @override
  Future<Place> getPlaceByName(String name) async {
    try {
      final querySnapshot =
          await firestore
              .collection('places')
              .where('name', isEqualTo: name)
              .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('Place not found');
      }

      final place = Place.fromFirestore(querySnapshot.docs.first);
      final reviewsSnapshot =
          await firestore
              .collection('reviews')
              .where('placeId', isEqualTo: place.id)
              .orderBy('date', descending: true)
              .limit(20)
              .get();

      final reviews =
          reviewsSnapshot.docs
              .map((doc) => Review.fromFirestore(doc.data()))
              .toList();

      return place.copyWith(reviews: reviews);
    } catch (e) {
      throw Exception('Error getting place: $e');
    }
  }

  @override
  Future<List<Place>> getPlacesByCategory(String categoryId) async {
    try {
      final querySnapshot =
          await firestore
              .collection('places')
              .where('categoryId', isEqualTo: categoryId)
              .get();

      final places = <Place>[];

      for (final doc in querySnapshot.docs) {
        final place = Place.fromFirestore(doc);
        final reviewsSnapshot =
            await firestore
                .collection('reviews')
                .where('placeId', isEqualTo: place.id)
                .orderBy('date', descending: true)
                .limit(20)
                .get();

        final reviews =
            reviewsSnapshot.docs
                .map((doc) => Review.fromFirestore(doc.data()))
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
      final querySnapshot =
          await firestore
              .collection('places')
              .where('ownerIds', arrayContains: ownerId)
              .get();

      final places = <Place>[];

      for (final doc in querySnapshot.docs) {
        final place = Place.fromFirestore(doc);
        final reviewsSnapshot =
            await firestore
                .collection('reviews')
                .where('placeId', isEqualTo: place.id)
                .orderBy('date', descending: true)
                .limit(20)
                .get();

        final reviews =
            reviewsSnapshot.docs
                .map((doc) => Review.fromFirestore(doc.data()))
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
      final places = <Place>[];

      // Firebase 'in' queries are limited to 10 items, so we batch them
      const int batchSize = 10;
      for (int i = 0; i < ownerIds.length; i += batchSize) {
        final batch = ownerIds.skip(i).take(batchSize).toList();

        final querySnapshot =
            await firestore
                .collection('places')
                .where('ownerIds', arrayContainsAny: batch)
                .get();

        for (final doc in querySnapshot.docs) {
          final place = Place.fromFirestore(doc);

          // Avoid duplicates
          if (!places.any((p) => p.id == place.id)) {
            final reviewsSnapshot =
                await firestore
                    .collection('reviews')
                    .where('placeId', isEqualTo: place.id)
                    .orderBy('date', descending: true)
                    .limit(20)
                    .get();

            final reviews =
                reviewsSnapshot.docs
                    .map((doc) => Review.fromFirestore(doc.data()))
                    .toList();

            places.add(place.copyWith(reviews: reviews));
          }
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
      // Update the place document with new owners
      await firestore.collection('places').doc(placeId).update({
        'ownerIds': ownerIds,
        'lastUpdated': FieldValue.serverTimestamp(),
      });

      // Return the updated place
      return await getPlaceById(placeId);
    } catch (e) {
      throw Exception('Error updating place ownership: $e');
    }
  }

  /// 📊 Gets analytics summary for places owned by an admin
  Future<PlaceOwnerAnalytics> getPlaceAnalyticsByOwnerId(String ownerId) async {
    try {
      // Get all places owned by this admin
      final ownerPlaces = await getPlacesByOwnerId(ownerId);

      // Calculate aggregated metrics
      int totalViews = 0;
      int totalReviews = 0;
      double totalRating = 0.0;
      int totalFavorites = 0;
      int placesWithHighRating = 0;
      int placesNeedingAttention = 0;

      for (final place in ownerPlaces) {
        totalReviews += place.reviews.length;
        totalRating += place.rating;
        totalFavorites += place.favoriteCount;

        if (place.rating >= 4.0) {
          placesWithHighRating++;
        }
        if (place.rating < 3.0 || place.reviews.isEmpty) {
          placesNeedingAttention++;
        }
      }

      // Get aggregated analytics from analytics collections if available
      try {
        final placeIds = ownerPlaces.map((p) => p.id).toList();

        // Split place IDs into batches of 10 (Firestore whereIn limit)
        const int batchSize = 10;
        final List<QuerySnapshot> allSnapshots = [];

        for (int i = 0; i < placeIds.length; i += batchSize) {
          final batchIds = placeIds.skip(i).take(batchSize).toList();

          final batchSnapshot =
              await firestore
                  .collection('analytics_places')
                  .where('placeId', whereIn: batchIds)
                  .get();

          allSnapshots.add(batchSnapshot);
        }

        // Aggregate results from all batches
        for (final snapshot in allSnapshots) {
          for (final doc in snapshot.docs) {
            final data = doc.data() as Map<String, dynamic>?;
            if (data != null) {
              totalViews += (data['viewsThisMonth'] as int? ?? 0);
            }
          }
        }
      } catch (e) {
        // Si no hay analytics disponibles, usar valores calculados
        print('Analytics not available, using calculated values: $e');
      }

      // Calculate monthly views (simplified)
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
          ownerPlaces
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
        'totalPlaces': ownerPlaces.length,
        'totalViews': totalViews,
        'totalReviews': totalReviews,
        'averageRating':
            ownerPlaces.isNotEmpty ? totalRating / ownerPlaces.length : 0.0,
        'totalFavorites': totalFavorites,
        'monthlyViews': monthlyViews,
        'topPerformingPlaces':
            topPerformingPlaces.map((e) => e.toJson()).toList(),
      });
    } catch (e) {
      throw Exception('Error getting analytics by owner: $e');
    }
  }

  @override
  Future<String> addPlace(Place place) async {
    try {
      final docRef = firestore.collection('places').doc();
      final placeWithId = place.copyWith(id: docRef.id);
      final placeData = placeWithId.toJson();
      placeData['createdAt'] = FieldValue.serverTimestamp();
      await docRef.set(placeData);

      // 2. Inicializar automáticamente la estructura de analytics
      try {
        await analyticsService.initializeAnalyticsStructure(docRef.id);
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
      return docRef.id;
    } catch (e) {
      // Si falla la creación del lugar, intentamos limpiar
      try {
        if (place.id.isNotEmpty) {
          await firestore.collection('places').doc(place.id).delete();
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
      final placeData = place.toJson();
      placeData['ownerIds'] = [ownerId];
      placeData['createdBy'] = ownerId;
      placeData['createdAt'] = FieldValue.serverTimestamp();

      // 1. Create the place document
      await firestore.collection('places').doc(place.id).set(placeData);

      // 2. Initialize analytics structure automatically
      await analyticsService.initializeAnalyticsStructure(place.id);

      print('✅ Lugar creado con propietario y analytics: ${place.name}');
    } catch (e) {
      // If analytics creation fails, try to clean up the created place
      try {
        await firestore.collection('places').doc(place.id).delete();
      } catch (_) {
        // Ignore cleanup errors
      }
      throw Exception('Error adding place with owner and analytics: $e');
    }
  }

  @override
  Future<void> updatePlace(Place place) async {
    try {
      await firestore.collection('places').doc(place.id).update(place.toJson());
    } catch (e) {
      throw Exception('Error updating place: $e');
    }
  }

  @override
  Future<bool> deletePlace(String id) async {
    try {
      // Primero verificar si el lugar existe y obtener sus datos
      final placeDoc = await firestore.collection('places').doc(id).get();

      if (!placeDoc.exists) {
        throw Exception('El lugar no existe');
      }

      // Verificar si el usuario actual tiene permisos para eliminar
      if (!authorization.canManagePlace(id)) {
        throw Exception('No tienes permisos para eliminar este lugar');
      }

      // Eliminar el lugar
      await firestore.collection('places').doc(id).delete();

      // Intentar limpiar analytics, pero no bloquear si falla
      try {
        await analyticsService.cleanupAnalyticsStructure(id);
      } catch (e) {
        print('⚠️ Error al limpiar analytics del lugar $id: $e');
        // No lanzamos la excepción, continuamos con la eliminación
      }

      return true;
    } catch (e) {
      throw Exception('Error al eliminar lugar: $e');
    }
  }

  @override
  Future<List<Place>> intelligentSearch(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) {
    // TODO: implement intelligentSearch
    throw UnimplementedError();
  }

  @override
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
  }) {
    // TODO: implement searchPlacesByLocation
    throw UnimplementedError();
  }

  @override
  Future<List<Place>> searchPlacesByText(
    String query, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) {
    // TODO: implement searchPlacesByText
    throw UnimplementedError();
  }

  @override
  Future<List<Place>> searchPlacesByVoice(
    String voiceQuery, {
    String? categoryId,
    double? minRating,
    double? maxPrice,
    double? minPrice,
    bool? isOpen,
    int limit = 50,
  }) {
    // TODO: implement searchPlacesByVoice
    throw UnimplementedError();
  }
}
