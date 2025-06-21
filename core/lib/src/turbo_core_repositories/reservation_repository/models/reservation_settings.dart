import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

part 'reservation_settings.freezed.dart';
part 'reservation_settings.g.dart';

/// Configuraciones de reserva para un lugar/negocio
@freezed
sealed class ReservationSettings with _$ReservationSettings {
  const factory ReservationSettings({
    required String id,
    required String placeId,
    @Default(true) bool acceptsReservations,
    @Default(60) int defaultSlotDuration,
    @Default(1) int minPartySize,
    @Default(20) int maxPartySize,
    @Default(7) int maxAdvanceBookingDays,
    @Default(2) int minAdvanceBookingHours,
    @Default(30) int maxDurationMinutes,
    @Default(true) bool requiresConfirmation,
    @Default(true) bool allowCancellation,
    @Default(true) bool allowModification,
    @Default(2) int cancellationHours,
    @Default(4) int modificationHours,
    @Default(true) bool sendConfirmationEmail,
    @Default(true) bool sendReminderEmail,
    @Default(24) int reminderHours,
    @Default([]) List<String> blockedTimeSlots,
    @Default([]) List<ReservationRule> customRules,
    String? welcomeMessage,
    String? cancellationPolicy,
    String? specialInstructions,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? createdBy,
    Map<String, dynamic>? metadata,
  }) = _ReservationSettings;

  const ReservationSettings._();

  factory ReservationSettings.fromJson(Map<String, dynamic> json) =>
      _$ReservationSettingsFromJson(json);

  /// Crear desde datos de Firestore
  factory ReservationSettings.fromFirestore(Map<String, dynamic> data) {
    return ReservationSettings(
      id: data['id'] as String,
      placeId: data['placeId'] as String,
      acceptsReservations: data['acceptsReservations'] as bool? ?? true,
      defaultSlotDuration: data['defaultSlotDuration'] as int? ?? 60,
      minPartySize: data['minPartySize'] as int? ?? 1,
      maxPartySize: data['maxPartySize'] as int? ?? 20,
      maxAdvanceBookingDays: data['maxAdvanceBookingDays'] as int? ?? 7,
      minAdvanceBookingHours: data['minAdvanceBookingHours'] as int? ?? 2,
      maxDurationMinutes: data['maxDurationMinutes'] as int? ?? 30,
      requiresConfirmation: data['requiresConfirmation'] as bool? ?? true,
      allowCancellation: data['allowCancellation'] as bool? ?? true,
      allowModification: data['allowModification'] as bool? ?? true,
      cancellationHours: data['cancellationHours'] as int? ?? 2,
      modificationHours: data['modificationHours'] as int? ?? 4,
      sendConfirmationEmail: data['sendConfirmationEmail'] as bool? ?? true,
      sendReminderEmail: data['sendReminderEmail'] as bool? ?? true,
      reminderHours: data['reminderHours'] as int? ?? 24,
      blockedTimeSlots:
          (data['blockedTimeSlots'] as List<dynamic>?)?.cast<String>() ?? [],
      customRules:
          (data['customRules'] as List<dynamic>?)
              ?.map((e) => ReservationRule.fromMap(e as Map<String, dynamic>))
              .toList() ??
          [],
      welcomeMessage: data['welcomeMessage'] as String?,
      cancellationPolicy: data['cancellationPolicy'] as String?,
      specialInstructions: data['specialInstructions'] as String?,
      createdAt:
          data['createdAt'] != null
              ? (data['createdAt'] as Timestamp).toDate()
              : null,
      updatedAt:
          data['updatedAt'] != null
              ? (data['updatedAt'] as Timestamp).toDate()
              : null,
      createdBy: data['createdBy'] as String?,
      metadata: data['metadata'] as Map<String, dynamic>?,
    );
  }

