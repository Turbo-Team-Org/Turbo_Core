# 🚀 Guía de Configuración Proyecto Turbo - Sistema Administrativo

## 📱 **Información del Proyecto**

- **Proyecto ID:** turbo-16770
- **Firebase Console:** https://console.firebase.google.com/project/turbo-16770
- **Firestore:** https://console.firebase.google.com/project/turbo-16770/firestore
- **Auth Domain:** turbo-16770.firebaseapp.com

## 🎯 **Opción 1: Ejecución Automática (RECOMENDADA)**

### **Ejecutar Script Funcional**

```bash
# Desde el directorio core/
dart run scripts/turbo_firestore_setup.dart
```

**Este script:**

- ✅ Se conecta automáticamente a tu proyecto turbo-16770
- ✅ Verifica el estado actual de tus collections
- ✅ Crea la collection `admin_users` con super administrador
- ✅ Actualiza lugares existentes con campos administrativos
- ✅ Actualiza eventos existentes con campos de auditoría
- ✅ Es seguro ejecutar múltiples veces (no duplica datos)

### **Salida Esperada:**

```
🚀 Configurando Sistema Administrativo - Proyecto Turbo

📱 Proyecto: turbo-16770
🔗 Firestore: turbo-16770.firebaseapp.com

✅ Conectado a Firebase exitosamente

📊 Verificando estado actual de Firestore...
   📍 Places: ✅ Existe
   🎯 Events: ✅ Existe
   👥 Users: ✅ Existe
   👑 Admin Users: ❌ No existe

🔧 Iniciando configuración del sistema administrativo...

👑 1. Configurando collection admin_users...
   ✅ Super Admin creado: superadmin@turbo.com
   🔑 UID: super_admin_001

🏢 2. Actualizando collection places...
   📍 Total lugares encontrados: X
   ✅ X lugares actualizados con campos administrativos

🎯 3. Actualizando collection events...
   🎯 Total eventos encontrados: Y
   ✅ Y eventos actualizados con campos de auditoría

🎉 ¡Configuración completada exitosamente!
```

## 🎯 **Opción 2: Configuración Manual**

Si el script no funciona, puedes configurar manualmente:

### **1. Crear Collection `admin_users`**

