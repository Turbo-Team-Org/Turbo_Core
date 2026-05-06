# 🔥 Configuración Firestore - Sistema Administrativo Turbo Core

## 📋 Resumen Ejecutivo

Esta documentación detalla todos los cambios necesarios en Firestore para implementar el sistema administrativo completo de Turbo Core, incluyendo la separación de usuarios regulares y administrativos, ownership de lugares, y auditoría completa.

## 🎯 **Cambios Realizados en los Modelos**

### **1. Modelo Place Actualizado**

**Nuevos campos agregados:**

```dart
// Campos administrativos para ownership y auditoría
@Default([]) List<String> ownerIds,     // IDs de usuarios admin propietarios
@Default('') String createdBy,          // ID del usuario que creó el lugar
DateTime? createdAt,                    // Timestamp de creación
DateTime? lastUpdated,                  // Timestamp de última actualización
```

### **2. Modelo Event Actualizado**

**Nuevos campos agregados:**

```dart
// Campos administrativos para auditoría
@Default('') String createdBy,          // ID del usuario que creó el evento
DateTime? createdAt,                    // Timestamp de creación
String? lastUpdatedBy,                  // ID del último usuario que editó
DateTime? lastUpdatedAt,                // Timestamp de última actualización
```

## 🗄️ **Estructura Firestore Requerida**

### **Collection: `admin_users`** _(NUEVA)_

```json
{
  "super_admin_001": {
    "uid": "super_admin_001",
    "email": "superadmin@turbo.com",
    "displayName": "Super Administrador",
    "role": "superAdmin",
    "ownedPlaceIds": [],
    "permissions": {},
    "createdAt": "2024-01-01T00:00:00Z",
    "lastLogin": null,
    "isActive": true,
    "photoUrl": null,
    "phoneNumber": null,
    "metadata": {
      "createdBy": "system",
      "initialSetup": true
    }
  },
  "place_owner_001": {
    "uid": "place_owner_001",
    "email": "owner@restaurant.com",
    "displayName": "Juan Pérez",
    "role": "placeOwner",
    "ownedPlaceIds": ["place_id_123"],
    "permissions": {
      "place_id_123": [
        "readPlace",
        "editPlace",
        "manageEvents",
        "viewReviews",
        "moderateReviews",
        "viewAnalytics",
        "manageOffers",
        "manageMedia"
      ]
    },
    "createdAt": "2024-01-01T00:00:00Z",
    "lastLogin": "2024-01-15T10:30:00Z",
    "isActive": true,
    "photoUrl": "https://example.com/avatar.jpg",
    "phoneNumber": "+1234567890",
    "metadata": {
      "createdBy": "super_admin_001"
    }
  }
}
```

### **Collection: `places`** _(ACTUALIZAR EXISTENTES)_

**Agregar a TODOS los documentos existentes:**

```json
{
  "place_id_123": {
    // ... campos existentes ...

    // 🆕 NUEVOS CAMPOS ADMINISTRATIVOS:
    "ownerIds": ["place_owner_001"], // Array de IDs de propietarios
    "createdBy": "system", // Para lugares existentes usar "system"
    "createdAt": "2024-01-01T00:00:00Z", // Timestamp de creación
    "lastUpdated": "2024-01-15T14:30:00Z" // Timestamp de última actualización
  }
}
```

### **Collection: `events`** _(ACTUALIZAR EXISTENTES)_

**Agregar a TODOS los documentos existentes:**

```json
{
  "event_id_456": {
    // ... campos existentes ...

    // 🆕 NUEVOS CAMPOS ADMINISTRATIVOS:
    "createdBy": "system", // Para eventos existentes usar "system"
    "createdAt": "2024-01-01T00:00:00Z", // Timestamp de creación
    "lastUpdatedBy": null, // Inicialmente null
    "lastUpdatedAt": null // Inicialmente null
  }
}
```

## 🚀 **Opciones de Implementación**

### **Opción 1: Script Automático (Recomendado)**

```bash
# Desde el directorio core/
dart run update_firestore_for_admin_system.dart
```

**¿Qué hace el script?**

- ✅ Crea collection `admin_users` con super admin inicial
- ✅ Actualiza todos los `places` con campos administrativos
- ✅ Actualiza todos los `events` con campos de auditoría
- ✅ Configura timestamps automáticamente
- ✅ Maneja errores y rollback automático

### **Opción 2: Configuración Manual**

#### **Paso 1: Crear Collection `admin_users`**

1. Ir a **Firebase Console > Firestore Database**
2. Crear nueva collection: `admin_users`
3. Agregar documento con ID: `super_admin_001`
4. Copiar estructura JSON mostrada arriba

#### **Paso 2: Actualizar Collection `places`**

Para **CADA** documento en `places`:

1. Agregar campo: `ownerIds` (array) = `[]`
2. Agregar campo: `createdBy` (string) = `"system"`
3. Agregar campo: `createdAt` (timestamp) = fecha actual
4. Agregar campo: `lastUpdated` (timestamp) = fecha actual

#### **Paso 3: Actualizar Collection `events`**

Para **CADA** documento en `events`:

1. Agregar campo: `createdBy` (string) = `"system"`
2. Agregar campo: `createdAt` (timestamp) = fecha actual
3. Agregar campo: `lastUpdatedBy` (string) = `null`
4. Agregar campo: `lastUpdatedAt` (timestamp) = `null`

## 🔐 **Reglas de Seguridad Firestore**

