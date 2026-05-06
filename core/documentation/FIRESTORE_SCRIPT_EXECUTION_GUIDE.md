# 🛠️ Guía de Ejecución Scripts Firestore - Sistema Administrativo

## ❌ **Problema Identificado**

Los scripts de configuración de Firestore **NO pueden ejecutarse directamente** desde el proyecto por los siguientes motivos:

### **1. Falta de Configuración Firebase**

```dart
// ❌ Error común
await Firebase.initializeApp(); // Sin configuración específica
```

**Problema:** Firebase necesita `firebase_options.dart` con la configuración específica de tu proyecto.

### **2. Dependencias No Configuradas**

```dart
// ❌ Error común
import 'package:core/src/turbo_core_repositories/turbo_core_repositories.dart';
// Las dependencias no están registradas en el contexto del script
```

**Problema:** Los scripts ejecutados con `dart run` no tienen acceso al contexto completo de Flutter.

### **3. Contexto de Ejecución Diferente**

```bash
# ❌ Esto falla
dart run scripts/setup_admin_firestore.dart

# ✅ Esto funciona pero requiere configuración adicional
flutter test scripts/setup_admin_firestore.dart
```

## 🎯 **Soluciones Disponibles**

### **Opción 1: Configuración Manual en Firebase Console** ⭐ **RECOMENDADA**

#### **Pasos:**

1. Abrir [Firebase Console](https://console.firebase.google.com)
2. Ir a tu proyecto Turbo Core
3. Navegar a Firestore Database
4. Crear collections manualmente

#### **Collection: `admin_users`**

```javascript
// Document ID: super_admin_001
{
  uid: "super_admin_001",
  email: "superadmin@turbo.com",
  displayName: "Super Administrador",
  role: "superAdmin",
  ownedPlaceIds: [],
  permissions: {},
  createdAt: [timestamp actual],
  lastLogin: null,
  isActive: true,
  photoUrl: null,
  phoneNumber: null,
  metadata: {
    createdBy: "system",
    initialSetup: true
  }
}
```

#### **Actualizar Collection: `places`**

```javascript
// Para cada documento en places, agregar:
{
  // ... campos existentes ...
  ownerIds: [],
  createdBy: "system",
  createdAt: [timestamp actual],
  lastUpdated: [timestamp actual]
}
```

#### **Actualizar Collection: `events`**

```javascript
// Para cada documento en events, agregar:
{
  // ... campos existentes ...
  createdBy: "system",
  createdAt: [timestamp actual],
  lastUpdatedBy: null,
  lastUpdatedAt: null
}
```

### **Opción 2: Usando Cloud Functions**

#### **Crear función de inicialización:**

```javascript
// functions/src/initAdminSystem.js
const functions = require("firebase-functions");
const admin = require("firebase-admin");

exports.initAdminSystem = functions.https.onCall(async (data, context) => {
  const firestore = admin.firestore();

  // Crear super admin
  await firestore.collection("admin_users").doc("super_admin_001").set({
    uid: "super_admin_001",
    email: "superadmin@turbo.com",
    // ... resto de campos
  });

  // Actualizar places y events
  // ... lógica de actualización

  return { success: true, message: "Sistema administrativo inicializado" };
});
```

#### **Ejecutar desde tu app Flutter:**

```dart
// En tu app Flutter
final callable = FirebaseFunctions.instance.httpsCallable('initAdminSystem');
final result = await callable.call();
```

### **Opción 3: Integración en la App** ⭐ **PARA DESARROLLO**

#### **Crear pantalla de setup en tu app:**

```dart
class AdminSetupScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Setup Sistema Admin')),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () => _createSuperAdmin(),
            child: Text('Crear Super Admin'),
          ),
          ElevatedButton(
            onPressed: () => _updatePlaces(),
            child: Text('Actualizar Lugares'),
          ),
          ElevatedButton(
            onPressed: () => _updateEvents(),
            child: Text('Actualizar Eventos'),
          ),
        ],
      ),
    );
  }

  Future<void> _createSuperAdmin() async {
    final adminRepo = GetIt.instance<AdminAuthRepository>();
    // Usar AdminAuthService para crear super admin
    // ... lógica de creación
  }

  Future<void> _updatePlaces() async {
    final placeRepo = GetIt.instance<PlaceRepository>();
    // Usar PlaceRepository para actualizar lugares
    // ... lógica de actualización
  }

  Future<void> _updateEvents() async {
    final eventRepo = GetIt.instance<EventRepository>();
    // Usar EventRepository para actualizar eventos
    // ... lógica de actualización
  }
}
```

### **Opción 4: Script con Configuración Completa**

#### **Crear archivo de configuración:**

```dart
// scripts/firebase_config.dart
import 'package:firebase_core/firebase_core.dart';

const firebaseOptions = FirebaseOptions(
  apiKey: 'TU_API_KEY',
  appId: 'TU_APP_ID',
  messagingSenderId: 'TU_SENDER_ID',
  projectId: 'TU_PROJECT_ID',
  storageBucket: 'TU_STORAGE_BUCKET',
  authDomain: 'TU_AUTH_DOMAIN',
);
```

#### **Ejecutar con configuración:**

```bash
# Después de configurar firebase_config.dart
dart run scripts/setup_admin_firestore.dart
```

## 📋 **Pasos Recomendados por Orden de Preferencia**

### **1. 🥇 Configuración Manual (Más Seguro)**

- ✅ Sin riesgo de errores de código
- ✅ Control total sobre los datos
- ✅ Funciona inmediatamente
- ❌ Requiere trabajo manual

### **2. 🥈 Integración en App (Más Conveniente)**

- ✅ Usa repositorios existentes
- ✅ Validación completa
- ✅ UI amigable para admins
- ❌ Requiere desarrollo adicional

### **3. 🥉 Cloud Functions (Más Escalable)**

- ✅ Ejecución en servidor
- ✅ Sin problemas de configuración local
- ✅ Reutilizable para otros proyectos
- ❌ Requiere configuración de Functions

### **4. 🔧 Scripts Standalone (Más Técnico)**

- ✅ Automatización completa
- ✅ Reutilizable
- ❌ Requiere configuración compleja
- ❌ Propenso a errores

## 🛡️ **Consideraciones de Seguridad**

### **Reglas de Seguridad de Firestore**

```javascript
// firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // Collection admin_users solo accesible por super admins
    match /admin_users/{adminId} {
      allow read, write: if request.auth != null &&
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin';
    }

    // Places solo editables por propietarios o super admins
    match /places/{placeId} {
      allow read: if true; // Público para lectura
      allow write: if request.auth != null && (
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin' ||
        request.auth.uid in resource.data.ownerIds
      );
    }

    // Events solo editables por creadores o propietarios del lugar
    match /events/{eventId} {
      allow read: if true; // Público para lectura
      allow write: if request.auth != null && (
        request.auth.uid == resource.data.createdBy ||
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin'
      );
    }
  }
}
```

## 🚀 **Próximos Pasos**

1. **Elegir opción de configuración** según tus necesidades
2. **Implementar reglas de seguridad** apropiadas
3. **Crear usuarios administrativos** usando AdminAuthService
4. **Asignar ownership** a lugares específicos
5. **Configurar UI administrativa** en tu panel

## 📞 **Soporte**

Si tienes problemas con cualquiera de estas opciones:

1. Verifica la documentación de Firebase para tu configuración específica
2. Consulta los logs de error para más detalles
3. Usa la configuración manual como fallback seguro

---

**Recomendación final:** Usa la **configuración manual** para el setup inicial, y luego implementa la **integración en app** para futuras operaciones administrativas.
