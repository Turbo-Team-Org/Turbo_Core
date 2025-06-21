import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

/// Script para verificar que el super admin existe y tiene los permisos correctos
Future<void> main() async {
  await Firebase.initializeApp();

  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;

  print('🔍 Verificando estado del super admin...');

  // Obtener usuario actual
  final currentUser = auth.currentUser;
  if (currentUser == null) {
    print('❌ No hay usuario autenticado');
    return;
  }

  print('👤 Usuario autenticado: ${currentUser.email} (${currentUser.uid})');

  try {
    // Verificar si existe en admin_users
    final adminDoc =
        await firestore.collection('admin_users').doc(currentUser.uid).get();

    if (!adminDoc.exists) {
      print('❌ El usuario no existe en la colección admin_users');
      print('💡 Creando usuario super admin...');

      await firestore.collection('admin_users').doc(currentUser.uid).set({
        'uid': currentUser.uid,
        'email': currentUser.email,
        'displayName': currentUser.displayName ?? 'Super Admin',
        'role': 'superAdmin',
        'ownedPlaceIds': [],
        'permissions': {},
        'createdAt': FieldValue.serverTimestamp(),
        'isActive': true,
        'metadata': {'createdBy': 'system', 'isInitialSetup': true},
      });

      print('✅ Super admin creado exitosamente');
    } else {
      final data = adminDoc.data()!;
      print('✅ Usuario encontrado en admin_users:');
      print('   📧 Email: ${data['email']}');
      print('   👑 Rol: ${data['role']}');
      print('   🟢 Activo: ${data['isActive']}');
      print('   🏢 Lugares: ${data['ownedPlaceIds']}');

      if (data['role'] != 'superAdmin') {
        print('⚠️  El usuario no es super admin, actualizando...');
        await firestore.collection('admin_users').doc(currentUser.uid).update({
          'role': 'superAdmin',
        });
        print('✅ Rol actualizado a superAdmin');
      }
    }

    // Verificar permisos de escritura
    print('\n🧪 Probando permisos de escritura...');

    // Probar escribir en business_owner_requests
    try {
      await firestore.collection('business_owner_requests').doc('test').set({
        'test': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await firestore
          .collection('business_owner_requests')
          .doc('test')
          .delete();
      print('✅ Permisos de business_owner_requests: OK');
    } catch (e) {
      print('❌ Error en business_owner_requests: $e');
    }

    // Probar escribir en admin_users
    try {
      await firestore.collection('admin_users').doc('test').set({
        'uid': 'test',
        'email': 'test@test.com',
        'role': 'placeOwner',
        'isActive': true,
        'createdAt': FieldValue.serverTimestamp(),
      });
      await firestore.collection('admin_users').doc('test').delete();
      print('✅ Permisos de admin_users: OK');
    } catch (e) {
      print('❌ Error en admin_users: $e');
    }

    print('\n🎉 Verificación completada');
  } catch (e) {
    print('❌ Error durante la verificación: $e');
  }
}
