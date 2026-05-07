// Turbo Core - Supabase Edge Functions: Places, Categories y Place-Categories
// Estas son las definiciones canonicas que se despliegan desde Cursor MCP.
// Cada export es la funcion canonica usada por el servicio edge en Dart.

import { createClient } from 'npm:@supabase/supabase-js@2'

const corsHeaders = {
  'Access-Control-Allow-Origin': '*',
  'Access-Control-Allow-Headers':
    'authorization, x-client-info, apikey, content-type',
}

function jsonOk(payload: unknown) {
  return new Response(JSON.stringify(payload), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status: 200,
  })
}

function jsonError(error: unknown, status = 400) {
  const message = error instanceof Error ? error.message : String(error)
  return new Response(JSON.stringify({ error: message }), {
    headers: { ...corsHeaders, 'Content-Type': 'application/json' },
    status,
  })
}

function clientAnon() {
  return createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_ANON_KEY') ?? '',
  )
}

function clientService() {
  return createClient(
    Deno.env.get('SUPABASE_URL') ?? '',
    Deno.env.get('SUPABASE_SERVICE_ROLE_KEY') ?? '',
  )
}

// =====================================================
// PLACES
// =====================================================

export async function public_get_places(_req: Request) {
  try {
    const { data, error } = await clientAnon()
      .from('places')
      .select('*')
      .order('rating', { ascending: false })
    if (error) throw error
    return jsonOk(data)
  } catch (e) {
    return jsonError(e)
  }
}

export async function public_get_place_by_id(req: Request) {
  try {
    const url = new URL(req.url)
    const id = url.searchParams.get('id')
    if (!id) throw new Error('id es requerido')
    const { data, error } = await clientAnon()
      .from('places')
      .select('*')
      .eq('id', id)
      .maybeSingle()
    if (error) throw error
    return jsonOk(data ?? {})
  } catch (e) {
    return jsonError(e)
  }
}

export async function public_get_place_by_name(req: Request) {
  try {
    const url = new URL(req.url)
    const name = url.searchParams.get('name')
    if (!name) throw new Error('name es requerido')
    const { data, error } = await clientAnon()
      .from('places')
      .select('*')
      .ilike('name', name)
      .maybeSingle()
    if (error) throw error
    return jsonOk(data ?? {})
  } catch (e) {
    return jsonError(e)
  }
}

