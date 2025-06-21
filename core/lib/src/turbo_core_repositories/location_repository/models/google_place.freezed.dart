// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'google_place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$GooglePlace {

 String get placeId; String get name; String get formattedAddress; LocationData get location; List<String> get types; String? get businessStatus; String? get vicinity; double? get rating; int? get userRatingsTotal; String? get photoReference; List<String> get photoReferences; String? get website; String? get phoneNumber; String? get internationalPhoneNumber; List<Map<String, dynamic>> get openingHours; String? get plusCode; List<Map<String, dynamic>> get addressComponents; Map<String, dynamic>? get geometry; String? get icon; String? get iconBackgroundColor; String? get iconMaskBaseUri; bool? get permanentlyClosed; List<String> get secondaryOpeningsHours; String? get utcOffset; String? get adrAddress; String? get formattedPhoneNumber; String? get url;
/// Create a copy of GooglePlace
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$GooglePlaceCopyWith<GooglePlace> get copyWith => _$GooglePlaceCopyWithImpl<GooglePlace>(this as GooglePlace, _$identity);

  /// Serializes this GooglePlace to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is GooglePlace&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.types, types)&&(identical(other.businessStatus, businessStatus) || other.businessStatus == businessStatus)&&(identical(other.vicinity, vicinity) || other.vicinity == vicinity)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.userRatingsTotal, userRatingsTotal) || other.userRatingsTotal == userRatingsTotal)&&(identical(other.photoReference, photoReference) || other.photoReference == photoReference)&&const DeepCollectionEquality().equals(other.photoReferences, photoReferences)&&(identical(other.website, website) || other.website == website)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.internationalPhoneNumber, internationalPhoneNumber) || other.internationalPhoneNumber == internationalPhoneNumber)&&const DeepCollectionEquality().equals(other.openingHours, openingHours)&&(identical(other.plusCode, plusCode) || other.plusCode == plusCode)&&const DeepCollectionEquality().equals(other.addressComponents, addressComponents)&&const DeepCollectionEquality().equals(other.geometry, geometry)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackgroundColor, iconBackgroundColor) || other.iconBackgroundColor == iconBackgroundColor)&&(identical(other.iconMaskBaseUri, iconMaskBaseUri) || other.iconMaskBaseUri == iconMaskBaseUri)&&(identical(other.permanentlyClosed, permanentlyClosed) || other.permanentlyClosed == permanentlyClosed)&&const DeepCollectionEquality().equals(other.secondaryOpeningsHours, secondaryOpeningsHours)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset)&&(identical(other.adrAddress, adrAddress) || other.adrAddress == adrAddress)&&(identical(other.formattedPhoneNumber, formattedPhoneNumber) || other.formattedPhoneNumber == formattedPhoneNumber)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,formattedAddress,location,const DeepCollectionEquality().hash(types),businessStatus,vicinity,rating,userRatingsTotal,photoReference,const DeepCollectionEquality().hash(photoReferences),website,phoneNumber,internationalPhoneNumber,const DeepCollectionEquality().hash(openingHours),plusCode,const DeepCollectionEquality().hash(addressComponents),const DeepCollectionEquality().hash(geometry),icon,iconBackgroundColor,iconMaskBaseUri,permanentlyClosed,const DeepCollectionEquality().hash(secondaryOpeningsHours),utcOffset,adrAddress,formattedPhoneNumber,url]);

@override
String toString() {
  return 'GooglePlace(placeId: $placeId, name: $name, formattedAddress: $formattedAddress, location: $location, types: $types, businessStatus: $businessStatus, vicinity: $vicinity, rating: $rating, userRatingsTotal: $userRatingsTotal, photoReference: $photoReference, photoReferences: $photoReferences, website: $website, phoneNumber: $phoneNumber, internationalPhoneNumber: $internationalPhoneNumber, openingHours: $openingHours, plusCode: $plusCode, addressComponents: $addressComponents, geometry: $geometry, icon: $icon, iconBackgroundColor: $iconBackgroundColor, iconMaskBaseUri: $iconMaskBaseUri, permanentlyClosed: $permanentlyClosed, secondaryOpeningsHours: $secondaryOpeningsHours, utcOffset: $utcOffset, adrAddress: $adrAddress, formattedPhoneNumber: $formattedPhoneNumber, url: $url)';
}


}

