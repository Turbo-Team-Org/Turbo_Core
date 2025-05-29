# Guía de Uso - Analytics Repository | Turbo Core

Esta guía explica cómo utilizar el **Analytics Repository** para obtener métricas, insights y análisis avanzados de los negocios en la plataforma Turbo.

## 🎯 **Características Principales**

### ✅ **Funcionalidades Implementadas:**

- ✅ Dashboard completo de métricas de negocio
- ✅ Análisis de tráfico por horas y días
- ✅ Insights avanzados de reseñas y sentimientos
- ✅ Tracking de visitas y conversiones
- ✅ KPIs con comparativas y tendencias
- ✅ Contenido y servicios más populares

### 🚧 **Funcionalidades Preparadas (TODO):**

- 🔄 Análisis predictivo con IA
- 🔄 Reportes personalizados en PDF/Excel
- 🔄 Alertas automáticas por métricas
- 🔄 Comparativas con industria y competidores
- 🔄 Customer Journey y CLV
- 🔄 Analytics geográficos y de dispositivos

---

## 📖 **Modelos Principales**

### **BusinessDashboard**

Dashboard completo con todas las métricas del negocio:

```dart
final dashboard = await analyticsRepository.getDashboardData(
  'place-123',
  DateRange.last30Days(),
);

print('Lugar: ${dashboard.placeName}');
print('Total vistas: ${dashboard.summary.totalViews}');
print('Rating promedio: ${dashboard.summary.averageRating}');
print('KPIs disponibles: ${dashboard.kpiMetrics.length}');
```

### **DateRange**

Manejo flexible de rangos de fechas:

```dart
// Rangos predefinidos
final today = DateRange.today();
final lastWeek = DateRange.last7Days();
final thisMonth = DateRange.thisMonth();

// Rango personalizado
final customRange = DateRange(
  startDate: DateTime(2024, 1, 1),
  endDate: DateTime(2024, 1, 31),
  type: DateRangeType.custom,
);

print(customRange.displayText); // "01/01/2024 - 31/01/2024"
print(customRange.durationInDays); // 31
```

### **KpiMetric**

Métricas con tendencias y comparaciones:

```dart
final dashboard = await analyticsRepository.getDashboardData(placeId, dateRange);

for (final kpi in dashboard.kpiMetrics) {
  print('📊 ${kpi.title}: ${kpi.formattedValue}');
  print('   Cambio: ${kpi.changeText} (${kpi.trend.description})');
  print('   Color: ${kpi.trend.color}');
}
```

---

## 🚀 **Casos de Uso Comunes**

### **1. Dashboard Principal para Panel de Administración**

```dart
import 'package:core/core.dart';
import 'package:get_it/get_it.dart';

class BusinessDashboardCubit extends Cubit<BusinessDashboardState> {
  BusinessDashboardCubit() : super(BusinessDashboardInitial());

  final _analyticsRepository = GetIt.instance<AnalyticsRepository>();

  Future<void> loadDashboard(String placeId) async {
    emit(BusinessDashboardLoading());

    try {
      final dashboard = await _analyticsRepository.getDashboardData(
        placeId,
        DateRange.last30Days(),
      );

      emit(BusinessDashboardLoaded(dashboard));
    } catch (e) {
      emit(BusinessDashboardError(e.toString()));
    }
  }

  Future<void> refreshMetrics(String placeId) async {
    await _analyticsRepository.updateRealTimeMetrics(placeId);
    await loadDashboard(placeId);
  }
}
```

### **2. Widget de KPIs para Dashboard**

```dart
class KpiMetricsWidget extends StatelessWidget {
  const KpiMetricsWidget({
    Key? key,
    required this.metrics,
  }) : super(key: key);

  final List<KpiMetric> metrics;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
      ),
      itemCount: metrics.length,
      itemBuilder: (context, index) {
        final metric = metrics[index];
        return KpiCard(
          title: metric.title,
          value: metric.formattedValue,
          change: metric.changeText,
          trend: metric.trend,
          icon: metric.icon,
        );
      },
    );
  }
}

class KpiCard extends StatelessWidget {
  const KpiCard({
    Key? key,
    required this.title,
    required this.value,
    required this.change,
    required this.trend,
    required this.icon,
  }) : super(key: key);

  final String title;
  final String value;
  final String change;
  final MetricTrend trend;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  _getIconData(icon),
                  size: 24,
                  color: Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
              ],
            ),
            const Spacer(),
            Text(
              value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: [
                Icon(
                  _getTrendIcon(trend),
                  size: 16,
                  color: _getTrendColor(trend),
                ),
                const SizedBox(width: 4),
                Text(
                  change,
                  style: TextStyle(
                    color: _getTrendColor(trend),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'visibility':
        return Icons.visibility;
      case 'star':
        return Icons.star;
      case 'rate_review':
        return Icons.rate_review;
      default:
        return Icons.analytics;
    }
  }

  IconData _getTrendIcon(MetricTrend trend) {
    switch (trend) {
      case MetricTrend.up:
        return Icons.trending_up;
      case MetricTrend.down:
        return Icons.trending_down;
      case MetricTrend.stable:
        return Icons.trending_flat;
    }
  }

  Color _getTrendColor(MetricTrend trend) {
    switch (trend) {
      case MetricTrend.up:
        return Colors.green;
      case MetricTrend.down:
        return Colors.red;
      case MetricTrend.stable:
        return Colors.orange;
    }
  }
}
```

