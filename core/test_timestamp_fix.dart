import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:core/core.dart';

/// Script de prueba para verificar que el problema de timestamps se ha solucionado
void main() async {
  print('🧪 Iniciando prueba de corrección de timestamps...');

  try {
    // Simular datos problemáticos que causaban el error
    final testData = {
      'title': 'Evento de Prueba',
      'description': 'Descripción de prueba',
      'date': '2025-07-07T00:51:00.000', // String en lugar de Timestamp
      'location': 'Ubicación de prueba',
      'imageUrl': 'https://example.com/image.jpg',
      'type': 'concert',
      'placeId': 'test-place-id',
      'price': 50.0,
      'isHighlighted': false,
      'tags': ['test', 'prueba'],
      'organizerName': 'Organizador de Prueba',
      'organizerContact': 'contact@test.com',
      'endDate': '2025-07-07T02:51:00.000', // String en lugar de Timestamp
      'link': 'https://example.com',
      'createdBy': 'test-user',
      'createdAt': '2025-01-01T00:00:00.000', // String en lugar de Timestamp
      'lastUpdatedBy': 'test-admin',
      'lastUpdatedAt':
          '2025-01-01T12:00:00.000', // String en lugar de Timestamp
    };

    print('📋 Datos de prueba creados con strings en lugar de timestamps');

    // Crear un DocumentSnapshot simulado
    final mockDoc = MockDocumentSnapshot(testData);

    print('🔄 Intentando parsear evento con datos problemáticos...');

    // Intentar crear un Event con los datos problemáticos
    final event = Event.fromFirestore(mockDoc);

    print('✅ ¡Éxito! Evento parseado correctamente:');
    print('   - ID: ${event.id}');
    print('   - Título: ${event.title}');
    print('   - Fecha: ${event.date}');
    print('   - Fecha de fin: ${event.endDate}');
    print('   - Creado: ${event.createdAt}');
    print('   - Actualizado: ${event.lastUpdatedAt}');

    print('\n🎉 ¡El problema de timestamps se ha solucionado correctamente!');
  } catch (e) {
    print('❌ Error durante la prueba: $e');
    print('🔧 El problema aún persiste y necesita más correcciones.');
  }
}

/// DocumentSnapshot simulado para pruebas
class MockDocumentSnapshot implements DocumentSnapshot {
  final Map<String, dynamic> _data;

  MockDocumentSnapshot(this._data);

  @override
  String get id => 'test-event-id';

  @override
  Map<String, dynamic>? data() => _data;

  @override
  bool get exists => true;

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}
