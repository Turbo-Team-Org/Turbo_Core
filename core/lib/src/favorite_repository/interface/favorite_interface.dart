import 'package:core/src/favorite_repository/models/favorite.dart';

/// Favorite interface
abstract class FavoriteInterface {
  /// Get favorites
  Future<List<Favorite>> getFavorites(String userId);

  /// Toggle favorite
  Future<void> toggleFavorite(Favorite favorite);

  /// Is favorite
  Future<bool> isFavorite(String userId, String placeId);

  /// Add favorite
  Future<void> addFavorite(String userId, String placeId);
}