### **3. Tracking de Eventos**

```dart
class AnalyticsTracker {
  static final _analyticsRepository = GetIt.instance<AnalyticsRepository>();

  // Trackear visita a un lugar
  static Future<void> trackPlaceVisit(
    String placeId, {
    String? userId,
    String? source,
    Map<String, dynamic>? additionalData,
  }) async {
    await _analyticsRepository.trackVisit(placeId, {
      'user_id': userId,
      'source': source ?? 'app',
      'timestamp': DateTime.now().toIso8601String(),
      'session_id': _generateSessionId(),
      ...?additionalData,
    });
  }

  // Trackear conversión (favorito, reserva, etc.)
  static Future<void> trackConversion(
    String placeId,
    String conversionType, {
    String? userId,
    double? value,
    Map<String, dynamic>? metadata,
  }) async {
    await _analyticsRepository.trackConversion(
      placeId,
      conversionType,
      {
        'user_id': userId,
        'value': value,
        'currency': 'COP',
        'timestamp': DateTime.now().toIso8601String(),
        ...?metadata,
      },
    );
  }

  static String _generateSessionId() {
    return DateTime.now().millisecondsSinceEpoch.toString();
  }
}

// Uso en la app
await AnalyticsTracker.trackPlaceVisit(
  'place-123',
  userId: 'user-456',
  source: 'search',
);

await AnalyticsTracker.trackConversion(
  'place-123',
  'favorite',
  userId: 'user-456',
);
```

### **4. Análisis de Reviews**

```dart
class ReviewAnalyticsWidget extends StatefulWidget {
  const ReviewAnalyticsWidget({
    Key? key,
    required this.placeId,
  }) : super(key: key);

  final String placeId;

  @override
  State<ReviewAnalyticsWidget> createState() => _ReviewAnalyticsWidgetState();
}

class _ReviewAnalyticsWidgetState extends State<ReviewAnalyticsWidget> {
  ReviewInsights? _insights;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _loadReviewInsights();
  }

  Future<void> _loadReviewInsights() async {
    final analyticsRepository = GetIt.instance<AnalyticsRepository>();

    try {
      final insights = await analyticsRepository.getReviewInsights(
        widget.placeId,
        DateRange.last30Days(),
      );

      setState(() {
        _insights = insights;
        _loading = false;
      });
    } catch (e) {
      setState(() => _loading = false);
      // Manejar error
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loading) {
      return const Center(child: CircularProgressIndicator());
    }

    final insights = _insights;
    if (insights == null) {
      return const Center(child: Text('Error al cargar insights'));
    }

    return Column(
      children: [
        // Rating distribution
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Distribución de Ratings',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                ...insights.ratingDistribution.entries.map((entry) {
                  final stars = entry.key;
                  final count = entry.value;
                  final percentage = insights.totalReviews > 0
                      ? (count / insights.totalReviews) * 100
                      : 0.0;

                  return Row(
                    children: [
                      Text('$stars ⭐'),
                      const SizedBox(width: 8),
                      Expanded(
                        child: LinearProgressIndicator(
                          value: percentage / 100,
                          backgroundColor: Colors.grey[300],
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text('$count (${percentage.toStringAsFixed(1)}%)'),
                    ],
                  );
                }).toList(),
              ],
            ),
          ),
        ),

        // Top keywords
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Palabras Más Mencionadas',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 8,
                  children: insights.topKeywords.map((keyword) {
                    return Chip(
                      label: Text(keyword),
                      backgroundColor: Colors.blue[100],
                    );
                  }).toList(),
                ),
              ],
            ),
          ),
        ),

        // Sentiment analysis
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Análisis de Sentimientos',
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: _SentimentBar(
                        label: 'Positivo',
                        percentage: insights.sentimentAnalysis.positiveScore,
                        color: Colors.green,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _SentimentBar(
                        label: 'Neutral',
                        percentage: insights.sentimentAnalysis.neutralScore,
                        color: Colors.orange,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: _SentimentBar(
                        label: 'Negativo',
                        percentage: insights.sentimentAnalysis.negativeScore,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _SentimentBar extends StatelessWidget {
  const _SentimentBar({
    required this.label,
    required this.percentage,
    required this.color,
  });

  final String label;
  final double percentage;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          '${percentage.toStringAsFixed(1)}%',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        LinearProgressIndicator(
          value: percentage / 100,
          backgroundColor: Colors.grey[300],
          valueColor: AlwaysStoppedAnimation<Color>(color),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
```

