import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/place_category_repository/interface/place_category_repository_interface.dart';
import 'package:core/src/turbo_core_repositories/place_category_repository/models/place_category.dart';
import 'package:core/src/turbo_core_repositories/place_repository/models/place/place.dart';

class PlaceCategoryService implements PlaceCategoryRepositoryInterface {
  PlaceCategoryService({FirebaseFirestore? firestore})
      : firestore = firestore ?? FirebaseFirestore.instance;
  final FirebaseFirestore firestore;
  final String _collectionName = 'place_categories';

  CollectionReference<Map<String, dynamic>> get placeCategoriesCollection =>
      firestore.collection(_collectionName);

  Future<void> upsertPlaceCategory(PlaceCategory placeCategory) async {
    await placeCategoriesCollection
        .doc('${placeCategory.placeId}_${placeCategory.categoryId}')
        .set({
      'placeId': placeCategory.placeId,
      'categoryId': placeCategory.categoryId,
      'createdAt': placeCategory.createdAt,
    });
  }

  /// Asigna una categoría a un lugar
  Future<bool> assignCategoryToPlace(String placeId, String categoryId) async {
    try {
      await placeCategoriesCollection.doc().set({
        'placeId': placeId,
        'categoryId': categoryId,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await firestore.collection('categories').doc(categoryId).update({
        'placesCount': FieldValue.increment(1),
      });
      return true;
    } catch (e) {
      throw Exception('Error al asignar categoría: $e');
    }
  }

  /// Elimina una categoría de un lugar
  Future<bool> removeCategoryFromPlace(
    String placeId,
    String categoryId,
  ) async {
    try {
      final querySnapshot = await placeCategoriesCollection
          .where('placeId', isEqualTo: placeId)
          .where('categoryId', isEqualTo: categoryId)
          .get();
      for (final doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
      if (querySnapshot.docs.isNotEmpty) {
        await firestore.collection('categories').doc(categoryId).update({
          'placesCount': FieldValue.increment(-1),
        });
      }
      return true;
    } catch (e) {
      throw Exception('Error al eliminar categoría de lugar: $e');
    }
  }

  /// Actualiza todas las categorías de un lugar
  Future<bool> updatePlaceCategories(
    String placeId,
    List<String> categoryIds,
  ) async {
    try {
      await firestore.runTransaction((transaction) async {
        final querySnapshot = await placeCategoriesCollection
            .where('placeId', isEqualTo: placeId)
            .get();
        for (final doc in querySnapshot.docs) {
          transaction.delete(doc.reference);
          final categoryId = doc.data()['categoryId'] as String;
          final categoryRef =
              firestore.collection('categories').doc(categoryId);
          transaction.update(categoryRef, {
            'placesCount': FieldValue.increment(-1),
          });
        }
        for (final categoryId in categoryIds) {
          final newAssocRef = placeCategoriesCollection.doc();
          transaction.set(newAssocRef, {
            'placeId': placeId,
            'categoryId': categoryId,
            'createdAt': FieldValue.serverTimestamp(),
          });
          final categoryRef =
              firestore.collection('categories').doc(categoryId);
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

  /// Obtiene todos los lugares de una categoría
  Future<List<Place>> getPlacesInCategory(String categoryId) async {
    try {
      final querySnapshot = await placeCategoriesCollection
          .where('categoryId', isEqualTo: categoryId)
          .get();
      if (querySnapshot.docs.isEmpty) {
        return [];
      }
      final placeIds = querySnapshot.docs
          .map((doc) => doc.data()['placeId'] as String)
          .toList();
      final places = await Future.wait(
        placeIds.map((id) => firestore.collection('places').doc(id).get()),
      );
      final placeList = places
          .where((doc) => doc.exists)
          .map((doc) => Place.fromJson({'id': doc.id, ...doc.data() ?? {}}))
          .toList();
      return placeList;
    } catch (e) {
      throw Exception('Error al obtener lugares por categoría: $e');
    }
  }
}
