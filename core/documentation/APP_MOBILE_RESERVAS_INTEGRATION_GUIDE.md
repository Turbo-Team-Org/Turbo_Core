# 📱 **Guía de Integración - Sistema de Reservas para App Mobile**

## 🎯 **Resumen para Developers de Flutter**

La **App Mobile Turbo** debe integrar el **sistema de reservas completo** desde **Turbo Core**. Esta guía te explica exactamente cómo implementar todas las funcionalidades de reservas que los usuarios finales necesitan.

## 🚀 **1. Configuración Inicial**

### **Dependency Injection**

Agrega el `ReservationRepository` a tu dependency injection:

```dart
// En tu archivo main.dart o dependency_injection.dart
void setupRepositories() {
  GetIt.instance.registerLazySingleton<ReservationRepository>(
    () => ReservationRepository(),
  );
}

// En tus páginas/cubit
final reservationRepo = GetIt.instance<ReservationRepository>();
```

### **Importaciones Necesarias**

```dart
// En tus archivos Flutter
import 'package:core/core.dart';

// Modelos específicos que usarás
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_status.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/business_availability.dart';
import 'package:core/src/turbo_core_repositories/reservation_repository/models/reservation_time_slot.dart';
```

## 📱 **2. Funcionalidades Principales a Implementar**

### **🔍 A. Consultar Horarios Disponibles**

**Pantalla**: `BookingPage` o `ReservationSelectionPage`

```dart
class BookingPageCubit extends Cubit<BookingState> {
  final ReservationRepository _reservationRepo;

  // 1. Obtener slots disponibles para una fecha específica
  Future<void> getAvailableSlotsForDate(String placeId, DateTime date) async {
    try {
      emit(state.copyWith(isLoading: true));

      final availableSlots = await _reservationRepo.getAvailableSlots(
        placeId,
        date,
      );

      // Filtrar solo slots con disponibilidad
      final openSlots = availableSlots
          .where((slot) => slot.hasAvailability)
          .toList();

      emit(state.copyWith(
        availableSlots: openSlots,
        isLoading: false,
      ));
    } catch (e) {
      emit(state.copyWith(
        error: 'Error cargando horarios: $e',
        isLoading: false,
      ));
    }
  }

  // 2. Obtener próximos horarios disponibles (para toda la semana)
  Future<void> getNextAvailableSlots(String placeId) async {
    try {
      final nextSlots = await _reservationRepo.getNextAvailableSlots(
        placeId,
        days: 7, // Próximos 7 días
      );

      emit(state.copyWith(nextAvailableSlots: nextSlots));
    } catch (e) {
      emit(state.copyWith(error: 'Error cargando próximos horarios: $e'));
    }
  }

  // 3. Validar disponibilidad antes de continuar
  Future<bool> validateTimeSlot(
    String placeId,
    DateTime startTime,
    DateTime endTime,
    int partySize,
  ) async {
    try {
      return await _reservationRepo.isSlotAvailable(
        placeId,
        startTime,
        endTime,
        partySize,
      );
    } catch (e) {
      return false;
    }
  }
}
```

**UI Implementation:**

