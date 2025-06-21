// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'distance_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$DistanceResult {

 double get distanceKm; double get distanceMeters; String get formattedDistance; Duration get estimatedTravelTime; String? get travelMode;// 'driving', 'walking', 'transit', 'bicycling'
 Map<String, dynamic>? get additionalInfo;
/// Create a copy of DistanceResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DistanceResultCopyWith<DistanceResult> get copyWith => _$DistanceResultCopyWithImpl<DistanceResult>(this as DistanceResult, _$identity);

  /// Serializes this DistanceResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DistanceResult&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.formattedDistance, formattedDistance) || other.formattedDistance == formattedDistance)&&(identical(other.estimatedTravelTime, estimatedTravelTime) || other.estimatedTravelTime == estimatedTravelTime)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode)&&const DeepCollectionEquality().equals(other.additionalInfo, additionalInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distanceKm,distanceMeters,formattedDistance,estimatedTravelTime,travelMode,const DeepCollectionEquality().hash(additionalInfo));

@override
String toString() {
  return 'DistanceResult(distanceKm: $distanceKm, distanceMeters: $distanceMeters, formattedDistance: $formattedDistance, estimatedTravelTime: $estimatedTravelTime, travelMode: $travelMode, additionalInfo: $additionalInfo)';
}


}

