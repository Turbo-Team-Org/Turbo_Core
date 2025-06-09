// 🏢 Script de Setup para Business Owner Requests
//
// Configura la nueva colección business_owner_requests en Firestore
// para el sistema de auto-registro de business owners

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  print('🚀 Configurando Business Owner Requests Collection...\n');

  try {
    // Inicializar Firebase
    await Firebase.initializeApp();
    final firestore = FirebaseFirestore.instance;

    await setupBusinessOwnerRequestsCollection(firestore);
    await createSampleRequests(firestore);
    await createIndexes(firestore);

    print('\n🎉 ¡Setup completado exitosamente!\n');
    printUsageInstructions();
  } catch (e) {
    print('❌ Error durante el setup: $e');
  }
}

/// 🗄️ Crear colección business_owner_requests
Future<void> setupBusinessOwnerRequestsCollection(
  FirebaseFirestore firestore,
) async {
  print('📁 1. Configurando collection business_owner_requests...');

  try {
    final collection = firestore.collection('business_owner_requests');

    // Verificar si ya existe
    final existing = await collection.limit(1).get();
    if (existing.docs.isNotEmpty) {
      print('   ℹ️ Collection ya existe, omitiendo creación');
      return;
    }

    // Crear documento de configuración de la colección
    await collection.doc('_config').set({
      'description': 'Solicitudes de registro para business owners',
      'version': '1.0.0',
      'createdAt': FieldValue.serverTimestamp(),
      'structure': {
        'fields': [
          'id - string - ID único de la solicitud',
          'userId - string - UID del usuario que solicita',
          'email - string - Email del usuario',
          'displayName - string - Nombre completo',
          'businessName - string - Nombre del negocio',
          'businessDescription - string - Descripción del negocio',
          'businessAddress - string - Dirección física',
          'phoneNumber - string - Teléfono de contacto',
          'website - string - Sitio web (opcional)',
          'status - string - Estado de la solicitud',
          'createdAt - timestamp - Fecha de creación',
          'reviewedAt - timestamp - Fecha de revisión',
          'reviewedBy - string - UID del super admin revisor',
          'rejectionReason - string - Razón del rechazo',
          'approvalNotes - string - Notas de aprobación',
          'businessMetadata - map - Metadatos del negocio',
          'contactInfo - map - Información de contacto',
        ],
        'indexes': ['userId', 'email', 'status', 'createdAt', 'reviewedBy'],
      },
    });

    print('   ✅ Collection business_owner_requests configurada');
  } catch (e) {
    print('   ❌ Error configurando collection: $e');
    rethrow;
  }
}

