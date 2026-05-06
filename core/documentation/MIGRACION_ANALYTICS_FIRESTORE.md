# 🚀 Guía de Migración de Analytics - Firestore

## 📋 **Resumen Ejecutivo**

Esta guía te explica paso a paso cómo migrar tu sistema de analytics de Turbo Core de la estructura antigua (subcollections) a la nueva arquitectura empresarial (collections separadas).

### ⚡ **Beneficios de la Migración**

- **Queries Cross-Lugar**: Análisis comparativo entre lugares
- **Benchmarking**: Comparación con promedios de industria
- **Escalabilidad**: Performance optimizada para grandes volúmenes
- **Analytics Empresariales**: Capacidades de business intelligence
- **Reportes Agregados**: Automáticos y eficientes

---

## 🏗️ **Arquitectura: Antes vs Después**

### **ANTES (Subcollections)**

```
places/
  └── {placeId}/
      └── analytics/           ❌ Limitada escalabilidad
          ├── summary
          ├── realtime
          ├── hourly_traffic/
          │   └── data/
          └── daily_traffic/
              └── data/
```

### **DESPUÉS (Collections Separadas)**

```
📊 analytics_places/         ✅ Queries cross-lugar
📈 analytics_traffic/        ✅ Time-series optimizado
💬 analytics_reviews/        ✅ Analytics por período
🎯 analytics_events/         ✅ Eventos individuales
⚡ analytics_realtime/       ✅ Métricas en tiempo real
📋 analytics_content/        ✅ Contenido popular
```

---

## 🔧 **¿Qué Necesitas Hacer en Firestore?**

### **1. Preparación (OBLIGATORIO)**

#### 📥 **Backup Completo**

```bash
# Exportar toda tu base de datos
gcloud firestore export gs://tu-bucket/backup-pre-migracion
```

#### 🔍 **Verificar Estado Actual**

```dart
// Ejecutar para ver estadísticas
dart run core/example_migration_script.dart
```

### **2. Configuración de Índices (RECOMENDADO)**

Firestore creará índices automáticamente, pero para mejor performance:

```javascript
// Índices recomendados para crear manualmente en Firebase Console
{
  "analytics_places": [
    {"fields": [{"placeId": "ASCENDING"}, {"total_views": "DESCENDING"}]},
    {"fields": [{"categoryId": "ASCENDING"}, {"conversion_rate": "DESCENDING"}]}
  ],
  "analytics_traffic": [
    {"fields": [{"placeId": "ASCENDING"}, {"type": "ASCENDING"}, {"date": "DESCENDING"}]},
    {"fields": [{"type": "ASCENDING"}, {"date": "DESCENDING"}]}
  ],
  "analytics_events": [
    {"fields": [{"placeId": "ASCENDING"}, {"type": "ASCENDING"}, {"timestamp": "DESCENDING"}]},
    {"fields": [{"type": "ASCENDING"}, {"timestamp": "DESCENDING"}]}
  ]
}
```

### **3. Ejecución de la Migración**

#### 🧪 **Testing (OBLIGATORIO)**

```dart
// 1. Probar en desarrollo primero
// 2. Descomenta esta línea en example_migration_script.dart:
// await _executeMigration(migration);

// 3. Ejecutar
dart run core/example_migration_script.dart
```

#### 🚀 **Producción**

```bash
# Ejecutar en horas de bajo tráfico (ej: 2-5 AM)
dart run core/example_migration_script.dart
```

### **4. Verificación Post-Migración**

#### ✅ **Comprobar Collections Nuevas**

```dart
// Verificar que se crearon las collections
- analytics_places/      → 1 doc por lugar
- analytics_traffic/     → docs time-series
- analytics_events/      → eventos individuales
- analytics_realtime/    → 1 doc por lugar
- analytics_content/     → 1 doc por lugar
```

#### 📊 **Verificar Datos**

```dart
// Script de verificación incluido
showDetailedStatsExample()
```

---

## ⚠️ **Problemas Comunes y Soluciones**

### **Problema: Error de permisos**