/// @nodoc
abstract mixin class $GooglePlaceCopyWith<$Res>  {
  factory $GooglePlaceCopyWith(GooglePlace value, $Res Function(GooglePlace) _then) = _$GooglePlaceCopyWithImpl;
@useResult
$Res call({
 String placeId, String name, String formattedAddress, LocationData location, List<String> types, String? businessStatus, String? vicinity, double? rating, int? userRatingsTotal, String? photoReference, List<String> photoReferences, String? website, String? phoneNumber, String? internationalPhoneNumber, List<Map<String, dynamic>> openingHours, String? plusCode, List<Map<String, dynamic>> addressComponents, Map<String, dynamic>? geometry, String? icon, String? iconBackgroundColor, String? iconMaskBaseUri, bool? permanentlyClosed, List<String> secondaryOpeningsHours, String? utcOffset, String? adrAddress, String? formattedPhoneNumber, String? url
});


$LocationDataCopyWith<$Res> get location;

}
/// @nodoc
class _$GooglePlaceCopyWithImpl<$Res>
    implements $GooglePlaceCopyWith<$Res> {
  _$GooglePlaceCopyWithImpl(this._self, this._then);

  final GooglePlace _self;
  final $Res Function(GooglePlace) _then;

/// Create a copy of GooglePlace
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? name = null,Object? formattedAddress = null,Object? location = null,Object? types = null,Object? businessStatus = freezed,Object? vicinity = freezed,Object? rating = freezed,Object? userRatingsTotal = freezed,Object? photoReference = freezed,Object? photoReferences = null,Object? website = freezed,Object? phoneNumber = freezed,Object? internationalPhoneNumber = freezed,Object? openingHours = null,Object? plusCode = freezed,Object? addressComponents = null,Object? geometry = freezed,Object? icon = freezed,Object? iconBackgroundColor = freezed,Object? iconMaskBaseUri = freezed,Object? permanentlyClosed = freezed,Object? secondaryOpeningsHours = null,Object? utcOffset = freezed,Object? adrAddress = freezed,Object? formattedPhoneNumber = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,businessStatus: freezed == businessStatus ? _self.businessStatus : businessStatus // ignore: cast_nullable_to_non_nullable
as String?,vicinity: freezed == vicinity ? _self.vicinity : vicinity // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,userRatingsTotal: freezed == userRatingsTotal ? _self.userRatingsTotal : userRatingsTotal // ignore: cast_nullable_to_non_nullable
as int?,photoReference: freezed == photoReference ? _self.photoReference : photoReference // ignore: cast_nullable_to_non_nullable
as String?,photoReferences: null == photoReferences ? _self.photoReferences : photoReferences // ignore: cast_nullable_to_non_nullable
as List<String>,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,internationalPhoneNumber: freezed == internationalPhoneNumber ? _self.internationalPhoneNumber : internationalPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,plusCode: freezed == plusCode ? _self.plusCode : plusCode // ignore: cast_nullable_to_non_nullable
as String?,addressComponents: null == addressComponents ? _self.addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,geometry: freezed == geometry ? _self.geometry : geometry // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,iconBackgroundColor: freezed == iconBackgroundColor ? _self.iconBackgroundColor : iconBackgroundColor // ignore: cast_nullable_to_non_nullable
as String?,iconMaskBaseUri: freezed == iconMaskBaseUri ? _self.iconMaskBaseUri : iconMaskBaseUri // ignore: cast_nullable_to_non_nullable
as String?,permanentlyClosed: freezed == permanentlyClosed ? _self.permanentlyClosed : permanentlyClosed // ignore: cast_nullable_to_non_nullable
as bool?,secondaryOpeningsHours: null == secondaryOpeningsHours ? _self.secondaryOpeningsHours : secondaryOpeningsHours // ignore: cast_nullable_to_non_nullable
as List<String>,utcOffset: freezed == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as String?,adrAddress: freezed == adrAddress ? _self.adrAddress : adrAddress // ignore: cast_nullable_to_non_nullable
as String?,formattedPhoneNumber: freezed == formattedPhoneNumber ? _self.formattedPhoneNumber : formattedPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of GooglePlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res> get location {
  
  return $LocationDataCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _GooglePlace extends GooglePlace {
  const _GooglePlace({required this.placeId, required this.name, required this.formattedAddress, required this.location, final  List<String> types = const [], this.businessStatus, this.vicinity, this.rating, this.userRatingsTotal, this.photoReference, final  List<String> photoReferences = const [], this.website, this.phoneNumber, this.internationalPhoneNumber, final  List<Map<String, dynamic>> openingHours = const [], this.plusCode, final  List<Map<String, dynamic>> addressComponents = const [], final  Map<String, dynamic>? geometry, this.icon, this.iconBackgroundColor, this.iconMaskBaseUri, this.permanentlyClosed, final  List<String> secondaryOpeningsHours = const [], this.utcOffset, this.adrAddress, this.formattedPhoneNumber, this.url}): _types = types,_photoReferences = photoReferences,_openingHours = openingHours,_addressComponents = addressComponents,_geometry = geometry,_secondaryOpeningsHours = secondaryOpeningsHours,super._();
  factory _GooglePlace.fromJson(Map<String, dynamic> json) => _$GooglePlaceFromJson(json);

@override final  String placeId;
@override final  String name;
@override final  String formattedAddress;
@override final  LocationData location;
 final  List<String> _types;
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

@override final  String? businessStatus;
@override final  String? vicinity;
@override final  double? rating;
@override final  int? userRatingsTotal;
@override final  String? photoReference;
 final  List<String> _photoReferences;
@override@JsonKey() List<String> get photoReferences {
  if (_photoReferences is EqualUnmodifiableListView) return _photoReferences;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_photoReferences);
}

@override final  String? website;
@override final  String? phoneNumber;
@override final  String? internationalPhoneNumber;
 final  List<Map<String, dynamic>> _openingHours;
@override@JsonKey() List<Map<String, dynamic>> get openingHours {
  if (_openingHours is EqualUnmodifiableListView) return _openingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_openingHours);
}

@override final  String? plusCode;
 final  List<Map<String, dynamic>> _addressComponents;
@override@JsonKey() List<Map<String, dynamic>> get addressComponents {
  if (_addressComponents is EqualUnmodifiableListView) return _addressComponents;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_addressComponents);
}

 final  Map<String, dynamic>? _geometry;
