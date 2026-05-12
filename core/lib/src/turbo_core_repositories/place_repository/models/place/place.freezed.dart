// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Place {

 String get id; String get name; String get description; String get address; List<String> get imageUrls; double get rating; List<Review> get reviews; List<Offer> get offers; List<String> get tags; bool get isOpen; String get mainImage; int get favoriteCount; String get menuUrl; double get latitude; double get longitude; String get categoryId; String get categoryName; Map<String, Map<String, String>> get openingHours; String get phone; String get website; int get priceLevel; Map<String, dynamic> get metadata;//Campos administrativos para ownership y auditoría
 List<String> get ownerIds; String get createdBy; DateTime? get createdAt; DateTime? get lastUpdated;
/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCopyWith<Place> get copyWith => _$PlaceCopyWithImpl<Place>(this as Place, _$identity);

  /// Serializes this Place to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Place&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&const DeepCollectionEquality().equals(other.offers, offers)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.mainImage, mainImage) || other.mainImage == mainImage)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.menuUrl, menuUrl) || other.menuUrl == menuUrl)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other.openingHours, openingHours)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.website, website) || other.website == website)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&const DeepCollectionEquality().equals(other.ownerIds, ownerIds)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,address,const DeepCollectionEquality().hash(imageUrls),rating,const DeepCollectionEquality().hash(reviews),const DeepCollectionEquality().hash(offers),const DeepCollectionEquality().hash(tags),isOpen,mainImage,favoriteCount,menuUrl,latitude,longitude,categoryId,categoryName,const DeepCollectionEquality().hash(openingHours),phone,website,priceLevel,const DeepCollectionEquality().hash(metadata),const DeepCollectionEquality().hash(ownerIds),createdBy,createdAt,lastUpdated]);

