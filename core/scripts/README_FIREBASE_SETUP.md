# 🔥 Script de Configuración Firestore para Servidor/CLI

Esta documentación explica cómo ejecutar el script de configuración de Firestore en diferentes entornos.

## 🎯 Opciones de Ejecución

### Opción 1: Con Flutter (Recomendado para desarrollo)

```bash
# Ejecutar directamente con Flutter
flutter run core/scripts/setup_admin_firestore.dart

# O crear proyecto temporal
flutter create temp_setup
cp core/scripts/setup_admin_firestore.dart temp_setup/lib/main.dart
cd temp_setup
flutter run
```

### Opción 2: Firebase Admin SDK (Para servidor/producción)

Para usar Firebase Admin SDK en entorno CLI puro, necesitas agregar las dependencias correctas:

#### pubspec.yaml

```yaml
name: firestore_setup
description: Script de configuración Firestore

environment:
  sdk: ">=3.7.0 <4.0.0"

dependencies:
  firebase_admin: ^0.1.0 # Nota: verificar versión disponible
  # O alternativamente:
  googleapis: ^11.4.0
  googleapis_auth: ^1.4.1

dev_dependencies:
  lints: ^3.0.0
```

#### Script con firebase_admin (si disponible)

```dart
import 'dart:io';
import 'package:firebase_admin/firebase_admin.dart';

void main() async {
  // Inicializar con credenciales de servicio
  final credential = Credential.fromServiceAccount(
    File('service-account-key.json'),
  );

  final app = FirebaseAdmin.instance.initializeApp(
    AppOptions(credential: credential),
  );

  final firestore = app.firestore();

  // Resto del código de configuración...
}
```

### Opción 3: Firebase CLI (Más simple para tareas administrativas)

```bash
# Instalar Firebase CLI
npm install -g firebase-tools

# Autenticar
firebase login

# Configurar proyecto
firebase use --add

# Importar datos usando JSON
firebase firestore:delete --all-collections
firebase firestore:import data.json
```

### Opción 4: REST API de Firestore

```dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:googleapis_auth/auth_io.dart';

void main() async {
  // Configurar autenticación
  final accountCredentials = ServiceAccountCredentials.fromJson(
    await File('service-account-key.json').readAsString(),
  );

  final scopes = ['https://www.googleapis.com/auth/datastore'];
  final client = await clientViaServiceAccount(accountCredentials, scopes);

  // Usar REST API
  final projectId = 'tu-proyecto-id';
  final url = 'https://firestore.googleapis.com/v1/projects/$projectId/databases/(default)/documents/admin_users';

  final response = await client.post(
    Uri.parse(url),
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({
      'fields': {
        'email': {'stringValue': 'admin@example.com'},
        'role': {'stringValue': 'superAdmin'},
        // ... más campos
      }
    }),
  );

  client.close();
}
```

## 🔧 Configuración de Credenciales

### Para Firebase Admin SDK

1. Ve a Firebase Console > Project Settings > Service Accounts
2. Genera nueva clave privada
3. Descarga el archivo JSON como `service-account-key.json`
4. Colócalo en la raíz del proyecto

### Para FlutterFire CLI

```bash
# Instalar FlutterFire CLI
dart pub global activate flutterfire_cli

# Configurar proyecto
flutterfire configure

# Esto genera firebase_options.dart automáticamente
```

## 📊 Datos de Ejemplo para Importar

### admin_users.json

```json
{
  "admin_users": {
    "super_admin_001": {
      "uid": "super_admin_001",
      "email": "superadmin@turbo.com",
      "displayName": "Super Administrador Turbo",
      "role": "superAdmin",
      "ownedPlaceIds": [],
      "permissions": {},
      "isActive": true,
      "metadata": {
        "createdBy": "system",
        "initialSetup": true,
        "version": "1.0.0"
      }
    }
  }
}
```

### firestore.indexes.json

```json
{
  "indexes": [
    {
      "collection": "admin_users",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "role", "order": "ASCENDING" },
        { "fieldPath": "isActive", "order": "ASCENDING" }
      ]
    },
    {
      "collection": "places",
      "queryScope": "COLLECTION",
      "fields": [
        { "fieldPath": "ownerIds", "arrayConfig": "CONTAINS" },
        { "fieldPath": "isActive", "order": "ASCENDING" }
      ]
    }
  ]
}
```

## 🚀 Comandos de Ejecución

### Desarrollo Local

```bash
# Con Flutter
flutter run core/scripts/setup_admin_firestore.dart

# Con Firebase CLI
firebase firestore:import admin_data.json
firebase firestore:indexes:set firestore.indexes.json
```

### Producción/CI

```bash
# Usando variables de entorno
export GOOGLE_APPLICATION_CREDENTIALS="service-account-key.json"
dart run scripts/setup_admin_firestore.dart

# O con Firebase CLI en CI
firebase use production
firebase deploy --only firestore:rules,firestore:indexes
```

## ⚠️ Consideraciones de Seguridad

1. **Nunca commitees** `service-account-key.json` al repositorio
2. **Usa variables de entorno** en producción
3. **Configura reglas de seguridad** apropiadas antes de producción
4. **Revoca credenciales** después de configuración inicial si es necesario

## 🔍 Troubleshooting

### Error: "firebase_admin not found"

- El paquete firebase_admin para Dart no está ampliamente disponible
- Usa Flutter + firebase_core en su lugar
- O usa Firebase CLI para tareas administrativas

### Error: "Permission denied"

- Verifica que el service account tenga rol "Firebase Admin"
- Asegúrate de que las reglas de Firestore permitan escritura
- Para testing usa: `allow read, write: if true;`

### Error: "Project not found"

- Verifica el PROJECT_ID en las credenciales
- Asegúrate de que Firebase esté habilitado en el proyecto
- Confirma que Firestore esté inicializado

## 📚 Referencias

- [Firebase Admin SDK](https://firebase.google.com/docs/admin/setup)
- [FlutterFire](https://firebase.flutter.dev/)
- [Firebase CLI](https://firebase.google.com/docs/cli)
- [Firestore REST API](https://firebase.google.com/docs/firestore/use-rest-api)
