# ✅ Checklist de Setup - Business Owner Auto-Registration

## 🎯 Resumen

Sistema que permite a usuarios regulares solicitar convertirse en business owners a través de un formulario, con aprobación de super admins.

---

## 📋 PASO 1: Crear Nuevas Colecciones

### Colecciones a Crear:

#### 1. **`business_owner_requests`** 📝

- **Propósito**: Solicitudes de registro como business owner
- **Crea con**: Firebase Console o script de Dart
- **Documentos iniciales**: `_config` (configuración)

#### 2. **`notifications`** 🔔

- **Propósito**: Notificaciones del sistema
- **Crea con**: Firebase Console o script de Dart
- **Documentos iniciales**: `_config` (configuración)

### 🔧 Opciones para Crear:

**Opción A - Manual (Firebase Console):**

```
1. Firebase Console → Firestore Database
2. "Start collection" → business_owner_requests
3. Primer documento: ID = "_config"
4. Campos: description, version, createdAt
5. Repetir para "notifications"
```

**Opción B - Script Automático:**

```bash
cd core
dart run scripts/setup_business_owner_requests.dart
```

---

## 📊 PASO 2: Crear Índices

### Índices para `business_owner_requests`:

```
1. userId (Ascending)
2. status (Ascending) + createdAt (Descending)
3. reviewedBy (Ascending) + reviewedAt (Descending)
4. createdAt (Descending)
```

### Índices para `notifications`:

```
1. targetRole (Ascending) + createdAt (Descending)
2. targetEmail (Ascending) + isRead (Ascending)
3. type (Ascending) + createdAt (Descending)
```

### 🎯 Cómo crear índices:

```
Firebase Console → Firestore → Indexes → "Create index"
- Collection: business_owner_requests
- Field 1: status (Ascending)
- Field 2: createdAt (Descending)
- [Create index]
```

---

## 🛡️ PASO 3: Actualizar Reglas de Seguridad

### Archivo de Reglas:

`firestore_rules_business_owners.rules` (ya creado)

### Reglas Principales:

#### `business_owner_requests`:

- ✅ **CREATE**: Solo usuario autenticado para sí mismo
- ✅ **READ**: Usuario lee sus solicitudes, super admin lee todas
- ✅ **UPDATE**: Solo super admin puede aprobar/rechazar
- ❌ **DELETE**: Solo super admin (raro, mejor mantener histórico)

#### `notifications`:

- ✅ **READ**: Super admin todas, usuario las suyas
- ✅ **CREATE**: Solo super admin/sistema
- ✅ **UPDATE**: Solo marcar como leída
- ❌ **DELETE**: Solo super admin

#### `admin_users` (actualizado):

- ✅ Auto-creación al aprobar business owner request

### 🚀 Desplegar Reglas:

```bash
# Método 1: Firebase Console
Firebase Console → Firestore → Rules → [Pegar reglas] → Publish

# Método 2: Firebase CLI
firebase deploy --only firestore:rules
```

---

## 🧪 PASO 4: Verificar Setup

### Checklist de Verificación:

```
□ Colección business_owner_requests existe
□ Colección notifications existe
□ Documentos _config creados en ambas
□ Índices creados y activos (puede tardar minutos)
□ Reglas de seguridad desplegadas
□ Script de verificación ejecutado sin errores
```

### Script de Verificación:

```bash
cd core
dart run scripts/setup_business_owner_requests.dart
# Debe mostrar: "✅ Setup completado exitosamente"
```

---

## 🔄 PASO 5: Integración en la App

### Para el Frontend (Flutter):

#### Formulario de Solicitud:

```dart
// En el panel de usuario
AdminAuthRepository.submitBusinessOwnerRequest(
  userId: currentUser.uid,
  displayName: 'Carlos Rodríguez',
  businessName: 'Restaurante La Abuela',
  // ... más campos
);
```

#### Panel de Super Admin:

```dart
// Ver solicitudes pendientes
AdminAuthRepository.getAllBusinessOwnerRequests(
  requestedByUid: superAdminUid,
  filterByStatus: BusinessOwnerRequestStatus.pending,
);

// Aprobar solicitud
AdminAuthRepository.approveBusinessOwnerRequest(
  requestId: requestId,
  approvedByUid: superAdminUid,
);
```

---

## 📊 PASO 6: Monitoreo y Métricas

### KPIs a Monitorear:

- Solicitudes por semana/mes
- Tiempo promedio de respuesta
- Tasa de aprobación
- Solicitudes urgentes (>7 días)

### Dashboard Sugerido:

```dart
BusinessOwnerRequestStats stats = await getBusinessOwnerRequestStats();
// stats.pendingRequests, stats.approvalRate, etc.
```

---

## 🚨 PASO 7: Consideraciones de Producción

### Seguridad:

- ✅ Rate limiting en Cloud Functions
- ✅ Validación adicional de business data
- ✅ Verificación de documentos/licencias
- ✅ Sistema de alertas para actividad sospechosa

### Performance:

- ✅ Cache de solicitudes frecuentes
- ✅ Paginación en listas largas
- ✅ Compresión de imágenes de negocio
- ✅ Archivado automático de solicitudes antiguas

### UX:

- ✅ Notificaciones push/email
- ✅ Estado en tiempo real de solicitudes
- ✅ Wizard paso a paso para formulario
- ✅ Preview antes de enviar solicitud

---

## 🛠️ Comandos Rápidos

```bash
# Setup completo
cd core
dart run scripts/setup_business_owner_requests.dart

# Verificar colecciones
firebase firestore:collections

# Ver reglas actuales
firebase firestore:rules

# Desplegar reglas
firebase deploy --only firestore:rules

# Ver índices
firebase firestore:indexes

# Verificar datos
dart run example_business_owner_registration_new_flow.dart
```

---

## 📞 Troubleshooting

### Error: "Collection doesn't exist"

```bash
# Verificar que las colecciones se crearon
firebase firestore:collections
```

### Error: "Permission denied"

```bash
# Verificar que las reglas se desplegaron
firebase firestore:rules
```

### Error: "Index required"

```bash
# El error te dará el comando exacto para crear el índice
# Ejemplo: firebase firestore:indexes:create --collection=business_owner_requests --fields=status:asc,createdAt:desc
```

### Error en Tests

```bash
# Verificar setup de testing
cd core
flutter test test/src/turbo_core_repositories/admin_auth_repository/
```

---

## ✅ Estado Final

Una vez completado todo:

### Nuevas Funcionalidades:

- 🏢 Usuarios pueden solicitar ser business owners
- 👑 Super admins pueden aprobar/rechazar solicitudes
- 🔔 Sistema de notificaciones automático
- 📊 Dashboard con métricas completas
- 🛡️ Seguridad granular por roles

### Collections en Firestore:

```
├── users/                     (existente)
├── admin_users/              (existente, actualizado)
├── places/                   (existente)
├── business_owner_requests/  (🆕 nueva)
└── notifications/            (🆕 nueva)
```

### Flujo Completo Funcionando:

```
Usuario → Formulario → Solicitud → Admin → Aprobación → Business Owner
```

🎉 **¡Sistema listo para usar!**
