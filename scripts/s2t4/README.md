# S2-T4 — Semillas de analytics (un solo proyecto Supabase)

## 1. `place_id`, `owner_id` y FK (`places` / `users`)

El Admin resuelve el negocio con `PlaceRepository.getPlacesByOwnerId(ownerUserId)` (`owner_ids` TEXT[] contiene el UID del business owner).

El seed **inserta o actualiza** (mismos UUID siempre) las filas mínimas en `public.users` y `public.places` **antes** de `analytics_*` y `reservations`. Así no falla `analytics_places_place_id_fkey` ni `reservations_user_id_fkey` en proyectos vacíos (sin correr [`supabase_database_setup_complete.sql`](../supabase_database_setup_complete.sql)).

| Rol | UUID | Email en `public.users` (seed) |
|-----|------|--------------------------------|
| Lugar S2-T4 | `550e8400-e29b-41d4-a716-446655440020` | — |
| Business owner (`owner_ids`) | `550e8400-e29b-41d4-a716-446655440013` | `s2t4-owner@turbo-seed.invalid` |
| Cliente reserva A | `550e8400-e29b-41d4-a716-446655440011` | `s2t4-client-a@turbo-seed.invalid` |
| Cliente reserva B | `550e8400-e29b-41d4-a716-446655440012` | `s2t4-client-b@turbo-seed.invalid` |

**Supabase Auth (login en Admin):** además de `public.users`, hace falta **`auth.users` + `auth.identities`** con el mismo `id` que `places.owner_ids` (`…440013` por defecto). Para no hacerlo a mano en el dashboard, ejecuta **`seed_auth_owner_s2t4.sql`** después del seed de datos.

| Campo | Valor por defecto (solo dev) |
|-------|------------------------------|
| Email | `s2t4-owner@turbo-seed.invalid` |
| Contraseña | `TurboS2t4Dev!` |

Para revertir solo ese login de prueba: `cleanup_auth_owner_s2t4.sql`.

Si usas **otro** `auth.uid()` real, puedes omitir el script de Auth y hacer `UPDATE places SET owner_ids = ARRAY['<tu auth.uid()>']::text[] WHERE id = '…440020'`.

Si usas **otros** UUIDs en los seeds, edita las constantes en `seed_analytics_s2t4.sql`, `seed_auth_owner_s2t4.sql` y los `cleanup_*.sql`.

## 2. Mapeo MVP (KPIs ↔ tablas / código Core)

| Objetivo | Origen en runtime |
|-----------|-------------------|
| Resumen vistas / visitantes / conversión / eventos / sesión | `analytics_places` → `_getDashboardSummary` + `_getKpiMetrics` en [`analytics_service_supabase.dart`](../../core/lib/src/turbo_core_repositories/analytics_repository/service/analytics_service_supabase.dart) |
| Rating y favoritos en resumen | `places.rating`, `places.favorite_count` (misma función) |
| Tráfico horario / gráfico | `analytics_traffic` con `type = 'hourly'` y `timestamp` en rango |
| Tráfico diario | `analytics_traffic` con `type = 'daily'` y `date` en rango |
| Insights de reseñas | `analytics_reviews` por `period` **o** cálculo desde tabla `reviews` si no hay fila |
| Contenido popular | `analytics_content` |
| Reservas (últimos 30 días, contador en Admin) | `ReservationRepository.getReservationsBetweenDates` → tabla `reservations` (columnas **snake_case** en Postgres; el cliente Core usa `place_id`, `reservation_date`, etc.) |

**Semillas de reservas:** `seed_analytics_s2t4.sql` inserta 3 filas con IDs `a1b00006-…` dentro del rango típico de `DateRange.last30Days()` (fechas relativas a `CURRENT_DATE`).

**Periodo de `analytics_reviews`:** el cliente usa `DateRange.last30Days()` → clave `month_YYYY_M` (mes calendario actual). El seed inserta ese periodo con `to_char(current_date, ...)` para alinearse al mes en curso.

## 3. RLS y rol de inserción

En el script maestro de referencia, **no** se habilita RLS sobre `analytics_*` (solo `users`, `admin_users`, `business_owner_requests`, `notifications`, `reservations`).

- **Lectura/escritura** con la `anon key` / usuario autenticado depende de las políticas **reales** de tu proyecto. Si las tablas `analytics_*` tienen RLS sin política para `authenticated`, el Admin fallará al leer.
- **Recomendación:** ejecutar `seed_analytics_s2t4.sql` en **SQL Editor** de Supabase (rol de servicio / postgres) o con una migración aplicada como superuser.
- Tras sembrar, valida en el dashboard de Supabase que las filas existen y que el usuario JWT que usa Turbo-Admin puede `SELECT` (ajusta políticas si hace falta: por ejemplo lectura para usuarios cuyo `auth.uid()` esté en `owner_ids` del `place_id`).

## 4. Orden de ejecución

1. **Una vez por proyecto** (si `business_owner_requests` solo tiene columnas viejas `owner_name` / `phone` / etc.): ejecutar [`migrate_business_owner_requests_for_core.sql`](./migrate_business_owner_requests_for_core.sql).
2. Revisar/editar constantes en `seed_analytics_s2t4.sql` y `seed_auth_owner_s2t4.sql` si cambias UUIDs o email.
3. Ejecutar `seed_analytics_s2t4.sql` (usuarios/lugar `public.*`, analytics, reservas).
4. Ejecutar `seed_auth_owner_s2t4.sql` (Auth email/contraseña + fila en `business_owner_requests` **aprobada** con el mismo `user_id`, para que `signInUnified` en Core enrute al dashboard de negocio).
5. Turbo-Admin: login con `s2t4-owner@turbo-seed.invalid` / `TurboS2t4Dev!` → `/business-owner-dashboard` con KPIs del seed.
6. Revertir: `cleanup_analytics_s2t4.sql` y `cleanup_auth_owner_s2t4.sql`.