export async function public_get_places_by_category(req: Request) {
  try {
    const url = new URL(req.url)
    const categoryId = url.searchParams.get('categoryId')
    if (!categoryId) throw new Error('categoryId es requerido')
    const { data, error } = await clientAnon()
      .from('places')
      .select('*')
      .eq('category_id', categoryId)
      .order('rating', { ascending: false })
    if (error) throw error
    return jsonOk(data ?? [])
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_add_place(req: Request) {
  try {
    const body = await req.json()
    const { data, error } = await clientService()
      .from('places')
      .insert([body])
      .select('id')
      .single()
    if (error) throw error
    return jsonOk({ id: data?.id })
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_add_place_with_owner(req: Request) {
  try {
    const { ownerId, ...place } = await req.json()
    const ownerIds: string[] = Array.isArray(place.owner_ids)
      ? place.owner_ids
      : []
    if (ownerId && !ownerIds.includes(ownerId)) ownerIds.push(ownerId)
    const payload = { ...place, owner_ids: ownerIds }
    const { data, error } = await clientService()
      .from('places')
      .insert([payload])
      .select('id')
      .single()
    if (error) throw error
    return jsonOk({ id: data?.id })
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_update_place(req: Request) {
  try {
    const body = await req.json()
    const { id, ...patch } = body
    if (!id) throw new Error('id es requerido')
    const { error } = await clientService()
      .from('places')
      .update(patch)
      .eq('id', id)
    if (error) throw error
    return jsonOk({ success: true })
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_delete_place(req: Request) {
  try {
    const { id } = await req.json()
    if (!id) throw new Error('id es requerido')
    const { error } = await clientService().from('places').delete().eq('id', id)
    if (error) throw error
    return jsonOk({ success: true })
  } catch (e) {
    return jsonError(e)
  }
}

// =====================================================
// CATEGORIES
// =====================================================

export async function public_get_categories(_req: Request) {
  try {
    const { data, error } = await clientAnon()
      .from('categories')
      .select('*')
      .eq('is_active', true)
      .order('sort_order', { ascending: true })
    if (error) throw error
    return jsonOk(data ?? [])
  } catch (e) {
    return jsonError(e)
  }
}

export async function public_get_category_by_id(req: Request) {
  try {
    const url = new URL(req.url)
    const id = url.searchParams.get('id')
    if (!id) throw new Error('id es requerido')
    const { data, error } = await clientAnon()
      .from('categories')
      .select('*')
      .eq('id', id)
      .maybeSingle()
    if (error) throw error
    return jsonOk(data ?? {})
  } catch (e) {
    return jsonError(e)
  }
}

export async function public_get_category_by_name(req: Request) {
  try {
    const url = new URL(req.url)
    const name = url.searchParams.get('name')
    if (!name) throw new Error('name es requerido')
    const { data, error } = await clientAnon()
      .from('categories')
      .select('*')
      .ilike('name', name)
      .maybeSingle()
    if (error) throw error
    return jsonOk(data ?? {})
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_add_category(req: Request) {
  try {
    const body = await req.json()
    const { data, error } = await clientService()
      .from('categories')
      .insert([body])
      .select('id')
      .single()
    if (error) throw error
    return jsonOk({ id: data?.id })
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_update_category(req: Request) {
  try {
    const body = await req.json()
    const { id, ...patch } = body
    if (!id) throw new Error('id es requerido')
    const { error } = await clientService()
      .from('categories')
      .update(patch)
      .eq('id', id)
    if (error) throw error
    return jsonOk({ success: true })
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_delete_category(req: Request) {
  try {
    const { id } = await req.json()
    if (!id) throw new Error('id es requerido')
    const { error } = await clientService()
      .from('categories')
      .delete()
      .eq('id', id)
    if (error) throw error
    return jsonOk({ success: true })
  } catch (e) {
    return jsonError(e)
  }
}

// =====================================================
// PLACE CATEGORIES (relacion many-to-many)
// =====================================================

export async function admin_assign_category_to_place(req: Request) {
  try {
    const { placeId, categoryId } = await req.json()
    if (!placeId || !categoryId)
      throw new Error('placeId y categoryId son requeridos')
    const { error } = await clientService()
      .from('place_categories')
      .upsert(
        [{ place_id: placeId, category_id: categoryId }],
        { onConflict: 'place_id,category_id' },
      )
    if (error) throw error
    return jsonOk({ ok: true })
  } catch (e) {
    return jsonError(e)
  }
}

export async function admin_remove_category_from_place(req: Request) {
  try {
    const { placeId, categoryId } = await req.json()
    if (!placeId || !categoryId)
      throw new Error('placeId y categoryId son requeridos')
    const { error } = await clientService()
      .from('place_categories')
      .delete()
      .eq('place_id', placeId)
      .eq('category_id', categoryId)
    if (error) throw error
    return jsonOk({ ok: true })
  } catch (e) {
    return jsonError(e)
  }
}

export async function public_get_places_in_category(req: Request) {
  try {
    const url = new URL(req.url)
    const categoryId = url.searchParams.get('categoryId')
    if (!categoryId) throw new Error('categoryId es requerido')
    const { data, error } = await clientAnon()
      .from('place_categories')
      .select('places(*)')
      .eq('category_id', categoryId)
    if (error) throw error
    const places = (data ?? [])
      .map((row: { places?: unknown }) => row.places)
      .filter(Boolean)
    return jsonOk(places)
  } catch (e) {
    return jsonError(e)
  }
}

export async function public_get_categories_for_place(req: Request) {
  try {
    const url = new URL(req.url)
    const placeId = url.searchParams.get('placeId')
    if (!placeId) throw new Error('placeId es requerido')
    const { data, error } = await clientAnon()
      .from('place_categories')
      .select('categories(*)')
      .eq('place_id', placeId)
    if (error) throw error
    const categories = (data ?? [])
      .map((row: { categories?: unknown }) => row.categories)
      .filter(Boolean)
    return jsonOk(categories)
  } catch (e) {
    return jsonError(e)
  }
}
