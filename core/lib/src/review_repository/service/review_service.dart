import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/review_repository/interface/review_interface.dart';
import 'package:core/src/review_repository/models/review.dart';

/// Review service
class ReviewService implements ReviewInterface {
  /// Constructor
  ReviewService({required this.firestore});

  /// Firebase firestore
  final FirebaseFirestore firestore;

  @override
  Future<List<Review>> getReviews() async {
    try {
      final snapshot = await firestore.collectionGroup('reviews').get();
      return snapshot.docs
          .map((doc) => Review.fromFirestore(doc.data()))
          .toList();
    } catch (e) {
      throw Exception('Error al obtener las reseñas: $e');
    }
  }

  @override
  Future<List<Review>> getReviewsFromAPlace(String placeId) async {
    try {
      final snapshot =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('reviews')
              .orderBy('date', descending: true)
              .get();

      return snapshot.docs.map((doc) {
        final data = doc.data();
        data['id'] = doc.id;
        return Review.fromFirestore(data);
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener las reseñas del lugar: $e');
    }
  }

  @override
  Future<void> addReview(Review review, String placeId) async {
    try {
      final placeRef = firestore.collection('places').doc(placeId);
      final reviewRef = placeRef.collection('reviews').doc(review.id);

      // Usamos una transacción para asegurar la consistencia de los datos
      await firestore.runTransaction((transaction) async {
        // Añadir la reseña
        transaction.set(reviewRef, review.toJson());

        // Actualizar el contador de reseñas y el rating promedio
        final placeDoc = await transaction.get(placeRef);
        final currentData = placeDoc.data() ?? {};
        final currentCount = (currentData['reviews_count'] ?? 0) as int;
        final currentRating = (currentData['rating'] ?? 0.0) as double;

        // Calcular nuevo rating promedio
        final newRating =
            ((currentRating * currentCount) + review.rating) /
            (currentCount + 1);

        transaction.update(placeRef, {
          'reviews_count': currentCount + 1,
          'rating': newRating,
        });
      });
    } catch (e) {
      throw Exception('Error al añadir la reseña: $e');
    }
  }

  @override
  Future<void> updateReview(Review review) async {
    try {
      // Primero necesitamos encontrar el lugar al que pertenece la reseña
      final querySnapshot =
          await firestore
              .collectionGroup('reviews')
              .where('id', isEqualTo: review.id)
              .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('No se encontró la reseña');
      }

      final doc = querySnapshot.docs.first;
      await doc.reference.update(review.toJson());
    } catch (e) {
      throw Exception('Error al actualizar la reseña: $e');
    }
  }

  @override
  Future<void> deleteReview(String reviewId) async {
    try {
      // Primero necesitamos encontrar el lugar al que pertenece la reseña
      final querySnapshot =
          await firestore
              .collectionGroup('reviews')
              .where('id', isEqualTo: reviewId)
              .get();

      if (querySnapshot.docs.isEmpty) {
        throw Exception('No se encontró la reseña');
      }

      final doc = querySnapshot.docs.first;
      final placeRef = doc.reference.parent.parent!;

      // Usamos una transacción para actualizar también el contador y rating
      await firestore.runTransaction((transaction) async {
        final reviewDoc = await transaction.get(doc.reference);
        final review = Review.fromFirestore(reviewDoc.data()!);

        // Eliminar la reseña
        transaction.delete(doc.reference);

        // Actualizar el contador y rating del lugar
        final placeDoc = await transaction.get(placeRef);
        final currentData = placeDoc.data() ?? {};
        final currentCount = (currentData['reviews_count'] ?? 0) as int;
        final currentRating = (currentData['rating'] ?? 0.0) as double;

        if (currentCount > 1) {
          // Recalcular el rating promedio excluyendo la reseña eliminada
          final newRating =
              ((currentRating * currentCount) - review.rating) /
              (currentCount - 1);
          transaction.update(placeRef, {
            'reviews_count': currentCount - 1,
            'rating': newRating,
          });
        } else {
          // Si era la última reseña, resetear los valores
          transaction.update(placeRef, {'reviews_count': 0, 'rating': 0.0});
        }
      });
    } catch (e) {
      throw Exception('Error al eliminar la reseña: $e');
    }
  }
}
