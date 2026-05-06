// 🚀 TURBO CORE - SUPABASE EDGE FUNCTIONS PARTE 1: AI & REVIEWS
// Copia y pega cada función en el panel de Supabase Edge Functions

import { createClient } from 'npm:@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers': 'authorization, x-client-info, apikey, content-type',
}

// =====================================================
// 1. AI SERVICES - Edge Functions
// =====================================================

// AI Chat Completion
export async function ai_chat_completion(req: Request) {
  try {
    const { model, system, temperature, messages, metadata } = await req.json()
    
    const response = {
      id: crypto.randomUUID(),
      content: "Respuesta simulada de IA",
      model: model || "gpt-3.5-turbo",
      timestamp: new Date().toISOString(),
      metadata: metadata || {}
    }
    
    return new Response(JSON.stringify(response), {
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

// AI Generate Place Description
export async function ai_generate_place_description(req: Request) {
  try {
    const { place, tone, language } = await req.json()
    
    const description = `Descripción generada para ${place.name} en ${language}`
    
    return new Response(JSON.stringify({ content: description }), {
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

// AI Generate Place Tags
export async function ai_generate_place_tags(req: Request) {
  try {
    const { place, maxTags, language } = await req.json()
    
    const tags = ["restaurante", "cubano", "tradicional", "acogedor"]
    
    return new Response(JSON.stringify(tags), {
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

// AI Summarize Reviews
export async function ai_summarize_reviews(req: Request) {
  try {
    const { text, maxWords, language } = await req.json()
    
    const summary = `Resumen de ${maxWords} palabras en ${language}`
    
    return new Response(JSON.stringify({ summary }), {
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

// AI Moderate Text
export async function ai_moderate_text(req: Request) {
  try {
    const { text } = await req.json()
    
    const allowed = !text.toLowerCase().includes('spam')
    
    return new Response(JSON.stringify({ allowed }), {
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

// AI Translate Text
export async function ai_translate_text(req: Request) {
  try {
    const { text, targetLanguage } = await req.json()
    
    const translated = `Texto traducido a ${targetLanguage}`
    
    return new Response(JSON.stringify({ content: translated }), {
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
// 2. REVIEW SERVICES - Edge Functions
// =====================================================

// Public Get Reviews
export async function public_get_reviews(req: Request) {
  try {
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('reviews')
      .select('*')
      .eq('status', 'approved')
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

// Public Add Review
export async function public_add_review(req: Request) {
  try {
    const { placeId, ...reviewData } = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('reviews')
      .insert([{ ...reviewData, place_id: placeId, status: 'pending' }])
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

// Admin Update Review
export async function admin_update_review(req: Request) {
  try {
    const reviewData = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const { error } = await supabase
      .from('reviews')
      .update(reviewData)
      .eq('id', reviewData.id)
    
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

// Admin Delete Review
export async function admin_delete_review(req: Request) {
  try {
    const { id } = await req.json()
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    const { error } = await supabase
      .from('reviews')
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

// Public Get Reviews By Place
export async function public_get_reviews_by_place(req: Request) {
  try {
    const url = new URL(req.url)
    const placeId = url.searchParams.get('placeId')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_ANON_KEY') ?? ''
    )
    
    const { data, error } = await supabase
      .from('reviews')
      .select('*')
      .eq('place_id', placeId)
      .eq('status', 'approved')
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

// Admin Get Reviews Paginated
export async function admin_get_reviews_paginated(req: Request) {
  try {
    const url = new URL(req.url)
    const page = parseInt(url.searchParams.get('page') || '1')
    const limit = parseInt(url.searchParams.get('limit') || '20')
    const status = url.searchParams.get('status')
    
    const supabase = createClient(
      Deno.env.get('SUPABASE_URL') ?? '',
      Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? ''
    )
    
    let query = supabase
      .from('reviews')
      .select('*', { count: 'exact' })
    
    if (status) {
      query = query.eq('status', status)
    }
    
    const { data, error, count } = await query
      .range((page - 1) * limit, page * limit - 1)
      .order('created_at', { ascending: false })
    
    if (error) throw error
    
    const total = count || 0
    const totalPages = Math.ceil(total / limit)
    
    const result = {
      items: data,
      total,
      page,
      limit,
      totalPages,
      hasNextPage: page < totalPages,
      hasPreviousPage: page > 1
    }
    
    return new Response(JSON.stringify(result), {
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

/*
🚀 INSTRUCCIONES PARA DESPLEGAR EN SUPABASE:

1. Ve al panel de Supabase de tu proyecto
2. Navega a "Edge Functions"
3. Crea una nueva función para cada endpoint
4. Copia y pega el código de cada función
5. Nombra cada función EXACTAMENTE como aparece aquí:

FUNCIONES AI:
- ai_chat_completion
- ai_generate_place_description  
- ai_generate_place_tags
- ai_summarize_reviews
- ai_moderate_text
- ai_translate_text

FUNCIONES REVIEW:
- public_get_reviews
- public_add_review
- admin_update_review
- admin_delete_review
- public_get_reviews_by_place
- admin_get_reviews_paginated

⚠️ IMPORTANTE:
- Los nombres DEBEN coincidir exactamente
- Configura las variables de entorno en Supabase
- Habilita CORS en cada función
*/