@override
String toString() {
  return 'Place(id: $id, name: $name, description: $description, address: $address, imageUrls: $imageUrls, rating: $rating, reviews: $reviews, offers: $offers, tags: $tags, isOpen: $isOpen, mainImage: $mainImage, favoriteCount: $favoriteCount, menuUrl: $menuUrl, latitude: $latitude, longitude: $longitude, categoryId: $categoryId, categoryName: $categoryName, openingHours: $openingHours, phone: $phone, website: $website, priceLevel: $priceLevel, metadata: $metadata, ownerIds: $ownerIds, createdBy: $createdBy, createdAt: $createdAt, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class $PlaceCopyWith<$Res>  {
  factory $PlaceCopyWith(Place value, $Res Function(Place) _then) = _$PlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String address, List<String> imageUrls, double rating, List<Review> reviews, List<Offer> offers, List<String> tags, bool isOpen, String mainImage, int favoriteCount, String menuUrl, double latitude, double longitude, String categoryId, String categoryName, Map<String, Map<String, String>> openingHours, String phone, String website, int priceLevel, Map<String, dynamic> metadata, List<String> ownerIds, String createdBy, DateTime? createdAt, DateTime? lastUpdated
});




}
/// @nodoc
class _$PlaceCopyWithImpl<$Res>
    implements $PlaceCopyWith<$Res> {
  _$PlaceCopyWithImpl(this._self, this._then);

  final Place _self;
  final $Res Function(Place) _then;

/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? imageUrls = null,Object? rating = null,Object? reviews = null,Object? offers = null,Object? tags = null,Object? isOpen = null,Object? mainImage = null,Object? favoriteCount = null,Object? menuUrl = null,Object? latitude = null,Object? longitude = null,Object? categoryId = null,Object? categoryName = null,Object? openingHours = null,Object? phone = null,Object? website = null,Object? priceLevel = null,Object? metadata = null,Object? ownerIds = null,Object? createdBy = null,Object? createdAt = freezed,Object? lastUpdated = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,mainImage: null == mainImage ? _self.mainImage : mainImage // ignore: cast_nullable_to_non_nullable
as String,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,menuUrl: null == menuUrl ? _self.menuUrl : menuUrl // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,openingHours: null == openingHours ? _self.openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, String>>,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,priceLevel: null == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as int,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,ownerIds: null == ownerIds ? _self.ownerIds : ownerIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Place].
extension PlacePatterns on Place {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Place value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Place() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Place value)  $default,){
final _that = this;
switch (_that) {
case _Place():
return $default(_that);}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Place value)?  $default,){
final _that = this;
switch (_that) {
case _Place() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String address,  List<String> imageUrls,  double rating,  List<Review> reviews,  List<Offer> offers,  List<String> tags,  bool isOpen,  String mainImage,  int favoriteCount,  String menuUrl,  double latitude,  double longitude,  String categoryId,  String categoryName,  Map<String, Map<String, String>> openingHours,  String phone,  String website,  int priceLevel,  Map<String, dynamic> metadata,  List<String> ownerIds,  String createdBy,  DateTime? createdAt,  DateTime? lastUpdated)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Place() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.imageUrls,_that.rating,_that.reviews,_that.offers,_that.tags,_that.isOpen,_that.mainImage,_that.favoriteCount,_that.menuUrl,_that.latitude,_that.longitude,_that.categoryId,_that.categoryName,_that.openingHours,_that.phone,_that.website,_that.priceLevel,_that.metadata,_that.ownerIds,_that.createdBy,_that.createdAt,_that.lastUpdated);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String description,  String address,  List<String> imageUrls,  double rating,  List<Review> reviews,  List<Offer> offers,  List<String> tags,  bool isOpen,  String mainImage,  int favoriteCount,  String menuUrl,  double latitude,  double longitude,  String categoryId,  String categoryName,  Map<String, Map<String, String>> openingHours,  String phone,  String website,  int priceLevel,  Map<String, dynamic> metadata,  List<String> ownerIds,  String createdBy,  DateTime? createdAt,  DateTime? lastUpdated)  $default,) {final _that = this;
switch (_that) {
case _Place():
return $default(_that.id,_that.name,_that.description,_that.address,_that.imageUrls,_that.rating,_that.reviews,_that.offers,_that.tags,_that.isOpen,_that.mainImage,_that.favoriteCount,_that.menuUrl,_that.latitude,_that.longitude,_that.categoryId,_that.categoryName,_that.openingHours,_that.phone,_that.website,_that.priceLevel,_that.metadata,_that.ownerIds,_that.createdBy,_that.createdAt,_that.lastUpdated);}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String description,  String address,  List<String> imageUrls,  double rating,  List<Review> reviews,  List<Offer> offers,  List<String> tags,  bool isOpen,  String mainImage,  int favoriteCount,  String menuUrl,  double latitude,  double longitude,  String categoryId,  String categoryName,  Map<String, Map<String, String>> openingHours,  String phone,  String website,  int priceLevel,  Map<String, dynamic> metadata,  List<String> ownerIds,  String createdBy,  DateTime? createdAt,  DateTime? lastUpdated)?  $default,) {final _that = this;
switch (_that) {
case _Place() when $default != null:
return $default(_that.id,_that.name,_that.description,_that.address,_that.imageUrls,_that.rating,_that.reviews,_that.offers,_that.tags,_that.isOpen,_that.mainImage,_that.favoriteCount,_that.menuUrl,_that.latitude,_that.longitude,_that.categoryId,_that.categoryName,_that.openingHours,_that.phone,_that.website,_that.priceLevel,_that.metadata,_that.ownerIds,_that.createdBy,_that.createdAt,_that.lastUpdated);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Place implements Place {
  const _Place({required this.id, required this.name, required this.description, required this.address, required final  List<String> imageUrls, required this.rating, required final  List<Review> reviews, final  List<Offer> offers = const [], final  List<String> tags = const [], this.isOpen = false, this.mainImage = '', this.favoriteCount = 0, this.menuUrl = '', this.latitude = 0.0, this.longitude = 0.0, this.categoryId = '', this.categoryName = '', final  Map<String, Map<String, String>> openingHours = const {}, this.phone = '', this.website = '', this.priceLevel = 0, final  Map<String, dynamic> metadata = const {}, final  List<String> ownerIds = const [], this.createdBy = '', this.createdAt, this.lastUpdated}): _imageUrls = imageUrls,_reviews = reviews,_offers = offers,_tags = tags,_openingHours = openingHours,_metadata = metadata,_ownerIds = ownerIds;
  factory _Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String address;
 final  List<String> _imageUrls;
@override List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override final  double rating;
 final  List<Review> _reviews;
@override List<Review> get reviews {
  if (_reviews is EqualUnmodifiableListView) return _reviews;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_reviews);
}

 final  List<Offer> _offers;
@override@JsonKey() List<Offer> get offers {
  if (_offers is EqualUnmodifiableListView) return _offers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_offers);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  bool isOpen;
@override@JsonKey() final  String mainImage;
@override@JsonKey() final  int favoriteCount;
@override@JsonKey() final  String menuUrl;
@override@JsonKey() final  double latitude;
@override@JsonKey() final  double longitude;
@override@JsonKey() final  String categoryId;
@override@JsonKey() final  String categoryName;
 final  Map<String, Map<String, String>> _openingHours;
@override@JsonKey() Map<String, Map<String, String>> get openingHours {
  if (_openingHours is EqualUnmodifiableMapView) return _openingHours;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_openingHours);
}

@override@JsonKey() final  String phone;
@override@JsonKey() final  String website;
@override@JsonKey() final  int priceLevel;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}

//Campos administrativos para ownership y auditoría
 final  List<String> _ownerIds;