```dart
class BookingTimeSelector extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookingPageCubit, BookingState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const CircularProgressIndicator();
        }

        return Column(
          children: [
            // Selector de fecha
            CalendarDatePicker(
              initialDate: DateTime.now(),
              firstDate: DateTime.now(),
              lastDate: DateTime.now().add(const Duration(days: 60)),
              onDateChanged: (date) {
                context.read<BookingPageCubit>()
                  .getAvailableSlotsForDate(widget.placeId, date);
              },
            ),

            const SizedBox(height: 16),

            // Grid de horarios disponibles
            if (state.availableSlots.isNotEmpty)
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2.5,
                  crossAxisSpacing: 8,
                  mainAxisSpacing: 8,
                ),
                itemCount: state.availableSlots.length,
                itemBuilder: (context, index) {
                  final slot = state.availableSlots[index];
                  return TimeSlotCard(
                    slot: slot,
                    onTap: () => _selectTimeSlot(slot),
                  );
                },
              )
            else
              const Text('No hay horarios disponibles para esta fecha'),
          ],
        );
      },
    );
  }
}

class TimeSlotCard extends StatelessWidget {
  final ReservationTimeSlot slot;
  final VoidCallback onTap;

  const TimeSlotCard({
    required this.slot,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: slot.hasAvailability ? onTap : null,
      child: Container(
        decoration: BoxDecoration(
          color: slot.hasAvailability
            ? Colors.blue.shade50
            : Colors.grey.shade200,
          border: Border.all(
            color: slot.hasAvailability
              ? Colors.blue
              : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              slot.formattedTime,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: slot.hasAvailability
                  ? Colors.blue
                  : Colors.grey,
              ),
            ),
            Text(
              '${slot.availableSlots} espacios',
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
```

### **📝 B. Crear Nueva Reserva**

**Pantalla**: `BookingFormPage` o `ReservationDetailsPage`

```dart
class BookingFormCubit extends Cubit<BookingFormState> {
  final ReservationRepository _reservationRepo;

  // Crear reserva con todos los datos del formulario
  Future<void> createReservation({
    required String placeId,
    required String userId,
    required DateTime startTime,
    required DateTime endTime,
    required int partySize,
    required String customerName,
    required String customerEmail,
    required String customerPhone,
    String? specialRequests,
  }) async {
    try {
      emit(state.copyWith(isCreating: true));

      // Validar una vez más antes de crear
      final isAvailable = await _reservationRepo.isSlotAvailable(
        placeId,
        startTime,
        endTime,
        partySize,
      );

      if (!isAvailable) {
        emit(state.copyWith(
          error: 'Este horario ya no está disponible',
          isCreating: false,
        ));
        return;
      }

      // Crear la reserva
      final reservation = await _reservationRepo.quickCreateReservation(
        placeId: placeId,
        userId: userId,
        dateTime: startTime,
        partySize: partySize,
        customerName: customerName,
        customerEmail: customerEmail,
        customerPhone: customerPhone,
        specialRequests: specialRequests,
      );

      emit(state.copyWith(
        createdReservation: reservation,
        isCreating: false,
        success: true,
      ));

      // Opcional: Navegar a página de confirmación
      // Navigator.pushReplacement(context, ReservationConfirmationPage(reservation));

    } catch (e) {
      emit(state.copyWith(
        error: 'Error creando reserva: $e',
        isCreating: false,
      ));
    }
  }
}
```

**UI Implementation:**

