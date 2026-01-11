### Supabase como fuente de verdad: Pipeline de ingesta, enriquecimiento y sync de Places

Este documento define cómo poblar y mantener actualizada la base de datos de lugares/negocios de Cuba en Supabase (fuente de verdad), garantizando calidad de datos, deduplicación y exportación al formato consumido por la app (Firestore actualmente).

---

## Objetivo

- **Poblar** Supabase con un listado amplio y deduplicado de lugares/negocios.
- **Enriquecer** con contacto, website, horarios, media y categorías.
- **Mantener** sincronización hacia Firestore con el shape de `Place` que consume la app.
- **Preparar** el flujo de contacto a 90 días para monetización.

## Alcance

- Fuentes: OSM/Overpass, directorios locales y webs oficiales, Bing Web Search para descubrimiento, scraping ligero (Playwright/Apify) cuando haga falta, siempre respetando ToS y robots.txt.
- Supabase es el source of truth. Firestore se usa como espejo para la app hasta migración completa.

---

## Modelo de datos en Supabase

Se emplean dos capas: staging y denormalizada.

- Staging (ingesta y trazabilidad):
  - `places_raw(id, source, source_url, raw_json, discovered_at, fingerprint, city, name)`
  - `sources(id, name, notes)`
  - `place_sources(id, place_id, source_id, field_name, value, last_seen_at)`
  - `dedupe_candidates(id, a_place_id, b_place_id, score, reason, resolved)`
  - `scrape_runs(id, workflow, started_at, finished_at, status, details)`

- Denormalizada (shape 1:1 con `Place`):
  - `places_denorm(
      id, name, description, address, image_urls, rating,
      reviews, offers, tags, is_open, main_image, favorite_count,
      menu_url, latitude, longitude, category_id, category_name,
      opening_hours, phone, website, price_level, metadata,
      owner_ids, created_by, created_at, last_updated
    )`

Campos clave y mapeo a `Place` (colección `places` en Firestore):

- Identidad: `name`, `description`, `tags`.
- Ubicación: `address`, `latitude`, `longitude`.
- Contacto: `phone`, `website`, `menu_url`.
- Horarios: `opening_hours` como `Map<String, {opens_at, closes_at}>`.
- Media: `image_urls`, `main_image`.
- Clasificación: `category_id`, `category_name`, `price_level`.
- Estado: `is_open`, `rating` (inicial 0), `reviews` ([]) y `offers` ([]).
- Auditoría: `metadata` incluye `sources`, `sourceUrls`, `fingerprint`, `confidence`, `social`, `is_claimed`.
- Ownership: `owner_ids`, `created_by`, `created_at`, `last_updated`.

Índices recomendados: trigram en `name` y `address` para búsqueda y dedupe.

---

## Reglas de actualización y propiedad de campo

- No sobreescribir campos modificados por owners (`metadata.is_claimed = true` o `owner_ids` no vacío).
- `main_image`: si vacío y `image_urls` tiene elementos, usar el primero.
- `reviews` y `offers`: mantener vacíos hasta integrar fuentes confiables.

---

## Pipeline n8n (Workflows)

- WF-01 Seed OSM Cuba
  - Cron → HTTP Overpass → Function (normalize + fingerprint) → Upsert `places_raw`.
  - Normalizar: minúsculas, sin tildes, trim; `fingerprint = normalize(name + address + city)`.

- WF-02 Descubrimiento y enriquecimiento
  - Trigger por nuevos `places_raw` o `places_denorm` incompletos.
  - Bing Web Search → parse resultados → obtener `website`/redes.
  - HTTP/Playwright (solo cuando sea necesario) → extraer `phone`, `email`, `whatsapp`, `opening_hours`, `image_urls`.
  - Upsert en `place_sources` y actualización de `places_denorm` cuando el dato mejora calidad.

- WF-03 Deduplicación incremental
  - Cron → SQL candidatos por similitud de `name`/`address` (trigram) y proximidad geográfica.
  - Score sugerido: 0.5·sim_name + 0.3·sim_address + 0.2·proximidad.
  - Merge automático si score ≥ 0.85; flag `needs_review` si 0.70–0.85; ignorar si < 0.70.

