import 'package:cloud_firestore/cloud_firestore.dart';

/// Utilidad de migración para Analytics Repository
/// Migra de la arquitectura de subcollections a collections separadas
class AnalyticsMigration {
  /// Constructor
  AnalyticsMigration({required this.firestore});

  /// Firebase Firestore instance
  final FirebaseFirestore firestore;

  // ==================== NOMBRES DE COLLECTIONS ====================

  /// Collections de la NUEVA arquitectura (separadas)
  static const String _analyticsPlacesCollection = 'analytics_places';
  static const String _analyticsTrafficCollection = 'analytics_traffic';
  static const String _analyticsReviewsCollection = 'analytics_reviews';
  static const String _analyticsEventsCollection = 'analytics_events';
  static const String _analyticsRealtimeCollection = 'analytics_realtime';
  static const String _analyticsContentCollection = 'analytics_content';

  // ==================== MIGRACIÓN COMPLETA ====================

  /// Migra todos los lugares existentes a la nueva estructura
  /// 🚨 EJECUTAR CON PRECAUCIÓN: Este proceso puede tomar tiempo y recursos
  Future<void> migrateAllExistingPlaces({
    int batchSize = 50,
    void Function(String placeId, String status)? onProgress,
  }) async {
    try {
      print('🔄 Iniciando migración completa de analytics...');

      // Obtener todos los lugares existentes
      final placesSnapshot = await firestore.collection('places').get();
      final totalPlaces = placesSnapshot.docs.length;

      print('📊 Total de lugares a migrar: $totalPlaces');

      var migratedCount = 0;
      var failedCount = 0;
      final failedPlaces = <String>[];

      // Procesar en batches para evitar timeouts
      for (int i = 0; i < placesSnapshot.docs.length; i += batchSize) {
        final batchDocs = placesSnapshot.docs.skip(i).take(batchSize);

        for (final placeDoc in batchDocs) {
          final placeId = placeDoc.id;

          try {
            onProgress?.call(placeId, 'Migrando...');
            await migrateSinglePlace(placeId);
            migratedCount++;
            onProgress?.call(placeId, 'Completado ✅');

            print('✅ Migrado: $placeId ($migratedCount/$totalPlaces)');
          } catch (e) {
            failedCount++;
            failedPlaces.add(placeId);
            onProgress?.call(placeId, 'Error ❌');

            print('❌ Error migrando $placeId: $e');
          }
        }

        // Pausa entre batches para evitar sobrecarga
        if (i + batchSize < placesSnapshot.docs.length) {
          await Future.delayed(const Duration(seconds: 2));
        }
      }

      print('🎉 Migración completada!');
      print('✅ Migrados exitosamente: $migratedCount');
      print('❌ Fallos: $failedCount');

      if (failedPlaces.isNotEmpty) {
        print('🚨 Lugares con errores: ${failedPlaces.join(', ')}');
      }
    } catch (e) {
      throw Exception('Error durante la migración masiva: $e');
    }
  }

  /// Migra un lugar específico de subcollections a collections separadas
  Future<void> migrateSinglePlace(String placeId) async {
    try {
      print('🔄 Migrando lugar: $placeId');

      // 1. Migrar datos de resumen
      await _migrateAnalyticsSummary(placeId);

      // 2. Migrar datos de tiempo real
      await _migrateRealtimeData(placeId);

      // 3. Migrar contenido popular
      await _migratePopularContent(placeId);

      // 4. Migrar tráfico por hora
      await _migrateHourlyTraffic(placeId);

      // 5. Migrar tráfico diario
      await _migrateDailyTraffic(placeId);

      // 6. Migrar eventos de visitas
      await _migrateVisitEvents(placeId);

      // 7. Migrar eventos de conversión
      await _migrateConversionEvents(placeId);

      print('✅ Migración completada para: $placeId');
    } catch (e) {
      throw Exception('Error migrando lugar $placeId: $e');
    }
  }

