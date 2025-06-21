import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'place_category.freezed.dart';
part 'place_category.g.dart';

/// Modelo que representa la relación entre un lugar y una categoría
@freezed
sealed class PlaceCategory with _$PlaceCategory {
  const factory PlaceCategory({
    required String placeId,
    required String categoryId,
    required DateTime createdAt,
    String? createdBy,
    Map<String, dynamic>? metadata,
  }) = _PlaceCategory;

  const PlaceCategory._();

  factory PlaceCategory.fromJson(Map<String, dynamic> json) =>
      _$PlaceCategoryFromJson(json);

  /// Crear desde datos de Firestore
  factory PlaceCategory.fromFirestore(Map<String, dynamic> data) {
    return PlaceCategory(
      placeId: data['placeId'] as String,
      categoryId: data['categoryId'] as String,
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      createdBy: data['createdBy'] as String?,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convertir a formato Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'placeId': placeId,
      'categoryId': categoryId,
      'createdAt': Timestamp.fromDate(createdAt),
      if (createdBy != null) 'createdBy': createdBy,
      if (metadata != null) 'metadata': metadata,
    };
  }

  /// Verificar si la asociación es válida
  bool get isValid => placeId.isNotEmpty && categoryId.isNotEmpty;

  /// Obtener ID único para la asociación
  String get associationId => '${placeId}_$categoryId';
}
