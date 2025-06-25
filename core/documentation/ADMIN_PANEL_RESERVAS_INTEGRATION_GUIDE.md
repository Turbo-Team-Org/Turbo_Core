# 🖥️ **Guía de Integración - Sistema de Reservas para Admin Panel**

## 🎯 **Resumen para Developers de Flutter Admin**

El **Admin Panel Turbo** debe integrar el **sistema completo de gestión de reservas** desde **Turbo Core**. Esta guía te explica exactamente cómo implementar todas las funcionalidades que los administradores de negocios necesitan.

## 🚀 **1. Configuración Inicial**

### **Dependency Injection**

```dart
// En tu archivo main.dart o dependency_injection.dart del Admin Panel
void setupAdminRepositories() {
  GetIt.instance.registerLazySingleton<ReservationRepository>(
    () => ReservationRepository(),
  );
}

// En tus páginas/cubit
final reservationRepo = GetIt.instance<ReservationRepository>();
```

### **Importaciones Necesarias**

```dart
// En tus archivos Flutter Admin
import 'package:core/core.dart';

// Modelos específicos que usarás
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/business_availability.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_settings.dart';
```

## 📊 **2. Dashboard Principal - Vista General**

### **ReservationDashboardCubit**

```dart
class ReservationDashboardCubit extends Cubit<ReservationDashboardState> {
  final ReservationRepository _reservationRepo;
  final String placeId;

  ReservationDashboardCubit(this._reservationRepo, this.placeId)
      : super(const ReservationDashboardState());

  // Cargar dashboard completo
  Future<void> loadDashboard() async {
    try {
      emit(state.copyWith(isLoading: true));

      // Cargar datos en paralelo
      final results = await Future.wait([
        _reservationRepo.getTodayReservations(placeId),
        _reservationRepo.getPlaceReservations(placeId, status: ReservationStatus.pending),
        _reservationRepo.getReservationsBetweenDates(
          placeId,
          DateTime.now(),
          DateTime.now().add(const Duration(days: 7)),
        ),
        _getReservationStats(),
      ]);

      final todayReservations = results[0] as List<Reservation>;
      final pendingReservations = results[1] as List<Reservation>;
      final weekReservations = results[2] as List<Reservation>;
      final stats = results[3] as ReservationStats;

      emit(state.copyWith(
        todayReservations: todayReservations,
        pendingReservations: pendingReservations,
        weekReservations: weekReservations,
        stats: stats,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Error cargando dashboard: $e',
        isLoading: false,
      ));
    }
  }

  // Stream en tiempo real
  void startRealtimeUpdates() {
    _reservationRepo.watchPlaceReservations(placeId).listen(
      (reservations) {
        emit(state.copyWith(allReservations: reservations));
      },
    );
  }

  Future<ReservationStats> _getReservationStats() async {
    final today = DateTime.now();
    final startOfMonth = DateTime(today.year, today.month, 1);

    final monthReservations = await _reservationRepo.getReservationsBetweenDates(
      placeId,
      startOfMonth,
      today,
    );

    return ReservationStats(
      totalThisMonth: monthReservations.length,
      completedThisMonth: monthReservations.where((r) => r.status == ReservationStatus.completed).length,
      cancelledThisMonth: monthReservations.where((r) => r.status == ReservationStatus.cancelled).length,
      averagePartySize: monthReservations.isEmpty ? 0 :
        monthReservations.map((r) => r.partySize).reduce((a, b) => a + b) / monthReservations.length,
    );
  }
}
```

### **Dashboard UI**