  /// Regenera completamente la estructura de analytics para un lugar
  /// Elimina datos antiguos y recrea con nueva estructura
  Future<void> regenerateAnalyticsStructure(String placeId) async {
    try {
      print('🔄 Regenerando estructura de analytics para: $placeId');

      // 1. Limpiar estructura antigua
      await _cleanupOldStructure(placeId);

      // 2. Limpiar estructura nueva (si existe)
      await _cleanupNewStructure(placeId);

      // 3. Crear nueva estructura limpia
      await _initializeCleanStructure(placeId);

      print('✅ Estructura regenerada para: $placeId');
    } catch (e) {
      throw Exception('Error regenerando estructura para $placeId: $e');
    }
  }

  /// Obtiene estadísticas del estado de migración
  Future<Map<String, dynamic>> getMigrationStats() async {
    try {
      final stats = <String, dynamic>{};

      // Contar lugares totales
      final placesSnapshot = await firestore.collection('places').get();
      stats['total_places'] = placesSnapshot.docs.length;

      // Contar lugares migrados (que tienen datos en collections nuevas)
      final migratedSnapshot =
          await firestore.collection(_analyticsPlacesCollection).get();
      stats['migrated_places'] = migratedSnapshot.docs.length;

      // Calcular pendientes
      stats['pending_places'] =
          stats['total_places'] - stats['migrated_places'];

      // Porcentaje de migración
      final totalPlaces = stats['total_places'] as int;
      final migrationPercentage =
          totalPlaces > 0
              ? (stats['migrated_places'] / totalPlaces * 100).round()
              : 0;
      stats['migration_percentage'] = migrationPercentage;

      // Contar documentos en collections nuevas
      final trafficSnapshot =
          await firestore.collection(_analyticsTrafficCollection).get();
      stats['traffic_records'] = trafficSnapshot.docs.length;

      final eventsSnapshot =
          await firestore.collection(_analyticsEventsCollection).get();
      stats['event_records'] = eventsSnapshot.docs.length;

      stats['last_checked'] = DateTime.now();

      return stats;
    } catch (e) {
      throw Exception('Error obteniendo estadísticas de migración: $e');
    }
  }

  // ==================== MÉTODOS PRIVADOS DE MIGRACIÓN ====================

  Future<void> _migrateAnalyticsSummary(String placeId) async {
    try {
      // Obtener datos de resumen de la estructura antigua
      final oldSummaryDoc =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('analytics')
              .doc('summary')
              .get();

      final oldData = oldSummaryDoc.data() ?? <String, dynamic>{};
      final now = DateTime.now();

      // Crear documento en nueva estructura
      await firestore.collection(_analyticsPlacesCollection).doc(placeId).set({
        'placeId': placeId,
        'total_views': oldData['total_views'] ?? 0,
        'unique_visitors': oldData['unique_visitors'] ?? 0,
        'total_conversions': oldData['total_conversions'] ?? 0,
        'average_rating': 0.0, // Se recalculará desde el lugar
        'total_reviews': 0, // Se recalculará desde el lugar
        'total_favorites': 0, // Se recalculará desde el lugar
        'conversion_rate': oldData['conversion_rate'] ?? 0.0,
        'total_events': oldData['total_events'] ?? 0,
        'avg_session_duration': oldData['avg_session_duration'] ?? 0.0,
        'created_at': oldData['created_at'] ?? now,
        'updated_at': now,
        'migrated_at': now,
      });

      print('📊 Resumen migrado para: $placeId');
    } catch (e) {
      print('⚠️ Error migrando resumen para $placeId: $e');
    }
  }

  Future<void> _migrateRealtimeData(String placeId) async {
    try {
      // Obtener datos de tiempo real de la estructura antigua
      final oldRealtimeDoc =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('analytics')
              .doc('realtime')
              .get();

      final oldData = oldRealtimeDoc.data() ?? <String, dynamic>{};
      final now = DateTime.now();

      // Crear documento en nueva estructura
      await firestore
          .collection(_analyticsRealtimeCollection)
          .doc(placeId)
          .set({
            'placeId': placeId,
            'activeUsers': oldData['activeUsers'] ?? 0,
            'currentSessions': oldData['currentSessions'] ?? 0,
            'lastUpdated': oldData['lastUpdated'] ?? now,
            'migrated_at': now,
          });

      print('⚡ Datos en tiempo real migrados para: $placeId');
    } catch (e) {
      print('⚠️ Error migrando tiempo real para $placeId: $e');
    }
  }

