// Script mejorado para configurar Firestore con sistema administrativo
// Ejecutar con: dart run scripts/setup_admin_firestore.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  print(
    '🔥 Configurando Firestore para Sistema Administrativo Turbo Core...\n',
  );

  try {
    // Inicializar Firebase con configuración básica
    await initializeFirebase();
    final firestore = FirebaseFirestore.instance;

    print('📊 Estado actual de Firestore:');
    await checkCurrentState(firestore);

    print('\n🚀 Iniciando configuración...');

    // 1. Crear collection admin_users
    await createInitialSuperAdmin(firestore);

    // 2. Actualizar places existentes
    await updatePlacesWithOwnership(firestore);

    // 3. Actualizar events existentes
    await updateEventsWithAuditFields(firestore);

    // 4. Crear índices necesarios
    await createFirestoreIndexes();

    print('\n✅ ¡Configuración completada exitosamente!');
    printNextSteps();
  } catch (e) {
    print('❌ Error durante la configuración: $e');
    printTroubleshootingSteps();
    exit(1);
  }
}

/// Inicializar Firebase con configuración flexible
Future<void> initializeFirebase() async {
  print('🔧 Inicializando Firebase...');

  try {
    // Intentar inicializar con configuración por defecto
    await Firebase.initializeApp();
    print('   ✅ Firebase inicializado correctamente');
  } catch (e) {
    print('   ⚠️ Error de inicialización: $e');
    print('   💡 Verifica que tengas firebase_options.dart configurado');
    throw Exception(
      'No se pudo inicializar Firebase. Verifica tu configuración.',
    );
  }
}

/// Verificar estado actual de Firestore
Future<void> checkCurrentState(FirebaseFirestore firestore) async {
  try {
    // Verificar collections existentes
    final placesCount = await getCollectionCount(firestore, 'places');
    final eventsCount = await getCollectionCount(firestore, 'events');
    final usersCount = await getCollectionCount(firestore, 'users');
    final adminUsersCount = await getCollectionCount(firestore, 'admin_users');

    print('   📍 Places: $placesCount documentos');
    print('   🎯 Events: $eventsCount documentos');
    print('   👥 Users: $usersCount documentos');
    print('   👑 Admin Users: $adminUsersCount documentos');
  } catch (e) {
    print('   ⚠️ No se pudo verificar el estado: $e');
  }
}

/// Obtener cantidad de documentos en una collection
Future<int> getCollectionCount(
  FirebaseFirestore firestore,
  String collection,
) async {
  try {
    final snapshot = await firestore.collection(collection).limit(1).get();
    return snapshot.size;
  } catch (e) {
    return 0;
  }
}

/// Crear super administrador inicial
Future<void> createInitialSuperAdmin(FirebaseFirestore firestore) async {
  print('👑 Configurando Super Administrador...');

  final adminRef = firestore.collection('admin_users').doc('super_admin_001');

  // Verificar si ya existe
  final existing = await adminRef.get();
  if (existing.exists) {
    print('   ℹ️ Super Admin ya existe, omitiendo creación');
    return;
  }

  final superAdminData = {
    'uid': 'super_admin_001',
    'email': 'superadmin@turbo.com',
    'displayName': 'Super Administrador Turbo',
    'role': 'superAdmin',
    'ownedPlaceIds': <String>[],
    'permissions': <String, dynamic>{},
    'createdAt': FieldValue.serverTimestamp(),
    'lastLogin': null,
    'isActive': true,
    'photoUrl': null,
    'phoneNumber': null,
    'metadata': {
      'createdBy': 'system',
      'initialSetup': true,
      'version': '1.0.0',
      'setupDate': DateTime.now().toIso8601String(),
    },
  };

  await adminRef.set(superAdminData);
  print('   ✅ Super Admin creado: superadmin@turbo.com');
}

