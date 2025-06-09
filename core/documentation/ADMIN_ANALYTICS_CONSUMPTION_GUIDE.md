# 📊 Guía de Consumo del AnalyticsRepository para Admin Panel

## 🎯 **Arquitectura y Flujo de Datos**

El sistema de analytics sigue Clean Architecture con separación clara de responsabilidades:

```
Admin Panel Frontend
    ↓
AnalyticsCubit (Estado)
    ↓
AnalyticsRepository (Lógica de Negocio)
    ↓
AnalyticsService (Acceso a Datos)
    ↓
Firestore (Base de Datos)
```

## 🔐 **Sistema de Permisos**

### **Roles de Usuario:**

- **Super Admin:** Acceso total a analytics de TODOS los lugares
- **Place Owner:** Solo analytics de SUS lugares asignados

### **Validación de Acceso:**

```dart
// El repository debe validar permisos antes de cada operación
bool canAccessPlace(String placeId, AdminUser currentUser) {
  if (currentUser.role == AdminRole.superAdmin) return true;
  return currentUser.ownedPlaceIds.contains(placeId);
}
```

## 📊 **Métodos Disponibles en AnalyticsRepository**

### **1. Dashboard Principal**

```dart
// Obtener dashboard completo
Future<BusinessDashboard> getDashboardData(String placeId, DateRange dateRange)

// Actualizar métricas en tiempo real
Future<void> updateRealTimeMetrics(String placeId)
```

### **2. Métricas Específicas**

```dart
// Tráfico por horas
Future<List<HourlyData>> getHourlyTraffic(String placeId, DateRange dateRange)

// Tráfico diario
Future<List<DailyData>> getDailyTraffic(String placeId, DateRange dateRange)

// Insights de reseñas
Future<ReviewInsights> getReviewInsights(String placeId, DateRange dateRange)

// Contenido popular
Future<PopularContent> getPopularContent(String placeId, DateRange dateRange)
```

### **3. Análisis Comparativo**

```dart
// Comparar con período anterior
Future<List<ComparisonMetric>> compareWithPreviousPeriod(String placeId, DateRange currentRange)

// Comparar con industria
Future<List<ComparisonMetric>> compareWithIndustry(String placeId, DateRange dateRange, String categoryId)

// Comparar con competidores
Future<List<ComparisonMetric>> compareWithCompetitors(String placeId, DateRange dateRange, List<String> competitorIds)
```

### **4. Análisis Predictivo**

```dart
// Analytics predictivo
Future<Map<String, dynamic>> getPredictiveAnalytics(String placeId, int daysToPredict)

// Análisis de tendencias
Future<Map<String, dynamic>> getTrendAnalysis(String placeId, DateRange dateRange)

// Oportunidades de mejora
Future<List<String>> getImprovementOpportunities(String placeId, DateRange dateRange)
```

### **5. Reportes y Exportación**

```dart
// Generar reporte personalizado
Future<Map<String, dynamic>> generateCustomReport(String placeId, DateRange dateRange, List<String> selectedMetrics, String reportFormat)

// Exportar datos
Future<String> exportAnalyticsData(String placeId, DateRange dateRange, String format)
```

### **6. Configuración de Alertas**

```dart
// Configurar alerta
Future<void> setupMetricAlert(String placeId, String metricName, double threshold, String alertType)

// Obtener alertas
Future<List<Map<String, dynamic>>> getMetricAlerts(String placeId)

// Remover alerta
Future<void> removeMetricAlert(String placeId, String alertId)
```

## 🏗️ **Cómo Implementar en el Admin Panel**

### **Paso 1: Configuración del Cubit**

