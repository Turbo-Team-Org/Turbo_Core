# 🗄️ Nuevas Colecciones de Firestore - Setup Guide

## 📋 Colecciones a Crear

### 1. **`business_owner_requests`** 📝

**Propósito**: Almacenar solicitudes de usuarios que quieren convertirse en business owners.

**Estructura del documento**:

```json
{
  "id": "request_001",
  "userId": "user_123456",
  "email": "carlos@email.com",
  "displayName": "Carlos Rodríguez",
  "businessName": "Restaurante La Abuela",
  "businessDescription": "Restaurante familiar con comida tradicional mexicana",
  "businessAddress": "Av. Reforma 123, Col. Centro, CDMX",
  "phoneNumber": "+52 55 1234 5678",
  "website": "https://restaurantelaabuela.mx",
  "status": "pending",
  "createdAt": "2024-01-20T10:30:00Z",
  "reviewedAt": null,
  "reviewedBy": null,
  "rejectionReason": null,
  "approvalNotes": null,
  "businessMetadata": {
    "category": "restaurant",
    "cuisine": "mexican",
    "priceRange": "medium",
    "capacity": 80,
    "hasDelivery": true,
    "hasParking": true
  },
  "contactInfo": {
    "managerName": "Carlos Rodríguez",
    "emergencyContact": "+52 55 8765 4321",
    "socialMedia": {
      "facebook": "@restaurantelaabuela",
      "instagram": "@laabuela_oficial"
    }
  }
}
```

**Estados posibles** (`status`):

- `pending` - Pendiente de revisión
- `reviewing` - En revisión por admin
- `needsMoreInfo` - Necesita más información
- `approved` - Aprobada y procesada
- `rejected` - Rechazada

### 2. **`notifications`** 🔔

**Propósito**: Sistema de notificaciones para avisar a admins sobre nuevas solicitudes y a usuarios sobre decisiones.

**Estructura del documento**:

```json
{
  "type": "business_owner_request",
  "title": "Nueva solicitud de Business Owner",
  "message": "Carlos Rodríguez (Restaurante La Abuela) ha solicitado registro",
  "createdAt": "2024-01-20T10:30:00Z",
  "targetRole": "superAdmin",
  "targetEmail": null,
  "isRead": false,
  "metadata": {
    "requestId": "request_001",
    "email": "carlos@email.com",
    "businessName": "Restaurante La Abuela"
  }
}
```

**Tipos de notificación** (`type`):

- `business_owner_request` - Nueva solicitud enviada
- `business_owner_approved` - Solicitud aprobada
- `business_owner_rejected` - Solicitud rechazada
- `business_owner_reviewing` - Solicitud en revisión
- `business_owner_needs_info` - Se necesita más información

## 🔧 Cómo Crear las Colecciones

### Opción 1: Firebase Console (Manual)

1. **Ve a Firebase Console** → Tu proyecto → Firestore Database
2. **Clic en "Start collection"**
3. **Collection ID**: `business_owner_requests`
4. **Primer documento**: Crear documento con ID `_config`
5. **Agregar campos del documento de configuración**:
   ```
   description: "Solicitudes de registro para business owners"
   version: "1.0.0"
   createdAt: [timestamp actual]
   ```
6. **Repetir para collection** `notifications`

### Opción 2: Script de Dart (Recomendado)

Ejecutar el script que ya creamos:

```bash
cd core
dart run scripts/setup_business_owner_requests.dart
```

### Opción 3: Firebase CLI + Script

```bash
# Crear archivo de inicialización
cat > init_collections.js << 'EOF'
const admin = require('firebase-admin');
admin.initializeApp();
const db = admin.firestore();

async function createCollections() {
  // Business Owner Requests
  await db.collection('business_owner_requests').doc('_config').set({
    description: 'Solicitudes de registro para business owners',
    version: '1.0.0',
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });

  // Notifications
  await db.collection('notifications').doc('_config').set({
    description: 'Notificaciones del sistema',
    version: '1.0.0',
    createdAt: admin.firestore.FieldValue.serverTimestamp()
  });

  console.log('✅ Colecciones creadas');
}

createCollections();
EOF

# Ejecutar
node init_collections.js
```

## 📊 Índices Requeridos

**Para `business_owner_requests`**:

```
- userId (Ascending)
- status (Ascending) + createdAt (Descending)
- reviewedBy (Ascending) + reviewedAt (Descending)
- createdAt (Descending)
```

**Para `notifications`**:

```
- targetRole (Ascending) + createdAt (Descending)
- targetEmail (Ascending) + isRead (Ascending)
- type (Ascending) + createdAt (Descending)
```

## 🎯 Comandos para Crear Índices

### Firebase Console

1. Ve a **Firestore** → **Indexes**
2. Clic en **"Create index"**
3. Agrega cada índice listado arriba

### Firebase CLI

```bash
# Agregar a firestore.indexes.json
{
  "indexes": [
    {
      "collection": "business_owner_requests",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "status", "order": "ASCENDING"},
        {"fieldPath": "createdAt", "order": "DESCENDING"}
      ]
    },
    {
      "collection": "business_owner_requests",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "userId", "order": "ASCENDING"}
      ]
    },
    {
      "collection": "notifications",
      "queryScope": "COLLECTION",
      "fields": [
        {"fieldPath": "targetRole", "order": "ASCENDING"},
        {"fieldPath": "createdAt", "order": "DESCENDING"}
      ]
    }
  ]
}

# Desplegar índices
firebase deploy --only firestore:indexes
```

## ✅ Verificación

Una vez creadas las colecciones, verifica:

1. **Que existen las colecciones**:

   - `business_owner_requests`
   - `notifications`

2. **Que tienen documentos de configuración**:

   - `business_owner_requests/_config`
   - `notifications/_config`

3. **Que los índices están creando** (pueden tardar unos minutos)

4. **Ejecutar script de verificación**:
   ```bash
   dart run scripts/setup_business_owner_requests.dart
   ```

## 🔄 Migración de Datos Existentes

Si ya tienes usuarios que deberían ser business owners:

```dart
// Script de migración (opcional)
Future<void> migrateExistingBusinessOwners() async {
  // 1. Identificar usuarios que ya son business owners
  // 2. Crear AdminUser documents para ellos
  // 3. Marcarlos en users collection
  // 4. Opcional: crear solicitudes históricas
}
```

---

**Siguiente paso**: Una vez creadas las colecciones, procedemos con las **Reglas de Seguridad** 🛡️
