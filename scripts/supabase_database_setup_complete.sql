-- =====================================================
-- SUPABASE DATABASE SETUP SCRIPT - COMPLETO
-- Turbo Platform - Firebase to Supabase Migration
-- Incluye todas las tablas de la lógica de negocio
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

-- Unique constraint for conflict resolution (skip if exists)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'unique_users_id'
    ) THEN
        ALTER TABLE users ADD CONSTRAINT unique_users_id UNIQUE (id);
    END IF;
END $$;

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

-- Unique constraint for conflict resolution (skip if exists)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'unique_categories_id'
    ) THEN
        ALTER TABLE categories ADD CONSTRAINT unique_categories_id UNIQUE (id);
    END IF;
END $$;

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

-- Unique constraint for conflict resolution (skip if exists)
DO $$
BEGIN
    IF NOT EXISTS (
        SELECT 1 FROM pg_constraint 
        WHERE conname = 'unique_places_id'
    ) THEN
        ALTER TABLE places ADD CONSTRAINT unique_places_id UNIQUE (id);
    END IF;
END $$;

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

-- Unique constraint handled in UNIQUE CONSTRAINTS section below

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

-- Unique constraint handled in UNIQUE CONSTRAINTS section below

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

-- Unique constraint handled in UNIQUE CONSTRAINTS section below

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

-- Unique constraint handled in UNIQUE CONSTRAINTS section below

-- =====================================================
-- ANALYTICS TABLES
-- =====================================================

