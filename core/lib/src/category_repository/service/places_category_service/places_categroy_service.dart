import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/category_repository/model/category.dart';
import 'package:core/src/place_repository/models/place/place.dart';

class PlaceCategoryService {
  final FirebaseFirestore _firestore;
  final String _collectionName = 'place_categories';

  PlaceCategoryService({FirebaseFirestore? firestore})
      : _firestore = firestore ?? FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get placeCategoriesCollection =>
      _firestore.collection(_collectionName);

  // Asignar una categoría a un lugar
  Future<bool> assignCategoryToPlace(String placeId, String categoryId) async {
    try {
      await placeCategoriesCollection.doc().set({
        'placeId': placeId,
        'categoryId': categoryId,
        'createdAt': FieldValue.serverTimestamp(),
      });

      // Incrementar contador de lugares en la categoría
      await _firestore.collection('categories').doc(categoryId).update({
        'placesCount': FieldValue.increment(1),
      });

      return true;
    } catch (e) {
      throw Exception('Error al asignar categoría: ${e.toString()}');
    }
  }

  // Eliminar una categoría de un lugar
  Future<bool> removeCategoryFromPlace(
    String placeId,
    String categoryId,
  ) async {
    try {
      // Buscar el documento de asociación
      final querySnapshot = await placeCategoriesCollection
          .where('placeId', isEqualTo: placeId)
          .where('categoryId', isEqualTo: categoryId)
          .get();

      // Eliminar todas las asociaciones encontradas
      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      // Decrementar contador de lugares en la categoría solo si tenía asociación
      if (querySnapshot.docs.isNotEmpty) {
        await _firestore.collection('categories').doc(categoryId).update({
          'placesCount': FieldValue.increment(-1),
        });
      }

      return true;
    } catch (e) {
      throw Exception('Error al eliminar categoría de lugar: ${e.toString()}');
    }
  }

  // Obtener todas las categorías de un lugar
  Future<List<Category>> getCategoriesForPlace(String placeId) async {
    try {
      // Buscar asociaciones para este lugar
      final querySnapshot = await placeCategoriesCollection
          .where('placeId', isEqualTo: placeId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      // Extraer IDs de categoría
      final categoryIds = querySnapshot.docs
          .map((doc) => doc.data()['categoryId'] as String)
          .toList();

      // Obtener documentos de categoría
      final categories = await Future.wait(
        categoryIds.map(
          (id) => _firestore.collection('categories').doc(id).get(),
        ),
      );

      // Convertir a objetos Category
      final categoryList = categories
          .where((doc) => doc.exists)
          .map(
            (doc) => Category.fromJson({'id': doc.id, ...doc.data() ?? {}}),
          )
          .toList();

      return categoryList;
    } catch (e) {
      throw Exception('Error al obtener categorías del lugar: ${e.toString()}');
    }
  }

  // Obtener todos los lugares de una categoría
  Future<List<Place>> getPlacesInCategory(String categoryId) async {
    try {
      // Buscar asociaciones para esta categoría
      final querySnapshot = await placeCategoriesCollection
          .where('categoryId', isEqualTo: categoryId)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return [];
      }

      // Extraer IDs de lugar
      final placeIds = querySnapshot.docs
          .map((doc) => doc.data()['placeId'] as String)
          .toList();

      // Obtener documentos de lugar
      final places = await Future.wait(
        placeIds.map((id) => _firestore.collection('places').doc(id).get()),
      );

      // Convertir a objetos Place
      final placeList = places
          .where((doc) => doc.exists)
          .map((doc) => Place.fromJson({'id': doc.id, ...doc.data() ?? {}}))
          .toList();

      return placeList;
    } catch (e) {
      throw Exception(
        'Error al obtener lugares por categoría: ${e.toString()}',
      );
    }
  }

  // Actualizar categorías de un lugar (reemplazar todas)
  Future<bool> updatePlaceCategories(
    String placeId,
    List<String> categoryIds,
  ) async {
    try {
      // Comenzar transacción
      await _firestore.runTransaction((transaction) async {
        // Obtener categorías actuales
        final querySnapshot = await placeCategoriesCollection
            .where('placeId', isEqualTo: placeId)
            .get();

        // Eliminar todas las asociaciones actuales
        for (var doc in querySnapshot.docs) {
          transaction.delete(doc.reference);

          // Decrementar el contador de lugares
          final categoryId = doc.data()['categoryId'] as String;
          final categoryRef =
              _firestore.collection('categories').doc(categoryId);
          transaction.update(categoryRef, {
            'placesCount': FieldValue.increment(-1),
          });
        }

        // Crear nuevas asociaciones
        for (var categoryId in categoryIds) {
          // Crear documento de asociación
          final newAssocRef = placeCategoriesCollection.doc();
          transaction.set(newAssocRef, {
            'placeId': placeId,
            'categoryId': categoryId,
            'createdAt': FieldValue.serverTimestamp(),
          });

          // Incrementar contador de lugares
          final categoryRef =
              _firestore.collection('categories').doc(categoryId);
          transaction.update(categoryRef, {
            'placesCount': FieldValue.increment(1),
          });
        }
      });

      return true;
    } catch (e) {
      throw Exception('Error al actualizar categorías: ${e.toString()}');
    }
  }
}
