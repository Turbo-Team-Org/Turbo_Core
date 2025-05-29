import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/src/turbo_core_repositories/analytics_repository/service/analytics_service.dart';

/// Utilidad para migrar lugares existentes a la nueva estructura de analytics
class AnalyticsMigration {
  /// Constructor
  AnalyticsMigration({required this.firestore, required this.analyticsService});

  /// Firestore instance
  final FirebaseFirestore firestore;

  /// Analytics service
  final AnalyticsService analyticsService;

  /// Inicializa analytics para todos los lugares existentes que no lo tengan
  /// USAR CON CUIDADO - Solo ejecutar una vez en producción
  Future<void> migrateAllExistingPlaces() async {
    try {
      print('🚀 Iniciando migración de analytics para lugares existentes...');

      // Obtener todos los lugares
      final placesSnapshot = await firestore.collection('places').get();
      final totalPlaces = placesSnapshot.docs.length;

      print('📊 Encontrados $totalPlaces lugares para migrar');

      var migratedCount = 0;
      var skippedCount = 0;
      var errorCount = 0;

      for (final placeDoc in placesSnapshot.docs) {
        final placeId = placeDoc.id;
        final placeName = placeDoc.data()['name'] as String? ?? 'Sin nombre';

        try {
          // Verificar si ya tiene estructura de analytics
          final hasAnalytics = await _hasAnalyticsStructure(placeId);

          if (hasAnalytics) {
            print('⏭️  Saltando $placeName (ya tiene analytics)');
            skippedCount++;
            continue;
          }

          // Inicializar estructura de analytics
          await analyticsService.initializeAnalyticsStructure(placeId);
          migratedCount++;

          print('✅ Migrado: $placeName ($migratedCount/$totalPlaces)');

          // Pequeña pausa para no sobrecargar Firestore
          await Future.delayed(const Duration(milliseconds: 100));
        } catch (e) {
          errorCount++;
          print('❌ Error migrando $placeName: $e');
        }
      }

      print('\n🎉 Migración completada:');
      print('  ✅ Migrados: $migratedCount');
      print('  ⏭️  Saltados: $skippedCount');
      print('  ❌ Errores: $errorCount');
      print('  📊 Total: $totalPlaces');
    } catch (e) {
      throw Exception('Error en migración masiva: $e');
    }
  }

  /// Inicializa analytics para un lugar específico (solo si no existe)
  Future<bool> migrateSinglePlace(String placeId) async {
    try {
      // Verificar si el lugar existe
      final placeDoc = await firestore.collection('places').doc(placeId).get();
      if (!placeDoc.exists) {
        throw Exception('Lugar no encontrado: $placeId');
      }

      // Verificar si ya tiene analytics
      final hasAnalytics = await _hasAnalyticsStructure(placeId);
      if (hasAnalytics) {
        print('⏭️  El lugar ya tiene estructura de analytics');
        return false;
      }

      // Inicializar analytics
      await analyticsService.initializeAnalyticsStructure(placeId);

      final placeName = placeDoc.data()?['name'] as String? ?? 'Sin nombre';
      print('✅ Analytics inicializados para: $placeName');

      return true;
    } catch (e) {
      throw Exception('Error migrando lugar individual: $e');
    }
  }

  /// Verifica si un lugar ya tiene estructura de analytics
  Future<bool> _hasAnalyticsStructure(String placeId) async {
    try {
      final summaryDoc =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('analytics')
              .doc('summary')
              .get();

      return summaryDoc.exists;
    } catch (e) {
      return false;
    }
  }

  /// Regenera la estructura de analytics para un lugar (fuerza recreación)
  Future<void> regenerateAnalyticsStructure(String placeId) async {
    try {
      print('🔄 Regenerando estructura de analytics para: $placeId');

      // Limpiar estructura existente
      await analyticsService.cleanupAnalyticsStructure(placeId);

      // Esperar un momento para que se complete la limpieza
      await Future.delayed(const Duration(seconds: 1));

      // Recrear estructura
      await analyticsService.initializeAnalyticsStructure(placeId);

      print('✅ Estructura de analytics regenerada');
    } catch (e) {
      throw Exception('Error regenerando analytics: $e');
    }
  }

  /// Obtiene estadísticas de migración
  Future<MigrationStats> getMigrationStats() async {
    try {
      final placesSnapshot = await firestore.collection('places').get();
      final totalPlaces = placesSnapshot.docs.length;

      var withAnalytics = 0;
      var withoutAnalytics = 0;

      for (final placeDoc in placesSnapshot.docs) {
        final hasAnalytics = await _hasAnalyticsStructure(placeDoc.id);
        if (hasAnalytics) {
          withAnalytics++;
        } else {
          withoutAnalytics++;
        }
      }

      return MigrationStats(
        totalPlaces: totalPlaces,
        withAnalytics: withAnalytics,
        withoutAnalytics: withoutAnalytics,
        migrationProgress:
            totalPlaces > 0 ? (withAnalytics / totalPlaces) * 100 : 0,
      );
    } catch (e) {
      throw Exception('Error obteniendo estadísticas: $e');
    }
  }
}

/// Estadísticas de migración
class MigrationStats {
  /// Constructor
  const MigrationStats({
    required this.totalPlaces,
    required this.withAnalytics,
    required this.withoutAnalytics,
    required this.migrationProgress,
  });

  /// Total de lugares
  final int totalPlaces;

  /// Lugares con analytics
  final int withAnalytics;

  /// Lugares sin analytics
  final int withoutAnalytics;

  /// Progreso de migración (0-100)
  final double migrationProgress;

  @override
  String toString() {
    return '''
📊 Estadísticas de Migración:
  Total de lugares: $totalPlaces
  Con analytics: $withAnalytics
  Sin analytics: $withoutAnalytics
  Progreso: ${migrationProgress.toStringAsFixed(1)}%
''';
  }
}
