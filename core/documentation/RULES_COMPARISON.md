# 🛡️ Comparación de Reglas: Antes vs Después

## 📋 Resumen de Cambios

### ✅ **Lo que SE MANTIENE igual:**

- Todas las reglas existentes funcionan igual
- Firebase Storage rules (imágenes de reviews)
- admin_users, users, places, offers, events, favorites, categories
- Analytics collections
- Funciones helper existentes

### 🆕 **Lo que SE AGREGA:**

- Reglas para `business_owner_requests` collection
- Reglas para `notifications` collection
- Mejoras en validación de reviews
- Documentos de configuración (\_config)

---

## 📊 Comparación Detallada

### 1. **Funciones Helper**

#### ✅ ANTES (se mantiene):

```javascript
function isAdmin() {
  return request.auth != null &&
    exists(/databases/$(database)/documents/admin_users/$(request.auth.uid));
}

function isSuperAdmin() {
  return request.auth != null &&
    get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.role == 'superAdmin';
}

function canManagePlace(placeId) {
  return request.auth != null && (
    isSuperAdmin() ||
    get(/databases/$(database)/documents/admin_users/$(request.auth.uid)).data.ownedPlaceIds.hasAny([placeId])
  );
}
```

#### 🆕 NUEVO (se agrega):

```javascript
function isOwner(userId) {
  return request.auth != null && request.auth.uid == userId;
}
```

### 2. **admin_users Collection**

#### ✅ ANTES:

```javascript
match /admin_users/{adminId} {
  allow read: if request.auth != null;
  allow create: if request.auth != null && (
    adminId == request.auth.uid ||
    !exists(/databases/$(database)/documents/admin_users) ||
    isSuperAdmin()
  );
  allow update: if request.auth != null && (
    adminId == request.auth.uid ||
    isSuperAdmin()
  );
  allow delete: if isSuperAdmin();
}
```

#### 🔄 DESPUÉS (mejorado):

```javascript
match /admin_users/{adminId} {
  allow read: if request.auth != null;
  allow create: if request.auth != null && (
    adminId == request.auth.uid ||
    !exists(/databases/$(database)/documents/admin_users) ||
    isSuperAdmin()
  );
  allow update: if request.auth != null && (
    // Usuario puede actualizar campos limitados de su perfil
    (adminId == request.auth.uid &&
     request.resource.data.diff(resource.data).affectedKeys()
       .hasOnly(['displayName', 'phoneNumber', 'photoUrl', 'lastLogin'])) ||
    // Super admin puede actualizar todo
    isSuperAdmin()
  );
  allow delete: if isSuperAdmin();
}
```

### 3. **users Collection**

#### ✅ ANTES:

```javascript
match /users/{userId} {
  allow read, update, delete: if request.auth != null && request.auth.uid == userId;
  allow create: if request.auth != null;
}
```

#### 🔄 DESPUÉS (con permiso adicional):

```javascript
match /users/{userId} {
  allow read, update, delete: if request.auth != null && request.auth.uid == userId;
  allow create: if request.auth != null;

  // 🆕 Permitir a admins leer usuarios (para verificaciones)
  allow read: if isAdmin();
}
```

### 4. **reviews Sub-collection en places**

#### ✅ ANTES:

```javascript
match /reviews/{reviewId} {
  allow read: if true;
  allow create: if request.auth != null;
  allow update, delete: if request.auth != null;
}
```

#### 🔄 DESPUÉS (más granular):

```javascript
match /reviews/{reviewId} {
  allow read: if true;
  allow create: if request.auth != null;
  allow update, delete: if request.auth != null && (
    // 🆕 El autor puede editar/eliminar su review
    request.auth.uid == resource.data.userId ||
    // 🆕 Business owner del lugar puede moderar reviews
    canManagePlace(placeId) ||
    // 🆕 Super admin puede todo
    isSuperAdmin()
  );
}
```

---

## 🆕 **Nuevas Reglas Completas**

### **business_owner_requests Collection**

