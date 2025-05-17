import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/category_repository/model/category.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';

/// Service for managing place categories.
class PlaceCategoryService {
  /// Constructor for the PlaceCategoryService.
  PlaceCategoryService({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore _firestore;
  final String _collectionName = 'place_categories';

  /// Collection reference for place categories.
  CollectionReference<Map<String, dynamic>> get placeCategoriesCollection =>
      _firestore.collection(_collectionName);

  /// Assigns a category to a place.
  Future<bool> assignCategoryToPlace(String placeId, String categoryId) async {
    try {
      await placeCategoriesCollection.doc().set({
        'placeId': placeId,
        'categoryId': categoryId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      /// Increment the places count in the category.
      await _firestore.collection('categories').doc(categoryId).update({
        'placesCount': FieldValue.increment(1),
      });

      return true;
    } catch (e) {
      throw Exception('Error al asignar categoría: $e');
    }
  }

  /// Removes a category from a place.
  Future<bool> removeCategoryFromPlace(
    String placeId,
    String categoryId,
  ) async {
    try {
      /// Search for the association document.
      final querySnapshot =
          await placeCategoriesCollection
              .where('placeId', isEqualTo: placeId)
              .where('categoryId', isEqualTo: categoryId)
              .get();

      /// Delete all found associations.
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      /// Decrement the places count in the category if it had an association.
      if (querySnapshot.docs.isNotEmpty) {
        await _firestore.collection('categories').doc(categoryId).update({
          'placesCount': FieldValue.increment(-1),
        });
      }

      return true;
    } catch (e) {
      throw Exception('Error al eliminar categoría de lugar: $e');
    }
  }

  /// Gets all categories for a place.
  Future<List<Category>> getCategoriesForPlace(String placeId) async {
    try {
      /// Search for associations for this place.
      final querySnapshot =
          await placeCategoriesCollection
              .where('placeId', isEqualTo: placeId)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      /// Extract category IDs.
      final categoryIds =
          querySnapshot.docs
              .map((doc) => doc.data()['categoryId'] as String)
              .toList();

      /// Get category documents.
      final categories = await Future.wait(
        categoryIds.map(
          (id) => _firestore.collection('categories').doc(id).get(),
        ),
      );

      /// Convert to Category objects.
      final categoryList =
          categories
              .where((doc) => doc.exists)
              .map(
                (doc) => Category.fromJson({'id': doc.id, ...doc.data() ?? {}}),
              )
              .toList();

      return categoryList;
    } catch (e) {
      throw Exception('Error al obtener categorías del lugar: $e');
    }
  }

  /// Gets all places for a category.
  Future<List<Place>> getPlacesInCategory(String categoryId) async {
    try {
      /// Search for associations for this category.
      final querySnapshot =
          await placeCategoriesCollection
              .where('categoryId', isEqualTo: categoryId)
              .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      /// Extract place IDs.
      final placeIds =
          querySnapshot.docs
              .map((doc) => doc.data()['placeId'] as String)
              .toList();

      /// Get place documents.
      final places = await Future.wait(
        placeIds.map((id) => _firestore.collection('places').doc(id).get()),
      );

      /// Convert to Place objects.
      final placeList =
          places
              .where((doc) => doc.exists)
              .map((doc) => Place.fromJson({'id': doc.id, ...doc.data() ?? {}}))
              .toList();

      return placeList;
    } catch (e) {
      throw Exception('Error al obtener lugares por categoría: $e');
    }
  }

  /// Updates the categories for a place (replacing all).
  Future<bool> updatePlaceCategories(
    String placeId,
    List<String> categoryIds,
  ) async {
    try {
      /// Start transaction.
      await _firestore.runTransaction((transaction) async {
        /// Get current categories.
        final querySnapshot =
            await placeCategoriesCollection
                .where('placeId', isEqualTo: placeId)
                .get();

        /// Delete all current associations.
        for (final doc in querySnapshot.docs) {
          transaction.delete(doc.reference);

          /// Decrement the places count in the category.
          final categoryId = doc.data()['categoryId'] as String;
          final categoryRef = _firestore
              .collection('categories')
              .doc(categoryId);
          transaction.update(categoryRef, {
            'placesCount': FieldValue.increment(-1),
          });
        }

        /// Create new associations.
        for (final categoryId in categoryIds) {
          /// Create association document.
          final newAssocRef = placeCategoriesCollection.doc();
          transaction.set(newAssocRef, {
            'placeId': placeId,
            'categoryId': categoryId,
            'createdAt': FieldValue.serverTimestamp(),
          });

          /// Increment the places count in the category.
          final categoryRef = _firestore
              .collection('categories')
              .doc(categoryId);
          transaction.update(categoryRef, {
            'placesCount': FieldValue.increment(1),
          });
        }
      });

      return true;
    } catch (e) {
      throw Exception('Error al actualizar categorías: $e');
    }
  }
}