Ve a [Firestore Console](https://console.firebase.google.com/project/turbo-16770/firestore) y crea:

```
Collection: admin_users
Document ID: super_admin_001

Fields:
├── uid: "super_admin_001" (string)
├── email: "superadmin@turbo.com" (string)
├── displayName: "Super Administrador Turbo" (string)
├── role: "superAdmin" (string)
├── ownedPlaceIds: [] (array)
├── permissions: {} (map)
├── createdAt: [timestamp actual] (timestamp)
├── lastLogin: null
├── isActive: true (boolean)
├── photoUrl: null
├── phoneNumber: null
└── metadata: {
    ├── createdBy: "system" (string)
    ├── initialSetup: true (boolean)
    ├── version: "1.0.0" (string)
    └── projectId: "turbo-16770" (string)
}
```

### **2. Actualizar Collection `places`**

Para **cada documento** en tu collection `places`, agregar:

```javascript
// Campos nuevos a agregar:
{
  ownerIds: [],                    // Array de strings
  createdBy: "system",            // String
  createdAt: [timestamp actual],  // Timestamp
  lastUpdated: [timestamp actual] // Timestamp
}
```

### **3. Actualizar Collection `events`**

Para **cada documento** en tu collection `events`, agregar:

```javascript
// Campos nuevos a agregar:
{
  createdBy: "system",           // String
  createdAt: [timestamp actual], // Timestamp
  lastUpdatedBy: null,           // String (nullable)
  lastUpdatedAt: null            // Timestamp (nullable)
}
```

## 🔐 **Configurar Authentication**

### **1. Habilitar Email/Password**

1. Ve a [Authentication Console](https://console.firebase.google.com/project/turbo-16770/authentication/providers)
2. Click en "Email/Password"
3. Habilita "Email/Password"
4. Habilita "Email link (passwordless sign-in)" si lo deseas

### **2. Crear Usuario Super Admin**

1. Ve a [Users Tab](https://console.firebase.google.com/project/turbo-16770/authentication/users)
2. Click "Add user"
3. Email: `superadmin@turbo.com`
4. Password: [Crear password seguro]
5. Click "Add user"

**⚠️ Importante:** El UID que se genere debe coincidir con el document ID en `admin_users`

## 🛡️ **Configurar Reglas de Seguridad**

Ve a [Firestore Rules](https://console.firebase.google.com/project/turbo-16770/firestore/rules) y actualiza:

```javascript
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

    // Events solo editables por creadores o super admins
    match /events/{eventId} {
      allow read: if true; // Público para lectura
      allow write: if request.auth != null && (
        request.auth.uid == resource.data.createdBy ||
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin'
      );
    }

    // Users regulares solo pueden editar su propio perfil
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }
  }
}
```

## 🚀 **Próximos Pasos de Desarrollo**

### **1. Integrar en tu App Flutter**

```dart
// En tu main.dart o donde inicialices dependencies
await initCoreDependencies(
  firebaseApp: Firebase.app(),
  sl: GetIt.instance,
);

// Para crear propietarios de lugares
final adminRepo = GetIt.instance<AdminAuthRepository>();

// Para gestionar lugares con ownership
final placeRepo = GetIt.instance<PlaceRepository>();

// Para eventos con auditoría
final eventRepo = GetIt.instance<EventRepository>();
```

### **2. Crear UI Administrativa**

```dart
// Ejemplo de pantalla para crear propietario
class CreatePlaceOwnerScreen extends StatelessWidget {
  Future<void> _createPlaceOwner() async {
    final adminRepo = GetIt.instance<AdminAuthRepository>();

    // Usar AdminAuthService para crear propietario
    final result = await adminRepo.signUp(
      email: 'propietario@ejemplo.com',
      password: 'password123',
      role: AdminRole.placeOwner,
      ownedPlaceIds: ['place_id_123'],
    );

    result.fold(
      (failure) => print('Error: $failure'),
      (adminUser) => print('Propietario creado: ${adminUser.email}'),
    );
  }
}
```

### **3. Asignar Ownership a Lugares**

```dart
// Ejemplo de asignación de propietario a lugar
Future<void> assignPlaceOwner(String placeId, String ownerId) async {
  final placeRepo = GetIt.instance<PlaceRepository>();

  await placeRepo.updatePlaceOwnership(
    placeId: placeId,
    ownerIds: [ownerId],
  );
}
```

## 📊 **Verificar Configuración**

### **En Firebase Console:**

1. [Admin Users](https://console.firebase.google.com/project/turbo-16770/firestore/data/admin_users) - Debe existir super_admin_001
2. [Places](https://console.firebase.google.com/project/turbo-16770/firestore/data/places) - Deben tener campos ownerIds, createdBy
3. [Events](https://console.firebase.google.com/project/turbo-16770/firestore/data/events) - Deben tener campos createdBy, createdAt

### **En tu App:**

```dart
// Test de conexión
final adminRepo = GetIt.instance<AdminAuthRepository>();
final result = await adminRepo.getAllAdminUsers();
print('Admin users found: ${result.length}');
```

## 🆘 **Solución de Problemas**

### **Script no se ejecuta:**

```bash
# Verificar dependencias
flutter pub get

# Ejecutar desde directorio correcto
cd core/
dart run scripts/turbo_firestore_setup.dart
```

### **Error de permisos:**

1. Ve a Firestore Rules
2. Temporalmente permite escritura: `allow read, write: if true;`
3. Ejecuta script
4. Restaura reglas de seguridad

### **Error de conexión:**

- Verifica tu conexión a internet
- Verifica que el proyecto turbo-16770 esté activo en Firebase

## 🎯 **Resultado Final**

Después de completar esta configuración tendrás:

✅ **Sistema de usuarios administrativos** separado de usuarios regulares  
✅ **Ownership granular** de lugares por propietarios  
✅ **Auditoría completa** de eventos y modificaciones  
✅ **Permisos por rol** (super admin, propietario)  
✅ **Analytics por propietario** listos para implementar  
✅ **Seguridad robusta** con reglas de Firestore

¡Tu plataforma Turbo ahora es una solución B2B/B2C completa! 🚀
