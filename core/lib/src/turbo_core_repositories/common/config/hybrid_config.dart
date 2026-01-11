import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

/// Configuración híbrida Firebase + Supabase
class HybridConfig {
  static late FirebaseFirestore _firestore;
  static late SupabaseClient _supabase;
  static bool _isInitialized = false;

  static FirebaseFirestore get firestore => _firestore;
  static SupabaseClient get supabase => _supabase;
  static bool get isInitialized => _isInitialized;

  static Future<void> initialize({
    required String supabaseUrl,
    required String supabaseAnonKey,
  }) async {
    // 1. Firebase (solo Google APIs)
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
    _firestore = FirebaseFirestore.instance;

    // 2. Supabase (lógica principal)
    await Supabase.initialize(
      url: supabaseUrl,
      anonKey: supabaseAnonKey,
    );
    _supabase = Supabase.instance.client;

    _isInitialized = true;
  }
}
