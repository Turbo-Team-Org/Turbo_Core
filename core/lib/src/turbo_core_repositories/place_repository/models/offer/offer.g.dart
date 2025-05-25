// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Offer _$OfferFromJson(Map<String, dynamic> json) => _Offer(
  offerTitle: json['offerTitle'] as String,
  offerDescription: json['offerDescription'] as String,
  offerValidUntil: const TimestampDateTimeConverter().fromJson(
    json['offerValidUntil'],
  ),
  offerPrice: (json['offerPrice'] as num?)?.toDouble(),
  offerConditions: json['offerConditions'] as String?,
  offerImage: json['offerImage'] as String?,
  name: json['name'] as String? ?? '',
  description: json['description'] as String? ?? '',
  image: json['image'] as String? ?? '',
);

Map<String, dynamic> _$OfferToJson(_Offer instance) => <String, dynamic>{
  'offerTitle': instance.offerTitle,
  'offerDescription': instance.offerDescription,
  'offerValidUntil': const TimestampDateTimeConverter().toJson(
    instance.offerValidUntil,
  ),
  'offerPrice': instance.offerPrice,
  'offerConditions': instance.offerConditions,
  'offerImage': instance.offerImage,
  'name': instance.name,
  'description': instance.description,
  'image': instance.image,
};