**Actualizar Rules en Firebase Console:**

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {

    // 👑 Admin Users - Solo super admins pueden gestionar
    match /admin_users/{userId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null
        && exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
        && get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == "superAdmin";
    }

    // 🏢 Places - Propietarios pueden gestionar sus lugares
    match /places/{placeId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && (
        // Super admin acceso total
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == "superAdmin")
        ||
        // Propietario puede editar su lugar
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && request.auth.uid in resource.data.ownerIds)
      );
    }

    // 🎯 Events - Basado en ownership del lugar asociado
    match /events/{eventId} {
      allow read: if request.auth != null;
      allow write: if request.auth != null && (
        // Super admin acceso total
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == "superAdmin")
        ||
        // Propietario del lugar puede gestionar eventos
        (exists(/databases/$(database)/documents/admin_users/$(request.auth.uid))
         && exists(/databases/$(database)/documents/places/$(resource.data.placeId))
         && request.auth.uid in get(/databases/$(database)/documents/places/$(resource.data.placeId)).data.ownerIds)
      );
    }

    // 📊 Analytics - Solo usuarios administrativos
    match /analytics_{type}/{docId} {
      allow read, write: if request.auth != null
        && exists(/databases/$(database)/documents/admin_users/$(request.auth.uid));
    }

    // 👥 Users regulares y otras collections (mantener reglas existentes)
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 📊 **Permisos Disponibles**

### **Roles del Sistema**

- **`superAdmin`**: Acceso total a toda la plataforma
- **`placeOwner`**: Gestión de lugares específicos asignados

### **Permisos Granulares por Lugar**

- `readPlace` - Ver información del lugar
- `editPlace` - Editar datos del lugar
- `manageEvents` - Crear/editar/eliminar eventos
- `viewReviews` - Ver reseñas del lugar
- `moderateReviews` - Moderar/responder reseñas
- `viewAnalytics` - Ver estadísticas y analytics
- `manageOffers` - Gestionar ofertas y promociones
- `manageMedia` - Subir/editar imágenes y media
- `manageSchedule` - Modificar horarios de apertura
- `respondReviews` - Responder a reseñas de clientes
- `exportData` - Exportar datos del lugar
- `inviteStaff` - Invitar personal adicional

## ✅ **Verificación Post-Implementación**

### **Checklist de Validación**

1. **Collection `admin_users` existe**

   - [ ] Super admin inicial creado
   - [ ] Estructura de permisos correcta
   - [ ] Timestamps configurados

2. **Collection `places` actualizada**

   - [ ] Todos los lugares tienen `ownerIds` (array)
   - [ ] Todos tienen `createdBy` = "system"
   - [ ] Timestamps `createdAt` y `lastUpdated` presentes

3. **Collection `events` actualizada**

   - [ ] Todos los eventos tienen `createdBy` = "system"
   - [ ] Campos de auditoría `lastUpdatedBy` y `lastUpdatedAt`
   - [ ] Timestamps `createdAt` configurados

4. **Reglas de Seguridad**

   - [ ] Reglas admin aplicadas correctamente
   - [ ] Acceso basado en ownership funciona
   - [ ] Super admin tiene acceso total

5. **Funcionalidades del Sistema**
   - [ ] AdminAuthService conecta correctamente
   - [ ] PlaceRepository filtra por propietario
   - [ ] EventRepository respeta ownership
   - [ ] Analytics por admin funcionan

## 🔄 **Flujo de Trabajo Recomendado**

### **Para Desarrollo**

1. **Ejecutar script automático** en entorno de desarrollo
2. **Probar funcionalidades** del Admin Panel
3. **Validar permisos** y ownership
4. **Verificar analytics** por propietario

### **Para Producción**

1. **Backup completo** de Firestore
2. **Ejecutar script** en horario de menor tráfico
3. **Validar** que no hay datos corruptos
4. **Probar** funcionalidades críticas
5. **Monitorear** errores post-despliegue

## 🆘 **Soporte y Troubleshooting**

### **Errores Comunes**

**Error: "ownerIds field missing"**

```bash
# Solución: Ejecutar actualización de places
dart run update_firestore_for_admin_system.dart
```

**Error: "admin_users collection not found"**

```bash
# Solución: Crear collection manualmente o ejecutar script
# Verificar que Firebase está inicializado correctamente
```

**Error: "Permission denied"**

```bash
# Solución: Verificar reglas de seguridad Firestore
# Asegurar que el usuario está en admin_users collection
```

### **Comandos de Diagnóstico**

```bash
# Verificar estructura analytics
dart run verify_analytics_collections.dart

# Compilar después de cambios
dart run build_runner build --delete-conflicting-outputs

# Verificar código
dart analyze
```

## 📈 **Impacto Empresarial**

### **Beneficios Logrados**

- ✅ **Separación clara** usuarios/admins
- ✅ **Ownership granular** de lugares
- ✅ **Analytics por propietario**
- ✅ **Auditoría completa** de cambios
- ✅ **Escalabilidad** para múltiples negocios
- ✅ **Seguridad robusta** basada en permisos

### **Casos de Uso Habilitados**

- 🏢 **Restaurantes** gestionan sus propios lugares
- 📊 **Analytics exclusivos** por negocio
- 🔐 **Control de acceso** granular
- 👥 **Múltiples administradores** por lugar
- 📱 **Admin Panel** diferenciado por rol

---

**Documentación creada:** $(date +%Y-%m-%d)  
**Versión Turbo Core:** 0.1.0+1  
**Flutter:** 3.29.0  
**Dart:** 3.7.0
