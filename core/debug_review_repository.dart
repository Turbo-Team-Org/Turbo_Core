import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get_it/get_it.dart';
import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';

/// Script de debugging para verificar la configuración del ReviewRepository
///
/// Este script te ayudará a identificar por qué el método getReviews()
/// no está llegando al ReviewService desde el Admin Panel.
void main() async {
  print('🔍 INICIANDO DEBUGGING DEL REVIEW REPOSITORY...\n');

  // 1. Verificar que las clases estén importadas correctamente
  print('✅ PASO 1: Verificando imports...');
  print('- ReviewRepository: ${ReviewRepository}');
  print('- ReviewService: ${ReviewService}');
  print('- Review: ${Review}');
  print('- ReviewStatus: ${ReviewStatus}');
  print('- PaginatedReviews: ${PaginatedReviews}\n');

  // 2. Simular inicialización de dependencias (sin Firebase real)
  print('✅ PASO 2: Verificando inyección de dependencias...');
  final sl = GetIt.instance;

  try {
    // Registrar un FirebaseFirestore mock (para testing)
    if (!sl.isRegistered<FirebaseFirestore>()) {
      print('⚠️  FirebaseFirestore NO está registrado en GetIt');
    } else {
      print('✅ FirebaseFirestore está registrado');
    }

    if (!sl.isRegistered<ReviewService>()) {
      print('⚠️  ReviewService NO está registrado en GetIt');
    } else {
      print('✅ ReviewService está registrado');
    }

    if (!sl.isRegistered<ReviewRepository>()) {
      print('⚠️  ReviewRepository NO está registrado en GetIt');
    } else {
      print('✅ ReviewRepository está registrado');
    }
  } catch (e) {
    print('❌ Error verificando dependencias: $e');
  }

  print('\n✅ PASO 3: Verificando instanciación manual...');

  try {
    // Crear instancia manual para verificar que funciona
    final mockFirestore = _createMockFirestore();
    final reviewService = ReviewService(firestore: mockFirestore);
    final reviewRepository = ReviewRepository(reviewService: reviewService);

    print('✅ ReviewService creado manualmente: ${reviewService.runtimeType}');
    print(
        '✅ ReviewRepository creado manualmente: ${reviewRepository.runtimeType}');
    print(
        '✅ Campo reviewService en repository: ${reviewRepository.reviewService.runtimeType}');

    // Verificar que el método existe
    print('✅ Método getReviews() existe: ${reviewRepository.getReviews}');
  } catch (e) {
    print('❌ Error en instanciación manual: $e');
  }

  print('\n📋 RESUMEN Y RECOMENDACIONES:');
  print('════════════════════════════════════════════════════════════════');
  print('');
  print('🎯 PROBLEMAS COMUNES Y SOLUCIONES:');
  print('');
  print('1. 🔧 VERIFICAR EN EL ADMIN PANEL:');
  print('   - ¿Estás usando GetIt.instance.get<ReviewRepository>()?');
  print('   - ¿O estás creando una instancia manual?');
  print('   - ¿Estás llamando directamente a ReviewService?');
  print('');
  print('2. 🔧 CÓDIGO CORRECTO EN ADMIN PANEL:');
  print('   ```dart');
  print('   // ✅ CORRECTO');
  print('   final reviewRepository = GetIt.instance.get<ReviewRepository>();');
  print('   final reviews = await reviewRepository.getReviews();');
  print('   ');
  print('   // ❌ INCORRECTO');
  print('   final reviewService = GetIt.instance.get<ReviewService>();');
  print('   final reviews = await reviewService.getReviews();');
  print('   ```');
  print('');
  print('3. 🔧 VERIFICAR INICIALIZACIÓN:');
  print(
      '   - ¿Se está llamando initCoreDependencies() antes de usar el repository?');
  print('   - ¿Firebase está inicializado correctamente?');
  print('');
  print('4. 🔧 DEBUGGING ADICIONAL:');
  print('   - Agrega print() al inicio de getReviews() en ReviewRepository');
  print('   - Agrega print() al inicio de getReviews() en ReviewService');
  print('   - Verifica que no haya excepciones silenciosas');
  print('');
  print('5. 🔧 EJEMPLO DE DEBUGGING EN ADMIN PANEL:');
  print('   ```dart');
  print('   try {');
  print('     print("🔍 Obteniendo ReviewRepository...");');
  print('     final repository = GetIt.instance.get<ReviewRepository>();');
  print('     print("✅ Repository obtenido: \${repository.runtimeType}");');
  print('     ');
  print('     print("🔍 Llamando getReviews()...");');
  print('     final reviews = await repository.getReviews();');
  print('     print("✅ Reviews obtenidas: \${reviews.length}");');
  print('   } catch (e) {');
  print('     print("❌ Error: \$e");');
  print('   }');
  print('   ```');
  print('');
  print('════════════════════════════════════════════════════════════════');
}

/// Crear un mock básico de FirebaseFirestore para testing
FirebaseFirestore _createMockFirestore() {
  // Esto es solo para verificar que las clases se pueden instanciar
  // En un entorno real, usarías el FirebaseFirestore real
  throw UnsupportedError('Mock FirebaseFirestore para debugging');
}

/// Función para verificar la configuración desde el Admin Panel
///
/// Copia esta función a tu Admin Panel para diagnosticar el problema
void debugReviewRepositoryFromAdminPanel() async {
  print('🔍 DEBUGGING DESDE ADMIN PANEL...\n');

  try {
    final sl = GetIt.instance;

    // Verificar que el repository esté registrado
    print('Verificando registro en GetIt...');
    if (sl.isRegistered<ReviewRepository>()) {
      print('✅ ReviewRepository está registrado');

      // Obtener el repository
      final repository = sl.get<ReviewRepository>();
      print('✅ Repository obtenido: ${repository.runtimeType}');
      print('✅ Service en repository: ${repository.reviewService.runtimeType}');

      // Intentar llamar al método
      print('\n🔍 Llamando getReviews()...');
      final reviews = await repository.getReviews();
      print('✅ Reviews obtenidas: ${reviews.length}');
    } else {
      print('❌ ReviewRepository NO está registrado en GetIt');
      print('💡 Asegúrate de llamar initCoreDependencies() primero');
    }
  } catch (e, stackTrace) {
    print('❌ ERROR: $e');
    print('📍 Stack trace: $stackTrace');
  }
}
