# 🔥 Configuración Manual Sistema Administrativo - Proyecto Turbo

## 📱 **Información del Proyecto**

- **Proyecto Firebase:** turbo-16770
- **URL Firestore:** https://console.firebase.google.com/project/turbo-16770/firestore
- **URL Authentication:** https://console.firebase.google.com/project/turbo-16770/authentication

## ⚠️ **Problema con Scripts Automáticos**

Los scripts automáticos tienen problemas de compatibilidad con tu versión de Flutter. **La configuración manual es la opción más segura y confiable.**

## 🎯 **Paso 1: Crear Collection `admin_users`**

### **1.1 Ir a Firestore Console**

1. Abre: https://console.firebase.google.com/project/turbo-16770/firestore
2. Click en "Start collection"
3. Collection ID: `admin_users`
4. Click "Next"

### **1.2 Crear Super Administrador**

**Document ID:** `super_admin_001`

**Campos a agregar:**

```
Field name: uid
Field type: string
Field value: super_admin_001

Field name: email
Field type: string
Field value: superadmin@turbo.com

Field name: displayName
Field type: string
Field value: Super Administrador Turbo

Field name: role
Field type: string
Field value: superAdmin

Field name: ownedPlaceIds
Field type: array
Field value: [] (vacío)

Field name: permissions
Field type: map
Field value: {} (vacío)

Field name: createdAt
Field type: timestamp
Field value: [Current timestamp]

Field name: lastLogin
Field type: null
Field value: null

Field name: isActive
Field type: boolean
Field value: true

Field name: photoUrl
Field type: null
Field value: null

Field name: phoneNumber
Field type: null
Field value: null

Field name: metadata
Field type: map
Subfields:
  ├── createdBy: "system" (string)
  ├── initialSetup: true (boolean)
  ├── version: "1.0.0" (string)
  └── projectId: "turbo-16770" (string)
```

5. Click "Save"

## 🎯 **Paso 2: Actualizar Collection `places`**

### **2.1 Abrir Collection Places**

1. En Firestore Console, click en collection `places`
2. **Para CADA documento** en places, click en el documento
3. Click en el botón "+" para agregar field

### **2.2 Campos a Agregar en CADA Lugar**

```
Field name: ownerIds
Field type: array
Field value: [] (vacío inicialmente)

Field name: createdBy
Field type: string
Field value: system

Field name: createdAt
Field type: timestamp
Field value: [Current timestamp]

Field name: lastUpdated
Field type: timestamp
Field value: [Current timestamp]
```

### **2.3 Repetir para Todos los Lugares**

- Debes hacer esto manualmente para cada documento en `places`
- Si tienes muchos lugares, puedes hacerlo gradualmente
- Los lugares sin estos campos seguirán funcionando, pero no tendrán ownership

## 🎯 **Paso 3: Actualizar Collection `events`**

### **3.1 Abrir Collection Events**

1. En Firestore Console, click en collection `events`
2. **Para CADA documento** en events, click en el documento
3. Click en el botón "+" para agregar field

### **3.2 Campos a Agregar en CADA Evento**

```
Field name: createdBy
Field type: string
Field value: system

Field name: createdAt
Field type: timestamp
Field value: [Current timestamp]

Field name: lastUpdatedBy
Field type: null
Field value: null

Field name: lastUpdatedAt
Field type: null
Field value: null
```

### **3.3 Repetir para Todos los Eventos**

- Debes hacer esto manualmente para cada documento en `events`
- Los eventos sin estos campos seguirán funcionando, pero no tendrán auditoría

## 🎯 **Paso 4: Configurar Authentication**

### **4.1 Habilitar Email/Password**

1. Ve a: https://console.firebase.google.com/project/turbo-16770/authentication/providers
2. Click en "Email/Password"
3. Habilita "Email/Password"
4. Click "Save"

### **4.2 Crear Usuario Super Admin**

1. Ve a: https://console.firebase.google.com/project/turbo-16770/authentication/users
2. Click "Add user"
3. **Email:** `superadmin@turbo.com`
4. **Password:** [Crear password seguro - guárdalo bien]
5. Click "Add user"

### **4.3 Importante: Obtener UID**

1. Después de crear el usuario, click en él
2. Copia el **UID** que se generó
3. Ve de vuelta a Firestore > admin_users > super_admin_001
4. **Actualiza el campo `uid`** con el UID real del usuario creado

## 🎯 **Paso 5: Configurar Reglas de Seguridad**

### **5.1 Actualizar Firestore Rules**