```dart
class ReservationDashboardPage extends StatelessWidget {
  final String placeId;

  const ReservationDashboardPage({required this.placeId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ReservationDashboardCubit(
        GetIt.instance<ReservationRepository>(),
        placeId,
      )..loadDashboard()..startRealtimeUpdates(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dashboard de Reservas'),
          actions: [
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () => _navigateToSettings(context),
            ),
          ],
        ),
        body: BlocBuilder<ReservationDashboardCubit, ReservationDashboardState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // KPIs Cards
                  _buildKPICards(state.stats),

                  const SizedBox(height: 20),

                  // Reservas pendientes (urgente)
                  if (state.pendingReservations.isNotEmpty)
                    _buildPendingReservationsCard(state.pendingReservations),

                  const SizedBox(height: 20),

                  // Reservas de hoy
                  _buildTodayReservationsSection(state.todayReservations),

                  const SizedBox(height: 20),

                  // Próximas reservas (esta semana)
                  _buildUpcomingReservationsSection(state.weekReservations),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _navigateToAvailabilitySettings(context),
          icon: const Icon(Icons.schedule),
          label: const Text('Configurar Horarios'),
        ),
      ),
    );
  }

  Widget _buildKPICards(ReservationStats? stats) {
    if (stats == null) return const SizedBox();

    return Row(
      children: [
        Expanded(
          child: _KPICard(
            title: 'Este Mes',
            value: '${stats.totalThisMonth}',
            subtitle: 'reservas',
            color: Colors.blue,
            icon: Icons.calendar_month,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _KPICard(
            title: 'Completadas',
            value: '${stats.completedThisMonth}',
            subtitle: 'exitosas',
            color: Colors.green,
            icon: Icons.check_circle,
          ),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: _KPICard(
            title: 'Promedio',
            value: '${stats.averagePartySize.toStringAsFixed(1)}',
            subtitle: 'personas',
            color: Colors.orange,
            icon: Icons.people,
          ),
        ),
      ],
    );
  }

  Widget _buildPendingReservationsCard(List<Reservation> pending) {
    return Card(
      color: Colors.orange.shade50,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.pending_actions, color: Colors.orange.shade700),
                const SizedBox(width: 8),
                Text(
                  '${pending.length} Reservas Pendientes',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.orange.shade700,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...pending.take(3).map((reservation) =>
              _PendingReservationTile(reservation: reservation)
            ),
            if (pending.length > 3)
              TextButton(
                onPressed: () => _navigateToPendingReservations(context),
                child: Text('Ver todas las ${pending.length} pendientes'),
              ),
          ],
        ),
      ),
    );
  }
}

class _KPICard extends StatelessWidget {
  final String title, value, subtitle;
  final Color color;
  final IconData icon;

  const _KPICard({
    required this.title,
    required this.value,
    required this.subtitle,
    required this.color,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 20),
                const SizedBox(width: 8),
                Text(title, style: const TextStyle(fontSize: 12, color: Colors.grey)),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              value,
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: color,
              ),
            ),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}
```

## 📋 **3. Gestión de Reservas - CRUD Completo**

### **ReservationManagementCubit**

```dart
class ReservationManagementCubit extends Cubit<ReservationManagementState> {
  final ReservationRepository _reservationRepo;
  final String placeId;

  // Confirmar reserva
  Future<void> confirmReservation({
    required String reservationId,
    String? tableNumber,
    String? notes,
  }) async {
    try {
      emit(state.copyWith(isProcessing: true));

      await _reservationRepo.confirmReservation(
        reservationId,
        tableNumber: tableNumber,
        notes: notes,
      );

      emit(state.copyWith(
        isProcessing: false,
        success: 'Reserva confirmada exitosamente',
      ));

      // Recargar datos
      await loadReservations();
    } catch (e) {
      emit(state.copyWith(
        error: 'Error confirmando reserva: $e',
        isProcessing: false,
      ));
    }
  }

  // Rechazar reserva
  Future<void> rejectReservation({
    required String reservationId,
    required String reason,
  }) async {
    try {
      emit(state.copyWith(isProcessing: true));

      await _reservationRepo.rejectReservation(reservationId, reason: reason);

      emit(state.copyWith(
        isProcessing: false,
        success: 'Reserva rechazada',
      ));

      await loadReservations();
    } catch (e) {
      emit(state.copyWith(
        error: 'Error rechazando reserva: $e',
        isProcessing: false,
      ));
    }
  }

  // Check-in del cliente
  Future<void> checkInReservation({
    required String reservationId,
    String? notes,
  }) async {
    try {
      await _reservationRepo.checkInReservation(reservationId, notes: notes);
      emit(state.copyWith(success: 'Check-in realizado'));
      await loadReservations();
    } catch (e) {
      emit(state.copyWith(error: 'Error en check-in: $e'));
    }
  }

  // Completar reserva
  Future<void> completeReservation({
    required String reservationId,
    String? notes,
  }) async {
    try {
      await _reservationRepo.completeReservation(reservationId, notes: notes);
      emit(state.copyWith(success: 'Reserva completada'));
      await loadReservations();
    } catch (e) {
      emit(state.copyWith(error: 'Error completando reserva: $e'));
    }
  }

  // Marcar como no-show
  Future<void> markNoShow({
    required String reservationId,
    String? notes,
  }) async {
    try {
      await _reservationRepo.markNoShow(reservationId, notes: notes);
      emit(state.copyWith(success: 'Marcado como no-show'));
      await loadReservations();
    } catch (e) {
      emit(state.copyWith(error: 'Error marcando no-show: $e'));
    }
  }
}
```

### **Reservation Management UI**

