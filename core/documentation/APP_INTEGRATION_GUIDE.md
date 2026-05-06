# 📱 Guía de Integración desde App/Admin Panel

Esta guía explica cómo integrar el sistema de entornos dinámicos desde tu **App Flutter** y **Admin Panel Web**.

## 🎯 **Integración desde la App Móvil**

### **1. En main.dart de la App**

```dart
// lib/main.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart'; // Turbo Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🌍 Configurar entorno dinámicamente
  await initializeTurboCore();

  runApp(MyApp());
}

Future<void> initializeTurboCore() async {
  // Determinar entorno basado en build mode o configuración
  final environment = _determineEnvironment();

  print('🚀 Inicializando Turbo Core en entorno: ${environment.name}');

  // Inicializar Core con entorno específico
  await initCoreDependencies(
    sl: GetIt.instance,
    environment: environment,
    enableDebugLogs: true, // Solo en debug
  );

  print('✅ Turbo Core inicializado correctamente');
}

TurboEnvironment _determineEnvironment() {
  // Opción 1: Basado en build mode
  if (kDebugMode) {
    return TurboEnvironment.dev;    // Firebase para desarrollo
  } else if (kProfileMode) {
    return TurboEnvironment.staging; // Supabase para testing
  } else {
    return TurboEnvironment.prod;    // Supabase para producción
  }

  // Opción 2: Basado en flavor/esquema
  // const flavor = String.fromEnvironment('FLAVOR', defaultValue: 'dev');
  // switch (flavor) {
  //   case 'dev': return TurboEnvironment.dev;
  //   case 'staging': return TurboEnvironment.staging;
  //   case 'prod': return TurboEnvironment.prod;
  //   default: return TurboEnvironment.dev;
  // }
}
```

### **2. Configuración de Build Variants**

#### **android/app/build.gradle**

```gradle
android {
    // ... configuración existente

    flavorDimensions "environment"
    productFlavors {
        dev {
            dimension "environment"
            applicationIdSuffix ".dev"
            versionNameSuffix "-dev"
            // Firebase configuration
        }
        staging {
            dimension "environment"
            applicationIdSuffix ".staging"
            versionNameSuffix "-staging"
            // Supabase configuration
        }
        prod {
            dimension "environment"
            // Production configuration
        }
    }
}
```

#### **Ejecutar con flavors**

```bash
# Desarrollo (Firebase)
flutter run --flavor dev

# Staging (Supabase)
flutter run --flavor staging

# Producción (Supabase)
flutter run --flavor prod
```

## 🖥️ **Integración desde Admin Panel Web**

### **1. En main.dart del Admin Panel**

```dart
// admin_panel/lib/main.dart
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:core/core.dart'; // Turbo Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // 🌍 Admin Panel siempre usa Supabase (datos más recientes)
  await initializeTurboCoreForAdmin();

  runApp(AdminApp());
}

Future<void> initializeTurboCoreForAdmin() async {
  print('🖥️ Inicializando Turbo Core para Admin Panel');

  // Admin Panel siempre usa Supabase para datos consistentes
  await initCoreDependencies(
    sl: GetIt.instance,
    environment: TurboEnvironment.staging, // o prod según configuración
    enableDebugLogs: kDebugMode,
  );

  print('✅ Admin Panel conectado a Supabase');
}
```

### **2. Configuración de Deploy**

#### **Para desarrollo local**

```bash
# Admin panel conectado a Supabase staging
ENVIRONMENT=staging flutter run -d chrome
```

#### **Para producción**

```bash
# Build para producción
flutter build web --release
```

## 🔧 **Configuración Avanzada**

### **1. Environment Switcher (Debug Only)**

```dart
// lib/debug/environment_switcher.dart
class EnvironmentSwitcher extends StatefulWidget {
  @override
  _EnvironmentSwitcherState createState() => _EnvironmentSwitcherState();
}

class _EnvironmentSwitcherState extends State<EnvironmentSwitcher> {
  TurboEnvironment _currentEnv = TurboEnvironment.dev;

  @override
  Widget build(BuildContext context) {
    if (!kDebugMode) return SizedBox.shrink(); // Solo en debug

    return FloatingActionButton(
      onPressed: _switchEnvironment,
      child: Icon(Icons.swap_horiz),
      tooltip: 'Switch Environment (${_currentEnv.name})',
    );
  }

  Future<void> _switchEnvironment() async {
    // Cambiar entorno
    _currentEnv = _currentEnv == TurboEnvironment.dev
        ? TurboEnvironment.staging
        : TurboEnvironment.dev;

    // Reinicializar Core
    await GetIt.instance.reset();
    await initCoreDependencies(
      sl: GetIt.instance,
      environment: _currentEnv,
      enableDebugLogs: true,
    );

    // Notificar cambio
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Switched to ${_currentEnv.name}')),
    );

    setState(() {});
  }
}
```

### **2. Environment Status Widget**

