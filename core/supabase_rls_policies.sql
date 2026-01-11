-- =====================================================
-- TURBO PLATFORM - RLS POLICIES (CORREGIDO)
-- =====================================================
-- Aplicar estas policies en Supabase SQL Editor
-- CORREGIDO: Nombres de tablas y campos según esquema real

-- =====================================================
-- 🌍 TABLAS PÚBLICAS (READ-ONLY)
-- =====================================================

-- PLACES: Todos pueden ver lugares, solo admins pueden modificar
ALTER TABLE places ENABLE ROW LEVEL SECURITY;

-- Policy: Todos pueden leer lugares
CREATE POLICY "places_public_read" ON places
  FOR SELECT USING (true);

-- Policy: Solo usuarios autenticados pueden insertar
CREATE POLICY "places_auth_insert" ON places
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Policy: Solo el owner o admins pueden actualizar
CREATE POLICY "places_owner_update" ON places
  FOR UPDATE USING (
    auth.uid()::text = ANY(owner_ids) OR 
    auth.role() = 'service_role'
  );

-- Policy: Solo el owner o admins pueden eliminar
CREATE POLICY "places_owner_delete" ON places
  FOR DELETE USING (
    auth.uid()::text = ANY(owner_ids) OR 
    auth.role() = 'service_role'
  );

-- =====================================================

-- CATEGORIES: Todos pueden ver categorías, solo admins pueden modificar
ALTER TABLE categories ENABLE ROW LEVEL SECURITY;

-- Policy: Todos pueden leer categorías
CREATE POLICY "categories_public_read" ON categories
  FOR SELECT USING (true);

-- Policy: Solo service role puede modificar categorías
CREATE POLICY "categories_admin_write" ON categories
  FOR ALL USING (auth.role() = 'service_role');

-- =====================================================

-- REVIEWS: Todos pueden ver reseñas, solo el autor puede modificar
ALTER TABLE reviews ENABLE ROW LEVEL SECURITY;

-- Policy: Todos pueden leer reseñas
CREATE POLICY "reviews_public_read" ON reviews
  FOR SELECT USING (true);

-- Policy: Usuarios autenticados pueden crear reseñas
CREATE POLICY "reviews_auth_insert" ON reviews
  FOR INSERT WITH CHECK (auth.role() = 'authenticated');

-- Policy: Solo el autor puede actualizar su reseña
-- CORREGIDO: Campo user_id es UUID, convertir a text para comparación
CREATE POLICY "reviews_author_update" ON reviews
  FOR UPDATE USING (auth.uid()::text = user_id::text);

-- Policy: Solo el autor o admin puede eliminar reseña
-- CORREGIDO: Campo user_id es UUID, convertir a text para comparación
CREATE POLICY "reviews_author_delete" ON reviews
  FOR DELETE USING (
    auth.uid()::text = user_id::text OR 
    auth.role() = 'service_role'
  );

-- =====================================================
-- 👤 TABLAS PRIVADAS (USER-SPECIFIC)
-- =====================================================

-- FAVORITES: Solo el usuario puede ver y modificar sus favoritos
ALTER TABLE favorites ENABLE ROW LEVEL SECURITY;

-- Policy: Solo el usuario puede ver sus favoritos
-- CORREGIDO: Campo user_id es UUID, convertir a text para comparación
CREATE POLICY "favorites_user_access" ON favorites
  FOR ALL USING (auth.uid()::text = user_id::text);

-- =====================================================

-- EVENTS: Todos pueden ver eventos, solo admins pueden modificar
ALTER TABLE events ENABLE ROW LEVEL SECURITY;

-- Policy: Todos pueden leer eventos
CREATE POLICY "events_public_read" ON events
  FOR SELECT USING (true);

-- Policy: Solo service role puede modificar eventos
CREATE POLICY "events_admin_write" ON events
  FOR ALL USING (auth.role() = 'service_role');

-- =====================================================
-- 🔐 TABLAS ADMIN (BUSINESS OWNERS)
-- =====================================================

-- ADMIN_USERS: Solo el usuario puede ver su propia info de admin
-- CORREGIDO: Tabla se llama admin_users, campo es auth_uid
ALTER TABLE admin_users ENABLE ROW LEVEL SECURITY;

-- Policy: Solo el usuario puede ver su propia info de admin
-- CORREGIDO: Campo auth_uid es UUID, convertir a text para comparación
CREATE POLICY "admin_users_self_access" ON admin_users
  FOR ALL USING (auth.uid()::text = auth_uid::text);

-- =====================================================
-- 📊 TABLAS DE JUNCIÓN
-- =====================================================

-- PLACE_CATEGORIES: Solo lectura pública
ALTER TABLE place_categories ENABLE ROW LEVEL SECURITY;

-- Policy: Todos pueden leer place_categories
CREATE POLICY "place_categories_public_read" ON place_categories
  FOR SELECT USING (true);

-- Policy: Solo service role puede modificar place_categories
CREATE POLICY "place_categories_admin_write" ON place_categories
  FOR ALL USING (auth.role() = 'service_role');

-- =====================================================
-- 🎉 VERIFICACIÓN DE POLICIES
-- =====================================================

-- Verificar que todas las policies están aplicadas
SELECT 
  schemaname,
  tablename,
  policyname,
  permissive,
  roles,
  cmd,
  qual
FROM pg_policies 
WHERE schemaname = 'public'
ORDER BY tablename, policyname;