/// Actualizar lugares con campos administrativos
Future<void> updatePlacesWithOwnership(FirebaseFirestore firestore) async {
  print('🏢 Actualizando lugares con ownership...');

  try {
    final placesSnapshot = await firestore.collection('places').get();

    if (placesSnapshot.docs.isEmpty) {
      print('   ℹ️ No hay lugares para actualizar');
      return;
    }

    int updatedCount = 0;
    final batch = firestore.batch();

    for (final doc in placesSnapshot.docs) {
      final data = doc.data();

      // Solo actualizar si no tiene ownerIds
      if (!data.containsKey('ownerIds')) {
        batch.update(doc.reference, {
          'ownerIds': <String>[],
          'createdBy': 'system',
          'createdAt': FieldValue.serverTimestamp(),
          'lastUpdated': FieldValue.serverTimestamp(),
        });
        updatedCount++;
      }
    }

    if (updatedCount > 0) {
      await batch.commit();
      print('   ✅ $updatedCount lugares actualizados');
    } else {
      print('   ℹ️ Todos los lugares ya tienen campos de ownership');
    }
  } catch (e) {
    print('   ❌ Error actualizando lugares: $e');
    rethrow;
  }
}

/// Actualizar eventos con campos de auditoría
Future<void> updateEventsWithAuditFields(FirebaseFirestore firestore) async {
  print('🎯 Actualizando eventos con auditoría...');

  try {
    final eventsSnapshot = await firestore.collection('events').get();

    if (eventsSnapshot.docs.isEmpty) {
      print('   ℹ️ No hay eventos para actualizar');
      return;
    }

    int updatedCount = 0;
    final batch = firestore.batch();

    for (final doc in eventsSnapshot.docs) {
      final data = doc.data();

      // Solo actualizar si no tiene createdBy
      if (!data.containsKey('createdBy')) {
        batch.update(doc.reference, {
          'createdBy': 'system',
          'createdAt': FieldValue.serverTimestamp(),
          'lastUpdatedBy': null,
          'lastUpdatedAt': null,
        });
        updatedCount++;
      }
    }

    if (updatedCount > 0) {
      await batch.commit();
      print('   ✅ $updatedCount eventos actualizados');
    } else {
      print('   ℹ️ Todos los eventos ya tienen campos de auditoría');
    }
  } catch (e) {
    print('   ❌ Error actualizando eventos: $e');
    rethrow;
  }
}

/// Crear índices necesarios para Firestore
Future<void> createFirestoreIndexes() async {
  print('📑 Configurando índices de Firestore...');

  print('''
   💡 Índices recomendados para crear en Firebase Console:
   
   Collection: admin_users
   - Compound index: role (Ascending), isActive (Ascending)
   - Compound index: ownedPlaceIds (Arrays), isActive (Ascending)
   
   Collection: places
   - Compound index: ownerIds (Arrays), isActive (Ascending)
   - Compound index: createdBy (Ascending), createdAt (Descending)
   
   Collection: events
   - Compound index: createdBy (Ascending), date (Ascending)
   - Compound index: placeId (Ascending), createdBy (Ascending)
   ''');
}

/// Imprimir próximos pasos
void printNextSteps() {
  print('''
📋 Próximos pasos:

1. 🔐 Configurar Authentication Rules:
   - Actualizar Firestore Security Rules
   - Configurar Authentication para admin users

2. 👥 Crear usuarios administrativos:
   - Usar AdminAuthService.signUp() para crear propietarios
   - Asignar lugares específicos a cada propietario

3. 🏢 Asignar ownership a lugares:
   - Usar PlaceRepository.updatePlaceOwnership()
   - Configurar permisos granulares por lugar

4. 📊 Configurar Analytics:
   - Las collections analytics ya están creadas
   - Configurar dashboard para propietarios

5. 🎯 Integrar con Admin Panel:
   - Usar AdminAuthRepository en tu Flutter App
   - Implementar UI para gestión de usuarios admin
''');
}

/// Imprimir pasos de solución de problemas
void printTroubleshootingSteps() {
  print('''
🛠️ Solución de problemas:

1. ❌ Error de inicialización Firebase:
   - Verifica que firebase_options.dart exista
   - Ejecuta: flutter packages pub run firebase_core:config
   - Asegúrate de tener las credenciales correctas

2. ❌ Error de permisos Firestore:
   - Verifica las reglas de seguridad en Firebase Console
   - Asegúrate de tener permisos de escritura en las collections

3. ❌ Error de dependencias:
   - Ejecuta: flutter pub get
   - Verifica que firebase_core y cloud_firestore estén en pubspec.yaml

4. 💡 Configuración manual alternativa:
   - Usa Firebase Console para crear collections manualmente
   - Consulta: documentation/FIRESTORE_ADMIN_SETUP_GUIDE.md
''');
}
