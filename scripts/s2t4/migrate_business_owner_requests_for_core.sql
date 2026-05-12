-- =============================================================================
-- Alinea public.business_owner_requests con AdminAuthServiceSupabase (Core).
-- Ejecutar UNA VEZ por proyecto (SQL Editor / MCP). Idempotente con IF NOT EXISTS.
-- Tabla legada: owner_name, phone, address, description → también columnas Core.
-- =============================================================================

BEGIN;

ALTER TABLE public.business_owner_requests
  ADD COLUMN IF NOT EXISTS user_id uuid REFERENCES auth.users (id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS display_name character varying,
  ADD COLUMN IF NOT EXISTS business_description text,
  ADD COLUMN IF NOT EXISTS business_address character varying,
  ADD COLUMN IF NOT EXISTS phone_number character varying,
  ADD COLUMN IF NOT EXISTS website character varying,
  ADD COLUMN IF NOT EXISTS business_metadata jsonb DEFAULT '{}'::jsonb,
  ADD COLUMN IF NOT EXISTS contact_info jsonb DEFAULT '{}'::jsonb,
  ADD COLUMN IF NOT EXISTS approved_by uuid,
  ADD COLUMN IF NOT EXISTS approved_at timestamptz,
  ADD COLUMN IF NOT EXISTS approval_notes text,
  ADD COLUMN IF NOT EXISTS rejected_by uuid,
  ADD COLUMN IF NOT EXISTS rejected_at timestamptz,
  ADD COLUMN IF NOT EXISTS updated_by uuid,
  ADD COLUMN IF NOT EXISTS status_notes text;

UPDATE public.business_owner_requests
SET
  display_name = COALESCE(display_name, owner_name),
  business_description = COALESCE(business_description, description, ''),
  business_address = COALESCE(business_address, address, ''),
  phone_number = COALESCE(phone_number, phone)
WHERE display_name IS NULL
   OR business_description IS NULL
   OR business_address IS NULL
   OR phone_number IS NULL;

COMMIT;
