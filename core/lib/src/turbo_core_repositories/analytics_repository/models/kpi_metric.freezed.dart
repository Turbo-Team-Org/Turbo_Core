// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'kpi_metric.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$KpiMetric {

 String get id; String get title; String get description; double get value; String get unit; double get previousValue; MetricTrend get trend; String get icon; String get formattedValue; String get changeText; double get changePercentage; Map<String, dynamic>? get metadata;
/// Create a copy of KpiMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$KpiMetricCopyWith<KpiMetric> get copyWith => _$KpiMetricCopyWithImpl<KpiMetric>(this as KpiMetric, _$identity);

  /// Serializes this KpiMetric to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is KpiMetric&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.previousValue, previousValue) || other.previousValue == previousValue)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.formattedValue, formattedValue) || other.formattedValue == formattedValue)&&(identical(other.changeText, changeText) || other.changeText == changeText)&&(identical(other.changePercentage, changePercentage) || other.changePercentage == changePercentage)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,value,unit,previousValue,trend,icon,formattedValue,changeText,changePercentage,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'KpiMetric(id: $id, title: $title, description: $description, value: $value, unit: $unit, previousValue: $previousValue, trend: $trend, icon: $icon, formattedValue: $formattedValue, changeText: $changeText, changePercentage: $changePercentage, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $KpiMetricCopyWith<$Res>  {
  factory $KpiMetricCopyWith(KpiMetric value, $Res Function(KpiMetric) _then) = _$KpiMetricCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, double value, String unit, double previousValue, MetricTrend trend, String icon, String formattedValue, String changeText, double changePercentage, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$KpiMetricCopyWithImpl<$Res>
    implements $KpiMetricCopyWith<$Res> {
  _$KpiMetricCopyWithImpl(this._self, this._then);

  final KpiMetric _self;
  final $Res Function(KpiMetric) _then;

/// Create a copy of KpiMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? value = null,Object? unit = null,Object? previousValue = null,Object? trend = null,Object? icon = null,Object? formattedValue = null,Object? changeText = null,Object? changePercentage = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,previousValue: null == previousValue ? _self.previousValue : previousValue // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as MetricTrend,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,formattedValue: null == formattedValue ? _self.formattedValue : formattedValue // ignore: cast_nullable_to_non_nullable
as String,changeText: null == changeText ? _self.changeText : changeText // ignore: cast_nullable_to_non_nullable
as String,changePercentage: null == changePercentage ? _self.changePercentage : changePercentage // ignore: cast_nullable_to_non_nullable
as double,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [KpiMetric].
extension KpiMetricPatterns on KpiMetric {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _KpiMetric value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _KpiMetric() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _KpiMetric value)  $default,){
final _that = this;
switch (_that) {
case _KpiMetric():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _KpiMetric value)?  $default,){
final _that = this;
switch (_that) {
case _KpiMetric() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  double value,  String unit,  double previousValue,  MetricTrend trend,  String icon,  String formattedValue,  String changeText,  double changePercentage,  Map<String, dynamic>? metadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _KpiMetric() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.value,_that.unit,_that.previousValue,_that.trend,_that.icon,_that.formattedValue,_that.changeText,_that.changePercentage,_that.metadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  double value,  String unit,  double previousValue,  MetricTrend trend,  String icon,  String formattedValue,  String changeText,  double changePercentage,  Map<String, dynamic>? metadata)  $default,) {final _that = this;
switch (_that) {
case _KpiMetric():
return $default(_that.id,_that.title,_that.description,_that.value,_that.unit,_that.previousValue,_that.trend,_that.icon,_that.formattedValue,_that.changeText,_that.changePercentage,_that.metadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  double value,  String unit,  double previousValue,  MetricTrend trend,  String icon,  String formattedValue,  String changeText,  double changePercentage,  Map<String, dynamic>? metadata)?  $default,) {final _that = this;
switch (_that) {
case _KpiMetric() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.value,_that.unit,_that.previousValue,_that.trend,_that.icon,_that.formattedValue,_that.changeText,_that.changePercentage,_that.metadata);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _KpiMetric implements KpiMetric {
  const _KpiMetric({required this.id, required this.title, required this.description, required this.value, required this.unit, required this.previousValue, required this.trend, required this.icon, this.formattedValue = '', this.changeText = '', this.changePercentage = 0.0, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _KpiMetric.fromJson(Map<String, dynamic> json) => _$KpiMetricFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  double value;
@override final  String unit;
@override final  double previousValue;
@override final  MetricTrend trend;
@override final  String icon;
@override@JsonKey() final  String formattedValue;
@override@JsonKey() final  String changeText;
@override@JsonKey() final  double changePercentage;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of KpiMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$KpiMetricCopyWith<_KpiMetric> get copyWith => __$KpiMetricCopyWithImpl<_KpiMetric>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$KpiMetricToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _KpiMetric&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.value, value) || other.value == value)&&(identical(other.unit, unit) || other.unit == unit)&&(identical(other.previousValue, previousValue) || other.previousValue == previousValue)&&(identical(other.trend, trend) || other.trend == trend)&&(identical(other.icon, icon) || other.icon == icon)&&(identical(other.formattedValue, formattedValue) || other.formattedValue == formattedValue)&&(identical(other.changeText, changeText) || other.changeText == changeText)&&(identical(other.changePercentage, changePercentage) || other.changePercentage == changePercentage)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,value,unit,previousValue,trend,icon,formattedValue,changeText,changePercentage,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'KpiMetric(id: $id, title: $title, description: $description, value: $value, unit: $unit, previousValue: $previousValue, trend: $trend, icon: $icon, formattedValue: $formattedValue, changeText: $changeText, changePercentage: $changePercentage, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$KpiMetricCopyWith<$Res> implements $KpiMetricCopyWith<$Res> {
  factory _$KpiMetricCopyWith(_KpiMetric value, $Res Function(_KpiMetric) _then) = __$KpiMetricCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, double value, String unit, double previousValue, MetricTrend trend, String icon, String formattedValue, String changeText, double changePercentage, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$KpiMetricCopyWithImpl<$Res>
    implements _$KpiMetricCopyWith<$Res> {
  __$KpiMetricCopyWithImpl(this._self, this._then);

  final _KpiMetric _self;
  final $Res Function(_KpiMetric) _then;

/// Create a copy of KpiMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? value = null,Object? unit = null,Object? previousValue = null,Object? trend = null,Object? icon = null,Object? formattedValue = null,Object? changeText = null,Object? changePercentage = null,Object? metadata = freezed,}) {
  return _then(_KpiMetric(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,value: null == value ? _self.value : value // ignore: cast_nullable_to_non_nullable
as double,unit: null == unit ? _self.unit : unit // ignore: cast_nullable_to_non_nullable
as String,previousValue: null == previousValue ? _self.previousValue : previousValue // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as MetricTrend,icon: null == icon ? _self.icon : icon // ignore: cast_nullable_to_non_nullable
as String,formattedValue: null == formattedValue ? _self.formattedValue : formattedValue // ignore: cast_nullable_to_non_nullable
as String,changeText: null == changeText ? _self.changeText : changeText // ignore: cast_nullable_to_non_nullable
as String,changePercentage: null == changePercentage ? _self.changePercentage : changePercentage // ignore: cast_nullable_to_non_nullable
as double,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
