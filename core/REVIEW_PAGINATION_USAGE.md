# Uso de Paginación en Reviews - Turbo Core

Este documento explica cómo utilizar el método `getAllReviews` con paginación en el sistema de reviews de Turbo Core.

## Método getAllReviews

El método `getAllReviews` permite obtener todas las reseñas del sistema con soporte completo de paginación y filtrado por estado.

### Sintaxis

```dart
Future<PagedResult<Review>> getAllReviews({
  int page = 1,
  int limit = 20,
  ReviewStatus? status,
})
```

### Parámetros

- **page** (opcional): Número de página a obtener (por defecto: 1)
- **limit** (opcional): Cantidad de elementos por página (por defecto: 20)
- **status** (opcional): Filtrar por estado de la reseña (pending, approved, rejected, etc.)

### Valor de Retorno

Retorna un `PagedResult<Review>` que contiene:

- **items**: Lista de reseñas de la página actual
- **totalCount**: Total de reseñas que coinciden con los filtros
- **currentPage**: Página actual
- **pageSize**: Tamaño de página utilizado
- **totalPages**: Total de páginas disponibles
- **hasNextPage**: Indica si hay una página siguiente
- **hasPreviousPage**: Indica si hay una página anterior

## Ejemplos de Uso

### 1. Obtener todas las reseñas (primera página)

```dart
import 'package:core/core.dart';

// Obtener las primeras 20 reseñas
final result = await reviewRepository.getAllReviews();

print('Total de reseñas: ${result.totalCount}');
print('Página actual: ${result.currentPage}');
print('Reseñas en esta página: ${result.items.length}');

for (final review in result.items) {
  print('${review.userName}: ${review.comment}');
}
```

### 2. Paginación personalizada

```dart
// Obtener la página 3 con 10 reseñas por página
final result = await reviewRepository.getAllReviews(
  page: 3,
  limit: 10,
);

print('Página ${result.currentPage} de ${result.totalPages}');
print('¿Hay página siguiente? ${result.hasNextPage}');
print('¿Hay página anterior? ${result.hasPreviousPage}');
```

### 3. Filtrar por estado de reseña

```dart
// Obtener solo reseñas aprobadas
final approvedReviews = await reviewRepository.getAllReviews(
  status: ReviewStatus.approved,
);

// Obtener reseñas pendientes de moderación
final pendingReviews = await reviewRepository.getAllReviews(
  status: ReviewStatus.pending,
  limit: 50, // Más elementos por página para moderación
);
```

### 4. Implementación de paginación en UI

```dart
class ReviewListWidget extends StatefulWidget {
  @override
  _ReviewListWidgetState createState() => _ReviewListWidgetState();
}

class _ReviewListWidgetState extends State<ReviewListWidget> {
  int currentPage = 1;
  final int pageSize = 20;
  PagedResult<Review>? currentResult;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadReviews();
  }

  Future<void> _loadReviews() async {
    setState(() => isLoading = true);

    try {
      final result = await GetIt.instance<ReviewRepository>().getAllReviews(
        page: currentPage,
        limit: pageSize,
        status: ReviewStatus.approved, // Solo mostrar aprobadas
      );

      setState(() {
        currentResult = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
      // Manejar error
    }
  }

  void _nextPage() {
    if (currentResult?.hasNextPage == true) {
      setState(() => currentPage++);
      _loadReviews();
    }
  }

  void _previousPage() {
    if (currentResult?.hasPreviousPage == true) {
      setState(() => currentPage--);
      _loadReviews();
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    final result = currentResult;
    if (result == null || result.items.isEmpty) {
      return const Center(child: Text('No hay reseñas disponibles'));
    }

    return Column(
      children: [
        // Lista de reseñas
        Expanded(
          child: ListView.builder(
            itemCount: result.items.length,
            itemBuilder: (context, index) {
              final review = result.items[index];
              return ReviewCard(review: review);
            },
          ),
        ),

        // Controles de paginación
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton(
              onPressed: result.hasPreviousPage ? _previousPage : null,
              child: const Text('Anterior'),
            ),

            Text('Página ${result.currentPage} de ${result.totalPages}'),

            ElevatedButton(
              onPressed: result.hasNextPage ? _nextPage : null,
              child: const Text('Siguiente'),
            ),
          ],
        ),
      ],
    );
  }
}
```

## Estados de Review Disponibles

```dart
enum ReviewStatus {
  pending,     // Pendiente de aprobación
  approved,    // Aprobada y visible públicamente
  rejected,    // Rechazada
  underReview, // En revisión/investigación
  flagged,     // Reportada por usuarios
}
```

## Métodos Relacionados

### Otros métodos de paginación disponibles:

- `getReviewsByPlaceId()`: Reseñas de un lugar específico
- `getReviewsByUserId()`: Reseñas de un usuario específico
- `getReviewsByStatus()`: Reseñas filtradas por estado
- `getReviewsPaginated()`: Método más genérico con todos los filtros

### Ejemplo comparativo:

```dart
// Método específico para un lugar
final placeReviews = await reviewRepository.getReviewsByPlaceId(
  'place-123',
  page: 1,
  limit: 10,
  status: ReviewStatus.approved,
);

// Método general (equivalente usando filtros)
final allReviews = await reviewRepository.getReviewsPaginated(
  page: 1,
  limit: 10,
  placeId: 'place-123',
  status: ReviewStatus.approved,
);
```

## Consideraciones de Rendimiento

1. **Límite recomendado**: Entre 10-50 elementos por página
2. **Filtrado**: Usar filtros de estado para reducir la carga
3. **Caché**: Considerar implementar caché local para páginas visitadas
4. **Lazy Loading**: Implementar carga bajo demanda en listas largas

## Manejo de Errores

```dart
try {
  final result = await reviewRepository.getAllReviews();
  // Procesar resultado
} catch (e) {
  if (e.toString().contains('Error al obtener todas las reseñas paginadas')) {
    // Error específico del servicio
    print('Error de conexión o base de datos');
  } else {
    // Error genérico
    print('Error inesperado: $e');
  }
}
```

## Integración con GetIt

```dart
// En tu configuración de dependencias
GetIt.instance.registerLazySingleton<ReviewRepository>(
  () => ReviewRepository(reviewService: GetIt.instance<ReviewService>()),
);

// En tu widget o cubit
final reviewRepository = GetIt.instance<ReviewRepository>();
final reviews = await reviewRepository.getAllReviews();
```
