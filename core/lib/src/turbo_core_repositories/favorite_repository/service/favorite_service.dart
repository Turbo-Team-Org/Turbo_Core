import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/interface/favorite_interface.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/models/favorite.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';
import 'package:uuid/uuid.dart';

/// Favorite service
class FavoriteService implements FavoriteInterface {
  /// Constructor
  FavoriteService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  /// Firestore instance
  final FirebaseFirestore _firestore;

  /// UUID instance
  final _uuid = const Uuid();

  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: favorite.userId)
              .where('placeId', isEqualTo: favorite.placeId)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        await _firestore
            .collection('favorites')
            .doc(querySnapshot.docs.first.id)
            .delete();
      } else {
        final newId = _uuid.v4();
        await _firestore.collection('favorites').doc(newId).set({
          'id': newId,
          'placeId': favorite.placeId,
          'userId': favorite.userId,
          'date': FieldValue.serverTimestamp(),
          'createdAt': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      throw Exception('Error al actualizar favorito: $e');
    }
  }

  @override
  Future<List<Favorite>> getFavorites(String userId) async {
    try {
      final favoritesSnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: userId)
              .get();

      final favorites =
          favoritesSnapshot.docs.map(Favorite.fromFirestore).toList();

      final placesSnapshot = await Future.wait(
        favorites.map(
          (favorite) =>
              _firestore.collection('places').doc(favorite.placeId).get(),
        ),
      );

      final favoritesWithPlaces = List<Favorite>.from(favorites);
      for (var i = 0; i < favorites.length; i++) {
        final placeDoc = placesSnapshot[i];
        if (placeDoc.exists) {
          final place = Place.fromFirestore(placeDoc);
          favoritesWithPlaces[i] = favorites[i].copyWith(place: place);
        }
      }

      return favoritesWithPlaces;
    } catch (e) {
      throw Exception('Error al obtener favoritos: $e');
    }
  }

  @override
  Future<bool> isFavorite(String userId, String placeId) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: userId)
              .where('placeId', isEqualTo: placeId)
              .get();

      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      throw Exception('Error al verificar favorito: $e');
    }
  }

  @override
  Future<void> addFavorite(String userId, String placeId) async {
    try {
      final newId = _uuid.v4();
      await _firestore.collection('favorites').doc(newId).set({
        'id': newId,
        'userId': userId,
        'placeId': placeId,
        'date': FieldValue.serverTimestamp(),
        'createdAt': FieldValue.serverTimestamp(),
      });
    } catch (e) {
      throw Exception('Error al agregar favorito: $e');
    }
  }

  @override
  Future<void> removeFavorite(String userId, String placeId) async {
    try {
      final querySnapshot =
          await _firestore
              .collection('favorites')
              .where('userId', isEqualTo: userId)
              .where('placeId', isEqualTo: placeId)
              .get();

      if (querySnapshot.docs.isNotEmpty) {
        await _firestore
            .collection('favorites')
            .doc(querySnapshot.docs.first.id)
            .delete();
      } else {
        throw Exception('Favorito no encontrado');
      }
    } catch (e) {
      throw Exception('Error al eliminar favorito: $e');
    }
  }
}
