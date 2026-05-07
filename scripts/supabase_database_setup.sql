-- =====================================================
-- SUPABASE DATABASE SETUP SCRIPT
-- Turbo Platform - Firebase to Supabase Migration
-- =====================================================

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pgcrypto";

-- =====================================================
-- CORE TABLES
-- =====================================================

-- 1. Users Table
CREATE TABLE IF NOT EXISTS users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    email VARCHAR NOT NULL UNIQUE,
    display_name VARCHAR,
    photo_url VARCHAR,
    phone_number VARCHAR,
    auth_provider VARCHAR DEFAULT 'email',
    role VARCHAR DEFAULT 'regular',
    favorites INTEGER[] DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for users
CREATE INDEX IF NOT EXISTS idx_users_email ON users(email);
CREATE INDEX IF NOT EXISTS idx_users_role ON users(role);

-- 2. Categories Table
CREATE TABLE IF NOT EXISTS categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    description TEXT,
    icon VARCHAR,
    color VARCHAR,
    is_active BOOLEAN DEFAULT true,
    sort_order INTEGER DEFAULT 0,
    places_count INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for categories
CREATE INDEX IF NOT EXISTS idx_categories_active ON categories(is_active);
CREATE INDEX IF NOT EXISTS idx_categories_sort ON categories(sort_order);

-- 3. Places Table
CREATE TABLE IF NOT EXISTS places (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    name VARCHAR NOT NULL,
    description TEXT,
    address VARCHAR NOT NULL,
    average_price DECIMAL(10,2) DEFAULT 0,
    image_urls TEXT[] DEFAULT '{}',
    rating DECIMAL(3,2) DEFAULT 0,
    tags TEXT[] DEFAULT '{}',
    is_open BOOLEAN DEFAULT false,
    main_image VARCHAR,
    favorite_count INTEGER DEFAULT 0,
    menu_url VARCHAR,
    latitude DECIMAL(10,8) DEFAULT 0,
    longitude DECIMAL(11,8) DEFAULT 0,
    category_id UUID REFERENCES categories(id),
    category_name VARCHAR,
    category_icon VARCHAR,
    opening_hours JSONB DEFAULT '{}',
    phone VARCHAR,
    website VARCHAR,
    price_level INTEGER DEFAULT 0,
    metadata JSONB DEFAULT '{}',
    owner_ids TEXT[] DEFAULT '{}',
    created_by UUID,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for places
CREATE INDEX IF NOT EXISTS idx_places_category ON places(category_id);
CREATE INDEX IF NOT EXISTS idx_places_location ON places(latitude, longitude);
CREATE INDEX IF NOT EXISTS idx_places_rating ON places(rating);
CREATE INDEX IF NOT EXISTS idx_places_owner_ids ON places USING GIN(owner_ids);

-- 4. Reviews Table
CREATE TABLE IF NOT EXISTS reviews (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    user_name VARCHAR,
    user_photo_url VARCHAR,
    rating DECIMAL(2,1) NOT NULL CHECK (rating >= 0 AND rating <= 5),
    comment TEXT,
    status VARCHAR DEFAULT 'pending',
    moderator_id UUID REFERENCES users(id),
    moderation_note TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for reviews
CREATE INDEX IF NOT EXISTS idx_reviews_place ON reviews(place_id);
CREATE INDEX IF NOT EXISTS idx_reviews_user ON reviews(user_id);
CREATE INDEX IF NOT EXISTS idx_reviews_status ON reviews(status);
CREATE INDEX IF NOT EXISTS idx_reviews_rating ON reviews(rating);

-- 5. Favorites Table
CREATE TABLE IF NOT EXISTS favorites (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, place_id)
);

-- Indexes for favorites
CREATE INDEX IF NOT EXISTS idx_favorites_user ON favorites(user_id);
CREATE INDEX IF NOT EXISTS idx_favorites_place ON favorites(place_id);

-- 6. Events Table
CREATE TABLE IF NOT EXISTS events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    title VARCHAR NOT NULL,
    description TEXT,
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    event_date TIMESTAMP WITH TIME ZONE NOT NULL,
    event_type VARCHAR DEFAULT 'general',
    is_highlighted BOOLEAN DEFAULT false,
    image_url VARCHAR,
    price DECIMAL(10,2) DEFAULT 0,
    capacity INTEGER DEFAULT 0,
    attendees INTEGER DEFAULT 0,
    tags TEXT[] DEFAULT '{}',
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for events
CREATE INDEX IF NOT EXISTS idx_events_place ON events(place_id);
CREATE INDEX IF NOT EXISTS idx_events_date ON events(event_date);
CREATE INDEX IF NOT EXISTS idx_events_type ON events(event_type);
CREATE INDEX IF NOT EXISTS idx_events_highlighted ON events(is_highlighted);

-- 7. Place Categories Junction Table
CREATE TABLE IF NOT EXISTS place_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(place_id, category_id)
);

