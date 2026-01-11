// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
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

 String get placeId; String get categoryId; DateTime get createdAt; String? get createdBy; Map<String, dynamic>? get metadata;
/// Create a copy of PlaceCategory
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PlaceCategoryCopyWith<PlaceCategory> get copyWith => _$PlaceCategoryCopyWithImpl<PlaceCategory>(this as PlaceCategory, _$identity);

  /// Serializes this PlaceCategory to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PlaceCategory&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,categoryId,createdAt,createdBy,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PlaceCategory(placeId: $placeId, categoryId: $categoryId, createdAt: $createdAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PlaceCategoryCopyWith<$Res>  {
  factory $PlaceCategoryCopyWith(PlaceCategory value, $Res Function(PlaceCategory) _then) = _$PlaceCategoryCopyWithImpl;
@useResult
$Res call({
 String placeId, String categoryId, DateTime createdAt, String? createdBy, Map<String, dynamic>? metadata
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
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? categoryId = null,Object? createdAt = null,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PlaceCategory].
extension PlaceCategoryPatterns on PlaceCategory {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PlaceCategory value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PlaceCategory() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PlaceCategory value)  $default,){
final _that = this;
switch (_that) {
case _PlaceCategory():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PlaceCategory value)?  $default,){
final _that = this;
switch (_that) {
case _PlaceCategory() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String placeId,  String categoryId,  DateTime createdAt,  String? createdBy,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PlaceCategory() when $default != null:
return $default(_that.placeId,_that.categoryId,_that.createdAt,_that.createdBy,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String placeId,  String categoryId,  DateTime createdAt,  String? createdBy,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _PlaceCategory():
return $default(_that.placeId,_that.categoryId,_that.createdAt,_that.createdBy,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String placeId,  String categoryId,  DateTime createdAt,  String? createdBy,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _PlaceCategory() when $default != null:
return $default(_that.placeId,_that.categoryId,_that.createdAt,_that.createdBy,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PlaceCategory extends PlaceCategory {
  const _PlaceCategory({required this.placeId, required this.categoryId, required this.createdAt, this.createdBy, final  Map<String, dynamic>? metadata}): _metadata = metadata,super._();
  factory _PlaceCategory.fromJson(Map<String, dynamic> json) => _$PlaceCategoryFromJson(json);

@override final  String placeId;
@override final  String categoryId;
@override final  DateTime createdAt;
@override final  String? createdBy;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PlaceCategory&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.categoryId, categoryId) || other.categoryId == categoryId)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.createdBy, createdBy) || other.createdBy == createdBy)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,categoryId,createdAt,createdBy,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'PlaceCategory(placeId: $placeId, categoryId: $categoryId, createdAt: $createdAt, createdBy: $createdBy, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PlaceCategoryCopyWith<$Res> implements $PlaceCategoryCopyWith<$Res> {
  factory _$PlaceCategoryCopyWith(_PlaceCategory value, $Res Function(_PlaceCategory) _then) = __$PlaceCategoryCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String categoryId, DateTime createdAt, String? createdBy, Map<String, dynamic>? metadata
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
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? categoryId = null,Object? createdAt = null,Object? createdBy = freezed,Object? metadata = freezed,}) {
  return _then(_PlaceCategory(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,categoryId: null == categoryId ? _self.categoryId : categoryId // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,createdBy: freezed == createdBy ? _self.createdBy : createdBy // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
