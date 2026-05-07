# Turbo_Core/core — CLAUDE.md (Paquete Dart compartido)

> Subproyecto: paquete Dart **puro** (sin Flutter) que centraliza lógica de negocio, modelos y servicios.
> **Hereda de:** [`../../CLAUDE.md`](../../CLAUDE.md) (workspace).
> Consumido por: `Turbo_App` (mobile) y `Turbo-Admin` (web).

---

## 1. Responsabilidad end-to-end del subproyecto

**Turbo_Core** es la **única fuente de verdad** para:

1. **Modelos de dominio** (`Place`, `Review`, `Payment`, `Reservation`, `User`, etc.) → freezed + json_serializable.
2. **Interfaces** (contratos abstractos por feature).
3. **Servicios** (implementación Supabase / Edge Functions).
4. **Repositorios** (facades para uso desde clientes).
5. **Excepciones y failures** tipadas por feature.
6. **Utilidades cross-platform** (validators, distance calculators, etc.).

**Lo que NUNCA debe hacer:**
- ❌ Importar `flutter` o `flutter/material`. Es Dart puro.
- ❌ Tener UI, theming, l10n. Eso es responsabilidad de los clientes.
- ❌ Depender de GetIt o de cualquier framework de DI. Inyección por constructor.
- ❌ Hacer side effects ocultos (logging, analytics, navegación).
- ❌ Acoplar lógica de negocio a Supabase (siempre detrás de una `Interface`).

---

## 2. Estructura por repositorio

Cada feature en Core sigue **exactamente** esta estructura:

```
lib/src/turbo_core_repositories/<feature>/
├── interface/
│   └── <feature>_interface.dart           # abstract class — contrato
├── models/
│   ├── <model_a>.dart                     # @freezed
│   ├── <model_a>.freezed.dart             # generado
│   ├── <model_a>.g.dart                   # generado (json_serializable)
│   └── <enum_b>.dart                      # enums tipados
├── service/
│   ├── <feature>_service.dart             # abstract class (si hay > 1 impl)
│   └── <feature>_service_supabase.dart    # implementación principal
├── repository/                            # opcional (facade)
│   └── <feature>_repository.dart
├── error_management/
│   ├── exceptions/<feature>_exception.dart
│   └── failures/<feature>_failure.dart
├── examples/                              # opcional
│   └── <feature>_example.dart
├── <feature>_repository.dart              # barrel principal
└── <feature>_repository_imports.dart      # exports
```

Repositorios actuales:

```
admin_auth_repository
ai_repository                  ✅ completo (Edge Functions)
analytics_repository           ✅ completo
authentication_repository      ✅ completo
category_repository            ✅ completo
common
event_repository               ✅ completo
favorite_repository            ✅ completo
location_repository            ⚠️ stubs en Google Places (search/details/autocomplete)
payment_repository             ✅ completo (TropiPay)
place_category_repository      ✅ completo
place_repository               ✅ completo
reservation_repository         ✅ completo
review_repository              ✅ completo
```

---

## 3. Patrones obligatorios

### 3.1 Modelo con freezed

```dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'review.freezed.dart';
part 'review.g.dart';

@freezed
class Review with _$Review {
  const factory Review({
    required String id,
    required String placeId,
    required String userId,
    required int rating,
    required String text,
    required DateTime createdAt,
    @Default(ReviewStatus.pending) ReviewStatus status,
  }) = _Review;

  factory Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);
}
```

**Reglas:**
- Inmutables, con factories nombrados solo si hay variantes.
- Siempre con `fromJson` cuando vengan de Supabase.
- Enums propios para estados (`ReviewStatus`, `PaymentStatus`, etc.).

### 3.2 Interface (contrato)

```dart
abstract class ReviewInterface {
  Future<List<Review>> getReviewsForPlace(String placeId);
  Future<Review> createReview({required Review review});
  Future<Review> updateReview({required Review review});
  Future<void> deleteReview({required String reviewId});
  Future<ReviewInsights> getReviewInsights(String placeId);
}
```

- Solo métodos públicos del feature.
- Nunca `SupabaseClient` ni detalles de implementación.

### 3.3 Service (implementación Supabase)

```dart
class ReviewServiceSupabase implements ReviewInterface {
  ReviewServiceSupabase({SupabaseClient? supabaseClient})
      : _supabase = supabaseClient ?? Supabase.instance.client;

  final SupabaseClient _supabase;

  @override
  Future<List<Review>> getReviewsForPlace(String placeId) async {
    try {
      final response = await _supabase
          .from('reviews')
          .select()
          .eq('place_id', placeId)
          .order('created_at', ascending: false);
      return (response as List)
          .map((e) => Review.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw ReviewException.fromError(e);
    }
  }
}
```

**Reglas:**
- Constructor con `SupabaseClient?` opcional (para tests).
- Toda excepción de Supabase se traduce a `<Feature>Exception` tipada.
- No silenciar errores: re-lanzar siempre.

### 3.4 Excepciones tipadas

```dart
sealed class ReviewException implements Exception {
  const ReviewException(this.message);
  final String message;

  factory ReviewException.fromError(Object error) {
    if (error is PostgrestException) return ReviewDatabaseException(error.message);
    if (error is AuthException) return ReviewAuthException(error.message);
    return ReviewUnknownException(error.toString());
  }
}

class ReviewDatabaseException extends ReviewException {
  const ReviewDatabaseException(super.message);
}
class ReviewAuthException extends ReviewException {
  const ReviewAuthException(super.message);
}
class ReviewUnknownException extends ReviewException {
  const ReviewUnknownException(super.message);
}
```

