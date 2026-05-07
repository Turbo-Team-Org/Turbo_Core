// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'review.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Review {

 String get id; String get userId; String get userName; String get userAvatar; String get comment; double get rating;@TimestampDateTimeConverter() DateTime get date;@TimestampDateTimeConverter() DateTime? get createdAt; List<String> get imageUrls; ReviewStatus get status; String? get moderationNote;@TimestampDateTimeConverter() DateTime? get moderatedAt; String? get moderatedBy;
/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewCopyWith<Review> get copyWith => _$ReviewCopyWithImpl<Review>(this as Review, _$identity);

  /// Serializes this Review to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Review&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other.imageUrls, imageUrls)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationNote, moderationNote) || other.moderationNote == moderationNote)&&(identical(other.moderatedAt, moderatedAt) || other.moderatedAt == moderatedAt)&&(identical(other.moderatedBy, moderatedBy) || other.moderatedBy == moderatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,userAvatar,comment,rating,date,createdAt,const DeepCollectionEquality().hash(imageUrls),status,moderationNote,moderatedAt,moderatedBy);

@override
String toString() {
  return 'Review(id: $id, userId: $userId, userName: $userName, userAvatar: $userAvatar, comment: $comment, rating: $rating, date: $date, createdAt: $createdAt, imageUrls: $imageUrls, status: $status, moderationNote: $moderationNote, moderatedAt: $moderatedAt, moderatedBy: $moderatedBy)';
}


}

/// @nodoc
abstract mixin class $ReviewCopyWith<$Res>  {
  factory $ReviewCopyWith(Review value, $Res Function(Review) _then) = _$ReviewCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String userName, String userAvatar, String comment, double rating,@TimestampDateTimeConverter() DateTime date,@TimestampDateTimeConverter() DateTime? createdAt, List<String> imageUrls, ReviewStatus status, String? moderationNote,@TimestampDateTimeConverter() DateTime? moderatedAt, String? moderatedBy
});




}
/// @nodoc
class _$ReviewCopyWithImpl<$Res>
    implements $ReviewCopyWith<$Res> {
  _$ReviewCopyWithImpl(this._self, this._then);

  final Review _self;
  final $Res Function(Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? userAvatar = null,Object? comment = null,Object? rating = null,Object? date = null,Object? createdAt = freezed,Object? imageUrls = null,Object? status = null,Object? moderationNote = freezed,Object? moderatedAt = freezed,Object? moderatedBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: null == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,imageUrls: null == imageUrls ? _self.imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,moderationNote: freezed == moderationNote ? _self.moderationNote : moderationNote // ignore: cast_nullable_to_non_nullable
as String?,moderatedAt: freezed == moderatedAt ? _self.moderatedAt : moderatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,moderatedBy: freezed == moderatedBy ? _self.moderatedBy : moderatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Review].
extension ReviewPatterns on Review {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Review value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Review value)  $default,){
final _that = this;
switch (_that) {
case _Review():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Review value)?  $default,){
final _that = this;
switch (_that) {
case _Review() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  String userAvatar,  String comment,  double rating, @TimestampDateTimeConverter()  DateTime date, @TimestampDateTimeConverter()  DateTime? createdAt,  List<String> imageUrls,  ReviewStatus status,  String? moderationNote, @TimestampDateTimeConverter()  DateTime? moderatedAt,  String? moderatedBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.userAvatar,_that.comment,_that.rating,_that.date,_that.createdAt,_that.imageUrls,_that.status,_that.moderationNote,_that.moderatedAt,_that.moderatedBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String userName,  String userAvatar,  String comment,  double rating, @TimestampDateTimeConverter()  DateTime date, @TimestampDateTimeConverter()  DateTime? createdAt,  List<String> imageUrls,  ReviewStatus status,  String? moderationNote, @TimestampDateTimeConverter()  DateTime? moderatedAt,  String? moderatedBy)  $default,) {final _that = this;
switch (_that) {
case _Review():
return $default(_that.id,_that.userId,_that.userName,_that.userAvatar,_that.comment,_that.rating,_that.date,_that.createdAt,_that.imageUrls,_that.status,_that.moderationNote,_that.moderatedAt,_that.moderatedBy);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String userName,  String userAvatar,  String comment,  double rating, @TimestampDateTimeConverter()  DateTime date, @TimestampDateTimeConverter()  DateTime? createdAt,  List<String> imageUrls,  ReviewStatus status,  String? moderationNote, @TimestampDateTimeConverter()  DateTime? moderatedAt,  String? moderatedBy)?  $default,) {final _that = this;
switch (_that) {
case _Review() when $default != null:
return $default(_that.id,_that.userId,_that.userName,_that.userAvatar,_that.comment,_that.rating,_that.date,_that.createdAt,_that.imageUrls,_that.status,_that.moderationNote,_that.moderatedAt,_that.moderatedBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Review implements Review {
  const _Review({required this.id, required this.userId, required this.userName, required this.userAvatar, required this.comment, required this.rating, @TimestampDateTimeConverter() required this.date, @TimestampDateTimeConverter() this.createdAt, final  List<String> imageUrls = const [], this.status = ReviewStatus.pending, this.moderationNote, @TimestampDateTimeConverter() this.moderatedAt, this.moderatedBy}): _imageUrls = imageUrls;
  factory _Review.fromJson(Map<String, dynamic> json) => _$ReviewFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String userName;
@override final  String userAvatar;
@override final  String comment;
@override final  double rating;
@override@TimestampDateTimeConverter() final  DateTime date;
@override@TimestampDateTimeConverter() final  DateTime? createdAt;
 final  List<String> _imageUrls;
@override@JsonKey() List<String> get imageUrls {
  if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_imageUrls);
}

@override@JsonKey() final  ReviewStatus status;
@override final  String? moderationNote;
@override@TimestampDateTimeConverter() final  DateTime? moderatedAt;
@override final  String? moderatedBy;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewCopyWith<_Review> get copyWith => __$ReviewCopyWithImpl<_Review>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Review&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.userName, userName) || other.userName == userName)&&(identical(other.userAvatar, userAvatar) || other.userAvatar == userAvatar)&&(identical(other.comment, comment) || other.comment == comment)&&(identical(other.rating, rating) || other.rating == rating)&&(identical(other.date, date) || other.date == date)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&const DeepCollectionEquality().equals(other._imageUrls, _imageUrls)&&(identical(other.status, status) || other.status == status)&&(identical(other.moderationNote, moderationNote) || other.moderationNote == moderationNote)&&(identical(other.moderatedAt, moderatedAt) || other.moderatedAt == moderatedAt)&&(identical(other.moderatedBy, moderatedBy) || other.moderatedBy == moderatedBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,userName,userAvatar,comment,rating,date,createdAt,const DeepCollectionEquality().hash(_imageUrls),status,moderationNote,moderatedAt,moderatedBy);

@override
String toString() {
  return 'Review(id: $id, userId: $userId, userName: $userName, userAvatar: $userAvatar, comment: $comment, rating: $rating, date: $date, createdAt: $createdAt, imageUrls: $imageUrls, status: $status, moderationNote: $moderationNote, moderatedAt: $moderatedAt, moderatedBy: $moderatedBy)';
}


}