---

## 📱 **Integración Completa**

### **Setup en main.dart**

```dart
void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Configurar Firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Inicializar dependencias del core
  await initCoreDependencies(
    firebaseApp: Firebase.app(),
    sl: GetIt.instance,
  );

  runApp(MyApp());
}
```

### **Uso en Cubits/Providers**

```dart
class BusinessAnalyticsCubit extends Cubit<BusinessAnalyticsState> {
  BusinessAnalyticsCubit({
    required this.placeId,
  }) : super(BusinessAnalyticsInitial());

  final String placeId;
  final _analyticsRepository = GetIt.instance<AnalyticsRepository>();

  Future<void> loadAnalytics([DateRange? dateRange]) async {
    emit(BusinessAnalyticsLoading());

    try {
      final range = dateRange ?? DateRange.last30Days();

      final results = await Future.wait([
        _analyticsRepository.getDashboardData(placeId, range),
        _analyticsRepository.getHourlyTraffic(placeId, range),
        _analyticsRepository.getPopularContent(placeId, range),
      ]);

      final dashboard = results[0] as BusinessDashboard;
      final hourlyTraffic = results[1] as List<HourlyData>;
      final popularContent = results[2] as PopularContent;

      emit(BusinessAnalyticsLoaded(
        dashboard: dashboard,
        hourlyTraffic: hourlyTraffic,
        popularContent: popularContent,
      ));
    } catch (e) {
      emit(BusinessAnalyticsError(e.toString()));
    }
  }
}
```

---

## 🎨 **Mejores Prácticas**

### **1. Performance**

```dart
// ✅ Cargar datos en paralelo
final results = await Future.wait([
  analyticsRepository.getDashboardData(placeId, dateRange),
  analyticsRepository.getReviewInsights(placeId, dateRange),
]);

// ❌ Cargar secuencialmente
final dashboard = await analyticsRepository.getDashboardData(placeId, dateRange);
final insights = await analyticsRepository.getReviewInsights(placeId, dateRange);
```

### **2. Manejo de Errores**

```dart
try {
  final dashboard = await analyticsRepository.getDashboardData(placeId, dateRange);
  // Usar dashboard
} catch (e) {
  if (e.toString().contains('Error al obtener datos del dashboard')) {
    // Error específico de analytics
    _showAnalyticsError();
  } else {
    // Error genérico
    _showGenericError();
  }
}
```

### **3. Tracking Automático**

```dart
class PlaceDetailPage extends StatefulWidget {
  const PlaceDetailPage({Key? key, required this.placeId}) : super(key: key);
  final String placeId;

  @override
  State<PlaceDetailPage> createState() => _PlaceDetailPageState();
}

class _PlaceDetailPageState extends State<PlaceDetailPage>
    with WidgetsBindingObserver {
  DateTime? _startTime;

  @override
  void initState() {
    super.initState();
    _startTime = DateTime.now();
    WidgetsBinding.instance.addObserver(this);

    // Track visit
    AnalyticsTracker.trackPlaceVisit(widget.placeId);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);

    // Track session duration
    if (_startTime != null) {
      final duration = DateTime.now().difference(_startTime!);
      GetIt.instance<AnalyticsRepository>().trackSessionDuration(
        widget.placeId,
        duration,
        {'page': 'place_detail'},
      );
    }

    super.dispose();
  }
}
```

---

## 🚀 **Funcionalidades Avanzadas (En Desarrollo)**

Las siguientes funcionalidades están preparadas en la interfaz y se implementarán en futuras versiones:

### **Analytics Predictivos**

```dart
// TODO: Implementar
final predictions = await analyticsRepository.getPredictiveAnalytics(
  placeId,
  30, // días a predecir
);
```

### **Reportes Personalizados**

```dart
// TODO: Implementar
final report = await analyticsRepository.generateCustomReport(
  placeId,
  DateRange.thisMonth(),
  ['views', 'conversions', 'revenue'],
  'pdf',
);
```

### **Alertas Automáticas**

```dart
// TODO: Implementar
await analyticsRepository.setupMetricAlert(
  placeId,
  'views',
  1000, // threshold
  'email',
);
```

Este Analytics Repository te brinda todas las herramientas necesarias para crear dashboards empresariales completos y análisis avanzados que diferenciarán tu plataforma en el mercado. 🎯📊
