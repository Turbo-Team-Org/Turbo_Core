// 🌍 Ejemplo de Cambio Dinámico de Entornos - Turbo Core
//
// Este ejemplo demuestra cómo el sistema cambia automáticamente
// entre Firebase (dev) y Supabase (staging) basado en variables de entorno.
//
// EJECUTAR CON FLUTTER:
// fvm flutter run core/example_environment_switching.dart -d chrome

import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';

// Imports del core
import 'package:core/src/dependency_inyection/init_config.dart';
import 'package:core/src/monorepo_utils/environments.dart';
import 'package:core/src/turbo_core_repositories/common/config/hybrid_database_config.dart';
import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';

void main() async {
  print('🚀 Turbo Core - Demostración de Entornos Dinámicos\n');

  WidgetsFlutterBinding.ensureInitialized();

  // Para web, ejecutamos la demo en la UI
  if (kIsWeb) {
    runApp(DemoApp());
  } else {
    // Para otras plataformas, ejecutamos en consola
    try {
      await _runConsoleDemo();
    } catch (e) {
      print('❌ Error en la demostración: $e');
    }
    exit(0);
  }
}

/// Demo para consola (móvil/desktop)
Future<void> _runConsoleDemo() async {
  await _loadEnvironmentVariables();
  await _demonstrateEnvironments();
  await _testServices();
}

/// Cargar variables de entorno
Future<void> _loadEnvironmentVariables() async {
  print('📄 Cargando variables de entorno...');

  try {
    // Intentar cargar .env
    if (await File('core/.env').exists()) {
      await dotenv.load(fileName: 'core/.env');
      print('✅ Archivo .env cargado exitosamente');
    } else {
      print('⚠️ Archivo .env no encontrado, usando configuración por defecto');
      _setDefaultEnvironmentVariables();
    }
  } catch (e) {
    print('⚠️ Error cargando .env: $e');
    _setDefaultEnvironmentVariables();
  }
}

/// Configurar variables por defecto para la demostración
void _setDefaultEnvironmentVariables() {
  print('📝 Configurando variables por defecto para demo...');

  // Configuración Firebase (proyecto actual)
  Platform.environment['ENVIRONMENT'] = 'dev';
  Platform.environment['FIREBASE_PROJECT_ID'] = 'turbo-16770';
  Platform.environment['FIREBASE_API_KEY'] =
      'AIzaSyAVutR13I58yvzsHjV5ZLtS9pHfe4cLsJ8';
  Platform.environment['FIREBASE_APP_ID'] =
      '1:626963970726:web:b87ea452393d72655a1267';
  Platform.environment['FIREBASE_SENDER_ID'] = '626963970726';
  Platform.environment['FIREBASE_AUTH_DOMAIN'] = 'turbo-16770.firebaseapp.com';
  Platform.environment['FIREBASE_STORAGE_BUCKET'] =
      'turbo-16770.firebasestorage.app';
  Platform.environment['FIREBASE_MEASUREMENT_ID'] = 'G-E872L0BE36';

  print('✅ Variables por defecto configuradas (Firebase)');
}

/// Demostrar diferentes configuraciones de entorno
Future<void> _demonstrateEnvironments() async {
  print('\n🔧 Demostrando configuraciones de entorno...\n');

  // Demo 1: Entorno Development (Firebase)
  await _demoEnvironment('Development', () async {
    await initCoreDependencies(
      sl: GetIt.instance,
      environment: TurboEnvironment.dev,
      enableDebugLogs: false,
    );
    _showEnvironmentInfo();
    _showAvailableServices();
  });

  // Reset GetIt para siguiente demo
  await GetIt.instance.reset();

  // Demo 2: Entorno Staging (Supabase)
  await _demoEnvironment('Staging', () async {
    await initCoreDependencies(
      sl: GetIt.instance,
      environment: TurboEnvironment.staging,
      enableDebugLogs: false,
    );
    _showEnvironmentInfo();
    _showAvailableServices();
  });

  // Reset GetIt para siguiente demo
  await GetIt.instance.reset();

  // Demo 3: Override de proveedor - Development pero con Supabase
  await _demoEnvironment('Development con Supabase Override', () async {
    // Simular override: dev environment pero forzando Supabase
    await initCoreDependencies(
      sl: GetIt.instance,
      environment:
          TurboEnvironment.staging, // Usar staging para forzar Supabase
      enableDebugLogs: false,
    );
    _showEnvironmentInfo();
    _showAvailableServices();
  });
}

