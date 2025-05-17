// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'offer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Offer _$OfferFromJson(Map<String, dynamic> json) {
  return _Offer.fromJson(json);
}

/// @nodoc
mixin _$Offer {
  String get offerTitle => throw _privateConstructorUsedError;
  String get offerDescription => throw _privateConstructorUsedError;
  @TimestampDateTimeConverter()
  DateTime get offerValidUntil => throw _privateConstructorUsedError;
  double? get offerPrice => throw _privateConstructorUsedError;
  String? get offerConditions => throw _privateConstructorUsedError;
  String? get offerImage => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get image => throw _privateConstructorUsedError;

  /// Serializes this Offer to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $OfferCopyWith<Offer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OfferCopyWith<$Res> {
  factory $OfferCopyWith(Offer value, $Res Function(Offer) then) =
      _$OfferCopyWithImpl<$Res, Offer>;
  @useResult
  $Res call(
      {String offerTitle,
      String offerDescription,
      @TimestampDateTimeConverter() DateTime offerValidUntil,
      double? offerPrice,
      String? offerConditions,
      String? offerImage,
      String name,
      String description,
      String image});
}

/// @nodoc
class _$OfferCopyWithImpl<$Res, $Val extends Offer>
    implements $OfferCopyWith<$Res> {
  _$OfferCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerTitle = null,
    Object? offerDescription = null,
    Object? offerValidUntil = null,
    Object? offerPrice = freezed,
    Object? offerConditions = freezed,
    Object? offerImage = freezed,
    Object? name = null,
    Object? description = null,
    Object? image = null,
  }) {
    return _then(_value.copyWith(
      offerTitle: null == offerTitle
          ? _value.offerTitle
          : offerTitle // ignore: cast_nullable_to_non_nullable
              as String,
      offerDescription: null == offerDescription
          ? _value.offerDescription
          : offerDescription // ignore: cast_nullable_to_non_nullable
              as String,
      offerValidUntil: null == offerValidUntil
          ? _value.offerValidUntil
          : offerValidUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
      offerPrice: freezed == offerPrice
          ? _value.offerPrice
          : offerPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      offerConditions: freezed == offerConditions
          ? _value.offerConditions
          : offerConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      offerImage: freezed == offerImage
          ? _value.offerImage
          : offerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OfferImplCopyWith<$Res> implements $OfferCopyWith<$Res> {
  factory _$$OfferImplCopyWith(
          _$OfferImpl value, $Res Function(_$OfferImpl) then) =
      __$$OfferImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String offerTitle,
      String offerDescription,
      @TimestampDateTimeConverter() DateTime offerValidUntil,
      double? offerPrice,
      String? offerConditions,
      String? offerImage,
      String name,
      String description,
      String image});
}

/// @nodoc
class __$$OfferImplCopyWithImpl<$Res>
    extends _$OfferCopyWithImpl<$Res, _$OfferImpl>
    implements _$$OfferImplCopyWith<$Res> {
  __$$OfferImplCopyWithImpl(
      _$OfferImpl _value, $Res Function(_$OfferImpl) _then)
      : super(_value, _then);

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? offerTitle = null,
    Object? offerDescription = null,
    Object? offerValidUntil = null,
    Object? offerPrice = freezed,
    Object? offerConditions = freezed,
    Object? offerImage = freezed,
    Object? name = null,
    Object? description = null,
    Object? image = null,
  }) {
    return _then(_$OfferImpl(
      offerTitle: null == offerTitle
          ? _value.offerTitle
          : offerTitle // ignore: cast_nullable_to_non_nullable
              as String,
      offerDescription: null == offerDescription
          ? _value.offerDescription
          : offerDescription // ignore: cast_nullable_to_non_nullable
              as String,
      offerValidUntil: null == offerValidUntil
          ? _value.offerValidUntil
          : offerValidUntil // ignore: cast_nullable_to_non_nullable
              as DateTime,
      offerPrice: freezed == offerPrice
          ? _value.offerPrice
          : offerPrice // ignore: cast_nullable_to_non_nullable
              as double?,
      offerConditions: freezed == offerConditions
          ? _value.offerConditions
          : offerConditions // ignore: cast_nullable_to_non_nullable
              as String?,
      offerImage: freezed == offerImage
          ? _value.offerImage
          : offerImage // ignore: cast_nullable_to_non_nullable
              as String?,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      image: null == image
          ? _value.image
          : image // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OfferImpl implements _Offer {
  const _$OfferImpl(
      {required this.offerTitle,
      required this.offerDescription,
      @TimestampDateTimeConverter() required this.offerValidUntil,
      this.offerPrice,
      this.offerConditions,
      this.offerImage,
      this.name = '',
      this.description = '',
      this.image = ''});

  factory _$OfferImpl.fromJson(Map<String, dynamic> json) =>
      _$$OfferImplFromJson(json);

  @override
  final String offerTitle;
  @override
  final String offerDescription;
  @override
  @TimestampDateTimeConverter()
  final DateTime offerValidUntil;
  @override
  final double? offerPrice;
  @override
  final String? offerConditions;
  @override
  final String? offerImage;
  @override
  @JsonKey()
  final String name;
  @override
  @JsonKey()
  final String description;
  @override
  @JsonKey()
  final String image;

  @override
  String toString() {
    return 'Offer(offerTitle: $offerTitle, offerDescription: $offerDescription, offerValidUntil: $offerValidUntil, offerPrice: $offerPrice, offerConditions: $offerConditions, offerImage: $offerImage, name: $name, description: $description, image: $image)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OfferImpl &&
            (identical(other.offerTitle, offerTitle) ||
                other.offerTitle == offerTitle) &&
            (identical(other.offerDescription, offerDescription) ||
                other.offerDescription == offerDescription) &&
            (identical(other.offerValidUntil, offerValidUntil) ||
                other.offerValidUntil == offerValidUntil) &&
            (identical(other.offerPrice, offerPrice) ||
                other.offerPrice == offerPrice) &&
            (identical(other.offerConditions, offerConditions) ||
                other.offerConditions == offerConditions) &&
            (identical(other.offerImage, offerImage) ||
                other.offerImage == offerImage) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.image, image) || other.image == image));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      offerTitle,
      offerDescription,
      offerValidUntil,
      offerPrice,
      offerConditions,
      offerImage,
      name,
      description,
      image);

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$OfferImplCopyWith<_$OfferImpl> get copyWith =>
      __$$OfferImplCopyWithImpl<_$OfferImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OfferImplToJson(
      this,
    );
  }
}

abstract class _Offer implements Offer {
  const factory _Offer(
      {required final String offerTitle,
      required final String offerDescription,
      @TimestampDateTimeConverter() required final DateTime offerValidUntil,
      final double? offerPrice,
      final String? offerConditions,
      final String? offerImage,
      final String name,
      final String description,
      final String image}) = _$OfferImpl;

  factory _Offer.fromJson(Map<String, dynamic> json) = _$OfferImpl.fromJson;

  @override
  String get offerTitle;
  @override
  String get offerDescription;
  @override
  @TimestampDateTimeConverter()
  DateTime get offerValidUntil;
  @override
  double? get offerPrice;
  @override
  String? get offerConditions;
  @override
  String? get offerImage;
  @override
  String get name;
  @override
  String get description;
  @override
  String get image;

  /// Create a copy of Offer
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$OfferImplCopyWith<_$OfferImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
