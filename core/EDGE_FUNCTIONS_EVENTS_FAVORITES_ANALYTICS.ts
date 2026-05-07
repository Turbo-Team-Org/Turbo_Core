// 🚀 TURBO CORE - SUPABASE EDGE FUNCTIONS PARTE 3: EVENTS, FAVORITES, ANALYTICS & MORE
// Copia y pega cada función en el panel de Supabase Edge Functions

import { createClient } from 'npm:@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

// =====================================================
// 5. EVENT SERVICES - Edge Functions
// =====================================================

// Public Get Events
export async function public_get_events(req: Request) {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('events')
      .select('*')
      .eq('is_active', true)
      .gte('start_date', new Date().toISOString())
      .order('start_date')
    
    if (error) throw error
    
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// Admin Add Event
export async function admin_add_event(req: Request) {
  try {
    const eventData = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('events')
      .insert([eventData])
      .select()
    
    if (error) throw error
    
    return new Response(JSON.stringify({ id: data[0].id }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// Admin Update Event
export async function admin_update_event(req: Request) {
  try {
    const eventData = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const { error } = await supabase
      .from('events')
      .update(eventData)
      .eq('id', eventData.id)
    
    if (error) throw error
    
    return new Response(JSON.stringify({ success: true }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// Admin Delete Event
export async function admin_delete_event(req: Request) {
  try {
    const { id } = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const { error } = await supabase
      .from('events')
      .delete()
      .eq('id', id)
    
    if (error) throw error
    
    return new Response(JSON.stringify({ success: true }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// =====================================================
// 6. FAVORITE SERVICES - Edge Functions
// =====================================================

// Public Toggle Favorite
export async function public_toggle_favorite(req: Request) {
  try {
    const { userId, placeId } = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    // Verificar si ya existe
    const { data: existing } = await supabase
      .from('favorites')
      .select('*')
      .eq('user_id', userId)
      .eq('place_id', placeId)
      .single()
    
    if (existing) {
      // Eliminar favorito
      await supabase
        .from('favorites')
        .delete()
        .eq('id', existing.id)
      
      return new Response(JSON.stringify({ isFavorite: false }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 200,
      })
    } else {
      // Agregar favorito
      const { data, error } = await supabase
        .from('favorites')
        .insert([{ user_id: userId, place_id: placeId }])
        .select()
      
      if (error) throw error
      
      return new Response(JSON.stringify({ isFavorite: true }), {
        headers: { ...corsHeaders, 'Content-Type': 'application/json' },
        status: 200,
      })
    }
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// Public Get Favorites
export async function public_get_favorites(req: Request) {
  try {
    const url = new URL(req.url)
    const userId = url.searchParams.get('userId')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('favorites')
      .select('*, places(*)')
      .eq('user_id', userId)
    
    if (error) throw error
    
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// Public Check Favorite
export async function public_check_favorite(req: Request) {
  try {
    const url = new URL(req.url)
    const userId = url.searchParams.get('userId')
    const placeId = url.searchParams.get('placeId')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('favorites')
      .select('*')
      .eq('user_id', userId)
      .eq('place_id', placeId)
      .single()
    
    if (error && error.code !== 'PGRST116') throw error
    
    const isFavorite = !!data
    
    return new Response(JSON.stringify({ isFavorite }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// =====================================================
// 7. ANALYTICS SERVICES - Edge Functions
// =====================================================

// Public Get Analytics
export async function public_get_analytics(req: Request) {
  try {
    const url = new URL(req.url)
    const placeId = url.searchParams.get('placeId')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    // Obtener analytics básicos del lugar
    const { data, error } = await supabase
      .from('place_analytics')
      .select('*')
      .eq('place_id', placeId)
      .single()
    
    if (error) throw error
    
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// Admin Get Analytics
export async function admin_get_analytics(req: Request) {
  try {
    const url = new URL(req.url)
    const placeId = url.searchParams.get('placeId')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    // Obtener analytics completos para admin
    const { data, error } = await supabase
      .from('place_analytics')
      .select('*')
      .eq('place_id', placeId)
      .single()
    
    if (error) throw error
    
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// =====================================================
// 8. RESERVATION SERVICES - Edge Functions
// =====================================================

// Public Make Reservation
export async function public_make_reservation(req: Request) {
  try {
    const reservationData = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('reservations')
      .insert([reservationData])
      .select()
    
    if (error) throw error
    
    return new Response(JSON.stringify({ id: data[0].id }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// Public Get User Reservations
export async function public_get_user_reservations(req: Request) {
  try {
    const url = new URL(req.url)
    const userId = url.searchParams.get('userId')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('reservations')
      .select('*, places(*)')
      .eq('user_id', userId)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    
    return new Response(JSON.stringify(data), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// =====================================================
// 9. ADMIN AUTH SERVICES - Edge Functions
// =====================================================

// Admin Login
export async function admin_login(req: Request) {
  try {
    const { email, password } = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase.auth.signInWithPassword({
      email,
      password,
    })
    
    if (error) throw error
    
    // Verificar si es admin
    const { data: profile } = await supabase
      .from('admin_users')
      .select('role')
      .eq('id', data.user.id)
      .single()
    
    if (!profile || !['admin', 'superAdmin'].includes(profile.role)) {
      throw new Error('Acceso denegado: usuario no es administrador')
    }
    
    return new Response(JSON.stringify({
      user: data.user,
      session: data.session,
      role: profile.role
    }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 200,
    })
  } catch (error) {
    return new Response(JSON.stringify({ error: error.message }), {
      headers: { ...corsHeaders, 'Content-Type': 'application/json' },
      status: 400,
    })
  }
}

// =====================================================
// 10. HEALTH CHECK - Edge Function
// =====================================================

// Health Check
export async function health(req: Request) {
  return new Response(JSON.stringify({ 
    status: 'healthy', 
    timestamp: new Date().toISOString(),
    service: 'Turbo Core Edge Functions'
  }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

/*
🚀 INSTRUCCIONES PARA DESPLEGAR EN SUPABASE:

1. Ve al panel de Supabase de tu proyecto
2. Navega a "Edge Functions"
3. Crea una nueva función para cada endpoint
4. Copia y pega el código de cada función
5. Nombra cada función EXACTAMENTE como aparece aquí:

FUNCIONES EVENT:
- public_get_events
- admin_add_event
- admin_update_event
- admin_delete_event

FUNCIONES FAVORITE:
- public_toggle_favorite
- public_get_favorites
- public_check_favorite

FUNCIONES ANALYTICS:
- public_get_analytics
- admin_get_analytics

FUNCIONES RESERVATION:
- public_make_reservation
- public_get_user_reservations

FUNCIONES ADMIN AUTH:
- admin_login

FUNCIONES UTILIDAD:
- health

⚠️ IMPORTANTE:
- Los nombres DEBEN coincidir exactamente
- Configura las variables de entorno en Supabase
- Habilita CORS en cada función
*/
