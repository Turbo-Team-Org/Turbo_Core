-- =============================================================================
-- S2-T4 cleanup: elimina filas sembradas por seed_analytics_s2t4.sql
-- No borra el lugar ni reviews de ejemplo; solo analytics_* y reservas S2-T4 con UUIDs fijos.
-- Opcional: revierte owner_ids del lugar de ejemplo (comenta si no quieres).
-- =============================================================================

BEGIN;

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

-- Opcional: quitar owner de prueba del lugar de ejemplo
-- UPDATE places SET owner_ids = '{}'::text[]
-- WHERE id = '550e8400-e29b-41d4-a716-446655440020';

COMMIT;