```dart
class ReservationManagementPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gestión de Reservas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Pendientes', icon: Icon(Icons.pending)),
              Tab(text: 'Hoy', icon: Icon(Icons.today)),
              Tab(text: 'Próximas', icon: Icon(Icons.upcoming)),
              Tab(text: 'Historial', icon: Icon(Icons.history)),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            _PendingReservationsTab(),
            _TodayReservationsTab(),
            _UpcomingReservationsTab(),
            _ReservationHistoryTab(),
          ],
        ),
      ),
    );
  }
}

class _PendingReservationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ReservationManagementCubit, ReservationManagementState>(
      builder: (context, state) {
        final pendingReservations = state.reservations
            .where((r) => r.status == ReservationStatus.pending)
            .toList();

        if (pendingReservations.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.check_circle, size: 64, color: Colors.green),
                SizedBox(height: 16),
                Text('¡Todas las reservas están gestionadas!'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: pendingReservations.length,
          itemBuilder: (context, index) {
            final reservation = pendingReservations[index];
            return PendingReservationCard(
              reservation: reservation,
              onConfirm: () => _showConfirmDialog(context, reservation),
              onReject: () => _showRejectDialog(context, reservation),
            );
          },
        );
      },
    );
  }

  void _showConfirmDialog(BuildContext context, Reservation reservation) {
    showDialog(
      context: context,
      builder: (context) => ConfirmReservationDialog(reservation: reservation),
    );
  }

  void _showRejectDialog(BuildContext context, Reservation reservation) {
    showDialog(
      context: context,
      builder: (context) => RejectReservationDialog(reservation: reservation),
    );
  }
}

class PendingReservationCard extends StatelessWidget {
  final Reservation reservation;
  final VoidCallback onConfirm;
  final VoidCallback onReject;

  const PendingReservationCard({
    required this.reservation,
    required this.onConfirm,
    required this.onReject,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header con tiempo restante
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  reservation.customerName,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                _buildUrgencyChip(reservation),
              ],
            ),

            const SizedBox(height: 12),

            // Información de la reserva
            _buildReservationInfo(),

            const SizedBox(height: 16),

            // Botones de acción
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onReject,
                    icon: const Icon(Icons.close, color: Colors.red),
                    label: const Text('Rechazar'),
                    style: OutlinedButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: onConfirm,
                    icon: const Icon(Icons.check),
                    label: const Text('Confirmar'),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildReservationInfo() {
    return Column(
      children: [
        _InfoRow(
          icon: Icons.calendar_today,
          label: 'Fecha',
          value: reservation.formattedDate,
        ),
        _InfoRow(
          icon: Icons.access_time,
          label: 'Hora',
          value: reservation.formattedTime,
        ),
        _InfoRow(
          icon: Icons.people,
          label: 'Personas',
          value: '${reservation.partySize}',
        ),
        if (reservation.specialRequests?.isNotEmpty ?? false)
          _InfoRow(
            icon: Icons.note,
            label: 'Solicitudes',
            value: reservation.specialRequests!,
          ),
      ],
    );
  }

  Widget _buildUrgencyChip(Reservation reservation) {
    final hoursUntil = reservation.startTime.difference(DateTime.now()).inHours;

    if (hoursUntil < 2) {
      return Chip(
        label: const Text('URGENTE'),
        backgroundColor: Colors.red.shade100,
        side: BorderSide(color: Colors.red.shade400),
      );
    } else if (hoursUntil < 24) {
      return Chip(
        label: const Text('HOY'),
        backgroundColor: Colors.orange.shade100,
        side: BorderSide(color: Colors.orange.shade400),
      );
    }

    return Chip(
      label: Text('${hoursUntil}h'),
      backgroundColor: Colors.blue.shade100,
      side: BorderSide(color: Colors.blue.shade400),
    );
  }
}
```

## ⚙️ **4. Configuración de Disponibilidad**

### **AvailabilitySettingsCubit**

