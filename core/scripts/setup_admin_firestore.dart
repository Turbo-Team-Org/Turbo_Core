// Script mejorado para configurar Firestore con sistema administrativo
//
// EJECUTAR CON FLUTTER (no dart puro):
// flutter run core/scripts/setup_admin_firestore.dart
//
// O como parte de una aplicación Flutter de testing:
// 1. Crea un proyecto Flutter temporal
// 2. Agrega este archivo como main.dart
// 3. Ejecuta con: flutter run

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  print(
    '🔥 Configurando Firestore para Sistema Administrativo Turbo Core...\n',
  );

  try {
    // Inicializar Firebase (requiere flutter_options.dart o configuración manual)
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

    // Terminar el proceso para evitar que Flutter quede ejecutándose
    exit(0);
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
    // Opción 1: Usar firebase_options.dart (generado por FlutterFire CLI)
    try {
      await Firebase.initializeApp();
      print('   ✅ Firebase inicializado con firebase_options.dart');
      return;
    } catch (e) {
      print(
        '   ⚠️ firebase_options.dart no encontrado, intentando configuración manual...',
      );
    }

    // Opción 2: Configuración manual para desarrollo/testing
    // NOTA: Reemplaza estos valores con los de tu proyecto Firebase
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: 'TU_API_KEY_AQUI',
        appId: 'TU_APP_ID_AQUI',
        messagingSenderId: 'TU_SENDER_ID_AQUI',
        projectId: 'TU_PROJECT_ID_AQUI',
        // Para web también necesitas:
        // authDomain: 'tu-proyecto.firebaseapp.com',
        // storageBucket: 'tu-proyecto.appspot.com',
      ),
    );

    print('   ✅ Firebase inicializado con configuración manual');
  } catch (e) {
    print('   ❌ Error de inicialización: $e');
    throw Exception(
      'No se pudo inicializar Firebase. Consulta las instrucciones de solución de problemas.',
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
   OPCIÓN A - Usar FlutterFire CLI (Recomendado):
   - Instala: dart pub global activate flutterfire_cli
   - Configura: flutterfire configure
   - Esto genera firebase_options.dart automáticamente

   OPCIÓN B - Configuración manual:
   - Edita las FirebaseOptions en initializeFirebase()
   - Obtén los valores desde Firebase Console > Project Settings

   OPCIÓN C - Variables de entorno:
   - export FIREBASE_PROJECT_ID="tu-proyecto-id"
   - export FIREBASE_API_KEY="tu-api-key"

2. ❌ Error de permisos Firestore:
   - Verifica las reglas de seguridad en Firebase Console
   - Para testing temporal, usa: allow read, write: if true;

3. ❌ Ejecutar el script:
   - NO uses: dart run scripts/setup_admin_firestore.dart
   - SÍ usa: flutter run scripts/setup_admin_firestore.dart
   - O crea un proyecto Flutter temporal con este archivo como main.dart

4. 🔧 Para uso en servidor/CLI real:
   - Usa Firebase Admin SDK con credenciales de servicio
   - Considera usar firebase-admin (Node.js) o gcloud CLI
   - Para scripts Dart puros, usa el REST API de Firestore

📚 Recursos adicionales:
   - FlutterFire: https://firebase.flutter.dev/docs/overview
   - Firebase Console: https://console.firebase.google.com
   - Firestore REST API: https://firebase.google.com/docs/firestore/use-rest-api

🎯 Alternativa con Firebase CLI:
   Si prefieres no usar Flutter, puedes usar Firebase CLI:
   - npm install -g firebase-tools
   - firebase login
   - firebase firestore:indexes:set firestore.indexes.json
''');
}
