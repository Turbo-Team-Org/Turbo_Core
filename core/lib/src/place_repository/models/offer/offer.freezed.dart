// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Offer {

 String get offerTitle; String get offerDescription;@TimestampDateTimeConverter() DateTime get offerValidUntil; double? get offerPrice; String? get offerConditions; String? get offerImage; String get name; String get description; String get image;
/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OfferCopyWith<Offer> get copyWith => _$OfferCopyWithImpl<Offer>(this as Offer, _$identity);

  /// Serializes this Offer to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Offer&&(identical(other.offerTitle, offerTitle) || other.offerTitle == offerTitle)&&(identical(other.offerDescription, offerDescription) || other.offerDescription == offerDescription)&&(identical(other.offerValidUntil, offerValidUntil) || other.offerValidUntil == offerValidUntil)&&(identical(other.offerPrice, offerPrice) || other.offerPrice == offerPrice)&&(identical(other.offerConditions, offerConditions) || other.offerConditions == offerConditions)&&(identical(other.offerImage, offerImage) || other.offerImage == offerImage)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offerTitle,offerDescription,offerValidUntil,offerPrice,offerConditions,offerImage,name,description,image);

@override
String toString() {
  return 'Offer(offerTitle: $offerTitle, offerDescription: $offerDescription, offerValidUntil: $offerValidUntil, offerPrice: $offerPrice, offerConditions: $offerConditions, offerImage: $offerImage, name: $name, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class $OfferCopyWith<$Res>  {
  factory $OfferCopyWith(Offer value, $Res Function(Offer) _then) = _$OfferCopyWithImpl;
@useResult
$Res call({
 String offerTitle, String offerDescription,@TimestampDateTimeConverter() DateTime offerValidUntil, double? offerPrice, String? offerConditions, String? offerImage, String name, String description, String image
});




}
/// @nodoc
class _$OfferCopyWithImpl<$Res>
    implements $OfferCopyWith<$Res> {
  _$OfferCopyWithImpl(this._self, this._then);

  final Offer _self;
  final $Res Function(Offer) _then;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? offerTitle = null,Object? offerDescription = null,Object? offerValidUntil = null,Object? offerPrice = freezed,Object? offerConditions = freezed,Object? offerImage = freezed,Object? name = null,Object? description = null,Object? image = null,}) {
  return _then(_self.copyWith(
offerTitle: null == offerTitle ? _self.offerTitle : offerTitle // ignore: cast_nullable_to_non_nullable
as String,offerDescription: null == offerDescription ? _self.offerDescription : offerDescription // ignore: cast_nullable_to_non_nullable
as String,offerValidUntil: null == offerValidUntil ? _self.offerValidUntil : offerValidUntil // ignore: cast_nullable_to_non_nullable
as DateTime,offerPrice: freezed == offerPrice ? _self.offerPrice : offerPrice // ignore: cast_nullable_to_non_nullable
as double?,offerConditions: freezed == offerConditions ? _self.offerConditions : offerConditions // ignore: cast_nullable_to_non_nullable
as String?,offerImage: freezed == offerImage ? _self.offerImage : offerImage // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Offer implements Offer {
  const _Offer({required this.offerTitle, required this.offerDescription, @TimestampDateTimeConverter() required this.offerValidUntil, this.offerPrice, this.offerConditions, this.offerImage, this.name = '', this.description = '', this.image = ''});
  factory _Offer.fromJson(Map<String, dynamic> json) => _$OfferFromJson(json);

@override final  String offerTitle;
@override final  String offerDescription;
@override@TimestampDateTimeConverter() final  DateTime offerValidUntil;
@override final  double? offerPrice;
@override final  String? offerConditions;
@override final  String? offerImage;
@override@JsonKey() final  String name;
@override@JsonKey() final  String description;
@override@JsonKey() final  String image;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OfferCopyWith<_Offer> get copyWith => __$OfferCopyWithImpl<_Offer>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OfferToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Offer&&(identical(other.offerTitle, offerTitle) || other.offerTitle == offerTitle)&&(identical(other.offerDescription, offerDescription) || other.offerDescription == offerDescription)&&(identical(other.offerValidUntil, offerValidUntil) || other.offerValidUntil == offerValidUntil)&&(identical(other.offerPrice, offerPrice) || other.offerPrice == offerPrice)&&(identical(other.offerConditions, offerConditions) || other.offerConditions == offerConditions)&&(identical(other.offerImage, offerImage) || other.offerImage == offerImage)&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.image, image) || other.image == image));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,offerTitle,offerDescription,offerValidUntil,offerPrice,offerConditions,offerImage,name,description,image);

@override
String toString() {
  return 'Offer(offerTitle: $offerTitle, offerDescription: $offerDescription, offerValidUntil: $offerValidUntil, offerPrice: $offerPrice, offerConditions: $offerConditions, offerImage: $offerImage, name: $name, description: $description, image: $image)';
}


}

/// @nodoc
abstract mixin class _$OfferCopyWith<$Res> implements $OfferCopyWith<$Res> {
  factory _$OfferCopyWith(_Offer value, $Res Function(_Offer) _then) = __$OfferCopyWithImpl;
@override @useResult
$Res call({
 String offerTitle, String offerDescription,@TimestampDateTimeConverter() DateTime offerValidUntil, double? offerPrice, String? offerConditions, String? offerImage, String name, String description, String image
});




}
/// @nodoc
class __$OfferCopyWithImpl<$Res>
    implements _$OfferCopyWith<$Res> {
  __$OfferCopyWithImpl(this._self, this._then);

  final _Offer _self;
  final $Res Function(_Offer) _then;

/// Create a copy of Offer
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? offerTitle = null,Object? offerDescription = null,Object? offerValidUntil = null,Object? offerPrice = freezed,Object? offerConditions = freezed,Object? offerImage = freezed,Object? name = null,Object? description = null,Object? image = null,}) {
  return _then(_Offer(
offerTitle: null == offerTitle ? _self.offerTitle : offerTitle // ignore: cast_nullable_to_non_nullable
as String,offerDescription: null == offerDescription ? _self.offerDescription : offerDescription // ignore: cast_nullable_to_non_nullable
as String,offerValidUntil: null == offerValidUntil ? _self.offerValidUntil : offerValidUntil // ignore: cast_nullable_to_non_nullable
as DateTime,offerPrice: freezed == offerPrice ? _self.offerPrice : offerPrice // ignore: cast_nullable_to_non_nullable
as double?,offerConditions: freezed == offerConditions ? _self.offerConditions : offerConditions // ignore: cast_nullable_to_non_nullable
as String?,offerImage: freezed == offerImage ? _self.offerImage : offerImage // ignore: cast_nullable_to_non_nullable
as String?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,image: null == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
