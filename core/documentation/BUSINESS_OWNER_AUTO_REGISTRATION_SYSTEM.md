# 🏢 Sistema de Auto-Registro de Business Owners

## 📋 Resumen del Sistema

Este sistema permite que usuarios regulares soliciten convertirse en **Business Owners** para gestionar sus negocios en Turbo Platform, siguiendo un flujo de aprobación controlado por Super Administradores.

## 🔄 Flujo del Proceso

```mermaid
graph TD
    A[Usuario Regular<br/>Ya registrado] --> B[Login en App/Panel]
    B --> C[Ve botón<br/>"Crear mi lugar"]
    C --> D[Llena formulario<br/>de negocio]
    D --> E[Envía solicitud]
    E --> F[Sistema crea<br/>BusinessOwnerRequest]
    F --> G[Notifica Super Admins]
    G --> H{Super Admin<br/>revisa}
    H -->|Aprobar| I[Usuario convertido<br/>a Business Owner]
    H -->|Rechazar| J[Usuario notificado<br/>del rechazo]
    H -->|Más info| K[Solicitar más<br/>información]
    I --> L[Usuario gestiona<br/>su negocio]
```

## 🗄️ Estructura de Datos

### 📝 BusinessOwnerRequest

```dart
{
  id: String,              // ID único de la solicitud
  userId: String,          // UID del usuario ya registrado
  email: String,           // Email del usuario
  displayName: String,     // Nombre completo
  businessName: String,    // Nombre del negocio
  businessDescription: String, // Descripción del negocio
  businessAddress: String, // Dirección física
  phoneNumber: String?,    // Teléfono (opcional)
  website: String?,        // Sitio web (opcional)
  status: BusinessOwnerRequestStatus, // Estado actual
  createdAt: DateTime,     // Fecha de creación
  reviewedAt: DateTime?,   // Fecha de revisión
  reviewedBy: String?,     // UID del super admin revisor
  rejectionReason: String?, // Razón del rechazo
  approvalNotes: String?,  // Notas de aprobación
  businessMetadata: Map,   // Metadatos del negocio
  contactInfo: Map,        // Información de contacto
}
```

### 📊 Estados de Solicitud

```dart
enum BusinessOwnerRequestStatus {
  pending,      // ⏳ Pendiente de revisión
  reviewing,    // 🔄 En revisión por admin
  needsMoreInfo,// 📝 Necesita más información
  approved,     // ✅ Aprobada y procesada
  rejected,     // ❌ Rechazada
}
```

## 🏗️ Arquitectura del Sistema

### 📁 Archivos Principales

```
core/lib/src/turbo_core_repositories/admin_auth_repository/
├── models/
│   ├── admin_user.dart                    # Modelo de usuario admin
│   └── business_owner_request.dart        # 🆕 Modelo de solicitud
├── service/
│   └── admin_auth_service.dart           # 🔄 Servicio actualizado
├── admin_auth_repository.dart            # 🔄 Repositorio actualizado
└── admin_auth_repository_imports.dart    # Exports
```

### 🗄️ Colecciones de Firestore

```
📁 admin_users/                    # Usuarios administrativos
📁 business_owner_requests/        # 🆕 Solicitudes de business owners
📁 notifications/                  # 🆕 Notificaciones del sistema
📁 users/                         # Usuarios regulares (existente)
```

## 🔧 Métodos Principales

### 👤 Para Usuarios (Auto-registro)

```dart
// Enviar solicitud para convertirse en business owner
Future<Either<AdminAuthFailure, BusinessOwnerRequest>> submitBusinessOwnerRequest({
  required String userId,           // UID del usuario actual
  required String displayName,
  required String businessName,
  required String businessDescription,
  required String businessAddress,
  String? phoneNumber,
  String? website,
  Map<String, dynamic>? businessMetadata,
  Map<String, dynamic>? contactInfo,
});
```

### 👑 Para Super Administradores

```dart
// Ver todas las solicitudes
Future<Either<AdminAuthFailure, List<BusinessOwnerRequest>>> getAllBusinessOwnerRequests({
  String? requestedByUid,
  BusinessOwnerRequestStatus? filterByStatus,
});

// Aprobar solicitud
Future<Either<AdminAuthFailure, AdminUser>> approveBusinessOwnerRequest({
  required String requestId,
  required String approvedByUid,
  List<String>? initialPlaceIds,
  String? approvalNotes,
});

// Rechazar solicitud
Future<Either<AdminAuthFailure, Unit>> rejectBusinessOwnerRequest({
  required String requestId,
  required String rejectedByUid,
  required String rejectionReason,
});

// Cambiar estado
Future<Either<AdminAuthFailure, Unit>> updateRequestStatus({
  required String requestId,
  required String updatedByUid,
  required BusinessOwnerRequestStatus newStatus,
  String? notes,
});

// Ver estadísticas
Future<Either<AdminAuthFailure, BusinessOwnerRequestStats>> getBusinessOwnerRequestStats({
  String? requestedByUid,
});
```

## 📱 Ejemplos de Uso

### 1. Usuario Solicita Registro