```dart
class BookingFormPage extends StatefulWidget {
  final String placeId;
  final ReservationTimeSlot selectedSlot;

  @override
  _BookingFormPageState createState() => _BookingFormPageState();
}

class _BookingFormPageState extends State<BookingFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _specialRequestsController = TextEditingController();

  int _partySize = 2;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Confirmar Reserva')),
      body: BlocListener<BookingFormCubit, BookingFormState>(
        listener: (context, state) {
          if (state.success) {
            // Navegar a confirmación
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ReservationConfirmationPage(
                  reservation: state.createdReservation!,
                ),
              ),
            );
          } else if (state.error != null) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.error!)),
            );
          }
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Resumen de la reserva
                _buildReservationSummary(),

                const SizedBox(height: 24),

                // Formulario de datos
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        // Número de personas
                        _buildPartySizeSelector(),

                        // Datos del cliente
                        TextFormField(
                          controller: _nameController,
                          decoration: const InputDecoration(
                            labelText: 'Nombre completo',
                            prefixIcon: Icon(Icons.person),
                          ),
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'El nombre es requerido';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            labelText: 'Email',
                            prefixIcon: Icon(Icons.email),
                          ),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'El email es requerido';
                            }
                            if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value!)) {
                              return 'Email inválido';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            labelText: 'Teléfono',
                            prefixIcon: Icon(Icons.phone),
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value?.isEmpty ?? true) {
                              return 'El teléfono es requerido';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 16),

                        TextFormField(
                          controller: _specialRequestsController,
                          decoration: const InputDecoration(
                            labelText: 'Solicitudes especiales (opcional)',
                            prefixIcon: Icon(Icons.note),
                            hintText: 'Ej: Mesa cerca de la ventana, celebración...',
                          ),
                          maxLines: 3,
                        ),
                      ],
                    ),
                  ),
                ),

                // Botón de confirmar
                _buildConfirmButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildReservationSummary() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisSpacing: CrossAxisAlignment.start,
          children: [
            Text('Resumen de Reserva', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 8),
                Text(widget.selectedSlot.formattedTime),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.people, size: 16),
                const SizedBox(width: 8),
                Text('$_partySize personas'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPartySizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('¿Para cuántas personas?', style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Row(
          children: [
            IconButton(
              onPressed: _partySize > 1 ? () => setState(() => _partySize--) : null,
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text('$_partySize', style: const TextStyle(fontSize: 18)),
            ),
            IconButton(
              onPressed: _partySize < 12 ? () => setState(() => _partySize++) : null,
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
        const SizedBox(height: 16),
      ],
    );
  }

  Widget _buildConfirmButton() {
    return BlocBuilder<BookingFormCubit, BookingFormState>(
      builder: (context, state) {
        return SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: state.isCreating ? null : _confirmReservation,
            child: state.isCreating
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text('Confirmar Reserva'),
          ),
        );
      },
    );
  }

  void _confirmReservation() {
    if (_formKey.currentState!.validate()) {
      context.read<BookingFormCubit>().createReservation(
        placeId: widget.placeId,
        userId: FirebaseAuth.instance.currentUser!.uid,
        startTime: widget.selectedSlot.startTime,
        endTime: widget.selectedSlot.endTime,
        partySize: _partySize,
        customerName: _nameController.text,
        customerEmail: _emailController.text,
        customerPhone: _phoneController.text,
        specialRequests: _specialRequestsController.text.isNotEmpty
          ? _specialRequestsController.text
          : null,
      );
    }
  }
}
```

### **📋 C. Gestión de Reservas del Usuario**

**Pantalla**: `MyReservationsPage`

```dart
class MyReservationsCubit extends Cubit<MyReservationsState> {
  final ReservationRepository _reservationRepo;
  final String userId;

  MyReservationsCubit(this._reservationRepo, this.userId);

  // Cargar todas las reservas del usuario
  Future<void> loadUserReservations() async {
    try {
      emit(state.copyWith(isLoading: true));

      final allReservations = await _reservationRepo.getUserReservations(userId);

      // Separar por categorías
      final upcoming = allReservations
          .where((r) => r.reservationDate.isAfter(DateTime.now()) &&
                       r.status.isActive)
          .toList();

      final past = allReservations
          .where((r) => r.reservationDate.isBefore(DateTime.now()) ||
                       r.status == ReservationStatus.completed)
          .toList();

      final cancelled = allReservations
          .where((r) => r.status.isCancelled)
          .toList();

      emit(state.copyWith(
        upcomingReservations: upcoming,
        pastReservations: past,
        cancelledReservations: cancelled,
        isLoading: false,
      ));

    } catch (e) {
      emit(state.copyWith(
        error: 'Error cargando reservas: $e',
        isLoading: false,
      ));
    }
  }

  // Cancelar reserva
  Future<void> cancelReservation(String reservationId, String reason) async {
    try {
      emit(state.copyWith(isCancelling: true));

      await _reservationRepo.cancelReservation(reservationId, reason: reason);

      // Recargar reservas
      await loadUserReservations();

      emit(state.copyWith(
        isCancelling: false,
        success: 'Reserva cancelada exitosamente',
      ));

    } catch (e) {
      emit(state.copyWith(
        error: 'Error cancelando reserva: $e',
        isCancelling: false,
      ));
    }
  }

  // Stream para actualizaciones en tiempo real
  Stream<List<Reservation>> watchUserReservations() {
    return _reservationRepo.watchUserReservations(userId);
  }
}
```