```dart
// analytics_cubit.dart
class AnalyticsCubit extends Cubit<AnalyticsState> {
  AnalyticsCubit() : super(const AnalyticsState.initial());

  final AnalyticsRepository _analyticsRepository = GetIt.instance<AnalyticsRepository>();

  // Validar permisos antes de cada operación
  bool _canAccessPlace(String placeId, AdminUser currentUser) {
    if (currentUser.role == AdminRole.superAdmin) return true;
    return currentUser.ownedPlaceIds.contains(placeId);
  }

  // Cargar dashboard con validación de permisos
  Future<void> loadDashboard(String placeId, DateRange dateRange, AdminUser currentUser) async {
    if (!_canAccessPlace(placeId, currentUser)) {
      emit(const AnalyticsState.error('Sin permisos para este lugar'));
      return;
    }

    emit(const AnalyticsState.loading());
    try {
      final dashboard = await _analyticsRepository.getDashboardData(placeId, dateRange);
      await _analyticsRepository.updateRealTimeMetrics(placeId);
      emit(AnalyticsState.dashboardLoaded(dashboard));
    } catch (e) {
      emit(AnalyticsState.error('Error: $e'));
    }
  }
}
```

### **Paso 2: Estados del Cubit**

```dart
// analytics_state.dart
@freezed
sealed class AnalyticsState with _$AnalyticsState {
  const factory AnalyticsState.initial() = _Initial;
  const factory AnalyticsState.loading() = _Loading;
  const factory AnalyticsState.dashboardLoaded(BusinessDashboard dashboard) = _DashboardLoaded;
  const factory AnalyticsState.comparisonLoaded(List<ComparisonMetric> comparisons) = _ComparisonLoaded;
  const factory AnalyticsState.error(String message) = _Error;
  // ... más estados según necesidades
}
```

### **Paso 3: Widget de Dashboard**

```dart
// admin_analytics_dashboard.dart
class AdminAnalyticsDashboard extends StatelessWidget {
  const AdminAnalyticsDashboard({
    required this.currentUser,
    required this.selectedPlaceId,
    super.key,
  });

  final AdminUser currentUser;
  final String selectedPlaceId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AnalyticsCubit(),
      child: AdminAnalyticsDashboardView(
        currentUser: currentUser,
        selectedPlaceId: selectedPlaceId,
      ),
    );
  }
}

class AdminAnalyticsDashboardView extends StatefulWidget {
  const AdminAnalyticsDashboardView({
    required this.currentUser,
    required this.selectedPlaceId,
    super.key,
  });

  final AdminUser currentUser;
  final String selectedPlaceId;

  @override
  State<AdminAnalyticsDashboardView> createState() => _AdminAnalyticsDashboardViewState();
}

class _AdminAnalyticsDashboardViewState extends State<AdminAnalyticsDashboardView> {
  late DateRange _selectedDateRange;

  @override
  void initState() {
    super.initState();
    _selectedDateRange = DateRange.lastMonth();
    _loadDashboard();
  }

  void _loadDashboard() {
    context.read<AnalyticsCubit>().loadDashboard(
      widget.selectedPlaceId,
      _selectedDateRange,
      widget.currentUser,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Analytics Dashboard'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadDashboard,
          ),
          IconButton(
            icon: const Icon(Icons.date_range),
            onPressed: _showDateRangePicker,
          ),
        ],
      ),
      body: BlocBuilder<AnalyticsCubit, AnalyticsState>(
        builder: (context, state) {
          return state.when(
            initial: () => const Center(child: Text('Selecciona un rango de fechas')),
            loading: () => const Center(child: CircularProgressIndicator()),
            dashboardLoaded: (dashboard) => _buildDashboard(context, dashboard),
            error: (message) => Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error, size: 64, color: Colors.red),
                  Text(message, style: Theme.of(context).textTheme.titleMedium),
                  ElevatedButton(
                    onPressed: _loadDashboard,
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildDashboard(BuildContext context, BusinessDashboard dashboard) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header con información del lugar
          _buildDashboardHeader(dashboard),

          const SizedBox(height: 24),

          // KPIs principales
          _buildKPISection(dashboard.summary),

          const SizedBox(height: 24),

          // Gráficos de tráfico
          _buildTrafficSection(dashboard.hourlyTraffic, dashboard.dailyTraffic),

          const SizedBox(height: 24),

          // Insights de reseñas
          _buildReviewInsights(dashboard.reviewInsights),

          const SizedBox(height: 24),

          // Contenido popular
          _buildPopularContent(dashboard.popularContent),
        ],
      ),
    );
  }
}
```

## 🔧 **Funcionalidades Específicas por Rol**

