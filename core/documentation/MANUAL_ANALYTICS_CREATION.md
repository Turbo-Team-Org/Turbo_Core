# 🚀 Creación Manual de Analytics - Turbo Core

## ⚠️ SITUACIÓN ACTUAL

Tu instalación de Flutter tiene incompatibilidades. Esta guía te permite crear las collections de analytics manualmente.

## 📋 PASO A PASO

### 1. Acceder a Firebase Console

1. Ve a [Firebase Console](https://console.firebase.google.com)
2. Selecciona tu proyecto Turbo Core
3. Ve a **Firestore Database**

### 2. Verificar Collections Existentes

Confirma que tienes estas collections:

- ✅ `places`
- ✅ `reviews`
- ✅ `events`

### 3. Crear Collections de Analytics

#### 🏢 Collection: `analytics_places`

Para cada lugar en tu collection `places`, crea un documento en `analytics_places`:

**Estructura del documento:**

```json
{
  "placeId": "ID_DEL_LUGAR",
  "placeName": "Nombre del lugar",
  "categoryId": "categoria_id",
  "categoryName": "Nombre categoría",
  "address": "Dirección",
  "total_views": 0,
  "unique_visitors": 0,
  "total_conversions": 0,
  "average_rating": 4.5,
  "total_reviews": 0,
  "total_favorites": 0,
  "conversion_rate": 0.0,
  "total_events": 0,
  "created_at": "TIMESTAMP_ACTUAL",
  "updated_at": "TIMESTAMP_ACTUAL",
  "initialized_from": "places_collection",
  "status": "active"
}
```

#### 📈 Collection: `analytics_traffic`

Para cada lugar, crea 2 documentos:

**Documento diario:**

```json
{
  "placeId": "ID_DEL_LUGAR",
  "type": "daily",
  "date": "TIMESTAMP_HOY",
  "views": 0,
  "unique_visitors": 0,
  "interactions": 0,
  "conversions": 0,
  "created_at": "TIMESTAMP_ACTUAL"
}
```

**Documento por hora:**

```json
{
  "placeId": "ID_DEL_LUGAR",
  "type": "hourly",
  "hour": 14,
  "date": "TIMESTAMP_HOY",
  "timestamp": "TIMESTAMP_ACTUAL",
  "views": 0,
  "interactions": 0,
  "created_at": "TIMESTAMP_ACTUAL"
}
```

#### ⚡ Collection: `analytics_realtime`

Para cada lugar, crea un documento:

```json
{
  "placeId": "ID_DEL_LUGAR",
  "activeUsers": 0,
  "currentSessions": 0,
  "last5MinViews": 0,
  "currentHourViews": 0,
  "peakHourToday": 0,
  "lastUpdated": "TIMESTAMP_ACTUAL",
  "created_at": "TIMESTAMP_ACTUAL",
  "status": "initialized"
}
```

## 🔧 SCRIPT JAVASCRIPT PARA FIREBASE CONSOLE

Puedes ejecutar este script en la consola de Firebase:

```javascript
// 1. Ve a Firebase Console > Firestore > Reglas
// 2. Temporalmente cambia las reglas a:
// allow read, write: if true;

// 3. Abre la consola del navegador (F12) y ejecuta:

async function createAnalytics() {
  const db = firebase.firestore();

  // Obtener todos los places
  const placesSnapshot = await db.collection("places").get();
  console.log(`Encontrados ${placesSnapshot.docs.length} places`);

  const batch = db.batch();
  let count = 0;

  placesSnapshot.docs.forEach((placeDoc) => {
    const placeData = placeDoc.data();
    const placeId = placeDoc.id;
    const now = new Date();
    const today = new Date(now.getFullYear(), now.getMonth(), now.getDate());

    // 1. Analytics Places
    const analyticsPlaceRef = db.collection("analytics_places").doc(placeId);
    batch.set(analyticsPlaceRef, {
      placeId: placeId,
      placeName: placeData.name || "Sin nombre",
      categoryId: placeData.categoryId || "",
      categoryName: placeData.categoryName || "",
      address: placeData.address || "",
      total_views: 0,
      unique_visitors: 0,
      total_conversions: 0,
      average_rating: placeData.rating || 0,
      total_reviews: 0,
      total_favorites: placeData.favoriteCount || 0,
      conversion_rate: 0.0,
      total_events: 0,
      created_at: firebase.firestore.Timestamp.fromDate(now),
      updated_at: firebase.firestore.Timestamp.fromDate(now),
      initialized_from: "places_collection",
      status: "active",
    });

    // 2. Analytics Traffic - Daily
    const dailyRef = db
      .collection("analytics_traffic")
      .doc(`${placeId}_daily_${today.getTime()}`);
    batch.set(dailyRef, {
      placeId: placeId,
      type: "daily",
      date: firebase.firestore.Timestamp.fromDate(today),
      views: 0,
      unique_visitors: 0,
      interactions: 0,
      conversions: 0,
      created_at: firebase.firestore.Timestamp.fromDate(now),
    });

    // 3. Analytics Traffic - Hourly
    const hourlyRef = db
      .collection("analytics_traffic")
      .doc(`${placeId}_hourly_${now.getHours()}_${today.getTime()}`);
    batch.set(hourlyRef, {
      placeId: placeId,
      type: "hourly",
      hour: now.getHours(),
      date: firebase.firestore.Timestamp.fromDate(today),
      timestamp: firebase.firestore.Timestamp.fromDate(now),
      views: 0,
      interactions: 0,
      created_at: firebase.firestore.Timestamp.fromDate(now),
    });

    // 4. Analytics Realtime
    const realtimeRef = db.collection("analytics_realtime").doc(placeId);
    batch.set(realtimeRef, {
      placeId: placeId,
      activeUsers: 0,
      currentSessions: 0,
      last5MinViews: 0,
      currentHourViews: 0,
      peakHourToday: 0,
      lastUpdated: firebase.firestore.Timestamp.fromDate(now),
      created_at: firebase.firestore.Timestamp.fromDate(now),
      status: "initialized",
    });

    count += 4;
  });

  // Ejecutar el batch
  await batch.commit();
  console.log(`✅ Analytics creados: ${count} documentos`);
  console.log(`📊 Collections creadas:`);
  console.log(`   - analytics_places: ${placesSnapshot.docs.length} docs`);
  console.log(`   - analytics_traffic: ${placesSnapshot.docs.length * 2} docs`);
  console.log(`   - analytics_realtime: ${placesSnapshot.docs.length} docs`);
}

// Ejecutar
createAnalytics()
  .then(() => {
    console.log("🎉 ANALYTICS CREADOS EXITOSAMENTE!");
  })
  .catch((error) => {
    console.error("❌ Error:", error);
  });
```

## 📊 VERIFICACIÓN

Después de ejecutar el script, verifica en Firebase Console que se crearon:

1. **analytics_places** - Un documento por cada lugar
2. **analytics_traffic** - Dos documentos por cada lugar (daily + hourly)
3. **analytics_realtime** - Un documento por cada lugar

## 🔒 RESTAURAR SEGURIDAD

**IMPORTANTE:** Después de crear los analytics, restaura las reglas de Firestore:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if request.auth != null;
    }
  }
}
```

## 💰 COSTO ESTIMADO

- **Escrituras:** ~4 por lugar
- **Costo:** ~$0.0024 USD por lugar
- **Total para 100 lugares:** ~$0.24 USD

## 🚀 PRÓXIMOS PASOS

Una vez creadas las collections:

1. ✅ Verifica en Firebase Console
2. ✅ Restaura las reglas de seguridad
3. ✅ Prueba queries desde tu app
4. ✅ Implementa tracking de eventos reales

## 🆘 SOPORTE

Si tienes problemas:

1. Verifica que tienes permisos de administrador en Firebase
2. Asegúrate de que las reglas permiten escritura temporalmente
3. Revisa la consola del navegador para errores
4. Contacta si necesitas ayuda adicional

---

**¡Tu sistema de analytics empresariales estará listo en minutos!** 🎯
