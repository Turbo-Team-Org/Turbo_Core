// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'place_category.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PlaceCategory {

 String get placeId; String get categoryId; DateTime get createdAt;
/// Create a copy of PlaceCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCategoryCopyWith<PlaceCategory> get copyWith => _$PlaceCategoryCopyWithImpl<PlaceCategory>(this as PlaceCategory, _$identity);

  /// Serializes this PlaceCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceCategory&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,categoryId,createdAt);

@override
String toString() {
  return 'PlaceCategory(placeId: $placeId, categoryId: $categoryId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $PlaceCategoryCopyWith<$Res>  {
  factory $PlaceCategoryCopyWith(PlaceCategory value, $Res Function(PlaceCategory) _then) = _$PlaceCategoryCopyWithImpl;
@useResult
$Res call({
 String placeId, String categoryId, DateTime createdAt
});




}
/// @nodoc
class _$PlaceCategoryCopyWithImpl<$Res>
    implements $PlaceCategoryCopyWith<$Res> {
  _$PlaceCategoryCopyWithImpl(this._self, this._then);

  final PlaceCategory _self;
  final $Res Function(PlaceCategory) _then;

/// Create a copy of PlaceCategory
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? categoryId = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PlaceCategory implements PlaceCategory {
  const _PlaceCategory({required this.placeId, required this.categoryId, required this.createdAt});
  factory _PlaceCategory.fromJson(Map<String, dynamic> json) => _$PlaceCategoryFromJson(json);

@override final  String placeId;
@override final  String categoryId;
@override final  DateTime createdAt;

/// Create a copy of PlaceCategory
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PlaceCategoryCopyWith<_PlaceCategory> get copyWith => __$PlaceCategoryCopyWithImpl<_PlaceCategory>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PlaceCategoryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceCategory&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,categoryId,createdAt);

@override
String toString() {
  return 'PlaceCategory(placeId: $placeId, categoryId: $categoryId, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$PlaceCategoryCopyWith<$Res> implements $PlaceCategoryCopyWith<$Res> {
  factory _$PlaceCategoryCopyWith(_PlaceCategory value, $Res Function(_PlaceCategory) _then) = __$PlaceCategoryCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String categoryId, DateTime createdAt
});




}
/// @nodoc
class __$PlaceCategoryCopyWithImpl<$Res>
    implements _$PlaceCategoryCopyWith<$Res> {
  __$PlaceCategoryCopyWithImpl(this._self, this._then);

  final _PlaceCategory _self;
  final $Res Function(_PlaceCategory) _then;

/// Create a copy of PlaceCategory
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? categoryId = null,Object? createdAt = null,}) {
  return _then(_PlaceCategory(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,
  ));
}


}

// dart format on
