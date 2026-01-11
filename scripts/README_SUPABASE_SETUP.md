# 🚀 Supabase Database Setup - Turbo Platform

Este directorio contiene todos los scripts y herramientas necesarias para configurar la base de datos de Supabase para Turbo Platform.

## 📁 Archivos Incluidos

- `supabase_database_setup.sql` - Script SQL completo para crear toda la base de datos
- `supabase_setup.dart` - Script de Dart para verificar y guiar el setup
- `README_SUPABASE_SETUP.md` - Esta documentación

## 🎯 ¿Qué hace el Setup?

El script de setup crea automáticamente:

### 📊 **10 Tablas Principales**

1. **users** - Usuarios con autenticación
2. **categories** - Categorías de lugares
3. **places** - Lugares/negocios
4. **reviews** - Sistema de reseñas con moderación
5. **favorites** - Favoritos de usuarios
6. **events** - Eventos
7. **place_categories** - Relaciones many-to-many
8. **place_locations** - Ubicaciones geoespaciales
9. **admin_users** - Usuarios administrativos
10. **business_owner_requests** - Solicitudes de propietarios

### 🔧 **Funciones PostgreSQL**

- `increment_category_places_count()` - Incrementa contador de lugares por categoría
- `decrement_category_places_count()` - Decrementa contador de lugares por categoría
- `update_place_rating()` - Actualiza rating promedio de lugares
- `update_updated_at_column()` - Actualiza timestamps automáticamente

### ⚡ **Triggers Automáticos**

- Actualización automática de `updated_at` en todas las tablas
- Actualización automática de ratings cuando cambian las reseñas
- Mantenimiento de contadores de categorías

### 🔒 **Seguridad (RLS)**

- Row Level Security habilitado en tablas sensibles
- Políticas de acceso configuradas
- Autenticación integrada con Supabase Auth

### 📈 **Datos de Muestra**

- 5 categorías (Restaurantes, Cafeterías, Bares, Hoteles, Entretenimiento)
- 5 lugares con ubicaciones reales en Madrid
- Usuarios de prueba (admin, regular, business_owner)
- Reseñas y favoritos de ejemplo
- Eventos próximos
- Solicitudes de propietarios pendientes

## 🚀 Pasos para Configurar

### 1. Crear Proyecto Supabase