/// Ejecutar demostración de un entorno específico
Future<void> _demoEnvironment(String name, Future<void> Function() demo) async {
  print('=' * 60);
  print('🌍 DEMO: $name');
  print('=' * 60);

  try {
    await demo();
  } catch (e) {
    print('❌ Error en demo $name: $e');
  }

  print('\n');
}

/// Mostrar información del entorno actual
void _showEnvironmentInfo() {
  print('\n📊 INFORMACIÓN DEL ENTORNO:');
  print('────────────────────────────────────────');

  final envInfo = Env.debugInfo;
  envInfo.forEach((key, value) {
    print('   $key: $value');
  });

  print('\n🔧 CONFIGURACIÓN HÍBRIDA:');
  print('────────────────────────────────────────');

  final hybridInfo = HybridDatabaseConfig.debugInfo;
  print('   Inicializado: ${hybridInfo['isInitialized']}');
  print('   Entorno: ${hybridInfo['environment']}');
  print('   Proveedor principal: ${hybridInfo['primaryProvider']}');
  print('   Firebase disponible: ${hybridInfo['firebaseAvailable']}');
  print('   Supabase disponible: ${hybridInfo['supabaseAvailable']}');
}

/// Mostrar servicios disponibles
void _showAvailableServices() {
  print('\n🛠️ SERVICIOS DISPONIBLES:');
  print('────────────────────────────────────────');

  final services = [
    ('AuthenticationInterface', AuthenticationInterface),
    ('PlaceInterface', PlaceInterface),
    ('ReviewInterface', ReviewInterface),
    ('CategoryInterface', CategoryInterface),
    ('EventInterface', EventInterface),
    ('FavoriteInterface', FavoriteInterface),
    ('LocationInterface', LocationInterface),
  ];

  for (final (name, type) in services) {
    final available = GetIt.instance.isRegistered();
    final status = available ? '✅' : '❌';
    print('   $status $name');
  }
}

/// Probar servicios básicos
Future<void> _testServices() async {
  print('\n🧪 PROBANDO SERVICIOS...\n');

  // Reset y configurar para Firebase
  await GetIt.instance.reset();

  try {
    await initCoreDependencies(
      sl: GetIt.instance,
      environment: TurboEnvironment.dev,
      enableDebugLogs: false,
    );

    await _testAuthenticationService();
    // await _testOtherServices(); // Comentado por ahora
  } catch (e) {
    print('❌ Error probando servicios: $e');
  }
}

/// Probar servicio de autenticación
Future<void> _testAuthenticationService() async {
  print('🔐 Probando AuthenticationService...');

  try {
    if (GetIt.instance.isRegistered<AuthenticationInterface>()) {
      final auth = GetIt.instance<AuthenticationInterface>();
      print('✅ AuthenticationInterface obtenido exitosamente');
      print('   Tipo: ${auth.runtimeType}');

      // Probar método básico (sin conexión real)
      print(
          '   Métodos disponibles: signInWithEmailAndPassword, signOut, etc.');
    } else {
      print('❌ AuthenticationInterface no está registrado');
    }
  } catch (e) {
    print('❌ Error probando AuthenticationService: $e');
  }
}

/// Widget para la demostración web
class DemoApp extends StatefulWidget {
  const DemoApp({super.key});

  @override
  State<DemoApp> createState() => _DemoAppState();
}

class _DemoAppState extends State<DemoApp> {
  List<String> _logs = [];
  bool _isLoading = false;
  TurboEnvironment _currentEnv = TurboEnvironment.dev;

  @override
  void initState() {
    super.initState();
    _runDemo();
  }

  void _addLog(String message) {
    setState(() {
      _logs.add(message);
    });
  }

  Future<void> _runDemo() async {
    setState(() {
      _isLoading = true;
      _logs.clear();
    });

    _addLog('🚀 Iniciando demostración de entornos dinámicos...');

    try {
      // Demo Development (Firebase)
      await _demoEnvironmentUI('Development (Firebase)', TurboEnvironment.dev);

      // Reset GetIt
      await GetIt.instance.reset();
      _addLog('🔄 Reiniciando servicios...');

      // Demo Staging (Supabase)
      await _demoEnvironmentUI('Staging (Supabase)', TurboEnvironment.staging);
    } catch (e) {
      _addLog('❌ Error: $e');
    }

    setState(() {
      _isLoading = false;
    });
  }

