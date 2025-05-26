import 'package:core/src/turbo_core_repositories/favorite_repository/models/favorite.dart';

/// Favorite interface
abstract class FavoriteInterface {
  // ==================== READ OPERATIONS ====================

  /// Get favorites
  Future<List<Favorite>> getFavorites(String userId);

  /// Is favorite
  Future<bool> isFavorite(String userId, String placeId);

  // ==================== CREATE OPERATIONS ====================

  /// Add favorite
  Future<void> addFavorite(String userId, String placeId);

  // ==================== UPDATE OPERATIONS ====================

  /// Toggle favorite
  Future<void> toggleFavorite(Favorite favorite);

  // ==================== DELETE OPERATIONS ====================

  /// Remove favorite
  Future<void> removeFavorite(String userId, String placeId);
}