1. Ve a [https://supabase.com](https://supabase.com)
2. Crea una cuenta o inicia sesión
3. Crea un nuevo proyecto
4. Anota la URL y las API keys

### 2. Configurar Variables de Entorno

Crea un archivo `.env` en la raíz del proyecto:

```bash
SUPABASE_URL=https://tu-proyecto.supabase.co
SUPABASE_ANON_KEY=tu-anon-key
SUPABASE_SERVICE_ROLE_KEY=tu-service-role-key
```

### 3. Ejecutar Script SQL

#### Opción A: Desde Supabase Dashboard (Recomendado)

1. Ve a tu proyecto Supabase
2. Navega a **SQL Editor**
3. Copia todo el contenido de `scripts/supabase_database_setup.sql`
4. Pega en el editor y ejecuta

#### Opción B: Desde Línea de Comandos

```bash
# Instalar psql si no lo tienes
# macOS: brew install postgresql
# Ubuntu: sudo apt-get install postgresql-client

# Ejecutar script
psql "postgresql://postgres:[password]@db.[project-ref].supabase.co:5432/postgres" -f scripts/supabase_database_setup.sql
```

### 4. Verificar Instalación

1. Ve a **Table Editor** en Supabase
2. Verifica que se crearon todas las tablas
3. Revisa que hay datos de muestra
4. Ejecuta el script de verificación:

```bash
dart run scripts/supabase_setup.dart --check-sql
```

### 5. Configurar Autenticación

1. Ve a **Authentication > Settings**
2. Configura los providers que necesites:
   - **Email**: Habilitado por defecto
   - **Google**: Configura OAuth credentials
   - **Otros**: Según necesites
3. Actualiza las URLs de redirección

### 6. Probar Servicios

```bash
# Ejecutar tests
dart test test/src/turbo_core_repositories/

# Analizar código
dart analyze lib/src/turbo_core_repositories/

# Verificar migración
dart run scripts/supabase_setup.dart --help
```

## 🔧 Comandos Útiles

```bash
# Verificar archivo SQL
dart run scripts/supabase_setup.dart --check-sql

# Mostrar contenido SQL
dart run scripts/supabase_setup.dart --show-sql

# Verificar variables de entorno
dart run scripts/supabase_setup.dart --check-env

# Mostrar comandos útiles
dart run scripts/supabase_setup.dart --commands

# Ver instrucciones completas
dart run scripts/supabase_setup.dart --help
```

## 🔍 Verificación Manual

### Verificar Tablas

```sql
-- Listar todas las tablas
SELECT table_name
FROM information_schema.tables
WHERE table_schema = 'public'
AND table_type = 'BASE TABLE'
ORDER BY table_name;
```

### Verificar Datos

```sql
-- Contar registros en cada tabla
SELECT 'Categories' as table_name, COUNT(*) as count FROM categories
UNION ALL
SELECT 'Users', COUNT(*) FROM users
UNION ALL
SELECT 'Places', COUNT(*) FROM places
UNION ALL
SELECT 'Reviews', COUNT(*) FROM reviews
UNION ALL
SELECT 'Favorites', COUNT(*) FROM favorites
UNION ALL
SELECT 'Events', COUNT(*) FROM events
UNION ALL
SELECT 'Admin Users', COUNT(*) FROM admin_users
UNION ALL
SELECT 'Business Requests', COUNT(*) FROM business_owner_requests;
```

### Verificar Funciones

```sql
-- Listar funciones creadas
SELECT routine_name
FROM information_schema.routines
WHERE routine_schema = 'public'
AND routine_type = 'FUNCTION';
```

### Verificar Triggers

```sql
-- Listar triggers
SELECT trigger_name, event_object_table
FROM information_schema.triggers
WHERE trigger_schema = 'public';
```

## 🔧 Troubleshooting

### ❌ Error: "permission denied"

**Solución**: Usa `SERVICE_ROLE_KEY` en lugar de `ANON_KEY` para operaciones administrativas.

### ❌ Error: "table already exists"

**Solución**: El script usa `IF NOT EXISTS`, es seguro ejecutarlo múltiples veces.

### ❌ Error: "function does not exist"

**Solución**: Ejecuta el script completo en orden, no por partes.

### ❌ Error: "RLS policy failed"

**Solución**: Verifica que auth está habilitado en Supabase.

### ❌ Error: "connection failed"

**Solución**: Verifica la URL y credenciales de Supabase.

### ❌ Error: "extension not found"

**Solución**: Las extensiones `uuid-ossp` y `pgcrypto` deben estar habilitadas en Supabase.

## 📊 Estructura de la Base de Datos

### Relaciones Principales

```
users (1) ←→ (N) reviews
users (1) ←→ (N) favorites
places (1) ←→ (N) reviews
places (1) ←→ (N) events
places (N) ←→ (N) categories (through place_categories)
places (1) ←→ (1) place_locations
```

### Índices Optimizados

- **Búsqueda por email**: `idx_users_email`
- **Búsqueda por ubicación**: `idx_places_location`
- **Búsqueda por rating**: `idx_places_rating`
- **Búsqueda por fecha**: `idx_events_date`
- **Búsqueda por estado**: `idx_reviews_status`
- **Arrays y JSONB**: `idx_places_owner_ids` (GIN)

### Seguridad

- **RLS habilitado** en tablas sensibles
- **Políticas de acceso** basadas en `auth.uid()`
- **Foreign keys** para integridad referencial
- **Cascading deletes** para mantener consistencia

## 🎉 ¡Listo para Producción!

Una vez completado el setup, tu base de datos estará:

- ✅ **Completamente funcional** con todos los servicios
- ✅ **Optimizada** con índices apropiados
- ✅ **Segura** con RLS y políticas de acceso
- ✅ **Escalable** con PostgreSQL
- ✅ **Lista para testing** con datos de muestra

## 📚 Documentación Adicional

- `../supabase_database_schema.md` - Detalles técnicos del schema
- `../supabase_migration_status.md` - Estado de la migración
- `../README.md` - Guía general del proyecto

---

**¿Necesitas ayuda?** Revisa la documentación o ejecuta `dart run scripts/supabase_setup.dart --help` para más información.