/// @nodoc
abstract mixin class _$ReviewCopyWith<$Res> implements $ReviewCopyWith<$Res> {
  factory _$ReviewCopyWith(_Review value, $Res Function(_Review) _then) = __$ReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String userName, String userAvatar, String comment, double rating,@TimestampDateTimeConverter() DateTime date,@TimestampDateTimeConverter() DateTime? createdAt, List<String> imageUrls, ReviewStatus status, String? moderationNote,@TimestampDateTimeConverter() DateTime? moderatedAt, String? moderatedBy
});




}
/// @nodoc
class __$ReviewCopyWithImpl<$Res>
    implements _$ReviewCopyWith<$Res> {
  __$ReviewCopyWithImpl(this._self, this._then);

  final _Review _self;
  final $Res Function(_Review) _then;

/// Create a copy of Review
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? userName = null,Object? userAvatar = null,Object? comment = null,Object? rating = null,Object? date = null,Object? createdAt = freezed,Object? imageUrls = null,Object? status = null,Object? moderationNote = freezed,Object? moderatedAt = freezed,Object? moderatedBy = freezed,}) {
  return _then(_Review(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,userName: null == userName ? _self.userName : userName // ignore: cast_nullable_to_non_nullable
as String,userAvatar: null == userAvatar ? _self.userAvatar : userAvatar // ignore: cast_nullable_to_non_nullable
as String,comment: null == comment ? _self.comment : comment // ignore: cast_nullable_to_non_nullable
as String,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as double,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,imageUrls: null == imageUrls ? _self._imageUrls : imageUrls // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,moderationNote: freezed == moderationNote ? _self.moderationNote : moderationNote // ignore: cast_nullable_to_non_nullable
as String?,moderatedAt: freezed == moderatedAt ? _self.moderatedAt : moderatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,moderatedBy: freezed == moderatedBy ? _self.moderatedBy : moderatedBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