1. Ve a: https://console.firebase.google.com/project/turbo-16770/firestore/rules
2. Reemplaza las reglas existentes con:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Admin users solo accesible por super admins
    match /admin_users/{adminId} {
      allow read, write: if request.auth != null &&
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin';
    }

    // Places: lectura pública, escritura solo por propietarios/super admins
    match /places/{placeId} {
      allow read: if true;
      allow write: if request.auth != null && (
        // Super admin puede editar todo
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin' ||
        // Propietario puede editar su lugar
        request.auth.uid in resource.data.ownerIds
      );
    }

    // Events: lectura pública, escritura solo por creadores/super admins
    match /events/{eventId} {
      allow read: if true;
      allow write: if request.auth != null && (
        // Super admin puede editar todo
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin' ||
        // Creador puede editar su evento
        request.auth.uid == resource.data.createdBy
      );
    }

    // Users regulares solo pueden editar su propio perfil
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;
    }

    // Collections analytics solo para admins
    match /analytics_places/{doc} {
      allow read, write: if request.auth != null &&
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data != null;
    }

    match /analytics_traffic/{doc} {
      allow read, write: if request.auth != null &&
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data != null;
    }

    match /analytics_realtime/{doc} {
      allow read, write: if request.auth != null &&
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data != null;
    }

    match /analytics_reviews/{doc} {
      allow read, write: if request.auth != null &&
        get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data != null;
    }
  }
}
```

3. Click "Publish"

## 🎯 **Paso 6: Verificar Configuración**

### **6.1 Verificar en Firestore Console**

Verifica que tienes:

- ✅ Collection `admin_users` con documento `super_admin_001`
- ✅ Places con campos: `ownerIds`, `createdBy`, `createdAt`, `lastUpdated`
- ✅ Events con campos: `createdBy`, `createdAt`, `lastUpdatedBy`, `lastUpdatedAt`

### **6.2 Verificar en Authentication**

Verifica que tienes:

- ✅ Email/Password habilitado
- ✅ Usuario `superadmin@turbo.com` creado
- ✅ UID del usuario coincide con field `uid` en documento admin_users

### **6.3 Test de Login**

1. En tu app Flutter, intenta hacer login con:
   - Email: `superadmin@turbo.com`
   - Password: [el que creaste]

## 🚀 **Próximos Pasos en tu App**

### **6.1 Crear Usuarios Administrativos**

```dart
final adminRepo = GetIt.instance<AdminAuthRepository>();

// Crear propietario de lugar
final result = await adminRepo.signUp(
  email: 'propietario@ejemplo.com',
  password: 'password123',
  role: AdminRole.placeOwner,
  ownedPlaceIds: ['lugar_id_aqui'],
);
```

### **6.2 Asignar Propietarios a Lugares**

```dart
final placeRepo = GetIt.instance<PlaceRepository>();

await placeRepo.updatePlaceOwnership(
  placeId: 'lugar_id_aqui',
  ownerIds: ['uid_del_propietario'],
);
```

### **6.3 Verificar Funcionalidad**

```dart
// Test AdminAuthRepository
final adminRepo = GetIt.instance<AdminAuthRepository>();
final admins = await adminRepo.getAllAdminUsers();
print('Total admin users: ${admins.length}');

// Test PlaceRepository con ownership
final placeRepo = GetIt.instance<PlaceRepository>();
final places = await placeRepo.getPlacesByOwnerId('uid_del_propietario');
print('Places del propietario: ${places.length}');
```

## 📊 **Estado Final del Sistema**

Después de completar estos pasos tendrás:

✅ **Separación completa** entre usuarios regulares (`users/`) y administrativos (`admin_users/`)  
✅ **Super administrador** con acceso total al sistema  
✅ **Ownership granular** de lugares por propietarios específicos  
✅ **Auditoría completa** de eventos con timestamps y creadores  
✅ **Seguridad robusta** con reglas de Firestore granulares  
✅ **Analytics preparados** para dashboard por propietario

## 🆘 **Solución de Problemas**

### **Error: Rules don't work**

- Verifica que publicaste las reglas correctamente
- Temporalmente puedes usar `allow read, write: if true;` para testing

### **Error: Super admin can't login**

- Verifica que el UID en admin_users coincide con el UID en Authentication
- Verifica que el usuario está activo en Authentication

### **Error: Places/Events don't update**

- Verifica que agregaste todos los campos administrativos
- Verifica que los tipos de datos son correctos (string, timestamp, array, etc.)

---

**¡Configuración manual completada!** Tu sistema administrativo Turbo ya está listo para usar. 🚀