```dart
final adminAuthRepo = GetIt.instance<AdminAuthRepository>();

final result = await adminAuthRepo.submitBusinessOwnerRequest(
  userId: currentUser.uid,
  displayName: 'Carlos Rodríguez',
  businessName: 'Restaurante La Abuela',
  businessDescription: 'Restaurante familiar con comida tradicional',
  businessAddress: 'Av. Reforma 123, CDMX',
  phoneNumber: '+52 55 1234 5678',
  website: 'https://restaurantelaabuela.mx',
  businessMetadata: {
    'category': 'restaurant',
    'cuisine': 'mexican',
    'capacity': 80,
  },
  contactInfo: {
    'emergencyContact': '+52 55 8765 4321',
    'socialMedia': {
      'facebook': '@restaurantelaabuela',
      'instagram': '@laabuela_oficial',
    },
  },
);

result.fold(
  (failure) => showError(failure.toString()),
  (request) => showSuccess('Solicitud enviada: ${request.id}'),
);
```

### 2. Super Admin Aprueba

```dart
// Ver solicitudes pendientes
final requestsResult = await adminAuthRepo.getAllBusinessOwnerRequests(
  requestedByUid: superAdminUid,
  filterByStatus: BusinessOwnerRequestStatus.pending,
);

// Aprobar solicitud específica
final approvalResult = await adminAuthRepo.approveBusinessOwnerRequest(
  requestId: requestId,
  approvedByUid: superAdminUid,
  initialPlaceIds: [], // Sin lugares iniciales
  approvalNotes: 'Documentación verificada correctamente',
);
```

## 🎯 Ventajas del Sistema

### ✅ Para Usuarios

- **Proceso Simple**: Solo llenar un formulario
- **Sin Credenciales Adicionales**: Usan su cuenta existente
- **Transparencia**: Pueden ver el estado de su solicitud
- **Sin Fricción**: No necesitan contacto directo con admins

### ✅ Para Administradores

- **Control Total**: Aprobación manual de cada solicitud
- **Información Completa**: Toda la data del negocio disponible
- **Trazabilidad**: Historial completo de cada solicitud
- **Escalable**: Sistema automatizado con notificaciones

### ✅ Para la Plataforma

- **Calidad**: Solo negocios verificados
- **Seguridad**: Proceso controlado de permisos
- **Crecimiento**: Facilita onboarding de business owners
- **Métricas**: Estadísticas completas del proceso

## 🔧 Configuración e Instalación

### 1. Base de Datos

```bash
# Ejecutar script de setup
dart run core/scripts/setup_business_owner_requests.dart
```

### 2. Índices de Firestore

```
Collection: business_owner_requests
- userId (Ascending)
- status (Ascending), createdAt (Descending)
- reviewedBy (Ascending), reviewedAt (Descending)
```

### 3. Reglas de Seguridad

```javascript
// business_owner_requests
match /business_owner_requests/{requestId} {
  // Usuarios pueden crear y leer sus propias solicitudes
  allow create: if request.auth != null
    && request.auth.uid == resource.data.userId;

  allow read: if request.auth != null
    && (request.auth.uid == resource.data.userId
        || isSuperAdmin(request.auth.uid));

  // Solo super admins pueden actualizar
  allow update: if request.auth != null
    && isSuperAdmin(request.auth.uid);
}
```

## 📊 Métricas y Monitoreo

### KPIs Principales

- **Tiempo de Respuesta Promedio**: Días entre solicitud y decisión
- **Tasa de Aprobación**: % de solicitudes aprobadas
- **Solicitudes Urgentes**: Pendientes por más de 7 días
- **Volumen**: Solicitudes por semana/mes

### Dashboard Sugerido

```dart
BusinessOwnerRequestStats {
  totalRequests: 156,
  pendingRequests: 12,
  approvedRequests: 128,
  rejectedRequests: 16,
  urgentRequests: 3,
  approvalRate: 88.9,
  averageResponseTimeDays: 2.3,
}
```

## 🚀 Próximos Pasos

### Fase 1: Implementación Básica ✅

- [x] Modelos de datos
- [x] Servicios y repositorios
- [x] Lógica de aprobación/rechazo
- [x] Sistema de notificaciones básico

### Fase 2: Interfaz de Usuario

- [ ] Formulario de solicitud para usuarios
- [ ] Panel de administración para super admins
- [ ] Dashboard con métricas
- [ ] Sistema de notificaciones en tiempo real

### Fase 3: Mejoras Avanzadas

- [ ] Envío de emails automáticos
- [ ] Integración con sistemas de verificación
- [ ] Bulk operations para admins
- [ ] Analytics avanzados

### Fase 4: Optimizaciones

- [ ] Cache de solicitudes frecuentes
- [ ] Archivado automático de solicitudes antiguas
- [ ] Sistema de templates para respuestas
- [ ] Integración con CRM

## 🔗 Archivos de Referencia

- `example_business_owner_registration_new_flow.dart` - Ejemplo completo de uso
- `scripts/setup_business_owner_requests.dart` - Script de configuración inicial
- `models/business_owner_request.dart` - Modelo principal
- `service/admin_auth_service.dart` - Lógica de negocio

## 📞 Soporte

Para dudas sobre implementación:

1. Revisar ejemplos en `core/example_business_owner_registration_new_flow.dart`
2. Consultar tests unitarios (cuando estén implementados)
3. Verificar logs de notificaciones en Firestore
4. Usar `getBusinessOwnerRequestStats()` para debugging

---

**✅ Sistema listo para integración en Turbo Platform**
