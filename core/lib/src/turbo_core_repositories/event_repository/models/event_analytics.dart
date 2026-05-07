import 'package:core/src/turbo_core_repositories/event_repository/models/event.dart';

/// 📊 Analytics data for events managed by an admin user
class EventAnalytics {
  const EventAnalytics({
    required this.adminUserId,
    required this.totalEvents,
    required this.activeEvents,
    required this.pastEvents,
    required this.upcomingEvents,
    required this.totalAttendees,
    required this.averageAttendees,
    required this.eventsByType,
    required this.monthlyEventCount,
    required this.topPerformingEvents,
  });

  /// ID del administrador
  final String adminUserId;

  /// Total de eventos en todas sus propiedades
  final int totalEvents;

  /// Eventos actualmente activos
  final int activeEvents;

  /// Eventos pasados
  final int pastEvents;

  /// Eventos próximos
  final int upcomingEvents;

  /// Total de asistentes en todos los eventos
  final int totalAttendees;

  /// Promedio de asistentes por evento
  final double averageAttendees;

  /// Distribución de eventos por tipo
  final Map<EventType, int> eventsByType;

  /// Conteo de eventos por mes
  final Map<String, int> monthlyEventCount;

  /// Eventos con mejor rendimiento
  final List<EventPerformance> topPerformingEvents;

  /// Factory para crear desde datos de Firebase
  factory EventAnalytics.fromData(
    String adminUserId,
    Map<String, dynamic> data,
  ) {
    return EventAnalytics(
      adminUserId: adminUserId,
      totalEvents: data['totalEvents'] as int? ?? 0,
      activeEvents: data['activeEvents'] as int? ?? 0,
      pastEvents: data['pastEvents'] as int? ?? 0,
      upcomingEvents: data['upcomingEvents'] as int? ?? 0,
      totalAttendees: data['totalAttendees'] as int? ?? 0,
      averageAttendees: (data['averageAttendees'] as num?)?.toDouble() ?? 0.0,
      eventsByType: Map<EventType, int>.from(
        (data['eventsByType'] as Map<String, dynamic>?) ?? {},
      ),
      monthlyEventCount: Map<String, int>.from(
        (data['monthlyEventCount'] as Map<String, dynamic>?) ?? {},
      ),
      topPerformingEvents: (data['topPerformingEvents'] as List<dynamic>? ?? [])
          .map(
            (item) => EventPerformance.fromJson(item as Map<String, dynamic>),
          )
          .toList(),
    );
  }
}

/// 📈 Performance data for a single event
class EventPerformance {
  const EventPerformance({
    required this.eventId,
    required this.eventTitle,
    required this.attendees,
    required this.revenue,
    required this.rating,
    required this.engagement,
  });

  /// ID del evento
  final String eventId;

  /// Título del evento
  final String eventTitle;

  /// Número de asistentes
  final int attendees;

  /// Ingresos generados
  final double revenue;

  /// Calificación promedio
  final double rating;

  /// Nivel de engagement
  final double engagement;

  /// Factory para crear desde JSON
  factory EventPerformance.fromJson(Map<String, dynamic> json) {
    return EventPerformance(
      eventId: json['eventId'] as String? ?? '',
      eventTitle: json['eventTitle'] as String? ?? '',
      attendees: json['attendees'] as int? ?? 0,
      revenue: (json['revenue'] as num?)?.toDouble() ?? 0.0,
      rating: (json['rating'] as num?)?.toDouble() ?? 0.0,
      engagement: (json['engagement'] as num?)?.toDouble() ?? 0.0,
    );
  }

  /// Convierte a JSON
  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventTitle': eventTitle,
      'attendees': attendees,
      'revenue': revenue,
      'rating': rating,
      'engagement': engagement,
    };
  }
}