@override Map<String, dynamic>? get geometry {
  final value = _geometry;
  if (value == null) return null;
  if (_geometry is EqualUnmodifiableMapView) return _geometry;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? icon;
@override final  String? iconBackgroundColor;
@override final  String? iconMaskBaseUri;
@override final  bool? permanentlyClosed;
 final  List<String> _secondaryOpeningsHours;
@override@JsonKey() List<String> get secondaryOpeningsHours {
  if (_secondaryOpeningsHours is EqualUnmodifiableListView) return _secondaryOpeningsHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_secondaryOpeningsHours);
}

@override final  String? utcOffset;
@override final  String? adrAddress;
@override final  String? formattedPhoneNumber;
@override final  String? url;

/// Create a copy of GooglePlace
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$GooglePlaceCopyWith<_GooglePlace> get copyWith => __$GooglePlaceCopyWithImpl<_GooglePlace>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$GooglePlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _GooglePlace&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.formattedAddress, formattedAddress) || other.formattedAddress == formattedAddress)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._types, _types)&&(identical(other.businessStatus, businessStatus) || other.businessStatus == businessStatus)&&(identical(other.vicinity, vicinity) || other.vicinity == vicinity)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.userRatingsTotal, userRatingsTotal) || other.userRatingsTotal == userRatingsTotal)&&(identical(other.photoReference, photoReference) || other.photoReference == photoReference)&&const DeepCollectionEquality().equals(other._photoReferences, _photoReferences)&&(identical(other.website, website) || other.website == website)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.internationalPhoneNumber, internationalPhoneNumber) || other.internationalPhoneNumber == internationalPhoneNumber)&&const DeepCollectionEquality().equals(other._openingHours, _openingHours)&&(identical(other.plusCode, plusCode) || other.plusCode == plusCode)&&const DeepCollectionEquality().equals(other._addressComponents, _addressComponents)&&const DeepCollectionEquality().equals(other._geometry, _geometry)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.iconBackgroundColor, iconBackgroundColor) || other.iconBackgroundColor == iconBackgroundColor)&&(identical(other.iconMaskBaseUri, iconMaskBaseUri) || other.iconMaskBaseUri == iconMaskBaseUri)&&(identical(other.permanentlyClosed, permanentlyClosed) || other.permanentlyClosed == permanentlyClosed)&&const DeepCollectionEquality().equals(other._secondaryOpeningsHours, _secondaryOpeningsHours)&&(identical(other.utcOffset, utcOffset) || other.utcOffset == utcOffset)&&(identical(other.adrAddress, adrAddress) || other.adrAddress == adrAddress)&&(identical(other.formattedPhoneNumber, formattedPhoneNumber) || other.formattedPhoneNumber == formattedPhoneNumber)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,placeId,name,formattedAddress,location,const DeepCollectionEquality().hash(_types),businessStatus,vicinity,rating,userRatingsTotal,photoReference,const DeepCollectionEquality().hash(_photoReferences),website,phoneNumber,internationalPhoneNumber,const DeepCollectionEquality().hash(_openingHours),plusCode,const DeepCollectionEquality().hash(_addressComponents),const DeepCollectionEquality().hash(_geometry),icon,iconBackgroundColor,iconMaskBaseUri,permanentlyClosed,const DeepCollectionEquality().hash(_secondaryOpeningsHours),utcOffset,adrAddress,formattedPhoneNumber,url]);