-- 11. Analytics Places (Resumen por lugar)
CREATE TABLE IF NOT EXISTS analytics_places (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    place_name VARCHAR,
    category_id UUID REFERENCES categories(id),
    category_name VARCHAR,
    address VARCHAR,
    total_views INTEGER DEFAULT 0,
    unique_visitors INTEGER DEFAULT 0,
    total_conversions INTEGER DEFAULT 0,
    average_rating DECIMAL(3,2) DEFAULT 0.0,
    total_reviews INTEGER DEFAULT 0,
    total_favorites INTEGER DEFAULT 0,
    conversion_rate DECIMAL(5,2) DEFAULT 0.0,
    total_events INTEGER DEFAULT 0,
    avg_session_duration DECIMAL(10,2) DEFAULT 0.0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for analytics_places
CREATE INDEX IF NOT EXISTS idx_analytics_places_place ON analytics_places(place_id);
CREATE INDEX IF NOT EXISTS idx_analytics_places_category ON analytics_places(category_id);
CREATE INDEX IF NOT EXISTS idx_analytics_places_views ON analytics_places(total_views);

-- Unique constraint handled in UNIQUE CONSTRAINTS section below

-- 12. Analytics Traffic (Datos de tráfico time-series)
CREATE TABLE IF NOT EXISTS analytics_traffic (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    type VARCHAR NOT NULL, -- 'hourly', 'daily', 'weekly', 'monthly'
    hour INTEGER, -- Para datos por hora (0-23)
    date DATE,
    timestamp TIMESTAMP WITH TIME ZONE,
    views INTEGER DEFAULT 0,
    unique_visitors INTEGER DEFAULT 0,
    interactions INTEGER DEFAULT 0,
    conversions INTEGER DEFAULT 0,
    new_reviews INTEGER DEFAULT 0,
    new_favorites INTEGER DEFAULT 0,
    avg_rating DECIMAL(3,2) DEFAULT 0.0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for analytics_traffic
CREATE INDEX IF NOT EXISTS idx_analytics_traffic_place ON analytics_traffic(place_id);
CREATE INDEX IF NOT EXISTS idx_analytics_traffic_type ON analytics_traffic(type);
CREATE INDEX IF NOT EXISTS idx_analytics_traffic_date ON analytics_traffic(date);
CREATE INDEX IF NOT EXISTS idx_analytics_traffic_timestamp ON analytics_traffic(timestamp);

-- Unique constraint handled in UNIQUE CONSTRAINTS section below

-- 13. Analytics Reviews (Analytics procesados de reviews)
CREATE TABLE IF NOT EXISTS analytics_reviews (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    period VARCHAR NOT NULL, -- 'month_2024_03', 'week_12', etc.
    total_reviews INTEGER DEFAULT 0,
    average_rating DECIMAL(3,2) DEFAULT 0.0,
    rating_distribution JSONB DEFAULT '{}',
    top_keywords TEXT[] DEFAULT '{}',
    top_complaints TEXT[] DEFAULT '{}',
    top_praises TEXT[] DEFAULT '{}',
    sentiment_analysis JSONB DEFAULT '{}',
    this_week_reviews INTEGER DEFAULT 0,
    calculated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for analytics_reviews
CREATE INDEX IF NOT EXISTS idx_analytics_reviews_place ON analytics_reviews(place_id);
CREATE INDEX IF NOT EXISTS idx_analytics_reviews_period ON analytics_reviews(period);

-- Unique constraint handled in UNIQUE CONSTRAINTS section below

-- 14. Analytics Events (Stream de eventos individuales)
CREATE TABLE IF NOT EXISTS analytics_events (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    type VARCHAR NOT NULL, -- 'visit', 'conversion', 'review', 'favorite'
    conversion_type VARCHAR, -- Para eventos de conversión
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    hour INTEGER,
    date DATE,
    metadata JSONB DEFAULT '{}',
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for analytics_events
CREATE INDEX IF NOT EXISTS idx_analytics_events_place ON analytics_events(place_id);
CREATE INDEX IF NOT EXISTS idx_analytics_events_type ON analytics_events(type);
CREATE INDEX IF NOT EXISTS idx_analytics_events_timestamp ON analytics_events(timestamp);

-- 15. Analytics Realtime (Métricas en tiempo real)
CREATE TABLE IF NOT EXISTS analytics_realtime (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    active_users INTEGER DEFAULT 0,
    current_sessions INTEGER DEFAULT 0,
    last_updated TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for analytics_realtime
CREATE INDEX IF NOT EXISTS idx_analytics_realtime_place ON analytics_realtime(place_id);

-- 16. Analytics Content (Contenido popular)
CREATE TABLE IF NOT EXISTS analytics_content (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    top_categories JSONB DEFAULT '[]',
    top_products JSONB DEFAULT '[]',
    top_services JSONB DEFAULT '[]',
    top_offers JSONB DEFAULT '[]',
    top_search_terms JSONB DEFAULT '[]',
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for analytics_content
CREATE INDEX IF NOT EXISTS idx_analytics_content_place ON analytics_content(place_id);

-- =====================================================
-- RESERVATION TABLES
-- =====================================================

-- 17. Reservations (Reservas principales)
CREATE TABLE IF NOT EXISTS reservations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    place_name VARCHAR,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    reservation_date DATE NOT NULL,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE NOT NULL,
    party_size INTEGER NOT NULL,
    status VARCHAR DEFAULT 'pending', -- pending, confirmed, cancelled, rejected, checked_in, no_show, completed
    customer_name VARCHAR NOT NULL,
    customer_email VARCHAR NOT NULL,
    customer_phone VARCHAR,
    special_requests TEXT,
    notes TEXT,
    table_number VARCHAR,
    confirmation_code VARCHAR UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    confirmed_at TIMESTAMP WITH TIME ZONE,
    checked_in_at TIMESTAMP WITH TIME ZONE,
    cancelled_at TIMESTAMP WITH TIME ZONE,
    cancel_reason TEXT,
    admin_notes TEXT,
    reminder_sent BOOLEAN DEFAULT false,
    customer_info JSONB DEFAULT '{}',
    metadata JSONB DEFAULT '{}'
);

-- Indexes for reservations
CREATE INDEX IF NOT EXISTS idx_reservations_place ON reservations(place_id);
CREATE INDEX IF NOT EXISTS idx_reservations_user ON reservations(user_id);
CREATE INDEX IF NOT EXISTS idx_reservations_date ON reservations(reservation_date);
CREATE INDEX IF NOT EXISTS idx_reservations_status ON reservations(status);
CREATE INDEX IF NOT EXISTS idx_reservations_confirmation ON reservations(confirmation_code);

-- 18. Business Availability (Disponibilidad del negocio)
CREATE TABLE IF NOT EXISTS business_availability (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    weekly_schedule JSONB DEFAULT '[]', -- Array de horarios semanales
    special_days JSONB DEFAULT '[]', -- Días especiales (feriados, eventos)
    blackout_dates JSONB DEFAULT '[]', -- Fechas bloqueadas
    accepts_reservations BOOLEAN DEFAULT true,
    default_slot_duration INTEGER DEFAULT 60, -- minutos
    max_party_size_default INTEGER DEFAULT 4,
    max_advance_booking_days INTEGER DEFAULT 7,
    min_advance_booking_hours INTEGER DEFAULT 2,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by UUID REFERENCES users(id),
    metadata JSONB DEFAULT '{}'
);

-- Indexes for business_availability
CREATE INDEX IF NOT EXISTS idx_business_availability_place ON business_availability(place_id);

-- 19. Reservation Settings (Configuraciones de reserva)
CREATE TABLE IF NOT EXISTS reservation_settings (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    accepts_reservations BOOLEAN DEFAULT true,
    default_slot_duration INTEGER DEFAULT 60,
    min_party_size INTEGER DEFAULT 1,
    max_party_size INTEGER DEFAULT 20,
    max_advance_booking_days INTEGER DEFAULT 7,
    min_advance_booking_hours INTEGER DEFAULT 2,
    max_duration_minutes INTEGER DEFAULT 30,
    requires_confirmation BOOLEAN DEFAULT true,
    allow_cancellation BOOLEAN DEFAULT true,
    allow_modification BOOLEAN DEFAULT true,
    cancellation_hours INTEGER DEFAULT 2,
    modification_hours INTEGER DEFAULT 4,
    send_confirmation_email BOOLEAN DEFAULT true,
    send_reminder_email BOOLEAN DEFAULT true,
    reminder_hours INTEGER DEFAULT 24,
    blocked_time_slots TEXT[] DEFAULT '{}',
    custom_rules JSONB DEFAULT '[]',
    welcome_message TEXT,
    cancellation_policy TEXT,
    special_instructions TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    created_by UUID REFERENCES users(id),
    metadata JSONB DEFAULT '{}'
);

-- Indexes for reservation_settings
CREATE INDEX IF NOT EXISTS idx_reservation_settings_place ON reservation_settings(place_id);

-- 20. Reservation Time Slots (Slots de tiempo)
CREATE TABLE IF NOT EXISTS reservation_time_slots (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    start_time TIMESTAMP WITH TIME ZONE NOT NULL,
    end_time TIMESTAMP WITH TIME ZONE NOT NULL,
    max_capacity INTEGER NOT NULL,
    current_reservations INTEGER DEFAULT 0,
    is_available BOOLEAN DEFAULT true,
    duration_minutes INTEGER DEFAULT 60,
    special_notes TEXT,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB DEFAULT '{}'
);

-- Indexes for reservation_time_slots
CREATE INDEX IF NOT EXISTS idx_reservation_time_slots_place ON reservation_time_slots(place_id);
CREATE INDEX IF NOT EXISTS idx_reservation_time_slots_start ON reservation_time_slots(start_time);
CREATE INDEX IF NOT EXISTS idx_reservation_time_slots_available ON reservation_time_slots(is_available);

-- =====================================================
-- ADDITIONAL TABLES
-- =====================================================

-- 21. Offers (Ofertas)
CREATE TABLE IF NOT EXISTS offers (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    offer_title VARCHAR NOT NULL,
    offer_description TEXT,
    offer_valid_until TIMESTAMP WITH TIME ZONE NOT NULL,
    offer_price DECIMAL(10,2),
    offer_conditions TEXT,
    offer_image VARCHAR,
    name VARCHAR DEFAULT '',
    description TEXT DEFAULT '',
    image VARCHAR DEFAULT '',
    is_active BOOLEAN DEFAULT true,
    created_by UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB DEFAULT '{}'
);

-- Indexes for offers
CREATE INDEX IF NOT EXISTS idx_offers_place ON offers(place_id);
CREATE INDEX IF NOT EXISTS idx_offers_valid_until ON offers(offer_valid_until);
CREATE INDEX IF NOT EXISTS idx_offers_active ON offers(is_active);

-- 22. Notifications (Notificaciones del sistema)
CREATE TABLE IF NOT EXISTS notifications (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    type VARCHAR NOT NULL, -- business_owner_request, business_owner_approved, etc.
    title VARCHAR NOT NULL,
    message TEXT NOT NULL,
    target_role VARCHAR, -- superAdmin, user, etc.
    target_email VARCHAR,
    is_read BOOLEAN DEFAULT false,
    request_id VARCHAR, -- Para notificaciones relacionadas con requests
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    metadata JSONB DEFAULT '{}'
);

-- Indexes for notifications
CREATE INDEX IF NOT EXISTS idx_notifications_type ON notifications(type);
CREATE INDEX IF NOT EXISTS idx_notifications_target_role ON notifications(target_role);
CREATE INDEX IF NOT EXISTS idx_notifications_target_email ON notifications(target_email);
CREATE INDEX IF NOT EXISTS idx_notifications_read ON notifications(is_read);

-- 23. Province (Provincias)
CREATE TABLE IF NOT EXISTS province (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR NOT NULL,
    provCod VARCHAR UNIQUE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for province
CREATE INDEX IF NOT EXISTS idx_province_cod ON province(provCod);

-- 24. Municipality (Municipios)
CREATE TABLE IF NOT EXISTS municipality (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    nombre VARCHAR NOT NULL,
    munCod VARCHAR UNIQUE,
    province_id UUID REFERENCES province(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes for municipality
CREATE INDEX IF NOT EXISTS idx_municipality_province ON municipality(province_id);
CREATE INDEX IF NOT EXISTS idx_municipality_cod ON municipality(munCod);

-- =====================================================
-- UNIQUE CONSTRAINTS FOR CONFLICT RESOLUTION
-- =====================================================

-- Add unique constraints for all remaining tables using proper PostgreSQL syntax
DO $$
BEGIN
    -- Reviews
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_reviews_id') THEN
        ALTER TABLE reviews ADD CONSTRAINT unique_reviews_id UNIQUE (id);
    END IF;
    
    -- Events
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_events_id') THEN
        ALTER TABLE events ADD CONSTRAINT unique_events_id UNIQUE (id);
    END IF;
    
    -- Admin Users
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_admin_users_id') THEN
        ALTER TABLE admin_users ADD CONSTRAINT unique_admin_users_id UNIQUE (id);
    END IF;
    
    -- Business Owner Requests
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_business_requests_id') THEN
        ALTER TABLE business_owner_requests ADD CONSTRAINT unique_business_requests_id UNIQUE (id);
    END IF;
    
    -- Analytics Places
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_analytics_places_id') THEN
        ALTER TABLE analytics_places ADD CONSTRAINT unique_analytics_places_id UNIQUE (id);
    END IF;
    
    -- Analytics Traffic
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_analytics_traffic_id') THEN
        ALTER TABLE analytics_traffic ADD CONSTRAINT unique_analytics_traffic_id UNIQUE (id);
    END IF;
    
    -- Analytics Reviews
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_analytics_reviews_id') THEN
        ALTER TABLE analytics_reviews ADD CONSTRAINT unique_analytics_reviews_id UNIQUE (id);
    END IF;
    
    -- Analytics Events
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_analytics_events_id') THEN
        ALTER TABLE analytics_events ADD CONSTRAINT unique_analytics_events_id UNIQUE (id);
    END IF;
    
    -- Analytics Realtime
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_analytics_realtime_id') THEN
        ALTER TABLE analytics_realtime ADD CONSTRAINT unique_analytics_realtime_id UNIQUE (id);
    END IF;
    
    -- Analytics Content
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_analytics_content_id') THEN
        ALTER TABLE analytics_content ADD CONSTRAINT unique_analytics_content_id UNIQUE (id);
    END IF;
    
    -- Reservations
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_reservations_id') THEN
        ALTER TABLE reservations ADD CONSTRAINT unique_reservations_id UNIQUE (id);
    END IF;
    
    -- Business Availability
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_business_availability_id') THEN
        ALTER TABLE business_availability ADD CONSTRAINT unique_business_availability_id UNIQUE (id);
    END IF;
    
    -- Reservation Settings
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_reservation_settings_id') THEN
        ALTER TABLE reservation_settings ADD CONSTRAINT unique_reservation_settings_id UNIQUE (id);
    END IF;
    
    -- Reservation Time Slots
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_reservation_time_slots_id') THEN
        ALTER TABLE reservation_time_slots ADD CONSTRAINT unique_reservation_time_slots_id UNIQUE (id);
    END IF;
    
    -- Offers
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_offers_id') THEN
        ALTER TABLE offers ADD CONSTRAINT unique_offers_id UNIQUE (id);
    END IF;
    
    -- Notifications
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_notifications_id') THEN
        ALTER TABLE notifications ADD CONSTRAINT unique_notifications_id UNIQUE (id);
    END IF;
    
    -- Province
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_province_id') THEN
        ALTER TABLE province ADD CONSTRAINT unique_province_id UNIQUE (id);
    END IF;
    
    -- Municipality
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_municipality_id') THEN
        ALTER TABLE municipality ADD CONSTRAINT unique_municipality_id UNIQUE (id);
    END IF;
    
    -- Place Categories
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_place_categories_id') THEN
        ALTER TABLE place_categories ADD CONSTRAINT unique_place_categories_id UNIQUE (id);
    END IF;
    
    -- Place Locations
    IF NOT EXISTS (SELECT 1 FROM pg_constraint WHERE conname = 'unique_place_locations_id') THEN
        ALTER TABLE place_locations ADD CONSTRAINT unique_place_locations_id UNIQUE (id);
    END IF;
    
END $$;

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

-- Automatic timestamp updates for all tables
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

CREATE TRIGGER update_analytics_places_updated_at 
    BEFORE UPDATE ON analytics_places 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_business_availability_updated_at 
    BEFORE UPDATE ON business_availability 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_reservation_settings_updated_at 
    BEFORE UPDATE ON reservation_settings 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_offers_updated_at 
    BEFORE UPDATE ON offers 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_province_updated_at 
    BEFORE UPDATE ON province 
    FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();

CREATE TRIGGER update_municipality_updated_at 
    BEFORE UPDATE ON municipality 
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
ALTER TABLE notifications ENABLE ROW LEVEL SECURITY;
ALTER TABLE reservations ENABLE ROW LEVEL SECURITY;

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

-- Policy for notifications
CREATE POLICY "Users can view own notifications" ON notifications
    FOR SELECT USING (
        target_email = auth.jwt() ->> 'email' OR
        target_role = 'superAdmin'
    );

-- Policy for reservations
CREATE POLICY "Users can view own reservations" ON reservations
    FOR SELECT USING (auth.uid()::text = user_id::text);

CREATE POLICY "Users can create own reservations" ON reservations
    FOR INSERT WITH CHECK (auth.uid()::text = user_id::text);

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
INSERT INTO place_locations (id, place_id, latitude, longitude, address, formatted_address) VALUES
('550e8400-e29b-41d4-a716-446655440050', '550e8400-e29b-41d4-a716-446655440020', 40.4168, -3.7038, 'Calle Principal 123', 'Calle Principal, 123, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440051', '550e8400-e29b-41d4-a716-446655440021', 40.4155, -3.7074, 'Plaza Mayor 45', 'Plaza Mayor, 45, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440052', '550e8400-e29b-41d4-a716-446655440022', 40.4175, -3.7045, 'Calle Pequeña 67', 'Calle Pequeña, 67, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440053', '550e8400-e29b-41d4-a716-446655440023', 40.4190, -3.7050, 'Gran Vía 100', 'Gran Vía, 100, Madrid, España'),
('550e8400-e29b-41d4-a716-446655440054', '550e8400-e29b-41d4-a716-446655440024', 40.4185, -3.7060, 'Plaza de Oriente 1', 'Plaza de Oriente, 1, Madrid, España')
ON CONFLICT (id) DO NOTHING;

-- Insert sample reviews
INSERT INTO reviews (id, place_id, user_id, user_name, rating, comment, status) VALUES
('550e8400-e29b-41d4-a716-446655440060', '550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440011', 'Juan Pérez', 5.0, 'Excelente comida italiana, muy auténtica', 'approved'),
('550e8400-e29b-41d4-a716-446655440061', '550e8400-e29b-41d4-a716-446655440020', '550e8400-e29b-41d4-a716-446655440012', 'María García', 4.0, 'Buen ambiente y servicio rápido', 'approved'),
('550e8400-e29b-41d4-a716-446655440062', '550e8400-e29b-41d4-a716-446655440021', '550e8400-e29b-41d4-a716-446655440011', 'Juan Pérez', 4.5, 'Café delicioso y ambiente acogedor', 'approved'),
('550e8400-e29b-41d4-a716-446655440063', '550e8400-e29b-41d4-a716-446655440022', '550e8400-e29b-41d4-a716-446655440012', 'María García', 4.0, 'Buenas tapas y ambiente tradicional', 'approved'),
('550e8400-e29b-41d4-a716-446655440064', '550e8400-e29b-41d4-a716-446655440023', '550e8400-e29b-41d4-a716-446655440011', 'Juan Pérez', 5.0, 'Hotel de lujo con excelente servicio', 'approved')
ON CONFLICT (id) DO NOTHING;

-- Insert sample favorites
INSERT INTO favorites (id, user_id, place_id) VALUES
('550e8400-e29b-41d4-a716-446655440070', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440020'),
('550e8400-e29b-41d4-a716-446655440071', '550e8400-e29b-41d4-a716-446655440011', '550e8400-e29b-41d4-a716-446655440021'),
('550e8400-e29b-41d4-a716-446655440072', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440022'),
('550e8400-e29b-41d4-a716-446655440073', '550e8400-e29b-41d4-a716-446655440012', '550e8400-e29b-41d4-a716-446655440023')
ON CONFLICT (user_id, place_id) DO NOTHING;

-- Insert sample events
INSERT INTO events (id, title, description, place_id, event_date, event_type, is_highlighted, price) VALUES
('550e8400-e29b-41d4-a716-446655440080', 'Noche de Jazz', 'Concierto de jazz en vivo', '550e8400-e29b-41d4-a716-446655440022', NOW() + INTERVAL '7 days', 'music', true, 25.00),
('550e8400-e29b-41d4-a716-446655440081', 'Cena de Gala', 'Cena especial con menú degustación', '550e8400-e29b-41d4-a716-446655440020', NOW() + INTERVAL '14 days', 'food', true, 75.00),
('550e8400-e29b-41d4-a716-446655440082', 'Exposición de Arte', 'Exposición de artistas locales', '550e8400-e29b-41d4-a716-446655440024', NOW() + INTERVAL '3 days', 'culture', false, 15.00),
('550e8400-e29b-41d4-a716-446655440083', 'Taller de Café', 'Aprende a preparar café artesanal', '550e8400-e29b-41d4-a716-446655440021', NOW() + INTERVAL '10 days', 'workshop', false, 30.00)
ON CONFLICT (id) DO NOTHING;

-- Insert sample admin users
INSERT INTO admin_users (uid, email, display_name, role, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440010', 'admin@turbo.com', 'Admin Turbo', 'superAdmin', true),
('550e8400-e29b-41d4-a716-446655440013', 'owner1@example.com', 'Carlos López', 'placeOwner', true)
ON CONFLICT (uid) DO NOTHING;

-- Insert sample business owner requests
INSERT INTO business_owner_requests (id, business_name, owner_name, email, phone, address, description, status) VALUES
('550e8400-e29b-41d4-a716-446655440090', 'Restaurante Nuevo', 'Ana Martínez', 'ana@example.com', '+34 600 123 456', 'Calle Nueva 50', 'Restaurante de comida mediterránea', 'pending'),
('550e8400-e29b-41d4-a716-446655440091', 'Cafetería Moderna', 'Luis Rodríguez', 'luis@example.com', '+34 600 654 321', 'Avenida Central 200', 'Cafetería con concepto moderno', 'pending')
ON CONFLICT (id) DO NOTHING;

-- Insert sample offers
INSERT INTO offers (id, place_id, offer_title, offer_description, offer_valid_until, offer_price, is_active) VALUES
('550e8400-e29b-41d4-a716-446655440100', '550e8400-e29b-41d4-a716-446655440020', 'Menú del Día', 'Menú completo con bebida incluida', NOW() + INTERVAL '30 days', 15.99, true),
('550e8400-e29b-41d4-a716-446655440101', '550e8400-e29b-41d4-a716-446655440021', '2x1 en Cafés', 'Lleva un amigo gratis', NOW() + INTERVAL '15 days', 0.00, true),
('550e8400-e29b-41d4-a716-446655440102', '550e8400-e29b-41d4-a716-446655440022', 'Happy Hour', '50% descuento en todas las bebidas', NOW() + INTERVAL '7 days', 0.00, true)
ON CONFLICT (id) DO NOTHING;

-- Insert sample notifications
INSERT INTO notifications (id, type, title, message, target_role, is_read) VALUES
('550e8400-e29b-41d4-a716-446655440110', 'business_owner_request', 'Nueva solicitud de Business Owner', 'Ana Martínez ha solicitado registro para Restaurante Nuevo', 'superAdmin', false),
('550e8400-e29b-41d4-a716-446655440111', 'system_update', 'Actualización del sistema', 'Nuevas funcionalidades disponibles', 'superAdmin', false)
ON CONFLICT (id) DO NOTHING;

-- Insert sample province and municipality
INSERT INTO province (id, nombre, provCod) VALUES
('550e8400-e29b-41d4-a716-446655440030', 'Madrid', 'MAD')
ON CONFLICT (id) DO NOTHING;

INSERT INTO municipality (id, nombre, munCod, province_id) VALUES
('550e8400-e29b-41d4-a716-446655440031', 'Madrid', 'MAD001', '550e8400-e29b-41d4-a716-446655440030')
ON CONFLICT (id) DO NOTHING;

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
SELECT 'Business Requests', COUNT(*) FROM business_owner_requests
UNION ALL
SELECT 'Offers', COUNT(*) FROM offers
UNION ALL
SELECT 'Notifications', COUNT(*) FROM notifications
UNION ALL
SELECT 'Province', COUNT(*) FROM province
UNION ALL
SELECT 'Municipality', COUNT(*) FROM municipality;

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