```
❌ Error: Permission denied accessing Firestore
```

**Solución:**

```dart
// Verificar reglas de Firestore en Firebase Console
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /analytics_{type}/{document} {
      allow read, write: if true; // Temporal para migración
    }
  }
}
```

### **Problema: Timeout en migración**

```
❌ Error: Timeout during migration
```

**Solución:**

```dart
// Reducir batch size en el script
await migration.migrateAllExistingPlaces(
  batchSize: 10, // Reducir de 50 a 10
);
```

### **Problema: Lugar específico falla**

```
❌ Error: Failed to migrate place_123
```

**Solución:**

```dart
// Migrar individualmente
await migrateSinglePlaceExample(); // Cambiar ID en código
```

---

## 🚨 **Plan de Rollback de Emergencia**

### **Si algo sale mal:**

1. **Parar la migración inmediatamente**
2. **Restaurar desde backup:**

   ```bash
   gcloud firestore import gs://tu-bucket/backup-pre-migracion
   ```

3. **Limpiar collections nuevas (si es necesario):**
   ```dart
   // Ejecutar solo en emergencia
   await cleanupNewCollections();
   ```

---

## 📈 **Nuevas Capacidades Después de Migrar**

### **1. Queries Cross-Lugar**

```dart
// Obtener top 10 lugares por conversión
final topPlaces = await firestore
  .collection('analytics_places')
  .orderBy('conversion_rate', descending: true)
  .limit(10)
  .get();
```

### **2. Benchmarking de Industria**

```dart
// Comparar con promedio de categoría
final industryAvg = await firestore
  .collection('analytics_places')
  .where('categoryId', isEqualTo: 'restaurants')
  .get();
```

### **3. Analytics en Tiempo Real**

```dart
// Stream de métricas live
firestore
  .collection('analytics_realtime')
  .doc(placeId)
  .snapshots()
  .listen((snapshot) {
    // Actualizar dashboard en tiempo real
  });
```

### **4. Reportes Agregados**

```dart
// Traffic patterns across all places
final trafficData = await firestore
  .collection('analytics_traffic')
  .where('type', isEqualTo: 'hourly')
  .where('date', isGreaterThan: lastWeek)
  .get();
```

---

## 🎯 **Timeline Recomendado**

### **Semana 1: Preparación**

- [ ] Backup completo de Firestore
- [ ] Testing en ambiente de desarrollo
- [ ] Configuración de índices opcionales

### **Semana 2: Migración**

- [ ] Ejecutar migración en horas de bajo tráfico
- [ ] Monitoreo en tiempo real
- [ ] Verificación de integridad

### **Semana 3: Verificación**

- [ ] Pruebas exhaustivas de funcionalidad
- [ ] Implementar nuevas capacidades empresariales
- [ ] Cleanup de estructura antigua (opcional)

---

## 📞 **Soporte y Contacto**

### **Si necesitas ayuda:**

1. **Revisar logs detallados** del script
2. **Ejecutar diagnósticos** con `showDetailedStatsExample()`
3. **Documentar el error específico** para soporte

### **Comandos de Diagnóstico:**

```bash
# Ver estado actual
dart run core/example_migration_script.dart

# Migrar lugar específico
migrateSinglePlaceExample()

# Regenerar lugar (último recurso)
regenerateAnalyticsExample()
```

---

## ✅ **Checklist Final**

- [ ] ✅ Backup completo realizado
- [ ] ✅ Testing en desarrollo exitoso
- [ ] ✅ Migración ejecutada sin errores
- [ ] ✅ Verificación de integridad pasada
- [ ] ✅ Nuevas capacidades funcionando
- [ ] ✅ Performance mejorada confirmada

**🎉 ¡Felicidades! Tu sistema ahora tiene capacidades empresariales de analytics avanzadas.**

---

**📚 Documentación Relacionada:**

- `ANALYTICS_ARQUITECTURA_NUEVA.md` - Arquitectura detallada
- `example_migration_script.dart` - Script de migración
- **Firebase Console** - Monitoreo en tiempo real
