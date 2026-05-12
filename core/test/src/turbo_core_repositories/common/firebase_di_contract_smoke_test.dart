import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Firebase DI contract smoke checks', () {
    test('registers AnalyticsInterface in firebase path', () async {
      final file = File('lib/src/dependency_inyection/init_config.dart');
      final source = await file.readAsString();

      expect(source, contains('if (!sl.isRegistered<AnalyticsInterface>())'));
      expect(source, contains('sl.registerLazySingleton<AnalyticsInterface>'));
      expect(source, contains('sl<AnalyticsService>()'));
    });
  });
}
