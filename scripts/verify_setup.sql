-- =====================================================
-- VERIFICATION SCRIPT - Turbo Core Supabase Setup
-- =====================================================

-- Verificar que todas las tablas se crearon correctamente
SELECT 
    table_name,
    CASE 
        WHEN table_name IN (
            'users', 'categories', 'places', 'reviews', 'favorites', 
            'events', 'place_categories', 'place_locations', 'admin_users', 
            'business_owner_requests', 'analytics_places', 'analytics_traffic',
            'analytics_reviews', 'analytics_events', 'analytics_realtime',
            'analytics_content', 'reservations', 'business_availability',
            'reservation_settings', 'reservation_time_slots', 'offers',
            'notifications', 'province', 'municipality'
        ) THEN '✅ EXPECTED'
        ELSE '❌ UNEXPECTED'
    END as status
FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- Verificar datos de muestra insertados
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
SELECT 'Business Requests', COUNT(*) FROM business_owner_requests
UNION ALL
SELECT 'Offers', COUNT(*) FROM offers
UNION ALL
SELECT 'Notifications', COUNT(*) FROM notifications
UNION ALL
SELECT 'Province', COUNT(*) FROM province
UNION ALL
SELECT 'Municipality', COUNT(*) FROM municipality;

-- Verificar que las funciones se crearon
SELECT 
    routine_name,
    CASE 
        WHEN routine_name IN (
            'increment_category_places_count', 'decrement_category_places_count',
            'update_updated_at_column', 'update_place_rating', 'trigger_update_place_rating'
        ) THEN '✅ EXPECTED'
        ELSE '❌ UNEXPECTED'
    END as status
FROM information_schema.routines 
WHERE routine_schema = 'public' 
AND routine_type = 'FUNCTION'
ORDER BY routine_name;

-- Verificar que los triggers se crearon
SELECT 
    trigger_name,
    event_object_table,
    CASE 
        WHEN trigger_name LIKE 'update_%_updated_at' OR trigger_name = 'reviews_update_place_rating'
        THEN '✅ EXPECTED'
        ELSE '❌ UNEXPECTED'
    END as status
FROM information_schema.triggers 
WHERE trigger_schema = 'public'
ORDER BY trigger_name;

-- Verificar RLS habilitado en tablas sensibles
SELECT 
    schemaname,
    tablename,
    rowsecurity,
    CASE 
        WHEN tablename IN ('users', 'admin_users', 'business_owner_requests', 'notifications', 'reservations')
        AND rowsecurity = true THEN '✅ RLS ENABLED'
        WHEN tablename IN ('users', 'admin_users', 'business_owner_requests', 'notifications', 'reservations')
        AND rowsecurity = false THEN '❌ RLS DISABLED'
        ELSE 'ℹ️ RLS NOT REQUIRED'
    END as rls_status
FROM pg_tables 
WHERE schemaname = 'public'
AND tablename IN ('users', 'admin_users', 'business_owner_requests', 'notifications', 'reservations')
ORDER BY tablename;

-- Verificar políticas RLS
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

-- Mostrar resumen final
DO $$
DECLARE
    table_count INTEGER;
    function_count INTEGER;
    trigger_count INTEGER;
    policy_count INTEGER;
BEGIN
    -- Contar tablas
    SELECT COUNT(*) INTO table_count
    FROM information_schema.tables 
    WHERE table_schema = 'public' 
    AND table_type = 'BASE TABLE';
    
    -- Contar funciones
    SELECT COUNT(*) INTO function_count
    FROM information_schema.routines 
    WHERE routine_schema = 'public' 
    AND routine_type = 'FUNCTION';
    
    -- Contar triggers
    SELECT COUNT(*) INTO trigger_count
    FROM information_schema.triggers 
    WHERE trigger_schema = 'public';
    
    -- Contar políticas
    SELECT COUNT(*) INTO policy_count
    FROM pg_policies 
    WHERE schemaname = 'public';
    
    RAISE NOTICE '=====================================================';
    RAISE NOTICE 'VERIFICATION SUMMARY';
    RAISE NOTICE '=====================================================';
    RAISE NOTICE 'Tables created: %', table_count;
    RAISE NOTICE 'Functions created: %', function_count;
    RAISE NOTICE 'Triggers created: %', trigger_count;
    RAISE NOTICE 'RLS Policies created: %', policy_count;
    RAISE NOTICE '=====================================================';
    
    IF table_count >= 24 THEN
        RAISE NOTICE '✅ SETUP COMPLETED SUCCESSFULLY!';
    ELSE
        RAISE NOTICE '❌ SETUP INCOMPLETE - Missing tables';
    END IF;
    
    RAISE NOTICE '=====================================================';
END $$; 