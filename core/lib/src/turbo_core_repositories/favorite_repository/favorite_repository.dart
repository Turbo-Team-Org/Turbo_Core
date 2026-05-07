import 'package:core/src/turbo_core_repositories/favorite_repository/interface/favorite_interface.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/models/favorite.dart';

/// Repository for managing user favorites and their operations.
///
/// This repository provides a clean interface for favorite-related operations,
/// following Clean Architecture principles and handling all business logic
/// related to user favorites.
class FavoriteRepository implements FavoriteInterface {
  /// Constructor for the FavoriteRepository.
  FavoriteRepository({required this.favoriteService});

  /// Favorite service instance for data operations (now accepts interface for environment flexibility)
  final FavoriteInterface favoriteService;

  // ==================== READ OPERATIONS ====================

  /// Gets all favorites for a specific user.
  ///
  /// [userId] The unique identifier of the user.
  ///
  /// Returns a list of favorites with their associated place information.
  /// Throws an exception if the operation fails.
  @override
  Future<List<Favorite>> getFavorites(String userId) async {
    try {
      return await favoriteService.getFavorites(userId);
    } catch (e) {
      throw Exception('Error al obtener favoritos: $e');
    }
  }

  /// Checks if a place is marked as favorite by a user.
  ///
  /// [userId] The unique identifier of the user.
  /// [placeId] The unique identifier of the place.
  ///
  /// Returns true if the place is in the user's favorites, false otherwise.
  /// Throws an exception if the operation fails.
  @override
  Future<bool> isFavorite(String userId, String placeId) async {
    try {
      return await favoriteService.isFavorite(userId, placeId);
    } catch (e) {
      throw Exception('Error al verificar favorito: $e');
    }
  }

  // ==================== CREATE OPERATIONS ====================

  /// Adds a place to user's favorites.
  ///
  /// [userId] The unique identifier of the user.
  /// [placeId] The unique identifier of the place to add to favorites.
  ///
  /// Returns true if the favorite was successfully added.
  /// Throws an exception if the operation fails or if already exists.
  @override
  Future<bool> addFavorite(String userId, String placeId) async {
    try {
      // Check if already exists to avoid duplicates
      final isAlreadyFavorite = await favoriteService.isFavorite(
        userId,
        placeId,
      );
      if (isAlreadyFavorite) {
        throw Exception('El lugar ya está en favoritos');
      }

      await favoriteService.addFavorite(userId, placeId);
      return true;
    } catch (e) {
      throw Exception('Error al agregar favorito: $e');
    }
  }

  // ==================== UPDATE OPERATIONS ====================