### **Super Admin - Funcionalidades Completas:**

```dart
// Super admin puede:
class SuperAdminAnalyticsActions {

  // Ver analytics de CUALQUIER lugar
  Future<void> viewAnyPlaceAnalytics(String placeId) async {
    final cubit = GetIt.instance<AnalyticsCubit>();
    await cubit.loadDashboard(placeId, dateRange, superAdminUser);
  }

  // Inicializar analytics para nuevos lugares
  Future<void> initializeNewPlaceAnalytics(String placeId) async {
    final repository = GetIt.instance<AnalyticsRepository>();
    await repository.initializeAnalyticsStructure(placeId);
  }

  // Comparar con toda la industria
  Future<void> compareWithIndustry(String placeId, String categoryId) async {
    final cubit = GetIt.instance<AnalyticsCubit>();
    await cubit.loadIndustryComparison(
      placeId: placeId,
      dateRange: dateRange,
      categoryId: categoryId,
      currentUser: superAdminUser,
    );
  }

  // Acceso a analytics predictivo avanzado
  Future<void> advancedPredictiveAnalytics(String placeId) async {
    final cubit = GetIt.instance<AnalyticsCubit>();
    await cubit.loadPredictiveAnalytics(
      placeId: placeId,
      daysToPredict: 90, // Puede predecir más días
      currentUser: superAdminUser,
    );
  }
}
```

### **Place Owner - Funcionalidades Limitadas:**

```dart
// Propietario solo puede:
class PlaceOwnerAnalyticsActions {

  // Ver analytics solo de SUS lugares
  Future<void> viewMyPlaceAnalytics(String placeId, AdminUser placeOwner) async {
    if (!placeOwner.ownedPlaceIds.contains(placeId)) {
      throw Exception('No tienes permisos para ver este lugar');
    }

    final cubit = GetIt.instance<AnalyticsCubit>();
    await cubit.loadDashboard(placeId, dateRange, placeOwner);
  }

  // Configurar alertas para sus lugares
  Future<void> setupMyPlaceAlerts(String placeId, AdminUser placeOwner) async {
    final cubit = GetIt.instance<AnalyticsCubit>();
    await cubit.setupMetricAlert(
      placeId: placeId,
      metricName: 'daily_views',
      threshold: 100.0,
      alertType: 'below_threshold',
      currentUser: placeOwner,
    );
  }

  // Generar reportes de sus lugares
  Future<void> generateMyPlaceReport(String placeId, AdminUser placeOwner) async {
    final cubit = GetIt.instance<AnalyticsCubit>();
    await cubit.generateCustomReport(
      placeId: placeId,
      dateRange: DateRange.lastMonth(),
      selectedMetrics: ['views', 'reviews', 'favorites'],
      reportFormat: 'pdf',
      currentUser: placeOwner,
    );
  }
}
```

## 📱 **Implementación en UI**

### **Selector de Lugares (con validación de permisos):**

```dart
class PlaceSelectorWidget extends StatelessWidget {
  const PlaceSelectorWidget({
    required this.currentUser,
    required this.onPlaceSelected,
    super.key,
  });

  final AdminUser currentUser;
  final Function(String placeId) onPlaceSelected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Place>>(
      future: _getAccessiblePlaces(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) return const CircularProgressIndicator();

        final places = snapshot.data!;

        return DropdownButton<String>(
          hint: const Text('Seleccionar lugar'),
          items: places.map((place) => DropdownMenuItem(
            value: place.id,
            child: Text(place.name),
          )).toList(),
          onChanged: onPlaceSelected,
        );
      },
    );
  }

  Future<List<Place>> _getAccessiblePlaces() async {
    final placeRepository = GetIt.instance<PlaceRepository>();

    if (currentUser.role == AdminRole.superAdmin) {
      // Super admin ve todos los lugares
      return await placeRepository.getAllPlaces();
    } else {
      // Propietario solo ve sus lugares
      return await placeRepository.getPlacesByOwnerIds(currentUser.ownedPlaceIds);
    }
  }
}
```

### **Dashboard Responsivo:**

