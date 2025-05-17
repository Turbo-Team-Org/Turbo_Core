// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
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

 String get id; String get name; String get description; String get address; double get averagePrice; List<String> get imageUrls; double get rating; List<Review> get reviews; List<Offer> get offers; List<String> get tags; bool get isOpen; List<Schedule> get schedules; String get mainImage; int get favoriteCount; String get menuUrl;
/// Create a copy of Place
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCopyWith<Place> get copyWith => _$PlaceCopyWithImpl<Place>(this as Place, _$identity);

  /// Serializes this Place to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Place&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.averagePrice, averagePrice) || other.averagePrice == averagePrice)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.reviews, reviews)&&const DeepCollectionEquality().equals(other.offers, offers)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other.schedules, schedules)&&(identical(other.mainImage, mainImage) || other.mainImage == mainImage)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.menuUrl, menuUrl) || other.menuUrl == menuUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,averagePrice,const DeepCollectionEquality().hash(imageUrls),rating,const DeepCollectionEquality().hash(reviews),const DeepCollectionEquality().hash(offers),const DeepCollectionEquality().hash(tags),isOpen,const DeepCollectionEquality().hash(schedules),mainImage,favoriteCount,menuUrl);

@override
String toString() {
  return 'Place(id: $id, name: $name, description: $description, address: $address, averagePrice: $averagePrice, imageUrls: $imageUrls, rating: $rating, reviews: $reviews, offers: $offers, tags: $tags, isOpen: $isOpen, schedules: $schedules, mainImage: $mainImage, favoriteCount: $favoriteCount, menuUrl: $menuUrl)';
}


}

/// @nodoc
abstract mixin class $PlaceCopyWith<$Res>  {
  factory $PlaceCopyWith(Place value, $Res Function(Place) _then) = _$PlaceCopyWithImpl;
@useResult
$Res call({
 String id, String name, String description, String address, double averagePrice, List<String> imageUrls, double rating, List<Review> reviews, List<Offer> offers, List<String> tags, bool isOpen, List<Schedule> schedules, String mainImage, int favoriteCount, String menuUrl
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? averagePrice = null,Object? imageUrls = null,Object? rating = null,Object? reviews = null,Object? offers = null,Object? tags = null,Object? isOpen = null,Object? schedules = null,Object? mainImage = null,Object? favoriteCount = null,Object? menuUrl = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,averagePrice: null == averagePrice ? _self.averagePrice : averagePrice // ignore: cast_nullable_to_non_nullable
as double,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviews: null == reviews ? _self.reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,offers: null == offers ? _self.offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,schedules: null == schedules ? _self.schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<Schedule>,mainImage: null == mainImage ? _self.mainImage : mainImage // ignore: cast_nullable_to_non_nullable
as String,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,menuUrl: null == menuUrl ? _self.menuUrl : menuUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Place implements Place {
  const _Place({required this.id, required this.name, required this.description, required this.address, required this.averagePrice, required final  List<String> imageUrls, required this.rating, required final  List<Review> reviews, final  List<Offer> offers = const [], final  List<String> tags = const [], this.isOpen = false, final  List<Schedule> schedules = const [], this.mainImage = "", this.favoriteCount = 0, this.menuUrl = ""}): _imageUrls = imageUrls,_reviews = reviews,_offers = offers,_tags = tags,_schedules = schedules;
  factory _Place.fromJson(Map<String, dynamic> json) => _$PlaceFromJson(json);

@override final  String id;
@override final  String name;
@override final  String description;
@override final  String address;
@override final  double averagePrice;
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
 final  List<Schedule> _schedules;
@override@JsonKey() List<Schedule> get schedules {
  if (_schedules is EqualUnmodifiableListView) return _schedules;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_schedules);
}

@override@JsonKey() final  String mainImage;
@override@JsonKey() final  int favoriteCount;
@override@JsonKey() final  String menuUrl;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Place&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.address, address) || other.address == address)&&(identical(other.averagePrice, averagePrice) || other.averagePrice == averagePrice)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._reviews, _reviews)&&const DeepCollectionEquality().equals(other._offers, _offers)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.isOpen, isOpen) || other.isOpen == isOpen)&&const DeepCollectionEquality().equals(other._schedules, _schedules)&&(identical(other.mainImage, mainImage) || other.mainImage == mainImage)&&(identical(other.favoriteCount, favoriteCount) || other.favoriteCount == favoriteCount)&&(identical(other.menuUrl, menuUrl) || other.menuUrl == menuUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,description,address,averagePrice,const DeepCollectionEquality().hash(_imageUrls),rating,const DeepCollectionEquality().hash(_reviews),const DeepCollectionEquality().hash(_offers),const DeepCollectionEquality().hash(_tags),isOpen,const DeepCollectionEquality().hash(_schedules),mainImage,favoriteCount,menuUrl);

@override
String toString() {
  return 'Place(id: $id, name: $name, description: $description, address: $address, averagePrice: $averagePrice, imageUrls: $imageUrls, rating: $rating, reviews: $reviews, offers: $offers, tags: $tags, isOpen: $isOpen, schedules: $schedules, mainImage: $mainImage, favoriteCount: $favoriteCount, menuUrl: $menuUrl)';
}


}

/// @nodoc
abstract mixin class _$PlaceCopyWith<$Res> implements $PlaceCopyWith<$Res> {
  factory _$PlaceCopyWith(_Place value, $Res Function(_Place) _then) = __$PlaceCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String description, String address, double averagePrice, List<String> imageUrls, double rating, List<Review> reviews, List<Offer> offers, List<String> tags, bool isOpen, List<Schedule> schedules, String mainImage, int favoriteCount, String menuUrl
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? description = null,Object? address = null,Object? averagePrice = null,Object? imageUrls = null,Object? rating = null,Object? reviews = null,Object? offers = null,Object? tags = null,Object? isOpen = null,Object? schedules = null,Object? mainImage = null,Object? favoriteCount = null,Object? menuUrl = null,}) {
  return _then(_Place(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,address: null == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String,averagePrice: null == averagePrice ? _self.averagePrice : averagePrice // ignore: cast_nullable_to_non_nullable
as double,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,reviews: null == reviews ? _self._reviews : reviews // ignore: cast_nullable_to_non_nullable
as List<Review>,offers: null == offers ? _self._offers : offers // ignore: cast_nullable_to_non_nullable
as List<Offer>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,isOpen: null == isOpen ? _self.isOpen : isOpen // ignore: cast_nullable_to_non_nullable
as bool,schedules: null == schedules ? _self._schedules : schedules // ignore: cast_nullable_to_non_nullable
as List<Schedule>,mainImage: null == mainImage ? _self.mainImage : mainImage // ignore: cast_nullable_to_non_nullable
as String,favoriteCount: null == favoriteCount ? _self.favoriteCount : favoriteCount // ignore: cast_nullable_to_non_nullable
as int,menuUrl: null == menuUrl ? _self.menuUrl : menuUrl // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