  Future<void> _migratePopularContent(String placeId) async {
    try {
      // Obtener contenido popular de la estructura antigua
      final oldContentDoc =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('analytics')
              .doc('popular_content')
              .get();

      final oldData = oldContentDoc.data() ?? <String, dynamic>{};
      final now = DateTime.now();

      // Crear documento en nueva estructura
      await firestore.collection(_analyticsContentCollection).doc(placeId).set({
        'placeId': placeId,
        'top_categories': oldData['top_categories'] ?? <Map<String, dynamic>>[],
        'top_products': oldData['top_products'] ?? <Map<String, dynamic>>[],
        'top_services': oldData['top_services'] ?? <Map<String, dynamic>>[],
        'top_offers': oldData['top_offers'] ?? <Map<String, dynamic>>[],
        'top_search_terms':
            oldData['top_search_terms'] ?? <Map<String, dynamic>>[],
        'updated_at': oldData['last_updated'] ?? now,
        'migrated_at': now,
      });

      print('📈 Contenido popular migrado para: $placeId');
    } catch (e) {
      print('⚠️ Error migrando contenido popular para $placeId: $e');
    }
  }

  Future<void> _migrateHourlyTraffic(String placeId) async {
    try {
      // Obtener datos de tráfico por hora de la estructura antigua
      final oldHourlySnapshot =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('analytics')
              .doc('hourly_traffic')
              .collection('data')
              .get();

      if (oldHourlySnapshot.docs.isEmpty) {
        print('ℹ️ No hay datos de tráfico por hora para migrar: $placeId');
        return;
      }

      final batch = firestore.batch();
      var count = 0;

      for (final doc in oldHourlySnapshot.docs) {
        final data = doc.data();
        final newDocId = '${placeId}_${doc.id}';

        final newRef = firestore
            .collection(_analyticsTrafficCollection)
            .doc(newDocId);

        batch.set(newRef, {
          'placeId': placeId,
          'type': 'hourly',
          'hour': data['hour'],
          'timestamp': data['timestamp'],
          'date': data['date'],
          'views': data['views'] ?? 0,
          'unique_visitors': data['unique_visitors'] ?? 0,
          'interactions': data['interactions'] ?? 0,
          'migrated_at': DateTime.now(),
        });

        count++;

        // Ejecutar batch cada 500 documentos
        if (count % 500 == 0) {
          await batch.commit();
        }
      }

      // Ejecutar batch final si quedan documentos
      if (count % 500 != 0) {
        await batch.commit();
      }

      print('📊 Tráfico por hora migrado para $placeId: $count documentos');
    } catch (e) {
      print('⚠️ Error migrando tráfico por hora para $placeId: $e');
    }
  }

  Future<void> _migrateDailyTraffic(String placeId) async {
    try {
      // Obtener datos de tráfico diario de la estructura antigua
      final oldDailySnapshot =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('analytics')
              .doc('daily_traffic')
              .collection('data')
              .get();

      if (oldDailySnapshot.docs.isEmpty) {
        print('ℹ️ No hay datos de tráfico diario para migrar: $placeId');
        return;
      }

      final batch = firestore.batch();
      var count = 0;

      for (final doc in oldDailySnapshot.docs) {
        final data = doc.data();
        final newDocId = '${placeId}_${doc.id}';

        final newRef = firestore
            .collection(_analyticsTrafficCollection)
            .doc(newDocId);

        batch.set(newRef, {
          'placeId': placeId,
          'type': 'daily',
          'date': data['date'],
          'views': data['views'] ?? 0,
          'unique_visitors': data['unique_visitors'] ?? 0,
          'new_reviews': data['new_reviews'] ?? 0,
          'new_favorites': data['new_favorites'] ?? 0,
          'interactions': data['interactions'] ?? 0,
          'avg_rating': data['avg_rating'] ?? 0.0,
          'migrated_at': DateTime.now(),
        });

        count++;

        // Ejecutar batch cada 500 documentos
        if (count % 500 == 0) {
          await batch.commit();
        }
      }

      // Ejecutar batch final si quedan documentos
      if (count % 500 != 0) {
        await batch.commit();
      }

      print('📊 Tráfico diario migrado para $placeId: $count documentos');
    } catch (e) {
      print('⚠️ Error migrando tráfico diario para $placeId: $e');
    }
  }