//Campos administrativos para ownership y auditoría
@override@JsonKey() List<String> get ownerIds {
  if (_ownerIds is EqualUnmodifiableListView) return _ownerIds;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_ownerIds);
}

@override@JsonKey() final  String createdBy;
@override final  DateTime? createdAt;
@override final  DateTime? lastUpdated;

/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCopyWith<_Place> get copyWith => __$PlaceCopyWithImpl<_Place>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Place&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&const DeepCollectionEquality().equals(other._offers, _offers)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&(identical(other.mainImage, mainImage) || other.mainImage == mainImage)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.menuUrl, menuUrl) || other.menuUrl == menuUrl)&&(identical(other.latitude, latitude) || other.latitude == latitude)&&(identical(other.longitude, longitude) || other.longitude == longitude)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.categoryName, categoryName) || other.categoryName == categoryName)&&const DeepCollectionEquality().equals(other._openingHours, _openingHours)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.website, website) || other.website == website)&&(identical(other.priceLevel, priceLevel) || other.priceLevel == priceLevel)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&const DeepCollectionEquality().equals(other._ownerIds, _ownerIds)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,name,description,address,const DeepCollectionEquality().hash(_imageUrls),rating,const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_offers),const DeepCollectionEquality().hash(_tags),isOpen,mainImage,favoriteCount,menuUrl,latitude,longitude,categoryId,categoryName,const DeepCollectionEquality().hash(_openingHours),phone,website,priceLevel,const DeepCollectionEquality().hash(_metadata),const DeepCollectionEquality().hash(_ownerIds),createdBy,createdAt,lastUpdated]);

@override
String toString() {
  return 'Place(id: $id, name: $name, description: $description, address: $address, imageUrls: $imageUrls, rating: $rating, reviews: $reviews, offers: $offers, tags: $tags, isOpen: $isOpen, mainImage: $mainImage, favoriteCount: $favoriteCount, menuUrl: $menuUrl, latitude: $latitude, longitude: $longitude, categoryId: $categoryId, categoryName: $categoryName, openingHours: $openingHours, phone: $phone, website: $website, priceLevel: $priceLevel, metadata: $metadata, ownerIds: $ownerIds, createdBy: $createdBy, createdAt: $createdAt, lastUpdated: $lastUpdated)';
}


}

/// @nodoc
abstract mixin class _$PlaceCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$PlaceCopyWith(_Place value, $Res Function(_Place) _then) = __$PlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String address, List<String> imageUrls, double rating, List<Review> reviews, List<Offer> offers, List<String> tags, bool isOpen, String mainImage, int favoriteCount, String menuUrl, double latitude, double longitude, String categoryId, String categoryName, Map<String, Map<String, String>> openingHours, String phone, String website, int priceLevel, Map<String, dynamic> metadata, List<String> ownerIds, String createdBy, DateTime? createdAt, DateTime? lastUpdated
});




}
/// @nodoc
class __$PlaceCopyWithImpl<$Res>
    implements _$PlaceCopyWith<$Res> {
  __$PlaceCopyWithImpl(this._self, this._then);

  final _Place _self;
  final $Res Function(_Place) _then;

/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? imageUrls = null,Object? rating = null,Object? reviews = null,Object? offers = null,Object? tags = null,Object? isOpen = null,Object? mainImage = null,Object? favoriteCount = null,Object? menuUrl = null,Object? latitude = null,Object? longitude = null,Object? categoryId = null,Object? categoryName = null,Object? openingHours = null,Object? phone = null,Object? website = null,Object? priceLevel = null,Object? metadata = null,Object? ownerIds = null,Object? createdBy = null,Object? createdAt = freezed,Object? lastUpdated = freezed,}) {
  return _then(_Place(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,offers: null == offers ? _self._offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,mainImage: null == mainImage ? _self.mainImage : mainImage // ignore: cast_nullable_to_non_nullable
as String,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,menuUrl: null == menuUrl ? _self.menuUrl : menuUrl // ignore: cast_nullable_to_non_nullable
as String,latitude: null == latitude ? _self.latitude : latitude // ignore: cast_nullable_to_non_nullable
as double,longitude: null == longitude ? _self.longitude : longitude // ignore: cast_nullable_to_non_nullable
as double,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,categoryName: null == categoryName ? _self.categoryName : categoryName // ignore: cast_nullable_to_non_nullable
as String,openingHours: null == openingHours ? _self._openingHours : openingHours // ignore: cast_nullable_to_non_nullable
as Map<String, Map<String, String>>,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,website: null == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String,priceLevel: null == priceLevel ? _self.priceLevel : priceLevel // ignore: cast_nullable_to_non_nullable
as int,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,ownerIds: null == ownerIds ? _self._ownerIds : ownerIds // ignore: cast_nullable_to_non_nullable
as List<String>,createdBy: null == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,lastUpdated: freezed == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