@override
String toString() {
  return 'GooglePlace(placeId: $placeId, name: $name, formattedAddress: $formattedAddress, location: $location, types: $types, businessStatus: $businessStatus, vicinity: $vicinity, rating: $rating, userRatingsTotal: $userRatingsTotal, photoReference: $photoReference, photoReferences: $photoReferences, website: $website, phoneNumber: $phoneNumber, internationalPhoneNumber: $internationalPhoneNumber, openingHours: $openingHours, plusCode: $plusCode, addressComponents: $addressComponents, geometry: $geometry, icon: $icon, iconBackgroundColor: $iconBackgroundColor, iconMaskBaseUri: $iconMaskBaseUri, permanentlyClosed: $permanentlyClosed, secondaryOpeningsHours: $secondaryOpeningsHours, utcOffset: $utcOffset, adrAddress: $adrAddress, formattedPhoneNumber: $formattedPhoneNumber, url: $url)';
}


}

/// @nodoc
abstract mixin class _$GooglePlaceCopyWith<$Res> implements $GooglePlaceCopyWith<$Res> {
  factory _$GooglePlaceCopyWith(_GooglePlace value, $Res Function(_GooglePlace) _then) = __$GooglePlaceCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String name, String formattedAddress, LocationData location, List<String> types, String? businessStatus, String? vicinity, double? rating, int? userRatingsTotal, String? photoReference, List<String> photoReferences, String? website, String? phoneNumber, String? internationalPhoneNumber, List<Map<String, dynamic>> openingHours, String? plusCode, List<Map<String, dynamic>> addressComponents, Map<String, dynamic>? geometry, String? icon, String? iconBackgroundColor, String? iconMaskBaseUri, bool? permanentlyClosed, List<String> secondaryOpeningsHours, String? utcOffset, String? adrAddress, String? formattedPhoneNumber, String? url
});


