import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Script para diagnosticar la estructura de Firestore y las funciones helper
Future<void> main() async {
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  print('🔍 DIAGNÓSTICO DE ESTRUCTURA FIRESTORE');
  print('=' * 50);

  // 1. Verificar usuario actual
  final currentUser = auth.currentUser;
  if (currentUser == null) {
    print('❌ No hay usuario autenticado');
    return;
  }

  print('👤 Usuario autenticado:');
  print('   UID: ${currentUser.uid}');
  print('   Email: ${currentUser.email}');
  print('');

  try {
    // 2. Verificar estructura de admin_users
    print('🏛️ VERIFICANDO COLECCIÓN admin_users:');
    print('-' * 30);

    // Buscar por document ID (método actual de las reglas)
    final adminDocById =
        await firestore.collection('admin_users').doc(currentUser.uid).get();

    print('📄 Búsqueda por document ID (${currentUser.uid}):');
    print('   Existe: ${adminDocById.exists}');
    if (adminDocById.exists) {
      final data = adminDocById.data()!;
      print('   Datos: $data');
      print('   Role: ${data['role']}');
      print('   UID field: ${data['uid']}');
    }
    print('');

    // Buscar por campo uid (método que implementamos en el código)
    final adminQueryByField =
        await firestore
            .collection('admin_users')
            .where('uid', isEqualTo: currentUser.uid)
            .get();

    print('🔍 Búsqueda por campo uid:');
    print('   Documentos encontrados: ${adminQueryByField.docs.length}');
    for (var doc in adminQueryByField.docs) {
      print('   Doc ID: ${doc.id}');
      print('   Datos: ${doc.data()}');
    }
    print('');

    // 3. Listar todos los documentos en admin_users
    print('📋 TODOS LOS DOCUMENTOS EN admin_users:');
    print('-' * 30);
    final allAdmins = await firestore.collection('admin_users').get();
    print('   Total documentos: ${allAdmins.docs.length}');

    for (var doc in allAdmins.docs) {
      final data = doc.data();
      print('   📄 Doc ID: ${doc.id}');
      print('      UID field: ${data['uid']}');
      print('      Email: ${data['email']}');
      print('      Role: ${data['role']}');
      print('      Active: ${data['isActive']}');
      print('');
    }

    // 4. Verificar business_owner_requests
    print('📝 VERIFICANDO COLECCIÓN business_owner_requests:');
    print('-' * 30);
    final businessRequests =
        await firestore.collection('business_owner_requests').get();

    print('   Total solicitudes: ${businessRequests.docs.length}');
    for (var doc in businessRequests.docs) {
      final data = doc.data();
      print('   📄 Doc ID: ${doc.id}');
      print('      User ID: ${data['userId']}');
      print('      Email: ${data['email']}');
      print('      Status: ${data['status']}');
      print('      Business: ${data['businessName']}');
      print('');
    }

    // 5. Probar las funciones helper manualmente
    print('🧪 PROBANDO LÓGICA DE FUNCIONES HELPER:');
    print('-' * 30);

    // Simular isAdmin()
    final isAdminResult = adminDocById.exists;
    print('   isAdmin() simulado: $isAdminResult');

    // Simular isSuperAdmin()
    bool isSuperAdminResult = false;
    if (adminDocById.exists) {
      final role = adminDocById.data()!['role'];
      isSuperAdminResult = role == 'superAdmin';
    }
    print('   isSuperAdmin() simulado: $isSuperAdminResult');

    // 6. Verificar permisos de lectura directamente
    print('');
    print('🔐 PROBANDO PERMISOS DE LECTURA:');
    print('-' * 30);

    try {
      // Intentar leer una solicitud específica
      if (businessRequests.docs.isNotEmpty) {
        final firstRequest = businessRequests.docs.first;
        print('   ✅ Puede leer business_owner_requests');
        print('   📄 Ejemplo: ${firstRequest.id}');
      } else {
        print('   ℹ️  No hay solicitudes para probar');
      }
    } catch (e) {
      print('   ❌ Error leyendo business_owner_requests: $e');
    }
  } catch (e) {
    print('❌ Error durante el diagnóstico: $e');
  }

  print('');
  print('🎯 RECOMENDACIONES:');
  print('-' * 30);
  print('1. Verificar que el document ID coincida con el UID del usuario');
  print('2. Verificar que el campo "role" sea exactamente "superAdmin"');
  print('3. Verificar que las reglas de Firestore estén actualizadas');
  print('4. Considerar usar búsqueda por campo uid si hay inconsistencias');
}