/// 📋 Crear solicitudes de ejemplo para testing
Future<void> createSampleRequests(FirebaseFirestore firestore) async {
  print('📋 2. Creando solicitudes de ejemplo...');

  try {
    final collection = firestore.collection('business_owner_requests');

    // Solicitud pendiente
    await collection.doc('sample_pending_001').set({
      'id': 'sample_pending_001',
      'userId': 'user_sample_001',
      'email': 'carlos@restaurantelaabuela.com',
      'displayName': 'Carlos Rodríguez',
      'businessName': 'Restaurante La Abuela',
      'businessDescription':
          'Restaurante familiar con comida tradicional mexicana',
      'businessAddress': 'Av. Reforma 123, Col. Centro, CDMX',
      'phoneNumber': '+52 55 1234 5678',
      'website': 'https://restaurantelaabuela.mx',
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
      'reviewedAt': null,
      'reviewedBy': null,
      'rejectionReason': null,
      'approvalNotes': null,
      'businessMetadata': {
        'category': 'restaurant',
        'cuisine': 'mexican',
        'priceRange': 'medium',
        'capacity': 80,
        'hasDelivery': true,
        'hasParking': true,
      },
      'contactInfo': {
        'managerName': 'Carlos Rodríguez',
        'emergencyContact': '+52 55 8765 4321',
        'socialMedia': {
          'facebook': '@restaurantelaabuela',
          'instagram': '@laabuela_oficial',
        },
      },
    });

    // Solicitud en revisión
    await collection.doc('sample_reviewing_001').set({
      'id': 'sample_reviewing_001',
      'userId': 'user_sample_002',
      'email': 'maria@cafecentral.com',
      'displayName': 'María López',
      'businessName': 'Café Central',
      'businessDescription':
          'Cafetería especializada en café de altura y repostería artesanal',
      'businessAddress': 'Calle Madero 45, Col. Historic Center, CDMX',
      'phoneNumber': '+52 55 2345 6789',
      'website': 'https://cafecentral.mx',
      'status': 'reviewing',
      'createdAt': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(days: 5)),
      ),
      'reviewedAt': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(days: 2)),
      ),
      'reviewedBy': 'super_admin_001',
      'rejectionReason': null,
      'approvalNotes': 'Verificando documentación legal',
      'businessMetadata': {
        'category': 'cafe',
        'specialty': 'artisan_coffee',
        'priceRange': 'medium',
        'capacity': 40,
        'hasWifi': true,
        'petFriendly': true,
      },
      'contactInfo': {
        'managerName': 'María López',
        'emergencyContact': '+52 55 3456 7890',
        'socialMedia': {
          'instagram': '@cafecentral_mx',
          'tiktok': '@cafecentral',
        },
      },
    });

    // Solicitud aprobada
    await collection.doc('sample_approved_001').set({
      'id': 'sample_approved_001',
      'userId': 'user_sample_003',
      'email': 'jose@barberíaelcorte.com',
      'displayName': 'José Martínez',
      'businessName': 'Barbería El Corte',
      'businessDescription':
          'Barbería tradicional con servicios de corte clásico y moderno',
      'businessAddress': 'Av. Insurgentes 789, Col. Roma Norte, CDMX',
      'phoneNumber': '+52 55 3456 7890',
      'website': null,
      'status': 'approved',
      'createdAt': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(days: 10)),
      ),
      'reviewedAt': Timestamp.fromDate(
        DateTime.now().subtract(const Duration(days: 3)),
      ),
      'reviewedBy': 'super_admin_001',
      'rejectionReason': null,
      'approvalNotes':
          'Solicitud aprobada. Usuario convertido a business owner.',
      'businessMetadata': {
        'category': 'personal_care',
        'service_type': 'barbershop',
        'priceRange': 'affordable',
        'capacity': 4,
        'appointmentOnly': true,
      },
      'contactInfo': {
        'managerName': 'José Martínez',
        'emergencyContact': '+52 55 4567 8901',
        'socialMedia': {
          'facebook': '@barberiaelcorte',
          'instagram': '@elcorte_barberia',
        },
      },
    });

    print('   ✅ 3 solicitudes de ejemplo creadas');
    print('      ⏳ Pendiente: Restaurante La Abuela');
    print('      🔄 En revisión: Café Central');
    print('      ✅ Aprobada: Barbería El Corte');
  } catch (e) {
    print('   ❌ Error creando ejemplos: $e');
    rethrow;
  }
}

/// 📊 Crear índices necesarios
Future<void> createIndexes(FirebaseFirestore firestore) async {
  print('📊 3. Configurando índices...');

  print('   ℹ️ Los siguientes índices deben crearse en Firebase Console:');
  print('   🔍 Collection: business_owner_requests');
  print('      - userId (Ascending)');
  print('      - status (Ascending), createdAt (Descending)');
  print('      - reviewedBy (Ascending), reviewedAt (Descending)');
  print('      - createdAt (Descending)');
  print('');
  print('   📖 Comando Firebase CLI:');
  print('   firebase firestore:indexes');
  print('');
  print('   ✅ Configuración de índices listada');
}