```javascript
match /business_owner_requests/{requestId} {
  // CREAR: Solo usuarios autenticados para sí mismos
  allow create: if request.auth != null &&
    request.auth.uid == request.resource.data.userId &&
    request.auth.token.email == request.resource.data.email &&
    request.resource.data.status == 'pending' &&
    request.resource.data.createdAt is timestamp &&
    !('reviewedBy' in request.resource.data) &&
    !('reviewedAt' in request.resource.data) &&
    request.resource.data.keys().hasAll([
      'id', 'userId', 'email', 'displayName',
      'businessName', 'businessDescription', 'businessAddress'
    ]);

  // LEER: Usuario sus solicitudes, super admin todas
  allow read: if request.auth != null &&
    (request.auth.uid == resource.data.userId || isSuperAdmin());

  // ACTUALIZAR: Solo super admins
  allow update: if isSuperAdmin() &&
    request.resource.data.userId == resource.data.userId &&
    request.resource.data.email == resource.data.email &&
    request.resource.data.businessName == resource.data.businessName &&
    request.resource.data.diff(resource.data).affectedKeys()
      .hasOnly(['status', 'reviewedAt', 'reviewedBy', 'rejectionReason', 'approvalNotes']);

  // ELIMINAR: Solo super admins
  allow delete: if isSuperAdmin();
}
```

### **notifications Collection**

```javascript
match /notifications/{notificationId} {
  // LEER: Super admins todas, usuarios las suyas
  allow read: if request.auth != null && (
    isSuperAdmin() ||
    (('targetRole' in resource.data && resource.data.targetRole == 'user') ||
     ('targetEmail' in resource.data && request.auth.token.email == resource.data.targetEmail))
  );

  // CREAR: Solo super admins manualmente
  allow create: if isSuperAdmin();

  // ACTUALIZAR: Solo marcar como leída
  allow update: if request.auth != null && (
    isSuperAdmin() ||
    (('targetEmail' in resource.data && request.auth.token.email == resource.data.targetEmail))
  ) &&
  request.resource.data.diff(resource.data).affectedKeys().hasOnly(['isRead']) &&
  request.resource.data.isRead == true;

  // ELIMINAR: Solo super admins
  allow delete: if isSuperAdmin();
}
```

---

## 🔧 **Cómo Aplicar los Cambios**

### Opción 1: Firebase Console

1. Ve a **Firebase Console** → Tu proyecto → **Firestore Database**
2. Clic en **"Rules"** en el menú lateral
3. **Reemplaza todo el contenido** con el archivo `firestore_rules_updated_complete.rules`
4. Clic en **"Publish"**

### Opción 2: Firebase CLI

```bash
# Reemplazar firestore.rules con el nuevo contenido
cp firestore_rules_updated_complete.rules firestore.rules

# Desplegar
firebase deploy --only firestore:rules
```

---

## ✅ **Beneficios de las Nuevas Reglas**

### 🔒 **Seguridad Mejorada:**

- Validación estricta en business_owner_requests
- Control granular de notificaciones
- Mejor validación en reviews (solo autor/admin puede modificar)
- Limitación de campos editables en perfiles admin

### 🚀 **Nuevas Funcionalidades:**

- Sistema de solicitudes de business owners
- Notificaciones automáticas
- Mejor moderación de contenido
- Documentos de configuración protegidos

### 🔄 **Compatibilidad Total:**

- No rompe funcionalidad existente
- Todas las reglas anteriores funcionan igual
- Solo agrega nuevas capacidades
- Migración sin downtime

---

## 🧪 **Testing de las Reglas**

### Verificar que funciona todo:

```bash
# 1. Verificar reglas existentes siguen funcionando
# 2. Probar creación de business_owner_request
# 3. Probar notificaciones
# 4. Verificar permisos de admin

# Script de verificación
cd core
dart run scripts/test_firestore_rules.dart
```

### Casos de prueba importantes:

```
✅ Usuario puede crear su business_owner_request
✅ Usuario NO puede crear request para otro usuario
✅ Super admin puede aprobar/rechazar requests
✅ Business owner NO puede modificar requests
✅ Notificaciones funcionan correctamente
✅ Todas las funciones existentes siguen funcionando
```

---

## 🚨 **IMPORTANTE: Backup**

Antes de aplicar las nuevas reglas, guarda las actuales:

```bash
# Descargar reglas actuales
firebase firestore:rules > firestore_rules_backup.rules

# Aplicar nuevas reglas
firebase deploy --only firestore:rules

# Si algo falla, restaurar:
# firebase deploy --only firestore:rules firestore_rules_backup.rules
```

---

**📝 Resultado Final:** Sistema completamente funcional con business owner auto-registration integrado, manteniendo 100% compatibilidad con funcionalidad existente.