```dart
class AvailabilitySettingsCubit extends Cubit<AvailabilitySettingsState> {
  final ReservationRepository _reservationRepo;
  final String placeId;

  // Configurar disponibilidad básica (primera vez)
  Future<void> setupBasicAvailability({
    required String openTime,
    required String closeTime,
    required List<int> closedDays,
    required int maxCapacityPerSlot,
  }) async {
    try {
      emit(state.copyWith(isSaving: true));

      await _reservationRepo.setupBasicAvailability(
        placeId: placeId,
        createdBy: 'admin_user_id', // Obtener del auth
        openTime: openTime,
        closeTime: closeTime,
        closedDays: closedDays,
        maxCapacityPerSlot: maxCapacityPerSlot,
      );

      emit(state.copyWith(
        isSaving: false,
        success: 'Disponibilidad configurada exitosamente',
      ));

      await loadCurrentAvailability();
    } catch (e) {
      emit(state.copyWith(
        error: 'Error configurando disponibilidad: $e',
        isSaving: false,
      ));
    }
  }

  // Actualizar horarios semanales
  Future<void> updateWeeklySchedule(List<WeeklySchedule> schedule) async {
    try {
      emit(state.copyWith(isSaving: true));

      await _reservationRepo.updateWeeklySchedule(placeId, schedule);

      emit(state.copyWith(
        isSaving: false,
        success: 'Horarios actualizados',
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Error actualizando horarios: $e',
        isSaving: false,
      ));
    }
  }

  // Agregar día especial
  Future<void> addSpecialDay(SpecialDay specialDay) async {
    try {
      await _reservationRepo.addSpecialDay(placeId, specialDay);
      emit(state.copyWith(success: 'Día especial agregado'));
      await loadCurrentAvailability();
    } catch (e) {
      emit(state.copyWith(error: 'Error agregando día especial: $e'));
    }
  }

  // Bloquear fechas
  Future<void> addBlackoutDate(BlackoutDate blackoutDate) async {
    try {
      await _reservationRepo.addBlackoutDate(placeId, blackoutDate);
      emit(state.copyWith(success: 'Fecha bloqueada'));
      await loadCurrentAvailability();
    } catch (e) {
      emit(state.copyWith(error: 'Error bloqueando fecha: $e'));
    }
  }
}
```

### **Availability Settings UI**

```dart
class AvailabilitySettingsPage extends StatelessWidget {
  final String placeId;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AvailabilitySettingsCubit(
        GetIt.instance<ReservationRepository>(),
        placeId,
      )..loadCurrentAvailability(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Configurar Disponibilidad'),
          actions: [
            IconButton(
              icon: const Icon(Icons.help_outline),
              onPressed: () => _showHelpDialog(context),
            ),
          ],
        ),
        body: BlocBuilder<AvailabilitySettingsCubit, AvailabilitySettingsState>(
          builder: (context, state) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Estado actual
                  _buildCurrentStatusCard(state.availability),

                  const SizedBox(height: 20),

                  // Configuración semanal
                  _buildWeeklyScheduleSection(state.availability?.weeklySchedule ?? []),

                  const SizedBox(height: 20),

                  // Días especiales
                  _buildSpecialDaysSection(state.availability?.specialDays ?? []),

                  const SizedBox(height: 20),

                  // Fechas bloqueadas
                  _buildBlackoutDatesSection(state.availability?.blackoutDates ?? []),
                ],
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () => _showQuickSetupDialog(context),
          icon: const Icon(Icons.flash_on),
          label: const Text('Configuración Rápida'),
        ),
      ),
    );
  }

  Widget _buildWeeklyScheduleSection(List<WeeklySchedule> schedule) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Horarios Semanales',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                TextButton.icon(
                  onPressed: () => _showEditScheduleDialog(context, schedule),
                  icon: const Icon(Icons.edit),
                  label: const Text('Editar'),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ...List.generate(7, (index) {
              final daySchedule = schedule.firstWhere(
                (s) => s.dayOfWeek == index + 1,
                orElse: () => WeeklySchedule(
                  dayOfWeek: index + 1,
                  isOpen: false,
                  timeRanges: [],
                ),
              );

              return _WeeklyScheduleTile(
                dayName: _getDayName(index + 1),
                schedule: daySchedule,
              );
            }),
          ],
        ),
      ),
    );
  }

  String _getDayName(int dayOfWeek) {
    const days = ['Lunes', 'Martes', 'Miércoles', 'Jueves', 'Viernes', 'Sábado', 'Domingo'];
    return days[dayOfWeek - 1];
  }
}
```

## 📊 **5. Configuración de Políticas de Reserva**

### **ReservationPoliciesCubit**