**UI Implementation:**

```dart
class MyReservationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Mis Reservas'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Próximas', icon: Icon(Icons.upcoming)),
              Tab(text: 'Pasadas', icon: Icon(Icons.history)),
              Tab(text: 'Canceladas', icon: Icon(Icons.cancel)),
            ],
          ),
        ),
        body: BlocProvider(
          create: (context) => MyReservationsCubit(
            GetIt.instance<ReservationRepository>(),
            FirebaseAuth.instance.currentUser!.uid,
          )..loadUserReservations(),
          child: TabBarView(
            children: [
              _UpcomingReservationsTab(),
              _PastReservationsTab(),
              _CancelledReservationsTab(),
            ],
          ),
        ),
      ),
    );
  }
}

class _UpcomingReservationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MyReservationsCubit, MyReservationsState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        if (state.upcomingReservations.isEmpty) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.event_busy, size: 64, color: Colors.grey),
                SizedBox(height: 16),
                Text('No tienes reservas próximas'),
                SizedBox(height: 8),
                Text('¡Haz tu próxima reserva ahora!'),
              ],
            ),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: state.upcomingReservations.length,
          itemBuilder: (context, index) {
            final reservation = state.upcomingReservations[index];
            return ReservationCard(
              reservation: reservation,
              showCancelButton: reservation.canBeCancelled,
              onCancel: () => _showCancelDialog(context, reservation),
              onTap: () => _showReservationDetails(context, reservation),
            );
          },
        );
      },
    );
  }

  void _showCancelDialog(BuildContext context, Reservation reservation) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Cancelar Reserva'),
        content: const Text('¿Estás seguro de que quieres cancelar esta reserva?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('No'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              context.read<MyReservationsCubit>()
                .cancelReservation(reservation.id, 'Cancelada por el usuario');
            },
            child: const Text('Sí, cancelar'),
          ),
        ],
      ),
    );
  }

  void _showReservationDetails(BuildContext context, Reservation reservation) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ReservationDetailsPage(reservation: reservation),
      ),
    );
  }
}

class ReservationCard extends StatelessWidget {
  final Reservation reservation;
  final bool showCancelButton;
  final VoidCallback? onCancel;
  final VoidCallback? onTap;

  const ReservationCard({
    required this.reservation,
    this.showCancelButton = false,
    this.onCancel,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header con status
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _buildStatusChip(reservation.status),
                  Text(
                    reservation.confirmationCode,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Información principal
              Row(
                children: [
                  const Icon(Icons.calendar_today, size: 16, color: Colors.blue),
                  const SizedBox(width: 8),
                  Text(
                    reservation.formattedDate,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(Icons.access_time, size: 16, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(reservation.formattedTime),
                ],
              ),

              const SizedBox(height: 4),

              Row(
                children: [
                  const Icon(Icons.people, size: 16, color: Colors.orange),
                  const SizedBox(width: 8),
                  Text('${reservation.partySize} personas'),
                ],
              ),

              if (reservation.specialRequests?.isNotEmpty ?? false) ...[
                const SizedBox(height: 8),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Icon(Icons.note, size: 16, color: Colors.purple),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        reservation.specialRequests!,
                        style: const TextStyle(
                          fontStyle: FontStyle.italic,
                          color: Colors.grey,
                        ),
                      ),
                    ),
                  ],
                ),
              ],

              // Botones de acción
              if (showCancelButton) ...[
                const SizedBox(height: 12),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton.icon(
                    onPressed: onCancel,
                    icon: const Icon(Icons.cancel_outlined, color: Colors.red),
                    label: const Text('Cancelar'),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatusChip(ReservationStatus status) {
    Color color;
    String text;

    switch (status) {
      case ReservationStatus.pending:
        color = Colors.orange;
        text = 'Pendiente';
        break;
      case ReservationStatus.confirmed:
        color = Colors.green;
        text = 'Confirmada';
        break;
      case ReservationStatus.cancelled:
        color = Colors.red;
        text = 'Cancelada';
        break;
      case ReservationStatus.completed:
        color = Colors.blue;
        text = 'Completada';
        break;
      default:
        color = Colors.grey;
        text = 'Desconocido';
    }

    return Chip(
      label: Text(text),
      backgroundColor: color.withOpacity(0.1),
      side: BorderSide(color: color),
      labelStyle: TextStyle(color: color, fontSize: 12),
    );
  }
}
```