@override $LocationDataCopyWith<$Res> get location;

}
/// @nodoc
class __$GooglePlaceCopyWithImpl<$Res>
    implements _$GooglePlaceCopyWith<$Res> {
  __$GooglePlaceCopyWithImpl(this._self, this._then);

  final _GooglePlace _self;
  final $Res Function(_GooglePlace) _then;

/// Create a copy of GooglePlace
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? name = null,Object? formattedAddress = null,Object? location = null,Object? types = null,Object? businessStatus = freezed,Object? vicinity = freezed,Object? rating = freezed,Object? userRatingsTotal = freezed,Object? photoReference = freezed,Object? photoReferences = null,Object? website = freezed,Object? phoneNumber = freezed,Object? internationalPhoneNumber = freezed,Object? openingHours = null,Object? plusCode = freezed,Object? addressComponents = null,Object? geometry = freezed,Object? icon = freezed,Object? iconBackgroundColor = freezed,Object? iconMaskBaseUri = freezed,Object? permanentlyClosed = freezed,Object? secondaryOpeningsHours = null,Object? utcOffset = freezed,Object? adrAddress = freezed,Object? formattedPhoneNumber = freezed,Object? url = freezed,}) {
  return _then(_GooglePlace(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,formattedAddress: null == formattedAddress ? _self.formattedAddress : formattedAddress // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as LocationData,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,businessStatus: freezed == businessStatus ? _self.businessStatus : businessStatus // ignore: cast_nullable_to_non_nullable
as String?,vicinity: freezed == vicinity ? _self.vicinity : vicinity // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,userRatingsTotal: freezed == userRatingsTotal ? _self.userRatingsTotal : userRatingsTotal // ignore: cast_nullable_to_non_nullable
as int?,photoReference: freezed == photoReference ? _self.photoReference : photoReference // ignore: cast_nullable_to_non_nullable
as String?,photoReferences: null == photoReferences ? _self._photoReferences : photoReferences // ignore: cast_nullable_to_non_nullable
as List<String>,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,internationalPhoneNumber: freezed == internationalPhoneNumber ? _self.internationalPhoneNumber : internationalPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,openingHours: null == openingHours ? _self._openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,plusCode: freezed == plusCode ? _self.plusCode : plusCode // ignore: cast_nullable_to_non_nullable
as String?,addressComponents: null == addressComponents ? _self._addressComponents : addressComponents // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,geometry: freezed == geometry ? _self._geometry : geometry // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,icon: freezed == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String?,iconBackgroundColor: freezed == iconBackgroundColor ? _self.iconBackgroundColor : iconBackgroundColor // ignore: cast_nullable_to_non_nullable
as String?,iconMaskBaseUri: freezed == iconMaskBaseUri ? _self.iconMaskBaseUri : iconMaskBaseUri // ignore: cast_nullable_to_non_nullable
as String?,permanentlyClosed: freezed == permanentlyClosed ? _self.permanentlyClosed : permanentlyClosed // ignore: cast_nullable_to_non_nullable
as bool?,secondaryOpeningsHours: null == secondaryOpeningsHours ? _self._secondaryOpeningsHours : secondaryOpeningsHours // ignore: cast_nullable_to_non_nullable
as List<String>,utcOffset: freezed == utcOffset ? _self.utcOffset : utcOffset // ignore: cast_nullable_to_non_nullable
as String?,adrAddress: freezed == adrAddress ? _self.adrAddress : adrAddress // ignore: cast_nullable_to_non_nullable
as String?,formattedPhoneNumber: freezed == formattedPhoneNumber ? _self.formattedPhoneNumber : formattedPhoneNumber // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of GooglePlace
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LocationDataCopyWith<$Res> get location {
  
  return $LocationDataCopyWith<$Res>(_self.location, (value) {
    return _then(_self.copyWith(location: value));
  });
}
}

// dart format on