```dart
class ReservationPoliciesCubit extends Cubit<ReservationPoliciesState> {
  final ReservationRepository _reservationRepo;
  final String placeId;

  // Actualizar configuraciones
  Future<void> updateReservationSettings(ReservationSettings settings) async {
    try {
      emit(state.copyWith(isSaving: true));

      await _reservationRepo.updateReservationSettings(settings);

      emit(state.copyWith(
        settings: settings,
        isSaving: false,
        success: 'Configuraciones actualizadas',
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Error actualizando configuraciones: $e',
        isSaving: false,
      ));
    }
  }

  // Presets comunes
  Future<void> applyRestaurantPreset() async {
    final settings = ReservationSettings(
      id: placeId,
      placeId: placeId,
      acceptsReservations: true,
      defaultSlotDuration: 120, // 2 horas
      minPartySize: 1,
      maxPartySize: 8,
      maxAdvanceBookingDays: 30,
      minAdvanceBookingHours: 2,
      requiresConfirmation: true,
      allowCancellation: true,
      allowModification: true,
      cancellationHours: 24,
      modificationHours: 4,
      sendConfirmationEmail: true,
      sendReminderEmail: true,
      reminderHours: 2,
      createdAt: DateTime.now(),
    );

    await updateReservationSettings(settings);
  }

  Future<void> applyCafePreset() async {
    final settings = ReservationSettings(
      id: placeId,
      placeId: placeId,
      acceptsReservations: true,
      defaultSlotDuration: 60, // 1 hora
      minPartySize: 1,
      maxPartySize: 6,
      maxAdvanceBookingDays: 7,
      minAdvanceBookingHours: 1,
      requiresConfirmation: false, // Confirmación automática
      allowCancellation: true,
      allowModification: true,
      cancellationHours: 2,
      modificationHours: 1,
      sendConfirmationEmail: true,
      sendReminderEmail: false,
      reminderHours: 0,
      createdAt: DateTime.now(),
    );

    await updateReservationSettings(settings);
  }
}
```

## 🎯 **6. Estados y Modelos para Admin**

```dart
// Estados para Dashboard
@freezed
class ReservationDashboardState with _$ReservationDashboardState {
  const factory ReservationDashboardState({
    @Default(false) bool isLoading,
    @Default([]) List<Reservation> todayReservations,
    @Default([]) List<Reservation> pendingReservations,
    @Default([]) List<Reservation> weekReservations,
    @Default([]) List<Reservation> allReservations,
    ReservationStats? stats,
    String? error,
  }) = _ReservationDashboardState;
}

// Estados para Management
@freezed
class ReservationManagementState with _$ReservationManagementState {
  const factory ReservationManagementState({
    @Default(false) bool isLoading,
    @Default(false) bool isProcessing,
    @Default([]) List<Reservation> reservations,
    String? error,
    String? success,
  }) = _ReservationManagementState;
}

// Estados para Settings
@freezed
class AvailabilitySettingsState with _$AvailabilitySettingsState {
  const factory AvailabilitySettingsState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    BusinessAvailability? availability,
    String? error,
    String? success,
  }) = _AvailabilitySettingsState;
}

// Modelo de estadísticas
@freezed
class ReservationStats with _$ReservationStats {
  const factory ReservationStats({
    required int totalThisMonth,
    required int completedThisMonth,
    required int cancelledThisMonth,
    required double averagePartySize,
  }) = _ReservationStats;
}
```

## 🚀 **7. Navegación y Routing**

```dart
class AdminReservationRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/reservations/dashboard':
        final placeId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ReservationDashboardPage(placeId: placeId),
        );

      case '/reservations/management':
        final placeId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ReservationManagementPage(placeId: placeId),
        );

      case '/reservations/availability':
        final placeId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => AvailabilitySettingsPage(placeId: placeId),
        );

      case '/reservations/policies':
        final placeId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => ReservationPoliciesPage(placeId: placeId),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundPage(),
        );
    }
  }
}
```

## ✅ **8. Checklist de Implementación**

### **Para el Developer del Admin Panel:**

- [ ] Configurar dependency injection del ReservationRepository
- [ ] Implementar ReservationDashboardPage con KPIs y tiempo real
- [ ] Crear ReservationManagementPage con tabs y acciones CRUD
- [ ] Desarrollar AvailabilitySettingsPage con configuración de horarios
- [ ] Implementar ReservationPoliciesPage con presets y configuraciones
- [ ] Agregar navegación desde el menú principal del admin
- [ ] Implementar notificaciones push para reservas pendientes
- [ ] Testing de todas las funcionalidades
- [ ] Manejo de permisos y roles de administrador

### **Funcionalidades Clave:**

- [ ] Dashboard con métricas en tiempo real
- [ ] Gestión de reservas pendientes (confirmar/rechazar)
- [ ] Check-in y checkout de clientes
- [ ] Configuración de horarios semanales
- [ ] Días especiales y fechas bloqueadas
- [ ] Políticas de cancelación y modificación
- [ ] Reportes y analytics
- [ ] Notificaciones automáticas

## 🎯 **¡Listo para Implementar!**

Con esta guía tienes **todo lo necesario** para integrar completamente el sistema de reservas en el Admin Panel. El sistema está **100% implementado en el Core** y solo necesitas conectar la UI de Flutter Admin con los servicios.

**¿Necesitas ayuda específica con algún componente del admin?**