/// @nodoc
abstract mixin class $DistanceResultCopyWith<$Res>  {
  factory $DistanceResultCopyWith(DistanceResult value, $Res Function(DistanceResult) _then) = _$DistanceResultCopyWithImpl;
@useResult
$Res call({
 double distanceKm, double distanceMeters, String formattedDistance, Duration estimatedTravelTime, String? travelMode, Map<String, dynamic>? additionalInfo
});




}
/// @nodoc
class _$DistanceResultCopyWithImpl<$Res>
    implements $DistanceResultCopyWith<$Res> {
  _$DistanceResultCopyWithImpl(this._self, this._then);

  final DistanceResult _self;
  final $Res Function(DistanceResult) _then;

/// Create a copy of DistanceResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? distanceKm = null,Object? distanceMeters = null,Object? formattedDistance = null,Object? estimatedTravelTime = null,Object? travelMode = freezed,Object? additionalInfo = freezed,}) {
  return _then(_self.copyWith(
distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,formattedDistance: null == formattedDistance ? _self.formattedDistance : formattedDistance // ignore: cast_nullable_to_non_nullable
as String,estimatedTravelTime: null == estimatedTravelTime ? _self.estimatedTravelTime : estimatedTravelTime // ignore: cast_nullable_to_non_nullable
as Duration,travelMode: freezed == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as String?,additionalInfo: freezed == additionalInfo ? _self.additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DistanceResult extends DistanceResult {
  const _DistanceResult({required this.distanceKm, required this.distanceMeters, required this.formattedDistance, required this.estimatedTravelTime, this.travelMode, final  Map<String, dynamic>? additionalInfo}): _additionalInfo = additionalInfo,super._();
  factory _DistanceResult.fromJson(Map<String, dynamic> json) => _$DistanceResultFromJson(json);

@override final  double distanceKm;
@override final  double distanceMeters;
@override final  String formattedDistance;
@override final  Duration estimatedTravelTime;
@override final  String? travelMode;
// 'driving', 'walking', 'transit', 'bicycling'
 final  Map<String, dynamic>? _additionalInfo;
// 'driving', 'walking', 'transit', 'bicycling'
@override Map<String, dynamic>? get additionalInfo {
  final value = _additionalInfo;
  if (value == null) return null;
  if (_additionalInfo is EqualUnmodifiableMapView) return _additionalInfo;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of DistanceResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DistanceResultCopyWith<_DistanceResult> get copyWith => __$DistanceResultCopyWithImpl<_DistanceResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DistanceResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DistanceResult&&(identical(other.distanceKm, distanceKm) || other.distanceKm == distanceKm)&&(identical(other.distanceMeters, distanceMeters) || other.distanceMeters == distanceMeters)&&(identical(other.formattedDistance, formattedDistance) || other.formattedDistance == formattedDistance)&&(identical(other.estimatedTravelTime, estimatedTravelTime) || other.estimatedTravelTime == estimatedTravelTime)&&(identical(other.travelMode, travelMode) || other.travelMode == travelMode)&&const DeepCollectionEquality().equals(other._additionalInfo, _additionalInfo));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,distanceKm,distanceMeters,formattedDistance,estimatedTravelTime,travelMode,const DeepCollectionEquality().hash(_additionalInfo));

@override
String toString() {
  return 'DistanceResult(distanceKm: $distanceKm, distanceMeters: $distanceMeters, formattedDistance: $formattedDistance, estimatedTravelTime: $estimatedTravelTime, travelMode: $travelMode, additionalInfo: $additionalInfo)';
}


}

/// @nodoc
abstract mixin class _$DistanceResultCopyWith<$Res> implements $DistanceResultCopyWith<$Res> {
  factory _$DistanceResultCopyWith(_DistanceResult value, $Res Function(_DistanceResult) _then) = __$DistanceResultCopyWithImpl;
@override @useResult
$Res call({
 double distanceKm, double distanceMeters, String formattedDistance, Duration estimatedTravelTime, String? travelMode, Map<String, dynamic>? additionalInfo
});




}
/// @nodoc
class __$DistanceResultCopyWithImpl<$Res>
    implements _$DistanceResultCopyWith<$Res> {
  __$DistanceResultCopyWithImpl(this._self, this._then);

  final _DistanceResult _self;
  final $Res Function(_DistanceResult) _then;

/// Create a copy of DistanceResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? distanceKm = null,Object? distanceMeters = null,Object? formattedDistance = null,Object? estimatedTravelTime = null,Object? travelMode = freezed,Object? additionalInfo = freezed,}) {
  return _then(_DistanceResult(
distanceKm: null == distanceKm ? _self.distanceKm : distanceKm // ignore: cast_nullable_to_non_nullable
as double,distanceMeters: null == distanceMeters ? _self.distanceMeters : distanceMeters // ignore: cast_nullable_to_non_nullable
as double,formattedDistance: null == formattedDistance ? _self.formattedDistance : formattedDistance // ignore: cast_nullable_to_non_nullable
as String,estimatedTravelTime: null == estimatedTravelTime ? _self.estimatedTravelTime : estimatedTravelTime // ignore: cast_nullable_to_non_nullable
as Duration,travelMode: freezed == travelMode ? _self.travelMode : travelMode // ignore: cast_nullable_to_non_nullable
as String?,additionalInfo: freezed == additionalInfo ? _self._additionalInfo : additionalInfo // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$NearbySearchResult {

 String get placeId; String get name; DistanceResult get distance; double get latitude; double get longitude; String? get address; double? get rating; List<String> get types; String? get photoReference; Map<String, dynamic>? get additionalData;
/// Create a copy of NearbySearchResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$NearbySearchResultCopyWith<NearbySearchResult> get copyWith => _$NearbySearchResultCopyWithImpl<NearbySearchResult>(this as NearbySearchResult, _$identity);

  /// Serializes this NearbySearchResult to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is NearbySearchResult&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.types, types)&&(identical(other.photoReference, photoReference) || other.photoReference == photoReference)&&const DeepCollectionEquality().equals(other.additionalData, additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,name,distance,latitude,longitude,address,rating,const DeepCollectionEquality().hash(types),photoReference,const DeepCollectionEquality().hash(additionalData));

@override
String toString() {
  return 'NearbySearchResult(placeId: $placeId, name: $name, distance: $distance, latitude: $latitude, longitude: $longitude, address: $address, rating: $rating, types: $types, photoReference: $photoReference, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class $NearbySearchResultCopyWith<$Res>  {
  factory $NearbySearchResultCopyWith(NearbySearchResult value, $Res Function(NearbySearchResult) _then) = _$NearbySearchResultCopyWithImpl;
@useResult
$Res call({
 String placeId, String name, DistanceResult distance, double latitude, double longitude, String? address, double? rating, List<String> types, String? photoReference, Map<String, dynamic>? additionalData
});


$DistanceResultCopyWith<$Res> get distance;

}
/// @nodoc
class _$NearbySearchResultCopyWithImpl<$Res>
    implements $NearbySearchResultCopyWith<$Res> {
  _$NearbySearchResultCopyWithImpl(this._self, this._then);

  final NearbySearchResult _self;
  final $Res Function(NearbySearchResult) _then;

/// Create a copy of NearbySearchResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? name = null,Object? distance = null,Object? latitude = null,Object? longitude = null,Object? address = freezed,Object? rating = freezed,Object? types = null,Object? photoReference = freezed,Object? additionalData = freezed,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as DistanceResult,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,types: null == types ? _self.types : types // ignore: cast_nullable_to_non_nullable
as List<String>,photoReference: freezed == photoReference ? _self.photoReference : photoReference // ignore: cast_nullable_to_non_nullable
as String?,additionalData: freezed == additionalData ? _self.additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of NearbySearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistanceResultCopyWith<$Res> get distance {
  
  return $DistanceResultCopyWith<$Res>(_self.distance, (value) {
    return _then(_self.copyWith(distance: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _NearbySearchResult implements NearbySearchResult {
  const _NearbySearchResult({required this.placeId, required this.name, required this.distance, required this.latitude, required this.longitude, this.address, this.rating, final  List<String> types = const [], this.photoReference, final  Map<String, dynamic>? additionalData}): _types = types,_additionalData = additionalData;
  factory _NearbySearchResult.fromJson(Map<String, dynamic> json) => _$NearbySearchResultFromJson(json);

@override final  String placeId;
@override final  String name;
@override final  DistanceResult distance;
@override final  double latitude;
@override final  double longitude;
@override final  String? address;
@override final  double? rating;
 final  List<String> _types;
@override@JsonKey() List<String> get types {
  if (_types is EqualUnmodifiableListView) return _types;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_types);
}

@override final  String? photoReference;
 final  Map<String, dynamic>? _additionalData;
@override Map<String, dynamic>? get additionalData {
  final value = _additionalData;
  if (value == null) return null;
  if (_additionalData is EqualUnmodifiableMapView) return _additionalData;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of NearbySearchResult
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$NearbySearchResultCopyWith<_NearbySearchResult> get copyWith => __$NearbySearchResultCopyWithImpl<_NearbySearchResult>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$NearbySearchResultToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _NearbySearchResult&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.name, name) || other.name == name)&&(identical(other.distance, distance) || other.distance == distance)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.address, address) || other.address == address)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._types, _types)&&(identical(other.photoReference, photoReference) || other.photoReference == photoReference)&&const DeepCollectionEquality().equals(other._additionalData, _additionalData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,name,distance,latitude,longitude,address,rating,const DeepCollectionEquality().hash(_types),photoReference,const DeepCollectionEquality().hash(_additionalData));

@override
String toString() {
  return 'NearbySearchResult(placeId: $placeId, name: $name, distance: $distance, latitude: $latitude, longitude: $longitude, address: $address, rating: $rating, types: $types, photoReference: $photoReference, additionalData: $additionalData)';
}


}

/// @nodoc
abstract mixin class _$NearbySearchResultCopyWith<$Res> implements $NearbySearchResultCopyWith<$Res> {
  factory _$NearbySearchResultCopyWith(_NearbySearchResult value, $Res Function(_NearbySearchResult) _then) = __$NearbySearchResultCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String name, DistanceResult distance, double latitude, double longitude, String? address, double? rating, List<String> types, String? photoReference, Map<String, dynamic>? additionalData
});


@override $DistanceResultCopyWith<$Res> get distance;

}
/// @nodoc
class __$NearbySearchResultCopyWithImpl<$Res>
    implements _$NearbySearchResultCopyWith<$Res> {
  __$NearbySearchResultCopyWithImpl(this._self, this._then);

  final _NearbySearchResult _self;
  final $Res Function(_NearbySearchResult) _then;

/// Create a copy of NearbySearchResult
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? name = null,Object? distance = null,Object? latitude = null,Object? longitude = null,Object? address = freezed,Object? rating = freezed,Object? types = null,Object? photoReference = freezed,Object? additionalData = freezed,}) {
  return _then(_NearbySearchResult(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,distance: null == distance ? _self.distance : distance // ignore: cast_nullable_to_non_nullable
as DistanceResult,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,rating: freezed == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double?,types: null == types ? _self._types : types // ignore: cast_nullable_to_non_nullable
as List<String>,photoReference: freezed == photoReference ? _self.photoReference : photoReference // ignore: cast_nullable_to_non_nullable
as String?,additionalData: freezed == additionalData ? _self._additionalData : additionalData // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of NearbySearchResult
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DistanceResultCopyWith<$Res> get distance {
  
  return $DistanceResultCopyWith<$Res>(_self.distance, (value) {
    return _then(_self.copyWith(distance: value));
  });
}
}


/// @nodoc
mixin _$ProximityFilter {

 double get latitude; double get longitude; double get radiusMeters;// Radio en metros
 int get limit;// Límite de resultados
 List<String> get categories;// Categorías a filtrar
 List<String> get excludeIds;// IDs a excluir
 String? get sortBy;// 'distance', 'rating', 'popularity'
 double? get minRating; bool? get openNow;
/// Create a copy of ProximityFilter
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProximityFilterCopyWith<ProximityFilter> get copyWith => _$ProximityFilterCopyWithImpl<ProximityFilter>(this as ProximityFilter, _$identity);

  /// Serializes this ProximityFilter to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProximityFilter&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.limit, limit) || other.limit == limit)&&const DeepCollectionEquality().equals(other.categories, categories)&&const DeepCollectionEquality().equals(other.excludeIds, excludeIds)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.openNow, openNow) || other.openNow == openNow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radiusMeters,limit,const DeepCollectionEquality().hash(categories),const DeepCollectionEquality().hash(excludeIds),sortBy,minRating,openNow);

@override
String toString() {
  return 'ProximityFilter(latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, limit: $limit, categories: $categories, excludeIds: $excludeIds, sortBy: $sortBy, minRating: $minRating, openNow: $openNow)';
}


}

/// @nodoc
abstract mixin class $ProximityFilterCopyWith<$Res>  {
  factory $ProximityFilterCopyWith(ProximityFilter value, $Res Function(ProximityFilter) _then) = _$ProximityFilterCopyWithImpl;
@useResult
$Res call({
 double latitude, double longitude, double radiusMeters, int limit, List<String> categories, List<String> excludeIds, String? sortBy, double? minRating, bool? openNow
});




}
/// @nodoc
class _$ProximityFilterCopyWithImpl<$Res>
    implements $ProximityFilterCopyWith<$Res> {
  _$ProximityFilterCopyWithImpl(this._self, this._then);

  final ProximityFilter _self;
  final $Res Function(ProximityFilter) _then;

/// Create a copy of ProximityFilter
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? latitude = null,Object? longitude = null,Object? radiusMeters = null,Object? limit = null,Object? categories = null,Object? excludeIds = null,Object? sortBy = freezed,Object? minRating = freezed,Object? openNow = freezed,}) {
  return _then(_self.copyWith(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as double,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self.categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,excludeIds: null == excludeIds ? _self.excludeIds : excludeIds // ignore: cast_nullable_to_non_nullable
as List<String>,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,openNow: freezed == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ProximityFilter extends ProximityFilter {
  const _ProximityFilter({required this.latitude, required this.longitude, this.radiusMeters = 5000, this.limit = 10, final  List<String> categories = const [], final  List<String> excludeIds = const [], this.sortBy, this.minRating, this.openNow}): _categories = categories,_excludeIds = excludeIds,super._();
  factory _ProximityFilter.fromJson(Map<String, dynamic> json) => _$ProximityFilterFromJson(json);

@override final  double latitude;
@override final  double longitude;
@override@JsonKey() final  double radiusMeters;
// Radio en metros
@override@JsonKey() final  int limit;
// Límite de resultados
 final  List<String> _categories;
// Límite de resultados
@override@JsonKey() List<String> get categories {
  if (_categories is EqualUnmodifiableListView) return _categories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_categories);
}

// Categorías a filtrar
 final  List<String> _excludeIds;
// Categorías a filtrar
@override@JsonKey() List<String> get excludeIds {
  if (_excludeIds is EqualUnmodifiableListView) return _excludeIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_excludeIds);
}

// IDs a excluir
@override final  String? sortBy;
// 'distance', 'rating', 'popularity'
@override final  double? minRating;
@override final  bool? openNow;

/// Create a copy of ProximityFilter
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProximityFilterCopyWith<_ProximityFilter> get copyWith => __$ProximityFilterCopyWithImpl<_ProximityFilter>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProximityFilterToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProximityFilter&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.radiusMeters, radiusMeters) || other.radiusMeters == radiusMeters)&&(identical(other.limit, limit) || other.limit == limit)&&const DeepCollectionEquality().equals(other._categories, _categories)&&const DeepCollectionEquality().equals(other._excludeIds, _excludeIds)&&(identical(other.sortBy, sortBy) || other.sortBy == sortBy)&&(identical(other.minRating, minRating) || other.minRating == minRating)&&(identical(other.openNow, openNow) || other.openNow == openNow));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,latitude,longitude,radiusMeters,limit,const DeepCollectionEquality().hash(_categories),const DeepCollectionEquality().hash(_excludeIds),sortBy,minRating,openNow);

@override
String toString() {
  return 'ProximityFilter(latitude: $latitude, longitude: $longitude, radiusMeters: $radiusMeters, limit: $limit, categories: $categories, excludeIds: $excludeIds, sortBy: $sortBy, minRating: $minRating, openNow: $openNow)';
}


}

/// @nodoc
abstract mixin class _$ProximityFilterCopyWith<$Res> implements $ProximityFilterCopyWith<$Res> {
  factory _$ProximityFilterCopyWith(_ProximityFilter value, $Res Function(_ProximityFilter) _then) = __$ProximityFilterCopyWithImpl;
@override @useResult
$Res call({
 double latitude, double longitude, double radiusMeters, int limit, List<String> categories, List<String> excludeIds, String? sortBy, double? minRating, bool? openNow
});




}
/// @nodoc
class __$ProximityFilterCopyWithImpl<$Res>
    implements _$ProximityFilterCopyWith<$Res> {
  __$ProximityFilterCopyWithImpl(this._self, this._then);

  final _ProximityFilter _self;
  final $Res Function(_ProximityFilter) _then;

/// Create a copy of ProximityFilter
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? latitude = null,Object? longitude = null,Object? radiusMeters = null,Object? limit = null,Object? categories = null,Object? excludeIds = null,Object? sortBy = freezed,Object? minRating = freezed,Object? openNow = freezed,}) {
  return _then(_ProximityFilter(
latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,radiusMeters: null == radiusMeters ? _self.radiusMeters : radiusMeters // ignore: cast_nullable_to_non_nullable
as double,limit: null == limit ? _self.limit : limit // ignore: cast_nullable_to_non_nullable
as int,categories: null == categories ? _self._categories : categories // ignore: cast_nullable_to_non_nullable
as List<String>,excludeIds: null == excludeIds ? _self._excludeIds : excludeIds // ignore: cast_nullable_to_non_nullable
as List<String>,sortBy: freezed == sortBy ? _self.sortBy : sortBy // ignore: cast_nullable_to_non_nullable
as String?,minRating: freezed == minRating ? _self.minRating : minRating // ignore: cast_nullable_to_non_nullable
as double?,openNow: freezed == openNow ? _self.openNow : openNow // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