-- Indexes for place_categories
CREATE INDEX IF NOT EXISTS idx_place_categories_place ON place_categories(place_id);
CREATE INDEX IF NOT EXISTS idx_place_categories_category ON place_categories(category_id);

-- 8. Place Locations Table
CREATE TABLE IF NOT EXISTS place_locations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    latitude DECIMAL(10,8) NOT NULL,
    longitude DECIMAL(11,8) NOT NULL,
    address VARCHAR,
    formatted_address VARCHAR,
    google_place_id VARCHAR,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for place_locations
CREATE INDEX IF NOT EXISTS idx_place_locations_place ON place_locations(place_id);
CREATE INDEX IF NOT EXISTS idx_place_locations_coords ON place_locations(latitude, longitude);

-- =====================================================
-- ADMIN TABLES
-- =====================================================

-- 9. Admin Users Table
CREATE TABLE IF NOT EXISTS admin_users (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    uid VARCHAR NOT NULL UNIQUE,
    email VARCHAR NOT NULL UNIQUE,
    display_name VARCHAR NOT NULL,
    role VARCHAR NOT NULL,
    is_active BOOLEAN DEFAULT true,
    owned_place_ids TEXT[] DEFAULT '{}',
    last_login TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for admin_users
CREATE INDEX IF NOT EXISTS idx_admin_users_uid ON admin_users(uid);
CREATE INDEX IF NOT EXISTS idx_admin_users_email ON admin_users(email);
CREATE INDEX IF NOT EXISTS idx_admin_users_role ON admin_users(role);

-- 10. Business Owner Requests Table
CREATE TABLE IF NOT EXISTS business_owner_requests (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    business_name VARCHAR NOT NULL,
    owner_name VARCHAR NOT NULL,
    email VARCHAR NOT NULL,
    phone VARCHAR,
    address VARCHAR,
    description TEXT,
    status VARCHAR DEFAULT 'pending',
    rejection_reason TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for business_owner_requests
CREATE INDEX IF NOT EXISTS idx_business_requests_status ON business_owner_requests(status);
CREATE INDEX IF NOT EXISTS idx_business_requests_email ON business_owner_requests(email);

-- =====================================================
-- POSTGRESQL FUNCTIONS
-- =====================================================

-- 1. Category Places Count Functions
CREATE OR REPLACE FUNCTION increment_category_places_count(category_id UUID)
RETURNS void AS $$
BEGIN
    UPDATE categories
    SET places_count = places_count + 1,
        updated_at = NOW()
    WHERE id = category_id;
END;
$$ LANGUAGE plpgsql;

CREATE OR REPLACE FUNCTION decrement_category_places_count(category_id UUID)
RETURNS void AS $$
BEGIN
    UPDATE categories
    SET places_count = GREATEST(places_count - 1, 0),
        updated_at = NOW()
    WHERE id = category_id;
END;
$$ LANGUAGE plpgsql;

-- 2. Automatic Timestamp Updates
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- 3. Update Place Rating Function
CREATE OR REPLACE FUNCTION update_place_rating(place_id UUID)
RETURNS void AS $$
DECLARE
    avg_rating DECIMAL(3,2);
BEGIN
    SELECT AVG(rating) INTO avg_rating
    FROM reviews
    WHERE reviews.place_id = update_place_rating.place_id
    AND status = 'approved';

    UPDATE places
    SET rating = COALESCE(avg_rating, 0),
        updated_at = NOW()
    WHERE id = place_id;
END;
$$ LANGUAGE plpgsql;

-- 4. Trigger function for place rating updates
CREATE OR REPLACE FUNCTION trigger_update_place_rating()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'INSERT' OR TG_OP = 'UPDATE' THEN
        PERFORM update_place_rating(NEW.place_id);
        RETURN NEW;
    ELSIF TG_OP = 'DELETE' THEN
        PERFORM update_place_rating(OLD.place_id);
        RETURN OLD;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- =====================================================
-- TRIGGERS
-- =====================================================

-- Automatic timestamp updates
CREATE TRIGGER update_users_updated_at 
    BEFORE UPDATE ON users 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_categories_updated_at 
    BEFORE UPDATE ON categories 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_places_updated_at 
    BEFORE UPDATE ON places 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reviews_updated_at 
    BEFORE UPDATE ON reviews 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_events_updated_at 
    BEFORE UPDATE ON events 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_admin_users_updated_at 
    BEFORE UPDATE ON admin_users 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_business_owner_requests_updated_at 
    BEFORE UPDATE ON business_owner_requests 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_place_locations_updated_at 
    BEFORE UPDATE ON place_locations 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

-- Place rating updates when reviews change
CREATE TRIGGER reviews_update_place_rating
    AFTER INSERT OR UPDATE OR DELETE ON reviews
    FOR EACH ROW EXECUTE FUNCTION trigger_update_place_rating();

-- =====================================================
-- ROW LEVEL SECURITY (RLS)
-- =====================================================

-- Enable RLS on sensitive tables
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE business_owner_requests ENABLE ROW LEVEL SECURITY;

-- Policy for users to only see their own data
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid()::text = id::text);

CREATE POLICY "Users can update own profile" ON users
    FOR UPDATE USING (auth.uid()::text = id::text);

CREATE POLICY "Users can insert own profile" ON users
    FOR INSERT WITH CHECK (auth.uid()::text = id::text);

-- Policy for admin users
CREATE POLICY "Admin users can view own profile" ON admin_users
    FOR SELECT USING (auth.uid()::text = uid);

CREATE POLICY "Admin users can update own profile" ON admin_users
    FOR UPDATE USING (auth.uid()::text = uid);

-- Policy for business owner requests
CREATE POLICY "Users can create business owner requests" ON business_owner_requests
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Admin users can view all requests" ON business_owner_requests
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM admin_users
            WHERE uid = auth.uid()::text
            AND is_active = true
        )
    );