  Future<void> _demoEnvironmentUI(String name, TurboEnvironment env) async {
    _addLog('\n🌍 === $name ===');

    try {
      // Inicializar Core
      await initCoreDependencies(
        sl: GetIt.instance,
        environment: env,
        enableDebugLogs: false,
      );

      _addLog('✅ Core inicializado correctamente');

      // Mostrar información del entorno
      final hybridInfo = HybridDatabaseConfig.debugInfo;
      _addLog('📊 Entorno: ${hybridInfo['environment']}');
      _addLog('🗄️ Proveedor: ${hybridInfo['primaryProvider']}');
      _addLog('🔥 Firebase: ${hybridInfo['firebaseAvailable'] ? '✅' : '❌'}');
      _addLog('💚 Supabase: ${hybridInfo['supabaseAvailable'] ? '✅' : '❌'}');

      // Verificar servicios disponibles
      final services = [
        'AuthenticationInterface',
        'ReviewInterface',
        'CategoryInterface',
        'EventInterface',
        'FavoriteInterface',
        'LocationInterface',
      ];

      _addLog('\n🛠️ Servicios disponibles:');
      for (final service in services) {
        final available = _isServiceAvailable(service);
        _addLog('   ${available ? '✅' : '❌'} $service');
      }
    } catch (e) {
      _addLog('❌ Error en $name: $e');
    }
  }

  bool _isServiceAvailable(String serviceName) {
    switch (serviceName) {
      case 'AuthenticationInterface':
        return GetIt.instance.isRegistered<AuthenticationInterface>();
      case 'ReviewInterface':
        return GetIt.instance.isRegistered<ReviewInterface>();
      case 'CategoryInterface':
        return GetIt.instance.isRegistered<CategoryInterface>();
      case 'EventInterface':
        return GetIt.instance.isRegistered<EventInterface>();
      case 'FavoriteInterface':
        return GetIt.instance.isRegistered<FavoriteInterface>();
      case 'LocationInterface':
        return GetIt.instance.isRegistered<LocationInterface>();
      default:
        return false;
    }
  }

  Future<void> _switchEnvironment() async {
    setState(() {
      _isLoading = true;
      _currentEnv = _currentEnv == TurboEnvironment.dev
          ? TurboEnvironment.staging
          : TurboEnvironment.dev;
    });

    await GetIt.instance.reset();
    await _demoEnvironmentUI(
      'Switched to ${_currentEnv.name}',
      _currentEnv,
    );

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Turbo Core - Environment Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Monaco',
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text('🌍 Turbo Core - Environment Demo'),
          backgroundColor: Colors.blue[800],
          foregroundColor: Colors.white,
          actions: [
            if (!_isLoading)
              IconButton(
                icon: Icon(Icons.refresh),
                onPressed: _runDemo,
                tooltip: 'Reiniciar Demo',
              ),
            if (!_isLoading)
              IconButton(
                icon: Icon(Icons.swap_horiz),
                onPressed: _switchEnvironment,
                tooltip: 'Cambiar Entorno',
              ),
          ],
        ),
        body: Container(
          color: Colors.grey[900],
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header info
              Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.blue[800],
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info, color: Colors.white),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Demostración del sistema de entornos dinámicos entre Firebase (dev) y Supabase (staging)',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 16),

              // Loading indicator
              if (_isLoading)
                Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CircularProgressIndicator(color: Colors.blue),
                      SizedBox(height: 16),
                      Text(
                        'Ejecutando demostración...',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                ),

              // Console output
              if (!_isLoading || _logs.isNotEmpty)
                Expanded(
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Colors.grey[700]!),
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: _logs
                            .map((log) => Padding(
                                  padding: EdgeInsets.only(bottom: 4),
                                  child: Text(
                                    log,
                                    style: TextStyle(
                                      color: Colors.green[300],
                                      fontSize: 12,
                                      fontFamily: 'Courier',
                                    ),
                                  ),
                                ))
                            .toList(),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
        bottomNavigationBar: Container(
          padding: EdgeInsets.all(16),
          color: Colors.grey[800],
          child: Text(
            '🚀 Turbo Core - Sistema de Entornos Dinámicos | Firebase (dev) ↔ Supabase (staging)',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white70,
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }
}
