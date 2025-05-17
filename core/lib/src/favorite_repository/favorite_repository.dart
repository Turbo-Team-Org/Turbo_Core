import 'package:core/src/favorite_repository/models/favorite.dart';
import 'package:core/src/favorite_repository/service/favorite_service.dart';

/// Favorite repository
class FavoriteRepository {
  /// Constructor
  FavoriteRepository({required this.favoriteService});

  /// Favorite service
  final FavoriteService favoriteService;

  /// Toggle favorite

  Future<void> toggleFavorite(Favorite favorite) async {
    await favoriteService.toggleFavorite(favorite);
  }

  /// Get favorites
  Future<List<Favorite>> getFavorites(String userId) async {
    return favoriteService.getFavorites(userId);
  }

  /// Is favorite
  Future<bool> isFavorite(String userId, String placeId) async {
    return favoriteService.isFavorite(userId, placeId);
  }
}