## 🔧 **3. Estados y Modelos para Flutter**

### **State Management**

```dart
// Estados para Booking
@freezed
class BookingState with _$BookingState {
  const factory BookingState({
    @Default(false) bool isLoading,
    @Default([]) List<ReservationTimeSlot> availableSlots,
    @Default([]) List<ReservationTimeSlot> nextAvailableSlots,
    ReservationTimeSlot? selectedSlot,
    String? error,
  }) = _BookingState;
}

// Estados para Form
@freezed
class BookingFormState with _$BookingFormState {
  const factory BookingFormState({
    @Default(false) bool isCreating,
    @Default(false) bool success,
    Reservation? createdReservation,
    String? error,
  }) = _BookingFormState;
}

// Estados para My Reservations
@freezed
class MyReservationsState with _$MyReservationsState {
  const factory MyReservationsState({
    @Default(false) bool isLoading,
    @Default(false) bool isCancelling,
    @Default([]) List<Reservation> upcomingReservations,
    @Default([]) List<Reservation> pastReservations,
    @Default([]) List<Reservation> cancelledReservations,
    String? error,
    String? success,
  }) = _MyReservationsState;
}
```

## 🎨 **4. Navegación y Routing**

```dart
// En tu archivo de rutas
class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/place-details':
        final placeId = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => PlaceDetailsPage(placeId: placeId),
        );

      case '/booking':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BookingPage(
            placeId: args['placeId'],
            placeName: args['placeName'],
          ),
        );

      case '/booking-form':
        final args = settings.arguments as Map<String, dynamic>;
        return MaterialPageRoute(
          builder: (_) => BookingFormPage(
            placeId: args['placeId'],
            selectedSlot: args['selectedSlot'],
          ),
        );

      case '/reservation-confirmation':
        final reservation = settings.arguments as Reservation;
        return MaterialPageRoute(
          builder: (_) => ReservationConfirmationPage(
            reservation: reservation,
          ),
        );

      case '/my-reservations':
        return MaterialPageRoute(
          builder: (_) => MyReservationsPage(),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const NotFoundPage(),
        );
    }
  }
}
```

## 📱 **5. Integraciones de UI Específicas**

### **En Place Details Page**

```dart
class PlaceDetailsPage extends StatelessWidget {
  final String placeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // ... resto del contenido del lugar

      // Agregar botón de reserva
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(16),
        child: ElevatedButton.icon(
          onPressed: () => Navigator.pushNamed(
            context,
            '/booking',
            arguments: {
              'placeId': placeId,
              'placeName': place.name,
            },
          ),
          icon: const Icon(Icons.calendar_today),
          label: const Text('Hacer Reserva'),
          style: ElevatedButton.styleFrom(
            minimumSize: const Size.fromHeight(48),
          ),
        ),
      ),
    );
  }
}
```

### **En Profile/Account Page**

```dart
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Mi Perfil')),
      body: ListView(
        children: [
          // ... otros elementos del perfil

          ListTile(
            leading: const Icon(Icons.restaurant_menu),
            title: const Text('Mis Reservas'),
            subtitle: const Text('Ver y gestionar tus reservas'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => Navigator.pushNamed(context, '/my-reservations'),
          ),

          // ... otros elementos
        ],
      ),
    );
  }
}
```

## 🔔 **6. Notificaciones y Recordatorios**