### 3.5 Edge Functions (Dio)

Para servicios que llaman a Supabase Edge Functions (ej: AI, Analytics avanzado, Payments):

```dart
class AiServiceEdge implements AiInterface {
  final Dio _dio;
  final String _baseUrl;

  AiServiceEdge({Dio? dio, required String baseUrl})
      : _dio = dio ?? Dio(),
        _baseUrl = baseUrl;

  @override
  Future<AiChatResponse> chatCompletion(List<AiMessage> messages) async {
    try {
      final response = await _dio.post(
        '$_baseUrl/chat-completion',
        data: {'messages': messages.map((m) => m.toJson()).toList()},
      );
      return AiChatResponse.fromJson(response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      throw AiException.fromDio(e);
    }
  }
}
```

---

## 4. Tests del Core

### Estructura
```
test/src/turbo_core_repositories/<feature>/
├── <feature>_repository_test.dart
└── service/
    └── <feature>_service_test.dart
```

### Cobertura mínima: **85%**

### Plantilla de test

```dart
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class MockSupabaseClient extends Mock implements SupabaseClient {}
class MockSupabaseQueryBuilder extends Mock implements SupabaseQueryBuilder {}

void main() {
  late ReviewServiceSupabase service;
  late MockSupabaseClient mockSupabase;

  setUp(() {
    mockSupabase = MockSupabaseClient();
    service = ReviewServiceSupabase(supabaseClient: mockSupabase);
  });

  group('ReviewServiceSupabase', () {
    group('getReviewsForPlace', () {
      test('returns list when query succeeds', () async {
        // Arrange / Act / Assert
      });

      test('throws ReviewDatabaseException on PostgrestException', () async {
        // ...
      });
    });
  });
}
```

---

## 5. Reglas inquebrantables

1. **Dart puro**, sin imports de `flutter/`.
2. **Toda interacción con backend va detrás de una `Interface`**.
3. **Excepciones siempre tipadas** por feature (`<Feature>Exception` sealed).
4. **Modelos siempre `@freezed`** + `fromJson` si vienen de la red.
5. **Constructor con `SupabaseClient?` opcional** para testabilidad.
6. **No usar print/debugPrint**. Para logging usar el callback opcional `onLog` o lanzar excepciones.
7. **Sin DI dentro del Core** — los clientes inyectan.
8. **Build runner** tras tocar `@freezed`:

```bash
cd Turbo_Core/core && dart run build_runner build --delete-conflicting-outputs
```

---

## 6. Comandos

```bash
cd Turbo_Core/core

# Setup
dart pub get

# Code generation
dart run build_runner build --delete-conflicting-outputs
dart run build_runner watch    # modo watch durante desarrollo

# Tests
flutter test
flutter test --coverage
genhtml coverage/lcov.info -o coverage/html

# Análisis
dart analyze lib/ --no-fatal-infos
```

---

## 7. Cómo añadir un nuevo repositorio (checklist)

1. Crear carpeta `lib/src/turbo_core_repositories/<feature>/`.
2. Crear `interface/<feature>_interface.dart` con los métodos públicos.
3. Crear `models/` con todos los modelos `@freezed` + enums.
4. Crear `error_management/exceptions/<feature>_exception.dart` (sealed).
5. Crear `service/<feature>_service_supabase.dart` que implementa la interface.
6. Crear `<feature>_repository.dart` (barrel principal).
7. Añadir export en `lib/src/turbo_core_repositories/turbo_core_repositories.dart`.
8. Tests: `test/src/turbo_core_repositories/<feature>/service/<feature>_service_test.dart` (≥85% coverage).
9. Ejecutar build_runner.
10. Verificar con `dart analyze`.

---

## 8. Estado actual (verificado)

| Repositorio | Service | Estado |
|---|---|---|
| `review_repository` | Supabase | ✅ Completo + tests |
| `payment_repository` | TropiPay + Supabase | ✅ Completo (listo para **Post-MVP**; MVP App no expone checkout — reservas gratis) |
| `ai_repository` | Edge Functions (Dio) | ✅ Completo |
| `analytics_repository` | Supabase + Edge | ✅ Completo (sin tests) |
| `location_repository` | Supabase + Geolocator | ⚠️ `searchPlaces`, `getPlaceDetails`, `autocompletePlaces`, `searchNearbyPlaces` retornan `[]` con `print` |
| `authentication_repository` | Supabase Auth | ✅ Completo |
| `place_repository` | Supabase | ✅ Completo |
| `reservation_repository` | Supabase | ✅ Completo |
| `event_repository` | Supabase | ✅ Completo |
| `favorite_repository` | Supabase | ✅ Completo |
| `category_repository` | Supabase | ✅ Completo |
| `place_category_repository` | Supabase | ✅ Completo |
| `admin_auth_repository` | Supabase | ✅ Completo |

Tareas pendientes en Core (ver sprints):
- **Sprint 2 / `google-places-api`**: completar stubs en `location_repository`.
- **Sprint 2 / `analytics-validate`**: añadir tests al `analytics_repository`.

---

## 9. Referencias

- **Workspace** (paraguas): [`../../CLAUDE.md`](../../CLAUDE.md)
- **Sprints:** [`../../.claude/sprints/`](../../.claude/sprints/)
- **Backlog completo:** [`../../.claude/MVP_FEATURES_BACKLOG.md`](../../.claude/MVP_FEATURES_BACKLOG.md)
