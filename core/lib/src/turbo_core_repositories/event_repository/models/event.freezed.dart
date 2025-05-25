// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Event {

 String get id; String get title; String get description; DateTime get date; String get location; String get imageUrl; EventType get type; String? get placeId; double? get price; bool get isHighlighted; List<String> get tags; String? get organizerName; String? get organizerContact; DateTime? get endDate; String? get link;
/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EventCopyWith<Event> get copyWith => _$EventCopyWithImpl<Event>(this as Event, _$identity);

  /// Serializes this Event to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.location, location) || other.location == location)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.price, price) || other.price == price)&&(identical(other.isHighlighted, isHighlighted) || other.isHighlighted == isHighlighted)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.organizerContact, organizerContact) || other.organizerContact == organizerContact)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,date,location,imageUrl,type,placeId,price,isHighlighted,const DeepCollectionEquality().hash(tags),organizerName,organizerContact,endDate,link);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, date: $date, location: $location, imageUrl: $imageUrl, type: $type, placeId: $placeId, price: $price, isHighlighted: $isHighlighted, tags: $tags, organizerName: $organizerName, organizerContact: $organizerContact, endDate: $endDate, link: $link)';
}


}

/// @nodoc
abstract mixin class $EventCopyWith<$Res>  {
  factory $EventCopyWith(Event value, $Res Function(Event) _then) = _$EventCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, DateTime date, String location, String imageUrl, EventType type, String? placeId, double? price, bool isHighlighted, List<String> tags, String? organizerName, String? organizerContact, DateTime? endDate, String? link
});




}
/// @nodoc
class _$EventCopyWithImpl<$Res>
    implements $EventCopyWith<$Res> {
  _$EventCopyWithImpl(this._self, this._then);

  final Event _self;
  final $Res Function(Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? date = null,Object? location = null,Object? imageUrl = null,Object? type = null,Object? placeId = freezed,Object? price = freezed,Object? isHighlighted = null,Object? tags = null,Object? organizerName = freezed,Object? organizerContact = freezed,Object? endDate = freezed,Object? link = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isHighlighted: null == isHighlighted ? _self.isHighlighted : isHighlighted // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,organizerName: freezed == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String?,organizerContact: freezed == organizerContact ? _self.organizerContact : organizerContact // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _Event implements Event {
  const _Event({required this.id, required this.title, required this.description, required this.date, required this.location, required this.imageUrl, required this.type, this.placeId, this.price, this.isHighlighted = false, final  List<String> tags = const [], this.organizerName, this.organizerContact, this.endDate, this.link}): _tags = tags;
  factory _Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  DateTime date;
@override final  String location;
@override final  String imageUrl;
@override final  EventType type;
@override final  String? placeId;
@override final  double? price;
@override@JsonKey() final  bool isHighlighted;
 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override final  String? organizerName;
@override final  String? organizerContact;
@override final  DateTime? endDate;
@override final  String? link;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EventCopyWith<_Event> get copyWith => __$EventCopyWithImpl<_Event>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EventToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Event&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.date, date) || other.date == date)&&(identical(other.location, location) || other.location == location)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.type, type) || other.type == type)&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.price, price) || other.price == price)&&(identical(other.isHighlighted, isHighlighted) || other.isHighlighted == isHighlighted)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.organizerName, organizerName) || other.organizerName == organizerName)&&(identical(other.organizerContact, organizerContact) || other.organizerContact == organizerContact)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.link, link) || other.link == link));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,date,location,imageUrl,type,placeId,price,isHighlighted,const DeepCollectionEquality().hash(_tags),organizerName,organizerContact,endDate,link);

@override
String toString() {
  return 'Event(id: $id, title: $title, description: $description, date: $date, location: $location, imageUrl: $imageUrl, type: $type, placeId: $placeId, price: $price, isHighlighted: $isHighlighted, tags: $tags, organizerName: $organizerName, organizerContact: $organizerContact, endDate: $endDate, link: $link)';
}


}

/// @nodoc
abstract mixin class _$EventCopyWith<$Res> implements $EventCopyWith<$Res> {
  factory _$EventCopyWith(_Event value, $Res Function(_Event) _then) = __$EventCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, DateTime date, String location, String imageUrl, EventType type, String? placeId, double? price, bool isHighlighted, List<String> tags, String? organizerName, String? organizerContact, DateTime? endDate, String? link
});




}
/// @nodoc
class __$EventCopyWithImpl<$Res>
    implements _$EventCopyWith<$Res> {
  __$EventCopyWithImpl(this._self, this._then);

  final _Event _self;
  final $Res Function(_Event) _then;

/// Create a copy of Event
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? date = null,Object? location = null,Object? imageUrl = null,Object? type = null,Object? placeId = freezed,Object? price = freezed,Object? isHighlighted = null,Object? tags = null,Object? organizerName = freezed,Object? organizerContact = freezed,Object? endDate = freezed,Object? link = freezed,}) {
  return _then(_Event(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as EventType,placeId: freezed == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String?,price: freezed == price ? _self.price : price // ignore: cast_nullable_to_non_nullable
as double?,isHighlighted: null == isHighlighted ? _self.isHighlighted : isHighlighted // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,organizerName: freezed == organizerName ? _self.organizerName : organizerName // ignore: cast_nullable_to_non_nullable
as String?,organizerContact: freezed == organizerContact ? _self.organizerContact : organizerContact // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,link: freezed == link ? _self.link : link // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
