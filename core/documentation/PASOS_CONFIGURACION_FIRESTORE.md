# 🚀 Pasos Específicos - Configuración Firestore

## ⚡ **Resumen Ejecutivo**

**¿Qué necesitas hacer?** Actualizar tu Firestore para soportar el sistema administrativo que acabamos de implementar.

**¿Por qué?** Los modelos `Place` y `Event` ahora incluyen campos administrativos para ownership y auditoría que no existen en tu Firestore actual.

## 🎯 **Opción Recomendada: Script Automático**

### **Paso 1: Ejecutar Script**

```bash
# Desde el directorio core/
dart run update_firestore_for_admin_system.dart
```

### **Lo que hace automáticamente:**

- ✅ Crea collection `admin_users` con super administrador inicial
- ✅ Agrega campos `ownerIds`, `createdBy`, `createdAt`, `lastUpdated` a TODOS los places
- ✅ Agrega campos `createdBy`, `createdAt`, `lastUpdatedBy`, `lastUpdatedAt` a TODOS los events
- ✅ Configura timestamps automáticamente
- ✅ Maneja errores y validaciones

## 📋 **Si Prefieres Hacerlo Manual**

### **Paso 1: Crear Collection admin_users**

En Firebase Console, crear documento:

```
Collection: admin_users
Document ID: super_admin_001

Campos:
- uid: "super_admin_001" (string)
- email: "superadmin@turbo.com" (string)
- displayName: "Super Administrador" (string)
- role: "superAdmin" (string)
- ownedPlaceIds: [] (array vacío)
- permissions: {} (map vacío)
- createdAt: [timestamp actual]
- lastLogin: null
- isActive: true (boolean)
- photoUrl: null
- phoneNumber: null
- metadata: {"createdBy": "system", "initialSetup": true} (map)
```

### **Paso 2: Actualizar TODOS los Places**

Para cada documento en collection `places`, agregar:

```
- ownerIds: [] (array vacío)
- createdBy: "system" (string)
- createdAt: [timestamp actual]
- lastUpdated: [timestamp actual]
```

### **Paso 3: Actualizar TODOS los Events**

Para cada documento en collection `events`, agregar:

```
- createdBy: "system" (string)
- createdAt: [timestamp actual]
- lastUpdatedBy: null
- lastUpdatedAt: null
```

## 🔐 **Paso 4: Actualizar Reglas de Seguridad**

En Firebase Console > Firestore > Rules, reemplazar con:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // Admin Users
    match /admin_users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
        && exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
        && get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == "superAdmin";
    }

    // Places con ownership
    match /places/{placeId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && (
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == "superAdmin")
        ||
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && request.auth.uid in resource.data.ownerIds)
      );
    }

    // Events basado en lugar
    match /events/{eventId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && (
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == "superAdmin")
        ||
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && exists(/databases/$(database)/documents/places/$(resource.data.placeId))
         && request.auth.uid in get(/databases/$(database)/documents/places/$(resource.data.placeId)).data.ownerIds)
      );
    }

    // Analytics solo admins
    match /analytics_{type}/{docId} {
      allow read, write: if request.auth != null
        && exists(/databases/$(database)/documents/admin_users/$(request.auth.uid));
    }

    // Resto de collections (mantener como está)
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## ✅ **Verificación**

Después de completar los pasos:

1. **Verificar que existe `admin_users/super_admin_001`**
2. **Comprobar que lugares tienen nuevos campos administrativos**
3. **Verificar que eventos tienen campos de auditoría**
4. **Probar que reglas de seguridad funcionan**

## 🔍 **Comandos de Validación**

```bash
# Verificar que no hay errores
dart analyze

# Compilar si hiciste cambios adicionales
dart run build_runner build --delete-conflicting-outputs
```

## ❗ **Importante**

- **Los modelos ya están actualizados** en el código
- **Solo falta sincronizar Firestore** con estos cambios
- **El script automático es la opción más segura**
- **Hacer backup** antes de ejecutar en producción

## 📞 **Si Algo Sale Mal**

- El script incluye manejo de errores automático
- Los campos nuevos tienen valores por defecto seguros
- La estructura existente no se modifica, solo se agregan campos
- Puedes ejecutar el script múltiples veces sin problemas
