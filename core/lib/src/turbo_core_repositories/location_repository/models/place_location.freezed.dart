// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_location.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceLocation {

 String get id; String get placeId;// ID del lugar/negocio
 LocationData get coordinates; String get formattedAddress; String? get streetNumber; String? get streetName; String? get neighborhood; String? get city; String? get state; String? get country; String? get postalCode; String? get googlePlaceId;// ID de Google Places API
 List<String> get addressComponents; String? get plusCode;// Google Plus Code
 DateTime? get createdAt; DateTime? get updatedAt; String? get createdBy; Map<String, dynamic>? get metadata;
/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceLocationCopyWith<PlaceLocation> get copyWith => _$PlaceLocationCopyWithImpl<PlaceLocation>(this as PlaceLocation, _$identity);

  /// Serializes this PlaceLocation to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.streetNumber, streetNumber) || other.streetNumber == streetNumber)&&(identical(other.streetName, streetName) || other.streetName == streetName)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.googlePlaceId, googlePlaceId) || other.googlePlaceId == googlePlaceId)&&const DeepCollectionEquality().equals(other.addressComponents, addressComponents)&&(identical(other.plusCode, plusCode) || other.plusCode == plusCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,coordinates,formattedAddress,streetNumber,streetName,neighborhood,city,state,country,postalCode,googlePlaceId,const DeepCollectionEquality().hash(addressComponents),plusCode,createdAt,updatedAt,createdBy,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PlaceLocation(id: $id, placeId: $placeId, coordinates: $coordinates, formattedAddress: $formattedAddress, streetNumber: $streetNumber, streetName: $streetName, neighborhood: $neighborhood, city: $city, state: $state, country: $country, postalCode: $postalCode, googlePlaceId: $googlePlaceId, addressComponents: $addressComponents, plusCode: $plusCode, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PlaceLocationCopyWith<$Res>  {
  factory $PlaceLocationCopyWith(PlaceLocation value, $Res Function(PlaceLocation) _then) = _$PlaceLocationCopyWithImpl;
@useResult
$Res call({
 String id, String placeId, LocationData coordinates, String formattedAddress, String? streetNumber, String? streetName, String? neighborhood, String? city, String? state, String? country, String? postalCode, String? googlePlaceId, List<String> addressComponents, String? plusCode, DateTime? createdAt, DateTime? updatedAt, String? createdBy, Map<String, dynamic>? metadata
});