-- =====================================================
-- SAMPLE DATA INSERTION
-- =====================================================

-- Insert sample categories
INSERT INTO categories (id, name, description, icon, color, sort_order) VALUES
('550e8400-e29b-41d4-a716-446655440001', 'Restaurantes', 'Los mejores restaurantes de la ciudad', '🍽️', '#FF6B6B', 1),
('550e8400-e29b-41d4-a716-446655440002', 'Cafeterías', 'Cafeterías y bistros acogedores', '☕', '#4ECDC4', 2),
('550e8400-e29b-41d4-a716-446655440003', 'Bares', 'Bares y pubs para disfrutar', '🍺', '#45B7D1', 3),
('550e8400-e29b-41d4-a716-446655440004', 'Hoteles', 'Hoteles y alojamientos', '🏨', '#96CEB4', 4),
('550e8400-e29b-41d4-a716-446655440005', 'Entretenimiento', 'Actividades y entretenimiento', '🎭', '#FFEAA7', 5)
ON CONFLICT (id) DO NOTHING;

-- Insert sample users
INSERT INTO users (id, email, display_name, role) VALUES
('550e8400-e29b-41d4-a716-446655440010', 'admin@turbo.com', 'Admin Turbo', 'admin'),
('550e8400-e29b-41d4-a716-446655440011', 'user1@example.com', 'Juan Pérez', 'regular'),
('550e8400-e29b-41d4-a716-446655440012', 'user2@example.com', 'María García', 'regular'),
('550e8400-e29b-41d4-a716-446655440013', 'owner1@example.com', 'Carlos López', 'business_owner')
ON CONFLICT (id) DO NOTHING;

-- Insert sample places
INSERT INTO places (id, name, description, address, category_id, category_name, category_icon, latitude, longitude, rating, price_level, is_open) VALUES
('550e8400-e29b-41d4-a716-446655440020', 'La Trattoria', 'Restaurante italiano auténtico', 'Calle Principal 123', '550e8400-e29b-41d4-a716-446655440001', 'Restaurantes', '🍽️', 40.4168, -3.7038, 4.5, 2, true),
('550e8400-e29b-41d4-a716-446655440021', 'Café Central', 'Cafetería con ambiente acogedor', 'Plaza Mayor 45', '550e8400-e29b-41d4-a716-446655440002', 'Cafeterías', '☕', 40.4155, -3.7074, 4.2, 1, true),
('550e8400-e29b-41d4-a716-446655440022', 'Bar El Rincón', 'Bar tradicional con tapas', 'Calle Pequeña 67', '550e8400-e29b-41d4-a716-446655440003', 'Bares', '🍺', 40.4175, -3.7045, 4.0, 1, true),
('550e8400-e29b-41d4-a716-446655440023', 'Hotel Gran Plaza', 'Hotel de lujo en el centro', 'Gran Vía 100', '550e8400-e29b-41d4-a716-446655440004', 'Hoteles', '🏨', 40.4190, -3.7050, 4.8, 4, true),
('550e8400-e29b-41d4-a716-446655440024', 'Teatro Real', 'Teatro histórico de la ciudad', 'Plaza de Oriente 1', '550e8400-e29b-41d4-a716-446655440005', 'Entretenimiento', '🎭', 40.4185, -3.7060, 4.7, 3, true)
ON CONFLICT (id) DO NOTHING;

