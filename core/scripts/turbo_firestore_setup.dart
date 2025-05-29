// Script funcional para configurar Firestore del proyecto Turbo
// Ejecutar con: dart run scripts/turbo_firestore_setup.dart

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// Configuración real del proyecto Turbo
const firebaseOptions = FirebaseOptions(
  apiKey: "AIzaSyAVutR13I58yvzsHjV5ZLtS9pHfe4cLsJ8",
  authDomain: "turbo-16770.firebaseapp.com",
  projectId: "turbo-16770",
  storageBucket: "turbo-16770.firebasestorage.app",
  messagingSenderId: "626963970726",
  appId: "1:626963970726:web:b87ea452393d72655a1267",
  measurementId: "G-E872L0BE36",
);

void main() async {
  print('🚀 Configurando Sistema Administrativo - Proyecto Turbo\n');
  print('📱 Proyecto: turbo-16770');
  print('🔗 Firestore: turbo-16770.firebaseapp.com\n');

  try {
    // Inicializar Firebase con credenciales del proyecto
    await Firebase.initializeApp(
      name: 'turbo-admin-setup',
      options: firebaseOptions,
    );

    final firestore = FirebaseFirestore.instance;
    print('✅ Conectado a Firebase exitosamente\n');

    // Verificar estado actual
    await verifyCurrentState(firestore);

    // Ejecutar configuración
    print('🔧 Iniciando configuración del sistema administrativo...\n');

    await createAdminUsersCollection(firestore);
    await updatePlacesCollection(firestore);
    await updateEventsCollection(firestore);

    print('\n🎉 ¡Configuración completada exitosamente!');
    printSuccessInstructions();
  } catch (e) {
    print('❌ Error durante la configuración: $e');
    printErrorHelp();
    exit(1);
  }
}

/// Verificar estado actual de Firestore
Future<void> verifyCurrentState(FirebaseFirestore firestore) async {
  print('📊 Verificando estado actual de Firestore...');

  try {
    final collections = ['places', 'events', 'users', 'admin_users'];
    final counts = <String, int>{};

    for (final collection in collections) {
      try {
        final snapshot = await firestore.collection(collection).limit(1).get();
        counts[collection] = snapshot.docs.length > 0 ? 1 : 0;
      } catch (e) {
        counts[collection] = 0;
      }
    }

    print(
      '   📍 Places: ${counts['places'] == 1 ? '✅ Existe' : '❌ No existe'}',
    );
    print(
      '   🎯 Events: ${counts['events'] == 1 ? '✅ Existe' : '❌ No existe'}',
    );
    print('   👥 Users: ${counts['users'] == 1 ? '✅ Existe' : '❌ No existe'}');
    print(
      '   👑 Admin Users: ${counts['admin_users'] == 1 ? '✅ Existe' : '❌ No existe'}',
    );
    print('');
  } catch (e) {
    print('   ⚠️ Error verificando estado: $e\n');
  }
}

/// Crear collection admin_users con super administrador
Future<void> createAdminUsersCollection(FirebaseFirestore firestore) async {
  print('👑 1. Configurando collection admin_users...');

  try {
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
        'projectId': 'turbo-16770',
        'setupDate': DateTime.now().toIso8601String(),
      },
    };

    await adminRef.set(superAdminData);
    print('   ✅ Super Admin creado: superadmin@turbo.com');
    print('   🔑 UID: super_admin_001');
  } catch (e) {
    print('   ❌ Error creando admin_users: $e');
    rethrow;
  }
}

/// Actualizar collection places con campos administrativos
Future<void> updatePlacesCollection(FirebaseFirestore firestore) async {
  print('🏢 2. Actualizando collection places...');

  try {
    final placesSnapshot = await firestore.collection('places').get();

    if (placesSnapshot.docs.isEmpty) {
      print('   ℹ️ No hay lugares para actualizar');
      return;
    }

    print('   📍 Total lugares encontrados: ${placesSnapshot.docs.length}');

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
      print(
        '   ✅ $updatedCount lugares actualizados con campos administrativos',
      );
    } else {
      print('   ℹ️ Todos los lugares ya tienen campos de ownership');
    }
  } catch (e) {
    print('   ❌ Error actualizando places: $e');
    rethrow;
  }
}

/// Actualizar collection events con campos de auditoría
Future<void> updateEventsCollection(FirebaseFirestore firestore) async {
  print('🎯 3. Actualizando collection events...');

  try {
    final eventsSnapshot = await firestore.collection('events').get();

    if (eventsSnapshot.docs.isEmpty) {
      print('   ℹ️ No hay eventos para actualizar');
      return;
    }

    print('   🎯 Total eventos encontrados: ${eventsSnapshot.docs.length}');

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
      print('   ✅ $updatedCount eventos actualizados con campos de auditoría');
    } else {
      print('   ℹ️ Todos los eventos ya tienen campos de auditoría');
    }
  } catch (e) {
    print('   ❌ Error actualizando events: $e');
    rethrow;
  }
}

/// Imprimir instrucciones de éxito
void printSuccessInstructions() {
  print('''
🎉 ¡Sistema Administrativo Configurado Exitosamente!

📋 Próximos pasos para usar el sistema:

1. 🔐 Configurar Authentication:
   • Ve a Firebase Console > Authentication
   • Habilita Email/Password si no está activo
   • Crea el usuario: superadmin@turbo.com

2. 👥 Crear usuarios administrativos desde tu app:
   • Usa AdminAuthService.signUp() para crear propietarios
   • Asigna lugares específicos a cada propietario
   • Configura permisos granulares por lugar

3. 🏢 Gestionar ownership de lugares:
   • Usa PlaceRepository.updatePlaceOwnership()
   • Asigna propietarios a lugares específicos
   • Configura permisos granulares

4. 📊 Configurar Dashboard Administrativo:
   • Integra AdminAuthRepository en tu Admin Panel
   • Implementa UI para gestión de usuarios admin
   • Configura analytics por propietario

5. 🛡️ Configurar Reglas de Seguridad:
   • Ve a Firestore > Rules
   • Implementa las reglas de seguridad recomendadas
   • Valida permisos por rol y ownership

📁 Documentación disponible en:
   • documentation/FIRESTORE_ADMIN_SYSTEM_SETUP.md
   • documentation/FIRESTORE_SCRIPT_EXECUTION_GUIDE.md

🎯 Tu sistema ahora soporta:
   ✅ Separación usuario regular vs administrativo
   ✅ Ownership granular de lugares
   ✅ Auditoría completa de eventos
   ✅ Permisos por rol y lugar
   ✅ Analytics por propietario
''');
}

/// Imprimir ayuda para errores
void printErrorHelp() {
  print('''
🛠️ Solución de problemas:

1. ❌ Error de permisos:
   • Ve a Firebase Console > Firestore > Rules
   • Temporalmente permite escritura para testing
   • Restaura reglas de seguridad después

2. ❌ Error de red:
   • Verifica tu conexión a internet
   • Verifica que el proyecto turbo-16770 esté activo
   • Intenta ejecutar el script nuevamente

3. ❌ Error de credenciales:
   • Verifica que las credenciales en el script sean correctas
   • Asegúrate de tener permisos en el proyecto Firebase

4. 💡 Alternativa manual:
   • Usa Firebase Console para crear collections manualmente
   • Consulta: documentation/FIRESTORE_ADMIN_SETUP_GUIDE.md

🔗 Recursos útiles:
   • Firebase Console: https://console.firebase.google.com/project/turbo-16770
   • Firestore: https://console.firebase.google.com/project/turbo-16770/firestore
''');
}