  /// Convertir a formato Firestore
  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'placeId': placeId,
      'acceptsReservations': acceptsReservations,
      'defaultSlotDuration': defaultSlotDuration,
      'minPartySize': minPartySize,
      'maxPartySize': maxPartySize,
      'maxAdvanceBookingDays': maxAdvanceBookingDays,
      'minAdvanceBookingHours': minAdvanceBookingHours,
      'maxDurationMinutes': maxDurationMinutes,
      'requiresConfirmation': requiresConfirmation,
      'allowCancellation': allowCancellation,
      'allowModification': allowModification,
      'cancellationHours': cancellationHours,
      'modificationHours': modificationHours,
      'sendConfirmationEmail': sendConfirmationEmail,
      'sendReminderEmail': sendReminderEmail,
      'reminderHours': reminderHours,
      'blockedTimeSlots': blockedTimeSlots,
      'customRules': customRules.map((e) => e.toMap()).toList(),
      'welcomeMessage': welcomeMessage,
      'cancellationPolicy': cancellationPolicy,
      'specialInstructions': specialInstructions,
      'createdAt': createdAt != null ? Timestamp.fromDate(createdAt!) : null,
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'createdBy': createdBy,
      'metadata': metadata,
    };
  }

  /// Verificar si se puede hacer reserva en fecha/hora específica
  bool canMakeReservation(DateTime dateTime, int partySize) {
    if (!acceptsReservations) return false;

    // Verificar tamaño de grupo
    if (partySize < minPartySize || partySize > maxPartySize) return false;

    // Verificar tiempo de anticipación
    final now = DateTime.now();
    final hoursDifference = dateTime.difference(now).inHours;

    if (hoursDifference < minAdvanceBookingHours) return false;

    final daysDifference = dateTime.difference(now).inDays;
    if (daysDifference > maxAdvanceBookingDays) return false;

    // Verificar slots bloqueados
    final timeSlot =
        '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    if (blockedTimeSlots.contains(timeSlot)) return false;

    // Aplicar reglas personalizadas
    for (final rule in customRules) {
      if (!rule.isValidForDateTime(dateTime, partySize)) return false;
    }

    return true;
  }

  /// Crear configuraciones por defecto para un lugar
  factory ReservationSettings.defaultFor(String placeId, {String? createdBy}) {
    final now = DateTime.now();
    return ReservationSettings(
      id: '${placeId}_settings',
      placeId: placeId,
      createdAt: now,
      updatedAt: now,
      createdBy: createdBy,
    );
  }
}

/// Regla personalizada de reserva
@freezed
sealed class ReservationRule with _$ReservationRule {
  const factory ReservationRule({
    required String id,
    required String name,
    required String description,
    required RuleType type,
    required Map<String, dynamic> conditions,
    @Default(true) bool isActive,
    String? errorMessage,
  }) = _ReservationRule;

  const ReservationRule._();

  factory ReservationRule.fromJson(Map<String, dynamic> json) =>
      _$ReservationRuleFromJson(json);

  factory ReservationRule.fromMap(Map<String, dynamic> map) {
    return ReservationRule(
      id: map['id'] as String,
      name: map['name'] as String,
      description: map['description'] as String,
      type: RuleType.fromString(map['type'] as String),
      conditions: map['conditions'] as Map<String, dynamic>,
      isActive: map['isActive'] as bool? ?? true,
      errorMessage: map['errorMessage'] as String?,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'type': type.value,
      'conditions': conditions,
      'isActive': isActive,
      'errorMessage': errorMessage,
    };
  }

  /// Verificar si la regla es válida para una fecha/hora específica
  bool isValidForDateTime(DateTime dateTime, int partySize) {
    if (!isActive) return true;

    switch (type) {
      case RuleType.dayOfWeek:
        final allowedDays = conditions['allowedDays'] as List<dynamic>? ?? [];
        return allowedDays.contains(dateTime.weekday);

      case RuleType.timeRange:
        final startHour = conditions['startHour'] as int? ?? 0;
        final endHour = conditions['endHour'] as int? ?? 24;
        return dateTime.hour >= startHour && dateTime.hour < endHour;

      case RuleType.partySize:
        final minSize = conditions['minSize'] as int? ?? 1;
        final maxSize = conditions['maxSize'] as int? ?? 100;
        return partySize >= minSize && partySize <= maxSize;

      case RuleType.dateRange:
        final startDate = DateTime.parse(conditions['startDate'] as String);
        final endDate = DateTime.parse(conditions['endDate'] as String);
        return dateTime.isAfter(startDate) && dateTime.isBefore(endDate);

      case RuleType.custom:
        // Implementar lógica personalizada según sea necesario
        return true;
    }
  }
}

/// Tipos de reglas de reserva
enum RuleType {
  dayOfWeek('day_of_week'),
  timeRange('time_range'),
  partySize('party_size'),
  dateRange('date_range'),
  custom('custom');

  const RuleType(this.value);

  final String value;

  static RuleType fromString(String value) {
    return RuleType.values.firstWhere(
      (type) => type.value == value,
      orElse: () => RuleType.custom,
    );
  }
}
