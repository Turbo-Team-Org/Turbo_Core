-- =============================================================================
-- S2-T4: usuario Auth (email/contraseña) alineado con el owner del seed de datos
-- Debe coincidir con public.users + places.owner_ids del seed principal.
-- SOLO entornos de desarrollo / un solo proyecto sin datos reales sensibles.
-- Ejecutar en Supabase SQL Editor con rol que pueda escribir en auth.* (postgres).
-- Requisitos:
-- 1) `migrate_business_owner_requests_for_core.sql` (una vez por proyecto).
-- 2) `seed_analytics_s2t4.sql` (public.users …013 y places …020).
-- =============================================================================

BEGIN;

-- Mismo UUID que places.owner_ids y public.users del seed S2-T4
INSERT INTO auth.users (
  id,
  instance_id,
  aud,
  role,
  email,
  encrypted_password,
  email_confirmed_at,
  raw_app_meta_data,
  raw_user_meta_data,
  created_at,
  updated_at
) VALUES (
  '550e8400-e29b-41d4-a716-446655440013'::uuid,
  '00000000-0000-0000-0000-000000000000'::uuid,
  'authenticated',
  'authenticated',
  's2t4-owner@turbo-seed.invalid',
  extensions.crypt('TurboS2t4Dev!', extensions.gen_salt('bf')),
  now(),
  '{"provider":"email","providers":["email"]}'::jsonb,
  '{}'::jsonb,
  now(),
  now()
)
ON CONFLICT (id) DO UPDATE SET
  email = EXCLUDED.email,
  encrypted_password = EXCLUDED.encrypted_password,
  email_confirmed_at = EXCLUDED.email_confirmed_at,
  raw_app_meta_data = EXCLUDED.raw_app_meta_data,
  updated_at = now();

INSERT INTO auth.identities (
  id,
  user_id,
  identity_data,
  provider,
  last_sign_in_at,
  created_at,
  updated_at,
  provider_id
) VALUES (
  gen_random_uuid(),
  '550e8400-e29b-41d4-a716-446655440013'::uuid,
  jsonb_build_object(
    'sub', '550e8400-e29b-41d4-a716-446655440013',
    'email', 's2t4-owner@turbo-seed.invalid',
    'email_verified', true,
    'phone_verified', false
  ),
  'email',
  now(),
  now(),
  now(),
  '550e8400-e29b-41d4-a716-446655440013'::text
)
ON CONFLICT (provider_id, provider) DO UPDATE SET
  user_id = EXCLUDED.user_id,
  identity_data = EXCLUDED.identity_data,
  last_sign_in_at = EXCLUDED.last_sign_in_at,
  updated_at = EXCLUDED.updated_at;

-- Login unificado (Core): fila en business_owner_requests con user_id = auth.uid()
DELETE FROM public.business_owner_requests
WHERE id = 'a1b00007-0000-4000-8000-000000000001'::uuid;

INSERT INTO public.business_owner_requests (
  id,
  user_id,
  email,
  display_name,
  business_name,
  owner_name,
  phone,
  phone_number,
  address,
  business_address,
  description,
  business_description,
  status,
  business_metadata,
  contact_info,
  approved_at,
  created_at,
  updated_at
) VALUES (
  'a1b00007-0000-4000-8000-000000000001'::uuid,
  '550e8400-e29b-41d4-a716-446655440013'::uuid,
  's2t4-owner@turbo-seed.invalid',
  'Owner S2T4 seed',
  'La Trattoria (S2-T4)',
  'Owner S2T4 seed',
  NULL,
  NULL,
  'Dirección seed — Turbo S2-T4',
  'Dirección seed — Turbo S2-T4',
  'Solicitud semilla S2-T4',
  'Solicitud semilla S2-T4',
  'approved',
  '{}'::jsonb,
  '{}'::jsonb,
  now(),
  now(),
  now()
);

COMMIT;
