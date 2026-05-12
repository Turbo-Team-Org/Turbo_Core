-- =============================================================================
-- S2-T4: revierte solo el usuario Auth del owner seed (…440013 + email).
-- Orden: identities primero (FK hacia auth.users).
-- NO ejecutar en producción si ese UUID ya es un usuario real.
-- =============================================================================

BEGIN;

DELETE FROM public.business_owner_requests
WHERE id = 'a1b00007-0000-4000-8000-000000000001'::uuid
   OR user_id = '550e8400-e29b-41d4-a716-446655440013'::uuid;

DELETE FROM auth.identities
WHERE provider = 'email'
  AND provider_id = '550e8400-e29b-41d4-a716-446655440013';

DELETE FROM auth.users
WHERE id = '550e8400-e29b-41d4-a716-446655440013'::uuid;

COMMIT;