/// 🔔 Crear colección de notificaciones
Future<void> createNotificationsCollection(FirebaseFirestore firestore) async {
  print('🔔 4. Configurando notifications collection...');

  try {
    final collection = firestore.collection('notifications');

    // Crear documento de configuración
    await collection.doc('_config').set({
      'description': 'Notificaciones del sistema para business owner requests',
      'version': '1.0.0',
      'createdAt': FieldValue.serverTimestamp(),
      'types': [
        'business_owner_request - Nueva solicitud enviada',
        'business_owner_approved - Solicitud aprobada',
        'business_owner_rejected - Solicitud rechazada',
        'business_owner_reviewing - Solicitud en revisión',
        'business_owner_needs_info - Se necesita más información',
      ],
    });

    // Notificación de ejemplo
    await collection.add({
      'type': 'business_owner_request',
      'title': 'Nueva solicitud de Business Owner',
      'message':
          'Carlos Rodríguez (Restaurante La Abuela) ha solicitado registro',
      'createdAt': FieldValue.serverTimestamp(),
      'targetRole': 'superAdmin',
      'isRead': false,
      'metadata': {
        'requestId': 'sample_pending_001',
        'email': 'carlos@restaurantelaabuela.com',
        'businessName': 'Restaurante La Abuela',
      },
    });

    print('   ✅ Notifications collection configurada');
  } catch (e) {
    print('   ❌ Error configurando notifications: $e');
  }
}

/// 📚 Mostrar instrucciones de uso
void printUsageInstructions() {
  print('📚 === INSTRUCCIONES DE USO ===\n');

  print('🔧 Configuración adicional requerida:');
  print('');
  print('1. 📊 Crear índices en Firebase Console:');
  print('   - Ve a Firestore > Indexes');
  print('   - Agrega los índices listados arriba');
  print('');
  print('2. 🛡️ Actualizar reglas de seguridad:');
  print('   - Agregar reglas para business_owner_requests');
  print('   - Permitir lectura/escritura según permisos');
  print('');
  print('3. 📱 Integrar en tu aplicación:');
  print('   - Usar AdminAuthRepository.submitBusinessOwnerRequest()');
  print('   - Implementar UI para el formulario');
  print('   - Agregar panel de administración para super admins');
  print('');

  print('🎯 Flujo de uso:');
  print('1. Usuario registrado llena formulario "Crear mi negocio"');
  print('2. Sistema crea solicitud en business_owner_requests');
  print('3. Super admin recibe notificación');
  print('4. Super admin revisa y aprueba/rechaza');
  print('5. Usuario es convertido a business owner');
  print('6. Usuario puede gestionar su negocio');
  print('');

  print('📊 Monitoreo:');
  print('- Usa getBusinessOwnerRequestStats() para métricas');
  print('- Filtra solicitudes por estado con getAllBusinessOwnerRequests()');
  print('- Configura alertas para solicitudes urgentes (>7 días)');
  print('');

  print('🔗 Archivos de ejemplo:');
  print('- example_business_owner_registration_new_flow.dart');
  print('- Admin panel UI components (por implementar)');
  print('- User registration flow (por implementar)');
  print('');

  print('✅ ¡Sistema listo para usar!');
}

/// 🧪 Verificar configuración
Future<void> verifySetup(FirebaseFirestore firestore) async {
  print('🧪 === VERIFICACIÓN DEL SETUP ===\n');

  try {
    // Verificar business_owner_requests
    final requests =
        await firestore
            .collection('business_owner_requests')
            .where('id', isNotEqualTo: '_config')
            .get();

    print('📋 Business Owner Requests: ${requests.docs.length} solicitudes');

    // Contar por estado
    final byStatus = <String, int>{};
    for (final doc in requests.docs) {
      final status = doc.data()['status'] as String;
      byStatus[status] = (byStatus[status] ?? 0) + 1;
    }

    byStatus.forEach((status, count) {
      print('   $status: $count');
    });

    // Verificar notifications
    final notifications =
        await firestore
            .collection('notifications')
            .where('type', isEqualTo: 'business_owner_request')
            .get();

    print('🔔 Notifications: ${notifications.docs.length} notificaciones');

    print('✅ Verificación completada');
  } catch (e) {
    print('❌ Error en verificación: $e');
  }
}
