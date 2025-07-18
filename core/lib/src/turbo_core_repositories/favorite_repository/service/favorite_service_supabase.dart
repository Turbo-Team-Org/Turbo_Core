import 'package:core/src/turbo_core_repositories/favorite_repository/interface/favorite_interface.dart';
import 'package:core/src/turbo_core_repositories/favorite_repository/models/favorite.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uuid/uuid.dart';

/// Favorite service for Supabase
class FavoriteServiceSupabase implements FavoriteInterface {
  /// Constructor
  FavoriteServiceSupabase({SupabaseClient? supabaseClient})
    : _supabase = supabaseClient ?? Supabase.instance.client;

  /// Supabase client instance
  final SupabaseClient _supabase;

  /// UUID instance
  final _uuid = const Uuid();

  @override
  Future<void> toggleFavorite(Favorite favorite) async {
    try {
      final existingFavorite = await _supabase
          .from('favorites')
          .select('id')
          .eq('user_id', favorite.userId)
          .eq('place_id', favorite.placeId)
          .maybeSingle();

      if (existingFavorite != null) {
        // Remove favorite
        await _supabase
            .from('favorites')
            .delete()
            .eq('id', existingFavorite['id']);
      } else {
        // Add favorite
        final newId = _uuid.v4();
        await _supabase.from('favorites').insert({
          'id': newId,
          'place_id': favorite.placeId,
          'user_id': favorite.userId,
          'created_at': DateTime.now().toIso8601String(),
        });
      }
    } catch (e) {
      throw Exception('Error al actualizar favorito: $e');
    }
  }

  @override
  Future<List<Favorite>> getFavorites(String userId) async {
    try {
      final response = await _supabase
          .from('favorites')
          .select('*')
          .eq('user_id', userId)
          .order('created_at', ascending: false);

      return response.map<Favorite>((data) {
        return Favorite(
          id: data['id'] as String,
          userId: data['user_id'] as String,
          placeId: data['place_id'] as String,
          date: DateTime.parse(data['created_at'] as String),
        );
      }).toList();
    } catch (e) {
      throw Exception('Error al obtener favoritos: $e');
    }
  }

  @override
  Future<bool> isFavorite(String userId, String placeId) async {
    try {
      final response = await _supabase
          .from('favorites')
          .select('id')
          .eq('user_id', userId)
          .eq('place_id', placeId)
          .maybeSingle();

      return response != null;
    } catch (e) {
      throw Exception('Error al verificar favorito: $e');
    }
  }

  @override
  Future<void> addFavorite(String userId, String placeId) async {
    try {
      final newId = _uuid.v4();
      await _supabase.from('favorites').insert({
        'id': newId,
        'place_id': placeId,
        'user_id': userId,
        'created_at': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Error al agregar favorito: $e');
    }
  }

  @override
  Future<void> removeFavorite(String userId, String placeId) async {
    try {
      await _supabase
          .from('favorites')
          .delete()
          .eq('user_id', userId)
          .eq('place_id', placeId);
    } catch (e) {
      throw Exception('Error al eliminar favorito: $e');
    }
  }
}