-- Insert sample place locations
INSERT INTO place_locations (place_id, latitude, longitude, address, formatted_address) VALUES
('550e8400-e29b-41d4-a716-446655440020', 40.4168, -3.7038, 'Calle Principal 123', 'Calle Principal, 123, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440021', 40.4155, -3.7074, 'Plaza Mayor 45', 'Plaza Mayor, 45, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440022', 40.4175, -3.7045, 'Calle Pequeña 67', 'Calle Pequeña, 67, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440023', 40.4190, -3.7050, 'Gran Vía 100', 'Gran Vía, 100, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440024', 40.4185, -3.7060, 'Plaza de Oriente 1', 'Plaza de Oriente, 1, Madrid, España')
ON CONFLICT (place_id) DO NOTHING;

-- Insert sample reviews
INSERT INTO reviews (place_id, user_id, user_name, rating, comment, status) VALUES
('550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440011', 'Juan Pérez', 5.0, 'Excelente comida italiana, muy auténtica', 'approved'),
('550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440012', 'María García', 4.0, 'Buen ambiente y servicio rápido', 'approved'),
('550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440011', 'Juan Pérez', 4.5, 'Café delicioso y ambiente acogedor', 'approved'),
('550e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440012', 'María García', 4.0, 'Buenas tapas y ambiente tradicional', 'approved'),
('550e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440011', 'Juan Pérez', 5.0, 'Hotel de lujo con excelente servicio', 'approved')
ON CONFLICT DO NOTHING;

-- Insert sample favorites
INSERT INTO favorites (user_id, place_id) VALUES
('550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440021'),
('550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440022'),
('550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440023')
ON CONFLICT (user_id, place_id) DO NOTHING;

-- Insert sample events
INSERT INTO events (title, description, place_id, event_date, event_type, is_highlighted, price) VALUES
('Noche de Jazz', 'Concierto de jazz en vivo', '550e8400-e29b-41d4-a716-446655440022', NOW() + INTERVAL '7 days', 'music', true, 25.00),
('Cena de Gala', 'Cena especial con menú degustación', '550e8400-e29b-41d4-a716-446655440020', NOW() + INTERVAL '14 days', 'food', true, 75.00),
('Exposición de Arte', 'Exposición de artistas locales', '550e8400-e29b-41d4-a716-446655440024', NOW() + INTERVAL '3 days', 'culture', false, 15.00),
('Taller de Café', 'Aprende a preparar café artesanal', '550e8400-e29b-41d4-a716-446655440021', NOW() + INTERVAL '10 days', 'workshop', false, 30.00)
ON CONFLICT DO NOTHING;

-- Insert sample admin users
INSERT INTO admin_users (uid, email, display_name, role, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440010', 'admin@turbo.com', 'Admin Turbo', 'superAdmin', true),
('550e8400-e29b-41d4-a716-446655440013', 'owner1@example.com', 'Carlos López', 'placeOwner', true)
ON CONFLICT (uid) DO NOTHING;

-- Insert sample business owner requests
INSERT INTO business_owner_requests (business_name, owner_name, email, phone, address, description, status) VALUES
('Restaurante Nuevo', 'Ana Martínez', 'ana@example.com', '+34 600 123 456', 'Calle Nueva 50', 'Restaurante de comida mediterránea', 'pending'),
('Cafetería Moderna', 'Luis Rodríguez', 'luis@example.com', '+34 600 654 321', 'Avenida Central 200', 'Cafetería con concepto moderno', 'pending')
ON CONFLICT DO NOTHING;

-- Update category places count
UPDATE categories SET places_count = (
    SELECT COUNT(*) FROM places WHERE category_id = categories.id
);

-- =====================================================
-- VERIFICATION QUERIES
-- =====================================================

-- Verify tables were created
SELECT table_name FROM information_schema.tables 
WHERE table_schema = 'public' 
AND table_type = 'BASE TABLE'
ORDER BY table_name;

-- Verify sample data
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

-- =====================================================
-- SETUP COMPLETE
-- =====================================================

-- Display completion message
DO $$
BEGIN
    RAISE NOTICE '=====================================================';
    RAISE NOTICE 'SUPABASE DATABASE SETUP COMPLETED SUCCESSFULLY!';
    RAISE NOTICE '=====================================================';
    RAISE NOTICE '';
    RAISE NOTICE '✅ All tables created with proper indexes';
    RAISE NOTICE '✅ All functions and triggers configured';
    RAISE NOTICE '✅ Row Level Security policies enabled';
    RAISE NOTICE '✅ Sample data inserted for testing';
    RAISE NOTICE '';
    RAISE NOTICE '🎉 Your Turbo Platform database is ready!';
    RAISE NOTICE '=====================================================';
END $$; 