```dart
// lib/widgets/environment_status.dart
class EnvironmentStatus extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final environment = HybridDatabaseConfig.currentEnvironment;
    final provider = HybridDatabaseConfig.currentProvider;

    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: _getEnvironmentColor(environment),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_getEnvironmentIcon(provider), size: 16, color: Colors.white),
          SizedBox(width: 4),
          Text(
            '${environment?.name.toUpperCase() ?? 'UNKNOWN'}',
            style: TextStyle(color: Colors.white, fontSize: 12),
          ),
        ],
      ),
    );
  }

  Color _getEnvironmentColor(TurboEnvironment? env) {
    switch (env) {
      case TurboEnvironment.dev: return Colors.orange;
      case TurboEnvironment.staging: return Colors.blue;
      case TurboEnvironment.prod: return Colors.green;
      default: return Colors.grey;
    }
  }

  IconData _getEnvironmentIcon(DatabaseProvider? provider) {
    switch (provider) {
      case DatabaseProvider.firebase: return Icons.local_fire_department;
      case DatabaseProvider.supabase: return Icons.storage;
      default: return Icons.help;
    }
  }
}
```

## 📋 **Ejemplos de Uso en Servicios**

### **1. Servicio que se adapta al entorno**

```dart
// lib/services/data_service.dart
class DataService {
  final AuthenticationInterface _auth = GetIt.instance<AuthenticationInterface>();
  final PlaceInterface _places = GetIt.instance<PlaceInterface>();

  Future<void> syncData() async {
    final environment = HybridDatabaseConfig.currentEnvironment;

    if (environment == TurboEnvironment.dev) {
      print('🔥 Sincronizando con Firebase (datos de desarrollo)');
      await _syncWithFirebase();
    } else {
      print('💚 Sincronizando con Supabase (datos de staging/prod)');
      await _syncWithSupabase();
    }
  }

  Future<void> _syncWithFirebase() async {
    // Lógica específica para Firebase
    // Por ejemplo, usar diferentes colecciones o configuraciones
  }

  Future<void> _syncWithSupabase() async {
    // Lógica específica para Supabase
    // Por ejemplo, usar RLS o funciones específicas de PostgreSQL
  }
}
```

### **2. Debug Info Service**

```dart
// lib/services/debug_service.dart
class DebugService {
  static void printEnvironmentInfo() {
    if (!kDebugMode) return;

    print('\n' + '=' * 50);
    print('🔍 TURBO CORE DEBUG INFO');
    print('=' * 50);

    // Environment info
    final envInfo = Env.debugInfo;
    print('📊 Environment Configuration:');
    envInfo.forEach((key, value) => print('   $key: $value'));

    // Hybrid config info
    final hybridInfo = HybridDatabaseConfig.debugInfo;
    print('\n🔧 Hybrid Configuration:');
    hybridInfo.forEach((key, value) => print('   $key: $value'));

    // Available services
    print('\n🛠️ Available Services:');
    final services = [
      'AuthenticationInterface',
      'PlaceInterface',
      'ReviewInterface',
      'CategoryInterface',
      'EventInterface',
      'FavoriteInterface',
      'LocationInterface',
    ];

    for (final service in services) {
      final available = GetIt.instance.isRegistered(service);
      print('   ${available ? '✅' : '❌'} $service');
    }

    print('=' * 50 + '\n');
  }
}
```

## 🚀 **Scripts de Build**

### **build_scripts.sh**

```bash
#!/bin/bash

# Build script para diferentes entornos

case "$1" in
  "dev")
    echo "🔥 Building for Development (Firebase)"
    flutter build apk --flavor dev
    ;;
  "staging")
    echo "💚 Building for Staging (Supabase)"
    flutter build apk --flavor staging
    ;;
  "prod")
    echo "🌟 Building for Production (Supabase)"
    flutter build apk --flavor prod --release
    ;;
  "admin")
    echo "🖥️ Building Admin Panel (Supabase)"
    cd admin_panel && flutter build web --release
    ;;
  *)
    echo "Usage: $0 {dev|staging|prod|admin}"
    exit 1
    ;;
esac
```

## 📊 **Monitoreo y Logs**

### **1. Environment Logger**

```dart
// lib/utils/environment_logger.dart
class EnvironmentLogger {
  static void logEnvironmentSwitch(TurboEnvironment from, TurboEnvironment to) {
    print('🔄 Environment Switch: ${from.name} → ${to.name}');

    // En producción, enviar a analytics
    if (!kDebugMode) {
      // Analytics.logEvent('environment_switch', {
      //   'from': from.name,
      //   'to': to.name,
      //   'timestamp': DateTime.now().toIso8601String(),
      // });
    }
  }

  static void logServiceUsage(String serviceName, String operation) {
    final env = HybridDatabaseConfig.currentEnvironment?.name ?? 'unknown';
    final provider = HybridDatabaseConfig.currentProvider?.name ?? 'unknown';

    print('📊 Service Usage: $serviceName.$operation (env: $env, provider: $provider)');
  }
}
```

## 🎯 **Resumen de Configuración**

| Escenario            | Entorno        | Base de Datos | Comando                        |
| -------------------- | -------------- | ------------- | ------------------------------ |
| **Desarrollo local** | `dev`          | Firebase      | `flutter run --flavor dev`     |
| **Testing/QA**       | `staging`      | Supabase      | `flutter run --flavor staging` |
| **Producción**       | `prod`         | Supabase      | `flutter run --flavor prod`    |
| **Admin Panel**      | `staging/prod` | Supabase      | `flutter run -d chrome`        |

**🚀 Con esta configuración, tanto la app móvil como el admin panel pueden pasar el entorno directamente al Core, y este se configurará automáticamente con Firebase o Supabase según corresponda!**