```dart
class ResponsiveAnalyticsDashboard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 1200) {
          // Desktop layout - 3 columnas
          return _buildDesktopLayout();
        } else if (constraints.maxWidth > 800) {
          // Tablet layout - 2 columnas
          return _buildTabletLayout();
        } else {
          // Mobile layout - 1 columna
          return _buildMobileLayout();
        }
      },
    );
  }
}
```

## 🚨 **Manejo de Errores y Estados**

### **Patrones de Error:**

```dart
// En el Cubit
void _handleAnalyticsError(Object error) {
  if (error.toString().contains('permission')) {
    emit(const AnalyticsState.error('Sin permisos para acceder'));
  } else if (error.toString().contains('network')) {
    emit(const AnalyticsState.error('Error de conexión'));
  } else if (error.toString().contains('not_found')) {
    emit(const AnalyticsState.error('Lugar no encontrado'));
  } else {
    emit(AnalyticsState.error('Error inesperado: $error'));
  }
}

// En la UI
Widget _buildErrorState(String message) {
  return Center(
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          message.contains('permisos') ? Icons.lock : Icons.error,
          size: 64,
          color: Colors.red,
        ),
        const SizedBox(height: 16),
        Text(message, textAlign: TextAlign.center),
        const SizedBox(height: 16),
        ElevatedButton(
          onPressed: () => context.read<AnalyticsCubit>().retry(),
          child: const Text('Reintentar'),
        ),
      ],
    ),
  );
}
```

## 🔄 **Actualización en Tiempo Real**

```dart
class RealTimeAnalyticsDashboard extends StatefulWidget {
  @override
  State<RealTimeAnalyticsDashboard> createState() => _RealTimeAnalyticsDashboardState();
}

class _RealTimeAnalyticsDashboardState extends State<RealTimeAnalyticsDashboard> {
  Timer? _refreshTimer;

  @override
  void initState() {
    super.initState();
    _startRealTimeUpdates();
  }

  void _startRealTimeUpdates() {
    _refreshTimer = Timer.periodic(const Duration(minutes: 5), (timer) {
      context.read<AnalyticsCubit>().refreshRealTimeMetrics(
        widget.selectedPlaceId,
        widget.currentUser,
      );
    });
  }

  @override
  void dispose() {
    _refreshTimer?.cancel();
    super.dispose();
  }
}
```

## 🎯 **Flujo Completo de Implementación**

### **1. Inicialización del Admin Panel:**

```dart
// En main.dart del Admin Panel
void main() async {
  // Inicializar dependencias core
  await initCoreDependencies(
    firebaseApp: Firebase.app(),
    sl: GetIt.instance,
  );

  runApp(AdminPanelApp());
}
```

### **2. Login y Validación:**

```dart
// Después del login exitoso
final adminUser = await AdminAuthRepository.getCurrentUser();
if (adminUser != null) {
  Navigator.pushReplacement(
    context,
    MaterialPageRoute(
      builder: (_) => AdminDashboard(currentUser: adminUser),
    ),
  );
}
```

### **3. Dashboard Principal:**

```dart
// En AdminDashboard
class AdminDashboard extends StatelessWidget {
  const AdminDashboard({required this.currentUser});
  final AdminUser currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar con navegación
          AdminSidebar(currentUser: currentUser),

          // Contenido principal
          Expanded(
            child: AdminAnalyticsDashboard(
              currentUser: currentUser,
              selectedPlaceId: selectedPlaceId,
            ),
          ),
        ],
      ),
    );
  }
}
```

## ✅ **Checklist de Implementación**

- [ ] Configurar GetIt con AnalyticsRepository
- [ ] Crear AnalyticsCubit con validación de permisos
- [ ] Implementar estados con Freezed
- [ ] Crear widgets de UI responsivos
- [ ] Implementar selector de lugares con permisos
- [ ] Agregar manejo de errores robusto
- [ ] Configurar actualización en tiempo real
- [ ] Testear con diferentes roles de usuario
- [ ] Implementar exportación de reportes
- [ ] Configurar alertas y notificaciones

¡Con esta arquitectura tendrás un sistema de analytics completo, seguro y escalable para tu Admin Panel! 🚀
