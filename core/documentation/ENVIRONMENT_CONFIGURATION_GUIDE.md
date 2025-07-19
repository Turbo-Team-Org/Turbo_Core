# 🌍 Guía de Configuración de Entornos - Turbo Core

Esta guía explica cómo configurar y cambiar entre diferentes entornos en Turbo Core, permitiendo usar Firebase (desarrollo) y Supabase (staging/production) dinámicamente.

## 📋 **Tabla de Contenidos**

1. [Resumen de Entornos](#-resumen-de-entornos)
2. [Configuración Inicial](#-configuración-inicial)
3. [Variables de Entorno](#-variables-de-entorno)
4. [Cómo Cambiar de Entorno](#-cómo-cambiar-de-entorno)
5. [Uso en Código](#-uso-en-código)
6. [Troubleshooting](#-troubleshooting)
7. [Ejemplos Prácticos](#-ejemplos-prácticos)

## 🎯 **Resumen de Entornos**

### **Entornos Disponibles**

| Entorno     | Base de Datos | Descripción                           | Uso               |
| ----------- | ------------- | ------------------------------------- | ----------------- |
| **dev**     | Firebase      | Desarrollo local con datos existentes | Desarrollo diario |
| **staging** | Supabase      | Pruebas con nueva arquitectura        | Testing, QA       |
| **prod**    | Supabase      | Producción (futuro)                   | Usuarios finales  |

### **Arquitectura Híbrida**

```mermaid
graph TD
    A[Turbo App] --> B[Turbo Core]
    B --> C{Environment?}
    C -->|dev| D[Firebase]
    C -->|staging| E[Supabase]
    C -->|prod| E

    D --> F[Firestore]
    D --> G[Firebase Auth]

    E --> H[PostgreSQL]
    E --> I[Supabase Auth]

    style D fill:#ff9800
    style E fill:#00d4aa
```

## 🚀 **Configuración Inicial**

### **1. Copiar Archivo de Entorno**

```bash
# En el directorio core/
cp env.example .env
```

### **2. Configurar Variables**

Edita el archivo `.env` con tus credenciales:

```bash
# Para desarrollo (Firebase)
ENVIRONMENT=dev
FIREBASE_PROJECT_ID=turbo-16770
# ... resto de credenciales Firebase

# Para staging (Supabase)
ENVIRONMENT=staging
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=tu-anon-key
```

### **3. Inicializar en el Código**

```dart
// En main.dart de tu app
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Cargar variables de entorno
  await dotenv.load(fileName: ".env");

  // Inicializar dependencias dinámicamente
  await initCoreDependencies(
    sl: GetIt.instance,
    enableDebugLogs: true, // Para ver qué se está cargando
  );

  runApp(MyApp());
}
```

## 📝 **Variables de Entorno**

### **Variables Principales**

```bash
# Configuración del entorno
ENVIRONMENT=dev|staging|prod
DATABASE_PROVIDER=firebase|supabase  # Opcional, auto-detectado

# Firebase (entorno dev)
FIREBASE_PROJECT_ID=turbo-16770
FIREBASE_API_KEY=...
FIREBASE_APP_ID=...

# Supabase (entorno staging/prod)
SUPABASE_URL=https://...
SUPABASE_ANON_KEY=...
SUPABASE_SERVICE_ROLE_KEY=...  # Para operaciones admin
```

### **Auto-detección**

Si no especificas `DATABASE_PROVIDER`, se auto-detecta:

- `ENVIRONMENT=dev` → `DATABASE_PROVIDER=firebase`
- `ENVIRONMENT=staging` → `DATABASE_PROVIDER=supabase`
- `ENVIRONMENT=prod` → `DATABASE_PROVIDER=supabase`

## 🔄 **Cómo Cambiar de Entorno**

### **Opción 1: Variables de Entorno**

```bash
# Cambiar a desarrollo (Firebase)
ENVIRONMENT=dev

# Cambiar a staging (Supabase)
ENVIRONMENT=staging
```

### **Opción 2: Override Programático**

```dart
// Forzar un entorno específico
await initCoreDependencies(
  sl: GetIt.instance,
  forceEnvironment: TurboEnvironment.staging,
);
```

### **Opción 3: Provider Específico**

```bash
# Forzar proveedor específico
DATABASE_PROVIDER=supabase
ENVIRONMENT=dev  # Desarrollo pero con Supabase
```

## 💻 **Uso en Código**

### **Verificar Entorno Actual**

```dart
import 'package:core/src/monorepo_utils/environments.dart';

void checkEnvironment() {
  print('Entorno: ${Env.environment.name}');
  print('Base de datos: ${Env.databaseProvider.name}');
  print('Firebase configurado: ${Env.isFirebaseConfigured}');
  print('Supabase configurado: ${Env.isSupabaseConfigured}');
}
```

### **Usar Servicios Dinámicamente**

```dart
import 'package:get_it/get_it.dart';
import 'package:core/core.dart';

class UserService {
  final AuthenticationInterface _auth = GetIt.instance<AuthenticationInterface>();
  final PlaceInterface _places = GetIt.instance<PlaceInterface>();

  // Los servicios se resuelven automáticamente según el entorno
  Future<void> login(String email, String password) async {
    await _auth.signInWithEmailAndPassword(email, password);
  }
}
```

### **Verificar Disponibilidad de Servicios**

```dart
import 'package:core/src/dependency_inyection/init_config.dart';

void checkServices() {
  if (isRepositoryAvailable<AuthenticationInterface>()) {
    print('✅ Authentication service disponible');
  }

  if (isRepositoryAvailable<PlaceInterface>()) {
    print('✅ Place service disponible');
  }
}
```

### **Debug de Configuración**

```dart
import 'package:core/src/dependency_inyection/init_config.dart';
import 'package:core/src/turbo_core_repositories/common/config/hybrid_database_config.dart';

void printDebugInfo() {
  // Info de entorno
  print('Environment Info: ${Env.debugInfo}');

  // Info de configuración híbrida
  print('Hybrid Config: ${HybridDatabaseConfig.debugInfo}');

  // Info de dependencias
  print('Dependencies: ${getDependencyInfo()}');

  // Info visual
  HybridDatabaseConfig.printConfigInfo();
}
```

## 🛠️ **Troubleshooting**

### **Error: "No database provider configured"**

```dart
// Verificar configuración
print(Env.debugInfo);

// Solución: Asegurar que las variables están configuradas
ENVIRONMENT=dev
FIREBASE_PROJECT_ID=turbo-16770
```

### **Error: "Firebase/Supabase no está configurado"**

```dart
// Verificar disponibilidad
print('Firebase disponible: ${HybridDatabaseConfig.isFirebaseAvailable}');
print('Supabase disponible: ${HybridDatabaseConfig.isSupabaseAvailable}');

// Solución: Verificar credenciales en .env
```

### **Error: "Service not registered"**

```dart
// Verificar qué servicios están registrados
if (!isRepositoryAvailable<AuthenticationInterface>()) {
  print('❌ AuthenticationInterface no registrado');
  // Verificar inicialización de dependencias
}
```

### **Logs de Debug**

```dart
// Habilitar logs detallados
await initCoreDependencies(
  sl: GetIt.instance,
  enableDebugLogs: true,
);

// Output esperado:
// 🔧 Inicializando dependencias Turbo Core...
// 📱 Entorno detectado: dev
// 🗄️ Proveedor de BD: firebase
// ✅ Firebase services registrados
// 📦 Registrando servicios básicos para:
//    Entorno: dev
//    Proveedor: firebase
// ✅ AuthenticationService (Firebase)
// ✅ PlaceService (Firebase)
// ...
```

## 📚 **Ejemplos Prácticos**

### **Desarrollo Normal (Firebase)**

```bash
# .env
ENVIRONMENT=dev
FIREBASE_PROJECT_ID=turbo-16770
FIREBASE_API_KEY=AIzaSyAVutR13I58yvzsHjV5ZLtS9pHfe4cLsJ8
# ... resto de Firebase
```

### **Testing con Supabase**

```bash
# .env
ENVIRONMENT=staging
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=tu-anon-key
```

### **Desarrollo Híbrido**

```bash
# .env
ENVIRONMENT=dev
DATABASE_PROVIDER=supabase  # Forzar Supabase en dev
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=tu-anon-key
```

### **Código con Verificación de Entorno**

```dart
class DataManager {
  Future<void> initializeData() async {
    if (Env.isUsingFirebase) {
      print('🔥 Usando Firebase - datos de desarrollo');
      // Lógica específica para Firebase
    } else if (Env.isUsingSupabase) {
      print('💚 Usando Supabase - datos de staging');
      // Lógica específica para Supabase
    }
  }
}
```

## 🎯 **Próximos Pasos**

1. **Completar servicios Supabase**: Implementar Place, Analytics, Admin Auth
2. **Migration tools**: Herramientas para migrar datos Firebase → Supabase
3. **Testing**: Tests automáticos para ambos entornos
4. **CI/CD**: Configuración automática según branch
5. **Monitoring**: Métricas diferenciadas por entorno

## 📞 **Soporte**

Si tienes problemas con la configuración de entornos:

1. Verifica el archivo `.env`
2. Ejecuta con `enableDebugLogs: true`
3. Revisa la salida de `Env.debugInfo`
4. Consulta los logs de inicialización