- WF-04 Sync a Firestore (consumo app actual)
  - Cron/On-Update → Select de `places_denorm` modificados.
  - Map a payload `Place` (ver ejemplo más abajo) → HTTP a Cloud Function (Firebase Admin) para upsert en colección `places` con `docId = id` de Supabase.

- WF-05 Contacto a 90 días (monetización)
  - Cron diario → Select en `owners_leads` con `first_seen_at + contact_after_days <= now()` y `status = 'pending'`.
  - Enviar mensaje por canal definido → Update `status` a `contacted`/`no-response`/`converted`.

Monitor: notificaciones a Telegram/Slack en errores (`scrape_runs`).

---

## Dedupe y calidad de datos

- Regla fuerte: teléfono igual o website igual → duplicado probable.
- Score híbrido: trigram de `name` y `address` + distancia Haversine.
- `data_quality_score` (opcional en `metadata`): sumar puntos por teléfono válido, website válido, horario completo, imágenes, redes verificadas.

---

## Sincronización a Firestore (shape `Place`)

Endpoint (Cloud Function) recibe:

```json
{
  "docId": "uuid-de-supabase",
  "data": {
    "name": "La Guarida",
    "description": "Restaurante icónico...",
    "address": "Concordia 418, Centro Habana, La Habana",
    "imageUrls": ["https://.../1.jpg", "https://.../2.jpg"],
    "rating": 0.0,
    "reviews": [],
    "offers": [],
    "tags": ["restaurant", "cuban"],
    "isOpen": false,
    "mainImage": "https://.../1.jpg",
    "favoriteCount": 0,
    "menuUrl": "https://.../menu.pdf",
    "latitude": 23.1401,
    "longitude": -82.3666,
    "categoryId": "restaurant",
    "categoryName": "Restaurant",
    "openingHours": {"mon": {"opens_at": "12:00", "closes_at": "23:00"}},
    "phone": "+5355551234",
    "website": "https://laguarida.com",
    "priceLevel": 3,
    "metadata": {
      "sources": ["osm", "website", "bing"],
      "social": {"instagram": "@laguarida"},
      "fingerprint": "laguarida-concordia418-centrohabana",
      "confidence": 0.92
    },
    "ownerIds": [],
    "createdBy": "etl-n8n",
    "createdAt": "2025-08-12T00:00:00Z",
    "lastUpdated": "2025-08-12T00:00:00Z"
  }
}
```

La función hace upsert en `places/{docId}`. El shape coincide con `Place.fromFirestore` para no romper la app.

---

## Seguridad y cumplimiento

- Respetar ToS y `robots.txt` de las fuentes; evitar scraping agresivo.
- Recolectar solo datos públicos de negocios (no personales sensibles).
- Activar RLS en Supabase y políticas de inserción/actualización para servicios.

---

## Métricas y monitoreo

- Conteo total de lugares, crecimiento semanal, porcentaje con teléfono/website/horarios, duplicados resueltos, leads contactados y conversión.
- Dashboards en Supabase/Metabase. Alertas automáticas en fallas de workflows.

---

## Próximos pasos

1. Crear migraciones para tablas `places_raw`, `places_denorm`, `place_sources`, `dedupe_candidates`, `scrape_runs`, `owners_leads` e índices trigram.
2. Implementar WF-01 a WF-05 en n8n y configurar credenciales (Overpass, Bing, hosting de Playwright/Apify, Firebase Admin HTTP).
3. Definir catálogo de categorías y mapeos desde OSM (`amenity`, `shop`, `tourism`, etc.).
4. Añadir vista de revisión humana en Admin Panel para duplicados y conflictos.
5. Poner en producción el job de sync a Firestore y monitoreo.

---

## Apéndice A — Normalización de horarios

Estructura estándar:

```json
{
  "mon": {"opens_at": "09:00", "closes_at": "18:00"},
  "tue": {"opens_at": "09:00", "closes_at": "18:00"}
}
```

---

## Apéndice B — Heurística de precio (opcional)

- 1 = económico; 2 = medio; 3 = alto. Detectado por keywords (“$”, “menú promedio”, “fine dining”).