$LocationDataCopyWith<$Res> get coordinates;

}
/// @nodoc
class _$PlaceLocationCopyWithImpl<$Res>
    implements $PlaceLocationCopyWith<$Res> {
  _$PlaceLocationCopyWithImpl(this._self, this._then);

  final PlaceLocation _self;
  final $Res Function(PlaceLocation) _then;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? placeId = null,Object? coordinates = null,Object? formattedAddress = null,Object? streetNumber = freezed,Object? streetName = freezed,Object? neighborhood = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? postalCode = freezed,Object? googlePlaceId = freezed,Object? addressComponents = null,Object? plusCode = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as LocationData,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,streetNumber: freezed == streetNumber ? _self.streetNumber : streetNumber // ignore: cast_nullable_to_non_nullable
as String?,streetName: freezed == streetName ? _self.streetName : streetName // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,googlePlaceId: freezed == googlePlaceId ? _self.googlePlaceId : googlePlaceId // ignore: cast_nullable_to_non_nullable
as String?,addressComponents: null == addressComponents ? _self.addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<String>,plusCode: freezed == plusCode ? _self.plusCode : plusCode // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res> get coordinates {
  
  return $LocationDataCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _PlaceLocation extends PlaceLocation {
  const _PlaceLocation({required this.id, required this.placeId, required this.coordinates, required this.formattedAddress, this.streetNumber, this.streetName, this.neighborhood, this.city, this.state, this.country, this.postalCode, this.googlePlaceId, final  List<String> addressComponents = const [], this.plusCode, this.createdAt, this.updatedAt, this.createdBy, final  Map<String, dynamic>? metadata}): _addressComponents = addressComponents,_metadata = metadata,super._();
  factory _PlaceLocation.fromJson(Map<String, dynamic> json) => _$PlaceLocationFromJson(json);

@override final  String id;
@override final  String placeId;
// ID del lugar/negocio
@override final  LocationData coordinates;
@override final  String formattedAddress;
@override final  String? streetNumber;
@override final  String? streetName;
@override final  String? neighborhood;
@override final  String? city;
@override final  String? state;
@override final  String? country;
@override final  String? postalCode;
@override final  String? googlePlaceId;
// ID de Google Places API
 final  List<String> _addressComponents;
// ID de Google Places API
@override@JsonKey() List<String> get addressComponents {
  if (_addressComponents is EqualUnmodifiableListView) return _addressComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addressComponents);
}

@override final  String? plusCode;
// Google Plus Code
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  String? createdBy;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceLocationCopyWith<_PlaceLocation> get copyWith => __$PlaceLocationCopyWithImpl<_PlaceLocation>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceLocationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceLocation&&(identical(other.id, id) || other.id == id)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.coordinates, coordinates) || other.coordinates == coordinates)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.streetNumber, streetNumber) || other.streetNumber == streetNumber)&&(identical(other.streetName, streetName) || other.streetName == streetName)&&(identical(other.neighborhood, neighborhood) || other.neighborhood == neighborhood)&&(identical(other.city, city) || other.city == city)&&(identical(other.state, state) || other.state == state)&&(identical(other.country, country) || other.country == country)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.googlePlaceId, googlePlaceId) || other.googlePlaceId == googlePlaceId)&&const DeepCollectionEquality().equals(other._addressComponents, _addressComponents)&&(identical(other.plusCode, plusCode) || other.plusCode == plusCode)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,placeId,coordinates,formattedAddress,streetNumber,streetName,neighborhood,city,state,country,postalCode,googlePlaceId,const DeepCollectionEquality().hash(_addressComponents),plusCode,createdAt,updatedAt,createdBy,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'PlaceLocation(id: $id, placeId: $placeId, coordinates: $coordinates, formattedAddress: $formattedAddress, streetNumber: $streetNumber, streetName: $streetName, neighborhood: $neighborhood, city: $city, state: $state, country: $country, postalCode: $postalCode, googlePlaceId: $googlePlaceId, addressComponents: $addressComponents, plusCode: $plusCode, createdAt: $createdAt, updatedAt: $updatedAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PlaceLocationCopyWith<$Res> implements $PlaceLocationCopyWith<$Res> {
  factory _$PlaceLocationCopyWith(_PlaceLocation value, $Res Function(_PlaceLocation) _then) = __$PlaceLocationCopyWithImpl;
@override @useResult
$Res call({
 String id, String placeId, LocationData coordinates, String formattedAddress, String? streetNumber, String? streetName, String? neighborhood, String? city, String? state, String? country, String? postalCode, String? googlePlaceId, List<String> addressComponents, String? plusCode, DateTime? createdAt, DateTime? updatedAt, String? createdBy, Map<String, dynamic>? metadata
});


@override $LocationDataCopyWith<$Res> get coordinates;

}
/// @nodoc
class __$PlaceLocationCopyWithImpl<$Res>
    implements _$PlaceLocationCopyWith<$Res> {
  __$PlaceLocationCopyWithImpl(this._self, this._then);

  final _PlaceLocation _self;
  final $Res Function(_PlaceLocation) _then;

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? placeId = null,Object? coordinates = null,Object? formattedAddress = null,Object? streetNumber = freezed,Object? streetName = freezed,Object? neighborhood = freezed,Object? city = freezed,Object? state = freezed,Object? country = freezed,Object? postalCode = freezed,Object? googlePlaceId = freezed,Object? addressComponents = null,Object? plusCode = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_PlaceLocation(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,coordinates: null == coordinates ? _self.coordinates : coordinates // ignore: cast_nullable_to_non_nullable
as LocationData,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,streetNumber: freezed == streetNumber ? _self.streetNumber : streetNumber // ignore: cast_nullable_to_non_nullable
as String?,streetName: freezed == streetName ? _self.streetName : streetName // ignore: cast_nullable_to_non_nullable
as String?,neighborhood: freezed == neighborhood ? _self.neighborhood : neighborhood // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,state: freezed == state ? _self.state : state // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,postalCode: freezed == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String?,googlePlaceId: freezed == googlePlaceId ? _self.googlePlaceId : googlePlaceId // ignore: cast_nullable_to_non_nullable
as String?,addressComponents: null == addressComponents ? _self._addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<String>,plusCode: freezed == plusCode ? _self.plusCode : plusCode // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of PlaceLocation
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res> get coordinates {
  
  return $LocationDataCopyWith<$Res>(_self.coordinates, (value) {
    return _then(_self.copyWith(coordinates: value));
  });
}
}

// dart format on
