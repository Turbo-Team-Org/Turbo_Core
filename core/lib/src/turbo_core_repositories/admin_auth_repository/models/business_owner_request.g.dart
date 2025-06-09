// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'business_owner_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_BusinessOwnerRequest _$BusinessOwnerRequestFromJson(
  Map<String, dynamic> json,
) => _BusinessOwnerRequest(
  id: json['id'] as String,
  userId: json['userId'] as String,
  email: json['email'] as String,
  displayName: json['displayName'] as String,
  businessName: json['businessName'] as String,
  businessDescription: json['businessDescription'] as String,
  businessAddress: json['businessAddress'] as String,
  phoneNumber: json['phoneNumber'] as String?,
  website: json['website'] as String?,
  status:
      $enumDecodeNullable(
        _$BusinessOwnerRequestStatusEnumMap,
        json['status'],
      ) ??
      BusinessOwnerRequestStatus.pending,
  createdAt: DateTime.parse(json['createdAt'] as String),
  reviewedAt:
      json['reviewedAt'] == null
          ? null
          : DateTime.parse(json['reviewedAt'] as String),
  reviewedBy: json['reviewedBy'] as String?,
  rejectionReason: json['rejectionReason'] as String?,
  approvalNotes: json['approvalNotes'] as String?,
  businessMetadata:
      json['businessMetadata'] as Map<String, dynamic>? ?? const {},
  contactInfo: json['contactInfo'] as Map<String, dynamic>? ?? const {},
);

Map<String, dynamic> _$BusinessOwnerRequestToJson(
  _BusinessOwnerRequest instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'email': instance.email,
  'displayName': instance.displayName,
  'businessName': instance.businessName,
  'businessDescription': instance.businessDescription,
  'businessAddress': instance.businessAddress,
  'phoneNumber': instance.phoneNumber,
  'website': instance.website,
  'status': _$BusinessOwnerRequestStatusEnumMap[instance.status]!,
  'createdAt': instance.createdAt.toIso8601String(),
  'reviewedAt': instance.reviewedAt?.toIso8601String(),
  'reviewedBy': instance.reviewedBy,
  'rejectionReason': instance.rejectionReason,
  'approvalNotes': instance.approvalNotes,
  'businessMetadata': instance.businessMetadata,
  'contactInfo': instance.contactInfo,
};

const _$BusinessOwnerRequestStatusEnumMap = {
  BusinessOwnerRequestStatus.pending: 'pending',
  BusinessOwnerRequestStatus.approved: 'approved',
  BusinessOwnerRequestStatus.rejected: 'rejected',
  BusinessOwnerRequestStatus.reviewing: 'reviewing',
  BusinessOwnerRequestStatus.needsMoreInfo: 'needsMoreInfo',
};
