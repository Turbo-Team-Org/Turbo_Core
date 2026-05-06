# Supabase Database Schema for Firebase Migration

This document outlines the PostgreSQL database schema required for migrating from Firebase to Supabase.

## Overview

The database schema is designed to replicate the Firebase Firestore collections as PostgreSQL tables, taking advantage of relational database features while maintaining compatibility with the existing data models.

## Core Tables

### 1. Users Table

```sql
CREATE TABLE users (
    id UUID PRIMARY KEY,
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

-- Indexes
CREATE INDEX idx_users_email ON users(email);
CREATE INDEX idx_users_role ON users(role);
```

### 2. Categories Table

```sql
CREATE TABLE categories (
    id UUID PRIMARY KEY,
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

-- Indexes
CREATE INDEX idx_categories_active ON categories(is_active);
CREATE INDEX idx_categories_sort ON categories(sort_order);
```

### 3. Places Table

```sql
CREATE TABLE places (
    id UUID PRIMARY KEY,
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

-- Indexes
CREATE INDEX idx_places_category ON places(category_id);
CREATE INDEX idx_places_location ON places(latitude, longitude);
CREATE INDEX idx_places_rating ON places(rating);
CREATE INDEX idx_places_owner_ids ON places USING GIN(owner_ids);
```

### 4. Reviews Table

```sql
CREATE TABLE reviews (
    id UUID PRIMARY KEY,
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

-- Indexes
CREATE INDEX idx_reviews_place ON reviews(place_id);
CREATE INDEX idx_reviews_user ON reviews(user_id);
CREATE INDEX idx_reviews_status ON reviews(status);
CREATE INDEX idx_reviews_rating ON reviews(rating);
```

### 5. Favorites Table

```sql
CREATE TABLE favorites (
    id UUID PRIMARY KEY,
    user_id UUID REFERENCES users(id) ON DELETE CASCADE,
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(user_id, place_id)
);

-- Indexes
CREATE INDEX idx_favorites_user ON favorites(user_id);
CREATE INDEX idx_favorites_place ON favorites(place_id);
```

### 6. Events Table

```sql
CREATE TABLE events (
    id UUID PRIMARY KEY,
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

-- Indexes
CREATE INDEX idx_events_place ON events(place_id);
CREATE INDEX idx_events_date ON events(event_date);
CREATE INDEX idx_events_type ON events(event_type);
CREATE INDEX idx_events_highlighted ON events(is_highlighted);
```

### 7. Place Categories Junction Table

```sql
CREATE TABLE place_categories (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    place_id UUID REFERENCES places(id) ON DELETE CASCADE,
    category_id UUID REFERENCES categories(id) ON DELETE CASCADE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    UNIQUE(place_id, category_id)
);

-- Indexes
CREATE INDEX idx_place_categories_place ON place_categories(place_id);
CREATE INDEX idx_place_categories_category ON place_categories(category_id);
```

## Admin Tables

### 8. Admin Users Table

```sql
CREATE TABLE admin_users (
    id UUID PRIMARY KEY,
    auth_uid UUID NOT NULL UNIQUE,
    email VARCHAR NOT NULL UNIQUE,
    display_name VARCHAR NOT NULL,
    role VARCHAR NOT NULL,
    is_active BOOLEAN DEFAULT true,
    place_ids TEXT[] DEFAULT '{}',
    last_login TIMESTAMP WITH TIME ZONE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Indexes
CREATE INDEX idx_admin_users_auth_uid ON admin_users(auth_uid);
CREATE INDEX idx_admin_users_email ON admin_users(email);
CREATE INDEX idx_admin_users_role ON admin_users(role);
```

### 9. Business Owner Requests Table

```sql
CREATE TABLE business_owner_requests (
    id UUID PRIMARY KEY,
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

-- Indexes
CREATE INDEX idx_business_requests_status ON business_owner_requests(status);
CREATE INDEX idx_business_requests_email ON business_owner_requests(email);
```

## PostgreSQL Functions

### 1. Category Places Count Functions