  Future<void> _migrateVisitEvents(String placeId) async {
    try {
      // Obtener eventos de visitas de la estructura antigua
      final oldVisitsSnapshot =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('visits')
              .get();

      if (oldVisitsSnapshot.docs.isEmpty) {
        print('ℹ️ No hay eventos de visitas para migrar: $placeId');
        return;
      }

      final batch = firestore.batch();
      var count = 0;

      for (final doc in oldVisitsSnapshot.docs) {
        final data = doc.data();

        final newRef =
            firestore
                .collection(_analyticsEventsCollection)
                .doc(); // Auto-generate ID

        batch.set(newRef, {
          'placeId': placeId,
          'type': 'visit',
          'timestamp': data['timestamp'],
          'metadata': data,
          'hour': (data['timestamp'] as Timestamp?)?.toDate().hour ?? 0,
          'date': (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
          'migrated_at': DateTime.now(),
        });

        count++;

        // Ejecutar batch cada 500 documentos
        if (count % 500 == 0) {
          await batch.commit();
        }
      }

      // Ejecutar batch final si quedan documentos
      if (count % 500 != 0) {
        await batch.commit();
      }

      print('📈 Eventos de visita migrados para $placeId: $count eventos');
    } catch (e) {
      print('⚠️ Error migrando eventos de visita para $placeId: $e');
    }
  }

  Future<void> _migrateConversionEvents(String placeId) async {
    try {
      // Obtener eventos de conversión de la estructura antigua
      final oldConversionsSnapshot =
          await firestore
              .collection('places')
              .doc(placeId)
              .collection('conversions')
              .get();

      if (oldConversionsSnapshot.docs.isEmpty) {
        print('ℹ️ No hay eventos de conversión para migrar: $placeId');
        return;
      }

      final batch = firestore.batch();
      var count = 0;

      for (final doc in oldConversionsSnapshot.docs) {
        final data = doc.data();

        final newRef =
            firestore
                .collection(_analyticsEventsCollection)
                .doc(); // Auto-generate ID

        batch.set(newRef, {
          'placeId': placeId,
          'type': 'conversion',
          'conversion_type': data['type'] ?? 'unknown',
          'timestamp': data['timestamp'],
          'metadata': data['metadata'] ?? <String, dynamic>{},
          'migrated_at': DateTime.now(),
        });

        count++;

        // Ejecutar batch cada 500 documentos
        if (count % 500 == 0) {
          await batch.commit();
        }
      }

      // Ejecutar batch final si quedan documentos
      if (count % 500 != 0) {
        await batch.commit();
      }

      print('🎯 Eventos de conversión migrados para $placeId: $count eventos');
    } catch (e) {
      print('⚠️ Error migrando eventos de conversión para $placeId: $e');
    }
  }

  Future<void> _cleanupOldStructure(String placeId) async {
    try {
      // Eliminar estructura antigua de analytics
      final analyticsCollection = firestore
          .collection('places')
          .doc(placeId)
          .collection('analytics');

      // Eliminar documentos principales
      final docs = ['summary', 'realtime', 'conversions', 'popular_content'];
      final batch = firestore.batch();

      for (final docId in docs) {
        batch.delete(analyticsCollection.doc(docId));
      }

      await batch.commit();

      // Eliminar subcollections
      await _deleteCollection(
        analyticsCollection.doc('hourly_traffic').collection('data'),
      );
      await _deleteCollection(
        analyticsCollection.doc('daily_traffic').collection('data'),
      );

      // Eliminar collections de eventos
      await _deleteCollection(
        firestore.collection('places').doc(placeId).collection('visits'),
      );
      await _deleteCollection(
        firestore.collection('places').doc(placeId).collection('conversions'),
      );

      print('🗑️ Estructura antigua limpiada para: $placeId');
    } catch (e) {
      print('⚠️ Error limpiando estructura antigua para $placeId: $e');
    }
  }

  Future<void> _cleanupNewStructure(String placeId) async {
    try {
      final batch = firestore.batch();

      // Eliminar documentos de la nueva estructura
      batch.delete(
        firestore.collection(_analyticsPlacesCollection).doc(placeId),
      );
      batch.delete(
        firestore.collection(_analyticsRealtimeCollection).doc(placeId),
      );
      batch.delete(
        firestore.collection(_analyticsContentCollection).doc(placeId),
      );

      await batch.commit();

      // Eliminar datos de tráfico
      final trafficSnapshot =
          await firestore
              .collection(_analyticsTrafficCollection)
              .where('placeId', isEqualTo: placeId)
              .get();

      await _deleteBatchDocs(trafficSnapshot.docs);

      // Eliminar eventos
      final eventsSnapshot =
          await firestore
              .collection(_analyticsEventsCollection)
              .where('placeId', isEqualTo: placeId)
              .get();

      await _deleteBatchDocs(eventsSnapshot.docs);

      print('🗑️ Estructura nueva limpiada para: $placeId');
    } catch (e) {
      print('⚠️ Error limpiando estructura nueva para $placeId: $e');
    }
  }

  Future<void> _initializeCleanStructure(String placeId) async {
    try {
      final batch = firestore.batch();
      final now = DateTime.now();
      final today = DateTime(now.year, now.month, now.day);

      // 1. Inicializar resumen del lugar
      final summaryRef = firestore
          .collection(_analyticsPlacesCollection)
          .doc(placeId);

      batch.set(summaryRef, {
        'placeId': placeId,
        'total_views': 0,
        'unique_visitors': 0,
        'total_conversions': 0,
        'average_rating': 0.0,
        'total_reviews': 0,
        'total_favorites': 0,
        'conversion_rate': 0.0,
        'total_events': 0,
        'avg_session_duration': 0.0,
        'created_at': now,
        'updated_at': now,
      });

      // 2. Inicializar datos de tiempo real
      final realtimeRef = firestore
          .collection(_analyticsRealtimeCollection)
          .doc(placeId);

      batch.set(realtimeRef, {
        'placeId': placeId,
        'activeUsers': 0,
        'currentSessions': 0,
        'lastUpdated': now,
      });

      // 3. Inicializar contenido popular
      final contentRef = firestore
          .collection(_analyticsContentCollection)
          .doc(placeId);

      batch.set(contentRef, {
        'placeId': placeId,
        'top_categories': <Map<String, dynamic>>[],
        'top_products': <Map<String, dynamic>>[],
        'top_services': <Map<String, dynamic>>[],
        'top_offers': <Map<String, dynamic>>[],
        'top_search_terms': <Map<String, dynamic>>[],
        'updated_at': now,
      });

      await batch.commit();

      print('✅ Estructura limpia inicializada para: $placeId');
    } catch (e) {
      throw Exception(
        'Error inicializando estructura limpia para $placeId: $e',
      );
    }
  }

  /// Helper para eliminar una collection completa
  Future<void> _deleteCollection(CollectionReference collection) async {
    const batchSize = 500;
    QuerySnapshot snapshot;

    do {
      snapshot = await collection.limit(batchSize).get();
      await _deleteBatchDocs(snapshot.docs);
    } while (snapshot.docs.isNotEmpty);
  }

  /// Helper para eliminar documentos en batch
  Future<void> _deleteBatchDocs(List<QueryDocumentSnapshot> docs) async {
    if (docs.isEmpty) return;

    final batch = firestore.batch();
    for (final doc in docs) {
      batch.delete(doc.reference);
    }
    await batch.commit();
  }
}
