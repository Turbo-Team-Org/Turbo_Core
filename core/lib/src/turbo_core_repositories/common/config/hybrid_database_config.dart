import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Configuración híbrida para Firebase + Supabase
/// Firebase: Google Maps APIs, Places, Geocoding
/// Supabase: Business logic, Auth, Database principal
class HybridDatabaseConfig {
  static late FirebaseFirestore _firestore;
  static late SupabaseClient _supabase;

  static bool _isInitialized = false;

  // Getters
  static FirebaseFirestore get firestore {
    if (!_isInitialized) {
      throw Exception('HybridDatabaseConfig no ha sido inicializado');
    }
    return _firestore;
  }

  static SupabaseClient get supabase {
    if (!_isInitialized) {
      throw Exception('HybridDatabaseConfig no ha sido inicializado');
    }
    return _supabase;
  }

  static bool get isInitialized => _isInitialized;

  /// Inicializar configuración híbrida
  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
    String? firebaseProjectId,
  }) async {
    try {
      // 1. Inicializar Firebase (solo para Google APIs)
      if (Firebase.apps.isEmpty) {
        await Firebase.initializeApp();
      }
      _firestore = FirebaseFirestore.instance;

      // 2. Inicializar Supabase (lógica de negocio principal)
      await Supabase.initialize(
        url: supabaseUrl,
        anonKey: supabaseAnonKey,
        debug: false, // Cambiar a true en desarrollo
      );
      _supabase = Supabase.instance.client;

      _isInitialized = true;

      print('✅ Configuración híbrida inicializada correctamente');
      print('🔥 Firebase: Solo Google APIs');
      print('💚 Supabase: Lógica de negocio principal');
    } catch (e) {
      throw Exception('Error inicializando configuración híbrida: $e');
    }
  }

  /// Limpiar recursos
  static Future<void> dispose() async {
    if (_isInitialized) {
      // Supabase se limpia automáticamente
      // Firebase mantiene conexión para Google APIs
      _isInitialized = false;
    }
  }
}

/// Enum para identificar qué base de datos usar
enum DatabaseProvider {
  firebase, // Solo para datos temporales de Google APIs
  supabase, // Para toda la lógica de negocio
}

/// Configuración específica por repositorio
class RepositoryConfig {
  // Repositories que usan Supabase (lógica de negocio)
  static const Set<String> supabaseRepositories = {
    'PlaceRepository',
    'UserRepository',
    'ReviewRepository',
    'ReservationRepository',
    'CategoryRepository',
    'EventRepository',
    'OfferRepository',
    'AnalyticsRepository',
    'AuthRepository', // Migrar gradualmente
  };

  // Repositories que usan Firebase (solo Google APIs)
  static const Set<String> firebaseRepositories = {
    'GoogleMapsRepository', // Para Google Places API
    'GeocodingRepository', // Para Geocoding API
    'LocationCacheRepository', // Cache temporal de Google APIs
  };

  /// Determinar qué base de datos usar según el repositorio
  static DatabaseProvider getProviderFor(String repositoryName) {
    if (supabaseRepositories.contains(repositoryName)) {
      return DatabaseProvider.supabase;
    } else if (firebaseRepositories.contains(repositoryName)) {
      return DatabaseProvider.firebase;
    } else {
      // Por defecto usar Supabase para nuevos repositorios
      return DatabaseProvider.supabase;
    }
  }
}