```sql
-- Function to increment category places count
CREATE OR REPLACE FUNCTION increment_category_places_count(category_id UUID)
RETURNS void AS $$
BEGIN
    UPDATE categories
    SET places_count = places_count + 1,
        updated_at = NOW()
    WHERE id = category_id;
END;
$$ LANGUAGE plpgsql;

-- Function to decrement category places count
CREATE OR REPLACE FUNCTION decrement_category_places_count(category_id UUID)
RETURNS void AS $$
BEGIN
    UPDATE categories
    SET places_count = GREATEST(places_count - 1, 0),
        updated_at = NOW()
    WHERE id = category_id;
END;
$$ LANGUAGE plpgsql;
```

### 2. Automatic Timestamp Updates

```sql
-- Function to update timestamp
CREATE OR REPLACE FUNCTION update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = NOW();
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Apply to all tables with updated_at
CREATE TRIGGER update_users_updated_at BEFORE UPDATE ON users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_categories_updated_at BEFORE UPDATE ON categories FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_places_updated_at BEFORE UPDATE ON places FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_reviews_updated_at BEFORE UPDATE ON reviews FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_events_updated_at BEFORE UPDATE ON events FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_admin_users_updated_at BEFORE UPDATE ON admin_users FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
CREATE TRIGGER update_business_owner_requests_updated_at BEFORE UPDATE ON business_owner_requests FOR EACH ROW EXECUTE FUNCTION update_updated_at_column();
```

### 3. Update Place Rating Function

```sql
-- Function to update place rating based on approved reviews
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

-- Trigger to update place rating when reviews change
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

CREATE TRIGGER reviews_update_place_rating
    AFTER INSERT OR UPDATE OR DELETE ON reviews
    FOR EACH ROW EXECUTE FUNCTION trigger_update_place_rating();
```

## Row Level Security (RLS)

### Enable RLS on sensitive tables

```sql
ALTER TABLE users ENABLE ROW LEVEL SECURITY;
ALTER TABLE admin_users ENABLE ROW LEVEL SECURITY;
ALTER TABLE business_owner_requests ENABLE ROW LEVEL SECURITY;

-- Policy for users to only see their own data
CREATE POLICY "Users can view own profile" ON users
    FOR SELECT USING (auth.uid() = id);

CREATE POLICY "Users can update own profile" ON users
    FOR UPDATE USING (auth.uid() = id);

-- Policy for admin users
CREATE POLICY "Admin users can view own profile" ON admin_users
    FOR SELECT USING (auth.uid() = auth_uid);

-- Policy for business owner requests
CREATE POLICY "Users can create business owner requests" ON business_owner_requests
    FOR INSERT WITH CHECK (true);

CREATE POLICY "Admin users can view all requests" ON business_owner_requests
    FOR SELECT USING (
        EXISTS (
            SELECT 1 FROM admin_users
            WHERE auth_uid = auth.uid()
            AND is_active = true
        )
    );
```

## Migration Notes

1. **Data Types**:

   - Firebase document IDs become UUID primary keys
   - Firebase timestamps become PostgreSQL `TIMESTAMP WITH TIME ZONE`
   - Firebase arrays become PostgreSQL arrays or JSONB
   - Firebase maps become JSONB

2. **Relationships**:

   - Foreign key constraints ensure data integrity
   - Junction tables handle many-to-many relationships
   - Cascading deletes maintain referential integrity

3. **Performance**:

   - Indexes on frequently queried columns
   - GIN indexes for array and JSONB columns
   - Composite indexes for complex queries

4. **Functions**:

   - PostgreSQL functions replace Firebase Cloud Functions for data consistency
   - Triggers maintain denormalized data (like rating averages)
   - RPC functions for complex operations

5. **Security**:
   - Row Level Security policies protect sensitive data
   - Admin permissions controlled through database policies
   - User authentication handled by Supabase Auth

## Environment Variables

Add these to your Supabase environment:

```
SUPABASE_URL=your_supabase_url
SUPABASE_ANON_KEY=your_supabase_anon_key
SUPABASE_SERVICE_ROLE_KEY=your_supabase_service_role_key
```

## Next Steps

1. Create the database schema using the SQL above
2. Test the Supabase services with sample data
3. Migrate existing Firebase data to Supabase
4. Update dependency injection to use Supabase services
5. Update environment configuration
6. Test thoroughly before production deployment