  /// Toggles the favorite status of a place for a user.
  ///
  /// [favorite] The favorite object containing user and place information.
  ///
  /// If the place is already a favorite, it will be removed.
  /// If the place is not a favorite, it will be added.
  /// Throws an exception if the operation fails.
  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    try {
      await favoriteService.toggleFavorite(favorite);
    } catch (e) {
      throw Exception('Error al alternar favorito: $e');
    }
  }

  // ==================== DELETE OPERATIONS ====================

  /// Removes a place from user's favorites.
  ///
  /// [userId] The unique identifier of the user.
  /// [placeId] The unique identifier of the place to remove from favorites.
  ///
  /// Returns true if the favorite was successfully removed.
  /// Throws an exception if the operation fails or if not found.
  Future<bool> removeFavorite(String userId, String placeId) async {
    try {
      await favoriteService.removeFavorite(userId, placeId);
      return true;
    } catch (e) {
      throw Exception('Error al eliminar favorito: $e');
    }
  }

  // ==================== SEARCH OPERATIONS ====================

  /// Gets favorites filtered by place category.
  ///
  /// [userId] The unique identifier of the user.
  /// [categoryId] The unique identifier of the category to filter by.
  ///
  /// Returns a list of favorites that belong to the specified category.
  Future<List<Favorite>> getFavoritesByCategory(
    String userId,
    String categoryId,
  ) async {
    try {
      final allFavorites = await favoriteService.getFavorites(userId);

      return allFavorites.where((favorite) {
        return favorite.place?.categoryId == categoryId;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener favoritos por categoría: $e');
    }
  }

  /// Searches favorites based on a query string.
  ///
  /// [userId] The unique identifier of the user.
  /// [query] The search term to look for in place names and descriptions.
  ///
  /// Returns a list of favorites that match the search criteria.
  Future<List<Favorite>> searchFavorites(String userId, String query) async {
    try {
      final allFavorites = await favoriteService.getFavorites(userId);
      final lowercaseQuery = query.toLowerCase();

      return allFavorites.where((favorite) {
        final place = favorite.place;
        if (place == null) return false;

        return place.name.toLowerCase().contains(lowercaseQuery) ||
            place.description.toLowerCase().contains(lowercaseQuery) ||
            place.tags.any((tag) => tag.toLowerCase().contains(lowercaseQuery));
      }).toList();
    } catch (e) {
      throw Exception('Error al buscar favoritos: $e');
    }
  }

  /// Gets favorites sorted by date added (most recent first).
  ///
  /// [userId] The unique identifier of the user.
  /// [limit] Optional limit for the number of favorites to return.
  ///
  /// Returns a list of favorites sorted by date added.
  Future<List<Favorite>> getFavoritesSortedByDate(
    String userId, {
    int? limit,
  }) async {
    try {
      final allFavorites = await favoriteService.getFavorites(userId);

      final sortedFavorites = allFavorites.toList()
        ..sort((a, b) => b.date.compareTo(a.date)); // Most recent first

      if (limit != null && limit > 0) {
        return sortedFavorites.take(limit).toList();
      }

      return sortedFavorites;
    } catch (e) {
      throw Exception('Error al obtener favoritos ordenados por fecha: $e');
    }
  }

  /// Gets favorites filtered by place rating range.
  ///
  /// [userId] The unique identifier of the user.
  /// [minRating] The minimum rating (inclusive).
  /// [maxRating] The maximum rating (inclusive).
  ///
  /// Returns a list of favorites within the specified rating range.
  Future<List<Favorite>> getFavoritesByRating({
    required String userId,
    required double minRating,
    required double maxRating,
  }) async {
    try {
      final allFavorites = await favoriteService.getFavorites(userId);

      return allFavorites.where((favorite) {
        final place = favorite.place;
        if (place == null) return false;
        return place.rating >= minRating && place.rating <= maxRating;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener favoritos por calificación: $e');
    }
  }

  /// Gets favorites filtered by place price range.
  ///
  /// [userId] The unique identifier of the user.
  /// [minPrice] The minimum average price (inclusive).
  /// [maxPrice] The maximum average price (inclusive).
  ///
  /// Returns a list of favorites within the specified price range.
  // Future<List<Favorite>> getFavoritesByPriceRange({
  //   required String userId,
  //   required double minPrice,
  //   required double maxPrice,
  // }) async {
  //   try {
  //     final allFavorites = await favoriteService.getFavorites(userId);

  //     return allFavorites.where((favorite) {
  //       final place = favorite.place;
  //       if (place == null) return false;
  //       return place.averagePrice >= minPrice && place.averagePrice <= maxPrice;
  //     }).toList();
  //   } catch (e) {
  //     throw Exception('Error al obtener favoritos por rango de precio: $e');
  //   }
  // }

  /// Gets only favorites of places that are currently open.
  ///
  /// [userId] The unique identifier of the user.
  ///
  /// Returns a list of favorites where the places are marked as open.
  Future<List<Favorite>> getOpenFavorites(String userId) async {
    try {
      final allFavorites = await favoriteService.getFavorites(userId);

      return allFavorites.where((favorite) {
        final place = favorite.place;
        return place?.isOpen == true;
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener favoritos abiertos: $e');
    }
  }

  /// Gets the count of favorites for a user.
  ///
  /// [userId] The unique identifier of the user.
  ///
  /// Returns the total number of favorites for the user.
  Future<int> getFavoritesCount(String userId) async {
    try {
      final favorites = await favoriteService.getFavorites(userId);
      return favorites.length;
    } catch (e) {
      throw Exception('Error al obtener conteo de favoritos: $e');
    }
  }

  /// Removes all favorites for a user.
  ///
  /// [userId] The unique identifier of the user.
  ///
  /// Returns true if all favorites were successfully removed.
  /// This is useful for account cleanup or user preferences reset.
  Future<bool> clearAllFavorites(String userId) async {
    try {
      final favorites = await favoriteService.getFavorites(userId);

      // Remove each favorite individually
      for (final favorite in favorites) {
        await favoriteService.removeFavorite(userId, favorite.placeId);
      }

      return true;
    } catch (e) {
      throw Exception('Error al limpiar todos los favoritos: $e');
    }
  }

  /// Checks if user has any favorites.
  ///
  /// [userId] The unique identifier of the user.
  ///
  /// Returns true if the user has at least one favorite, false otherwise.
  Future<bool> hasFavorites(String userId) async {
    try {
      final count = await getFavoritesCount(userId);
      return count > 0;
    } catch (e) {
      throw Exception('Error al verificar si tiene favoritos: $e');
    }
  }
}
