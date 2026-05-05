import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Supabase contract smoke checks', () {
    test('reservation service uses snake_case contract keys', () async {
      final file = File(
        'lib/src/turbo_core_repositories/reservation_repository/service/'
        'reservation_service_supabase.dart',
      );
      final source = await file.readAsString();

      expect(source, contains('user_id'));
      expect(source, contains('place_id'));
      expect(source, contains('reservation_date'));
      expect(source, contains('start_time'));
      expect(source, contains('end_time'));
      expect(source, contains('party_size'));
      expect(source, contains('updated_at'));
    });

    test('supabase DI wires AdminAuthRepository through interface', () async {
      final file = File('lib/src/dependency_inyection/init_config.dart');
      final source = await file.readAsString();

      expect(
        source,
        contains('AdminAuthRepositoryImpl(adminAuthService: sl<AdminAuthInterface>())'),
      );
    });
  });
}
