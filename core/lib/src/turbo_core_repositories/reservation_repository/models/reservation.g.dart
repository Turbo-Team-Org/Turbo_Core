// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reservation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Reservation _$ReservationFromJson(Map<String, dynamic> json) => _Reservation(
  id: json['id'] as String,
  placeId: json['placeId'] as String,
  userId: json['userId'] as String,
  reservationDate: DateTime.parse(json['reservationDate'] as String),
  startTime: DateTime.parse(json['startTime'] as String),
  endTime: DateTime.parse(json['endTime'] as String),
  partySize: (json['partySize'] as num).toInt(),
  status: $enumDecode(_$ReservationStatusEnumMap, json['status']),
  customerName: json['customerName'] as String? ?? '',
  customerEmail: json['customerEmail'] as String? ?? '',
  customerPhone: json['customerPhone'] as String? ?? '',
  placeName: json['placeName'] as String?,
  specialRequests: json['specialRequests'] as String?,
  notes: json['notes'] as String?,
  tableNumber: json['tableNumber'] as String?,
  confirmationCode: json['confirmationCode'] as String?,
  createdAt:
      json['createdAt'] == null
          ? null
          : DateTime.parse(json['createdAt'] as String),
  updatedAt:
      json['updatedAt'] == null
          ? null
          : DateTime.parse(json['updatedAt'] as String),
  confirmedAt:
      json['confirmedAt'] == null
          ? null
          : DateTime.parse(json['confirmedAt'] as String),
  checkedInAt:
      json['checkedInAt'] == null
          ? null
          : DateTime.parse(json['checkedInAt'] as String),
  cancelledAt:
      json['cancelledAt'] == null
          ? null
          : DateTime.parse(json['cancelledAt'] as String),
  cancelReason: json['cancelReason'] as String?,
  adminNotes: json['adminNotes'] as String?,
  reminderSent: json['reminderSent'] as bool?,
  customerInfo: json['customerInfo'] as Map<String, dynamic>? ?? const {},
  metadata: json['metadata'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$ReservationToJson(_Reservation instance) =>
    <String, dynamic>{
      'id': instance.id,
      'placeId': instance.placeId,
      'userId': instance.userId,
      'reservationDate': instance.reservationDate.toIso8601String(),
      'startTime': instance.startTime.toIso8601String(),
      'endTime': instance.endTime.toIso8601String(),
      'partySize': instance.partySize,
      'status': _$ReservationStatusEnumMap[instance.status]!,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'customerPhone': instance.customerPhone,
      'placeName': instance.placeName,
      'specialRequests': instance.specialRequests,
      'notes': instance.notes,
      'tableNumber': instance.tableNumber,
      'confirmationCode': instance.confirmationCode,
      'createdAt': instance.createdAt?.toIso8601String(),
      'updatedAt': instance.updatedAt?.toIso8601String(),
      'confirmedAt': instance.confirmedAt?.toIso8601String(),
      'checkedInAt': instance.checkedInAt?.toIso8601String(),
      'cancelledAt': instance.cancelledAt?.toIso8601String(),
      'cancelReason': instance.cancelReason,
      'adminNotes': instance.adminNotes,
      'reminderSent': instance.reminderSent,
      'customerInfo': instance.customerInfo,
      'metadata': instance.metadata,
    };

const _$ReservationStatusEnumMap = {
  ReservationStatus.pending: 'pending',
  ReservationStatus.confirmed: 'confirmed',
  ReservationStatus.cancelled: 'cancelled',
  ReservationStatus.rejected: 'rejected',
  ReservationStatus.checkedIn: 'checkedIn',
  ReservationStatus.noShow: 'noShow',
  ReservationStatus.completed: 'completed',
  ReservationStatus.modifying: 'modifying',
};