```dart
// Service para notificaciones locales
class ReservationNotificationService {

  // Programar recordatorio para reserva
  static Future<void> scheduleReservationReminder(Reservation reservation) async {
    final reminderTime = reservation.startTime.subtract(const Duration(hours: 2));

    await NotificationService.scheduleNotification(
      id: reservation.id.hashCode,
      title: 'Recordatorio de Reserva',
      body: 'Tu reserva es en 2 horas - ${reservation.formattedTime}',
      scheduledDate: reminderTime,
      payload: 'reservation:${reservation.id}',
    );
  }

  // Cancelar recordatorio
  static Future<void> cancelReservationReminder(String reservationId) async {
    await NotificationService.cancelNotification(reservationId.hashCode);
  }
}
```

## ⚡ **7. Features Opcionales Avanzadas**

### **A. Búsqueda de Horarios por Filtros**

```dart
// Buscar lugares con disponibilidad específica
Future<List<PlaceWithAvailability>> searchPlacesWithAvailability({
  required DateTime desiredDate,
  required int partySize,
  String? location,
  String? category,
}) async {
  final places = await placeRepository.getPlacesByFilters(
    location: location,
    category: category,
  );

  final placesWithAvailability = <PlaceWithAvailability>[];

  for (final place in places) {
    final slots = await reservationRepository.getAvailableSlots(
      place.id,
      desiredDate,
    );

    if (slots.any((slot) => slot.availableSlots >= partySize)) {
      placesWithAvailability.add(
        PlaceWithAvailability(
          place: place,
          availableSlots: slots.where((s) => s.availableSlots >= partySize).toList(),
        ),
      );
    }
  }

  return placesWithAvailability;
}
```

### **B. Modificar Reserva**

```dart
// En ReservationDetailsPage
Future<void> modifyReservation(Reservation reservation) async {
  if (!reservation.canBeModified) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Esta reserva ya no se puede modificar')),
    );
    return;
  }

  Navigator.pushNamed(
    context,
    '/booking',
    arguments: {
      'placeId': reservation.placeId,
      'editingReservation': reservation,
    },
  );
}
```

## 🚀 **8. Testing Recomendado**

```dart
// Test de integración
void main() {
  group('Reservation Integration Tests', () {
    late ReservationRepository reservationRepo;

    setUp(() {
      reservationRepo = MockReservationRepository();
    });

    testWidgets('should create reservation successfully', (tester) async {
      // Implementar test completo del flujo
    });

    testWidgets('should show available time slots', (tester) async {
      // Test de UI para slots disponibles
    });
  });
}
```

## ✅ **9. Checklist de Implementación**

### **Para el Developer:**

- [ ] Agregar dependency injection del ReservationRepository
- [ ] Crear BookingPage con selector de horarios
- [ ] Implementar BookingFormPage con formulario completo
- [ ] Crear MyReservationsPage con tabs (próximas/pasadas/canceladas)
- [ ] Agregar ReservationDetailsPage
- [ ] Integrar botón "Hacer Reserva" en PlaceDetailsPage
- [ ] Agregar "Mis Reservas" en ProfilePage
- [ ] Implementar notificaciones de recordatorio
- [ ] Testing de todas las funcionalidades
- [ ] Manejar estados de error y loading apropiadamente

### **UX/UI Considerations:**

- [ ] Calendario fácil de usar para selección de fechas
- [ ] Grid de horarios visualmente atractivo
- [ ] Formulario claro con validaciones
- [ ] Estados de reserva bien identificados (chips de colores)
- [ ] Confirmaciones de acciones críticas (cancelar)
- [ ] Loading states en todas las operaciones
- [ ] Manejo de errores user-friendly

## 🎯 **¡Listo para Implementar!**

Con esta guía tienes **todo lo necesario** para integrar completamente el sistema de reservas en la App Mobile. El sistema está **100% implementado en el Core** y solo necesitas conectar la UI de Flutter con los servicios.

**¿Necesitas ayuda específica con algún componente?**
