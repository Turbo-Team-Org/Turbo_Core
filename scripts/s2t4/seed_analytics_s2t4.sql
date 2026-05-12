-- =============================================================================
-- S2-T4 seed: analytics + enlace owner ↔ lugar (un solo ambiente Supabase)
-- Ejecutar en Supabase SQL Editor (recomendado: rol con bypass RLS).
-- Antes de la primera vez en un proyecto con tabla `business_owner_requests` legada,
-- ejecuta `migrate_business_owner_requests_for_core.sql` (una vez).
-- Edita place_id / owner_user_id si no usas el dataset de ejemplo del repo.
-- =============================================================================

BEGIN;

-- -----------------------------------------------------------------------------
-- 0) FK previas: `analytics_*` y `reservations` exigen filas en `places` y
--    `users`. En proyectos recién creados (sin supabase_database_setup_complete)
--    no existen; este bloque inserta/actualiza solo los UUID del seed S2-T4.
-- -----------------------------------------------------------------------------
INSERT INTO public.users (id, email, display_name, role) VALUES
  (
    '550e8400-e29b-41d4-a716-446655440013'::uuid,
    's2t4-owner@turbo-seed.invalid',
    'Owner S2-T4 seed',
    'business_owner'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    's2t4-client-a@turbo-seed.invalid',
    'Cliente A S2-T4',
    'regular'
  ),
  (
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    's2t4-client-b@turbo-seed.invalid',
    'Cliente B S2-T4',
    'regular'
  )
ON CONFLICT (id) DO UPDATE SET
  email = EXCLUDED.email,
  display_name = EXCLUDED.display_name,
  role = EXCLUDED.role;

INSERT INTO public.places (
  id,
  name,
  address,
  description,
  rating,
  is_open,
  price_level,
  favorite_count,
  owner_ids
) VALUES (
  '550e8400-e29b-41d4-a716-446655440020'::uuid,
  'La Trattoria (S2-T4)',
  'Dirección seed — Turbo S2-T4',
  'Lugar de prueba generado por scripts/s2t4.',
  4.5,
  true,
  2,
  0,
  ARRAY['550e8400-e29b-41d4-a716-446655440013']::text[]
)
ON CONFLICT (id) DO UPDATE SET
  owner_ids = EXCLUDED.owner_ids,
  name = EXCLUDED.name,
  address = EXCLUDED.address,
  description = EXCLUDED.description,
  rating = EXCLUDED.rating,
  is_open = EXCLUDED.is_open,
  price_level = EXCLUDED.price_level;

-- Limpieza idempotente (UUIDs fijos namespace S2T4)
DELETE FROM analytics_traffic WHERE id IN (
    'a1b00002-0000-4000-8000-000000000001'::uuid,
    'a1b00010-0000-4000-8000-000000000001'::uuid,
    'a1b00010-0000-4000-8000-000000000002'::uuid,
    'a1b00010-0000-4000-8000-000000000003'::uuid,
    'a1b00010-0000-4000-8000-000000000004'::uuid,
    'a1b00010-0000-4000-8000-000000000005'::uuid
);
DELETE FROM analytics_reviews WHERE id = 'a1b00003-0000-4000-8000-000000000001'::uuid;
DELETE FROM analytics_realtime WHERE id = 'a1b00004-0000-4000-8000-000000000001'::uuid;
DELETE FROM analytics_content WHERE id = 'a1b00005-0000-4000-8000-000000000001'::uuid;
DELETE FROM analytics_places WHERE id = 'a1b00001-0000-4000-8000-000000000001'::uuid;

DELETE FROM reservations WHERE id IN (
    'a1b00006-0000-4000-8000-000000000001'::uuid,
    'a1b00006-0000-4000-8000-000000000002'::uuid,
    'a1b00006-0000-4000-8000-000000000003'::uuid
);

INSERT INTO analytics_places (
    id, place_id, place_name, total_views, unique_visitors, total_conversions,
    average_rating, total_reviews, total_favorites, conversion_rate, total_events,
    avg_session_duration, created_at, updated_at
) VALUES (
    'a1b00001-0000-4000-8000-000000000001'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'La Trattoria (S2-T4 seed)',
    1250, 420, 18,
    4.60, 32, 88, 3.25, 12,
    4.50,
    now(), now()
);

INSERT INTO analytics_traffic (
    id, place_id, type, hour, date, timestamp, views, unique_visitors,
    interactions, conversions, new_reviews, new_favorites, avg_rating, created_at
) VALUES (
    'a1b00002-0000-4000-8000-000000000001'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'daily',
    NULL,
    current_date,
    date_trunc('day', now() AT TIME ZONE 'utc'),
    120, 45, 8, 1, 2, 1, 4.5, now()
);

