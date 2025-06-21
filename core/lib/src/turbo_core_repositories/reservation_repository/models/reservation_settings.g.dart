// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_ReservationSettings _$ReservationSettingsFromJson(Map<String, dynamic> json) =>
    _ReservationSettings(
      id: json['id'] as String,
      placeId: json['placeId'] as String,
      acceptsReservations: json['acceptsReservations'] as bool? ?? true,
      defaultSlotDuration: (json['defaultSlotDuration'] as num?)?.toInt() ?? 60,
      minPartySize: (json['minPartySize'] as num?)?.toInt() ?? 1,
      maxPartySize: (json['maxPartySize'] as num?)?.toInt() ?? 20,
      maxAdvanceBookingDays:
          (json['maxAdvanceBookingDays'] as num?)?.toInt() ?? 7,
      minAdvanceBookingHours:
          (json['minAdvanceBookingHours'] as num?)?.toInt() ?? 2,
      maxDurationMinutes: (json['maxDurationMinutes'] as num?)?.toInt() ?? 30,
      requiresConfirmation: json['requiresConfirmation'] as bool? ?? true,
      allowCancellation: json['allowCancellation'] as bool? ?? true,
      allowModification: json['allowModification'] as bool? ?? true,
      cancellationHours: (json['cancellationHours'] as num?)?.toInt() ?? 2,
      modificationHours: (json['modificationHours'] as num?)?.toInt() ?? 4,
      sendConfirmationEmail: json['sendConfirmationEmail'] as bool? ?? true,
      sendReminderEmail: json['sendReminderEmail'] as bool? ?? true,
      reminderHours: (json['reminderHours'] as num?)?.toInt() ?? 24,
      blockedTimeSlots:
          (json['blockedTimeSlots'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      customRules:
          (json['customRules'] as List<dynamic>?)
              ?.map((e) => ReservationRule.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
      welcomeMessage: json['welcomeMessage'] as String?,
      cancellationPolicy: json['cancellationPolicy'] as String?,
      specialInstructions: json['specialInstructions'] as String?,
      createdAt:
          json['createdAt'] == null
              ? null
              : DateTime.parse(json['createdAt'] as String),
      updatedAt:
          json['updatedAt'] == null
              ? null
              : DateTime.parse(json['updatedAt'] as String),
      createdBy: json['createdBy'] as String?,
      metadata: json['metadata'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ReservationSettingsToJson(
  _ReservationSettings instance,
) => <String, dynamic>{
  'id': instance.id,
  'placeId': instance.placeId,
  'acceptsReservations': instance.acceptsReservations,
  'defaultSlotDuration': instance.defaultSlotDuration,
  'minPartySize': instance.minPartySize,
  'maxPartySize': instance.maxPartySize,
  'maxAdvanceBookingDays': instance.maxAdvanceBookingDays,
  'minAdvanceBookingHours': instance.minAdvanceBookingHours,
  'maxDurationMinutes': instance.maxDurationMinutes,
  'requiresConfirmation': instance.requiresConfirmation,
  'allowCancellation': instance.allowCancellation,
  'allowModification': instance.allowModification,
  'cancellationHours': instance.cancellationHours,
  'modificationHours': instance.modificationHours,
  'sendConfirmationEmail': instance.sendConfirmationEmail,
  'sendReminderEmail': instance.sendReminderEmail,
  'reminderHours': instance.reminderHours,
  'blockedTimeSlots': instance.blockedTimeSlots,
  'customRules': instance.customRules,
  'welcomeMessage': instance.welcomeMessage,
  'cancellationPolicy': instance.cancellationPolicy,
  'specialInstructions': instance.specialInstructions,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'createdBy': instance.createdBy,
  'metadata': instance.metadata,
};

_ReservationRule _$ReservationRuleFromJson(Map<String, dynamic> json) =>
    _ReservationRule(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      type: $enumDecode(_$RuleTypeEnumMap, json['type']),
      conditions: json['conditions'] as Map<String, dynamic>,
      isActive: json['isActive'] as bool? ?? true,
      errorMessage: json['errorMessage'] as String?,
    );

Map<String, dynamic> _$ReservationRuleToJson(_ReservationRule instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'type': _$RuleTypeEnumMap[instance.type]!,
      'conditions': instance.conditions,
      'isActive': instance.isActive,
      'errorMessage': instance.errorMessage,
    };

const _$RuleTypeEnumMap = {
  RuleType.dayOfWeek: 'dayOfWeek',
  RuleType.timeRange: 'timeRange',
  RuleType.partySize: 'partySize',
  RuleType.dateRange: 'dateRange',
  RuleType.custom: 'custom',
};
