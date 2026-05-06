// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_chat_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiChatResponse {

 String get id; String get model; String get content; Map<String, dynamic> get metadata;
/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiChatResponseCopyWith<AiChatResponse> get copyWith => _$AiChatResponseCopyWithImpl<AiChatResponse>(this as AiChatResponse, _$identity);

  /// Serializes this AiChatResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiChatResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.model, model) || other.model == model)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,model,content,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'AiChatResponse(id: $id, model: $model, content: $content, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $AiChatResponseCopyWith<$Res>  {
  factory $AiChatResponseCopyWith(AiChatResponse value, $Res Function(AiChatResponse) _then) = _$AiChatResponseCopyWithImpl;
@useResult
$Res call({
 String id, String model, String content, Map<String, dynamic> metadata
});




}
/// @nodoc
class _$AiChatResponseCopyWithImpl<$Res>
    implements $AiChatResponseCopyWith<$Res> {
  _$AiChatResponseCopyWithImpl(this._self, this._then);

  final AiChatResponse _self;
  final $Res Function(AiChatResponse) _then;

/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? model = null,Object? content = null,Object? metadata = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [AiChatResponse].
extension AiChatResponsePatterns on AiChatResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiChatResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiChatResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiChatResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiChatResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String model,  String content,  Map<String, dynamic> metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
return $default(_that.id,_that.model,_that.content,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String model,  String content,  Map<String, dynamic> metadata)  $default,) {final _that = this;
switch (_that) {
case _AiChatResponse():
return $default(_that.id,_that.model,_that.content,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String model,  String content,  Map<String, dynamic> metadata)?  $default,) {final _that = this;
switch (_that) {
case _AiChatResponse() when $default != null:
return $default(_that.id,_that.model,_that.content,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiChatResponse implements AiChatResponse {
  const _AiChatResponse({required this.id, required this.model, required this.content, final  Map<String, dynamic> metadata = const {}}): _metadata = metadata;
  factory _AiChatResponse.fromJson(Map<String, dynamic> json) => _$AiChatResponseFromJson(json);

@override final  String id;
@override final  String model;
@override final  String content;
 final  Map<String, dynamic> _metadata;
@override@JsonKey() Map<String, dynamic> get metadata {
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_metadata);
}


/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiChatResponseCopyWith<_AiChatResponse> get copyWith => __$AiChatResponseCopyWithImpl<_AiChatResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiChatResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiChatResponse&&(identical(other.id, id) || other.id == id)&&(identical(other.model, model) || other.model == model)&&(identical(other.content, content) || other.content == content)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,model,content,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'AiChatResponse(id: $id, model: $model, content: $content, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$AiChatResponseCopyWith<$Res> implements $AiChatResponseCopyWith<$Res> {
  factory _$AiChatResponseCopyWith(_AiChatResponse value, $Res Function(_AiChatResponse) _then) = __$AiChatResponseCopyWithImpl;
@override @useResult
$Res call({
 String id, String model, String content, Map<String, dynamic> metadata
});




}
/// @nodoc
class __$AiChatResponseCopyWithImpl<$Res>
    implements _$AiChatResponseCopyWith<$Res> {
  __$AiChatResponseCopyWithImpl(this._self, this._then);

  final _AiChatResponse _self;
  final $Res Function(_AiChatResponse) _then;

/// Create a copy of AiChatResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? model = null,Object? content = null,Object? metadata = null,}) {
  return _then(_AiChatResponse(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,model: null == model ? _self.model : model // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,metadata: null == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