INSERT INTO analytics_traffic (
    id, place_id, type, hour, date, timestamp, views, unique_visitors,
    interactions, conversions, new_reviews, new_favorites, avg_rating, created_at
) VALUES
(
    'a1b00010-0000-4000-8000-000000000001'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'hourly',
    10,
    current_date,
    date_trunc('day', now() AT TIME ZONE 'utc') + interval '10 hours',
    22, 9, 2, 0, 0, 0, 4.3, now()
),
(
    'a1b00010-0000-4000-8000-000000000002'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'hourly',
    11,
    current_date,
    date_trunc('day', now() AT TIME ZONE 'utc') + interval '11 hours',
    28, 11, 3, 0, 0, 0, 4.4, now()
),
(
    'a1b00010-0000-4000-8000-000000000003'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'hourly',
    12,
    current_date,
    date_trunc('day', now() AT TIME ZONE 'utc') + interval '12 hours',
    35, 14, 4, 0, 1, 0, 4.5, now()
),
(
    'a1b00010-0000-4000-8000-000000000004'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'hourly',
    13,
    current_date,
    date_trunc('day', now() AT TIME ZONE 'utc') + interval '13 hours',
    40, 16, 5, 0, 0, 0, 4.4, now()
),
(
    'a1b00010-0000-4000-8000-000000000005'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'hourly',
    14,
    current_date,
    date_trunc('day', now() AT TIME ZONE 'utc') + interval '14 hours',
    31, 12, 3, 0, 0, 0, 4.2, now()
);

INSERT INTO analytics_reviews (
    id, place_id, period, total_reviews, average_rating, rating_distribution,
    top_keywords, top_complaints, top_praises, sentiment_analysis, this_week_reviews, calculated_at
) VALUES (
    'a1b00003-0000-4000-8000-000000000001'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    format('month_%s_%s', extract(year from current_date)::int, extract(month from current_date)::int),
    28, 4.55,
    '{"1":0,"2":0,"3":2,"4":10,"5":16}'::jsonb,
    ARRAY['comida', 'servicio', 'vista'],
    ARRAY['espera'],
    ARRAY['excelente', 'recomendado'],
    '{"positiveScore":0.72,"neutralScore":0.18,"negativeScore":0.10,"trend":"stable","positiveKeywords":[],"negativeKeywords":[]}'::jsonb,
    4,
    now()
);

INSERT INTO analytics_realtime (
    id, place_id, active_users, current_sessions, last_updated, created_at
) VALUES (
    'a1b00004-0000-4000-8000-000000000001'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    3, 2, now(), now()
);

INSERT INTO analytics_content (
    id, place_id, top_categories, top_products, top_services, top_offers, top_search_terms, updated_at
) VALUES (
    'a1b00005-0000-4000-8000-000000000001'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    '[{"id":"c1","name":"Pasta","count":12,"percentage":35.0}]'::jsonb,
    '[{"id":"p1","name":"Lasagna","count":6,"percentage":18.0}]'::jsonb,
    '[{"id":"s1","name":"Cena","count":8,"percentage":22.0}]'::jsonb,
    '[]'::jsonb,
    '[{"id":"q1","name":"pizza","count":5,"percentage":15.0}]'::jsonb,
    now()
);

-- Reservas de ejemplo (últimos 30 días) para el KPI del Admin vía ReservationRepository
INSERT INTO reservations (
    id, place_id, place_name, user_id, reservation_date, start_time, end_time,
    party_size, status, customer_name, customer_email, customer_phone,
    confirmation_code, special_requests
) VALUES
(
    'a1b00006-0000-4000-8000-000000000001'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'La Trattoria',
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    CURRENT_DATE - 3,
    (CURRENT_DATE - 3 + TIME '20:00')::timestamp,
    (CURRENT_DATE - 3 + TIME '22:30')::timestamp,
    4, 'confirmed', 'Cliente Seed S2T4 A', 'seed-a@example.com', '+53000000001',
    'S2T4-RES-001', 'Semilla S2-T4'
),
(
    'a1b00006-0000-4000-8000-000000000002'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'La Trattoria',
    '550e8400-e29b-41d4-a716-446655440012'::uuid,
    CURRENT_DATE - 12,
    (CURRENT_DATE - 12 + TIME '13:00')::timestamp,
    (CURRENT_DATE - 12 + TIME '15:00')::timestamp,
    2, 'completed', 'Cliente Seed S2T4 B', 'seed-b@example.com', '+53000000002',
    'S2T4-RES-002', NULL
),
(
    'a1b00006-0000-4000-8000-000000000003'::uuid,
    '550e8400-e29b-41d4-a716-446655440020'::uuid,
    'La Trattoria',
    '550e8400-e29b-41d4-a716-446655440011'::uuid,
    CURRENT_DATE - 25,
    (CURRENT_DATE - 25 + TIME '21:00')::timestamp,
    (CURRENT_DATE - 25 + TIME '23:00')::timestamp,
    3, 'pending', 'Cliente Seed S2T4 C', 'seed-c@example.com', NULL,
    'S2T4-RES-003', NULL
);

COMMIT;
