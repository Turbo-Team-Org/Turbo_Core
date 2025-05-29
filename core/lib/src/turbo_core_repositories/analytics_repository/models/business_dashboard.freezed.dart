// dart format width=80
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'business_dashboard.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$BusinessDashboard {

 String get placeId; String get placeName; DateRange get dateRange; List<KpiMetric> get kpiMetrics; DashboardSummary get summary; List<HourlyData> get hourlyTraffic; List<DailyData> get dailyTraffic; ReviewInsights get reviewInsights; PopularContent get popularContent; List<ComparisonMetric> get comparisons; DateTime get lastUpdated; Map<String, dynamic>? get metadata;
/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$BusinessDashboardCopyWith<BusinessDashboard> get copyWith => _$BusinessDashboardCopyWithImpl<BusinessDashboard>(this as BusinessDashboard, _$identity);

  /// Serializes this BusinessDashboard to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is BusinessDashboard&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.dateRange, dateRange) || other.dateRange == dateRange)&&const DeepCollectionEquality().equals(other.kpiMetrics, kpiMetrics)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.hourlyTraffic, hourlyTraffic)&&const DeepCollectionEquality().equals(other.dailyTraffic, dailyTraffic)&&(identical(other.reviewInsights, reviewInsights) || other.reviewInsights == reviewInsights)&&(identical(other.popularContent, popularContent) || other.popularContent == popularContent)&&const DeepCollectionEquality().equals(other.comparisons, comparisons)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,placeName,dateRange,const DeepCollectionEquality().hash(kpiMetrics),summary,const DeepCollectionEquality().hash(hourlyTraffic),const DeepCollectionEquality().hash(dailyTraffic),reviewInsights,popularContent,const DeepCollectionEquality().hash(comparisons),lastUpdated,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'BusinessDashboard(placeId: $placeId, placeName: $placeName, dateRange: $dateRange, kpiMetrics: $kpiMetrics, summary: $summary, hourlyTraffic: $hourlyTraffic, dailyTraffic: $dailyTraffic, reviewInsights: $reviewInsights, popularContent: $popularContent, comparisons: $comparisons, lastUpdated: $lastUpdated, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $BusinessDashboardCopyWith<$Res>  {
  factory $BusinessDashboardCopyWith(BusinessDashboard value, $Res Function(BusinessDashboard) _then) = _$BusinessDashboardCopyWithImpl;
@useResult
$Res call({
 String placeId, String placeName, DateRange dateRange, List<KpiMetric> kpiMetrics, DashboardSummary summary, List<HourlyData> hourlyTraffic, List<DailyData> dailyTraffic, ReviewInsights reviewInsights, PopularContent popularContent, List<ComparisonMetric> comparisons, DateTime lastUpdated, Map<String, dynamic>? metadata
});


$DateRangeCopyWith<$Res> get dateRange;$DashboardSummaryCopyWith<$Res> get summary;$ReviewInsightsCopyWith<$Res> get reviewInsights;$PopularContentCopyWith<$Res> get popularContent;

}
/// @nodoc
class _$BusinessDashboardCopyWithImpl<$Res>
    implements $BusinessDashboardCopyWith<$Res> {
  _$BusinessDashboardCopyWithImpl(this._self, this._then);

  final BusinessDashboard _self;
  final $Res Function(BusinessDashboard) _then;

/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? placeId = null,Object? placeName = null,Object? dateRange = null,Object? kpiMetrics = null,Object? summary = null,Object? hourlyTraffic = null,Object? dailyTraffic = null,Object? reviewInsights = null,Object? popularContent = null,Object? comparisons = null,Object? lastUpdated = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,dateRange: null == dateRange ? _self.dateRange : dateRange // ignore: cast_nullable_to_non_nullable
as DateRange,kpiMetrics: null == kpiMetrics ? _self.kpiMetrics : kpiMetrics // ignore: cast_nullable_to_non_nullable
as List<KpiMetric>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as DashboardSummary,hourlyTraffic: null == hourlyTraffic ? _self.hourlyTraffic : hourlyTraffic // ignore: cast_nullable_to_non_nullable
as List<HourlyData>,dailyTraffic: null == dailyTraffic ? _self.dailyTraffic : dailyTraffic // ignore: cast_nullable_to_non_nullable
as List<DailyData>,reviewInsights: null == reviewInsights ? _self.reviewInsights : reviewInsights // ignore: cast_nullable_to_non_nullable
as ReviewInsights,popularContent: null == popularContent ? _self.popularContent : popularContent // ignore: cast_nullable_to_non_nullable
as PopularContent,comparisons: null == comparisons ? _self.comparisons : comparisons // ignore: cast_nullable_to_non_nullable
as List<ComparisonMetric>,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}
/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateRangeCopyWith<$Res> get dateRange {
  
  return $DateRangeCopyWith<$Res>(_self.dateRange, (value) {
    return _then(_self.copyWith(dateRange: value));
  });
}/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<$Res> get summary {
  
  return $DashboardSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInsightsCopyWith<$Res> get reviewInsights {
  
  return $ReviewInsightsCopyWith<$Res>(_self.reviewInsights, (value) {
    return _then(_self.copyWith(reviewInsights: value));
  });
}/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PopularContentCopyWith<$Res> get popularContent {
  
  return $PopularContentCopyWith<$Res>(_self.popularContent, (value) {
    return _then(_self.copyWith(popularContent: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _BusinessDashboard implements BusinessDashboard {
  const _BusinessDashboard({required this.placeId, required this.placeName, required this.dateRange, required final  List<KpiMetric> kpiMetrics, required this.summary, required final  List<HourlyData> hourlyTraffic, required final  List<DailyData> dailyTraffic, required this.reviewInsights, required this.popularContent, final  List<ComparisonMetric> comparisons = const [], required this.lastUpdated, final  Map<String, dynamic>? metadata}): _kpiMetrics = kpiMetrics,_hourlyTraffic = hourlyTraffic,_dailyTraffic = dailyTraffic,_comparisons = comparisons,_metadata = metadata;
  factory _BusinessDashboard.fromJson(Map<String, dynamic> json) => _$BusinessDashboardFromJson(json);

@override final  String placeId;
@override final  String placeName;
@override final  DateRange dateRange;
 final  List<KpiMetric> _kpiMetrics;
@override List<KpiMetric> get kpiMetrics {
  if (_kpiMetrics is EqualUnmodifiableListView) return _kpiMetrics;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_kpiMetrics);
}

@override final  DashboardSummary summary;
 final  List<HourlyData> _hourlyTraffic;
@override List<HourlyData> get hourlyTraffic {
  if (_hourlyTraffic is EqualUnmodifiableListView) return _hourlyTraffic;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_hourlyTraffic);
}

 final  List<DailyData> _dailyTraffic;
@override List<DailyData> get dailyTraffic {
  if (_dailyTraffic is EqualUnmodifiableListView) return _dailyTraffic;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_dailyTraffic);
}

@override final  ReviewInsights reviewInsights;
@override final  PopularContent popularContent;
 final  List<ComparisonMetric> _comparisons;
@override@JsonKey() List<ComparisonMetric> get comparisons {
  if (_comparisons is EqualUnmodifiableListView) return _comparisons;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_comparisons);
}

@override final  DateTime lastUpdated;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$BusinessDashboardCopyWith<_BusinessDashboard> get copyWith => __$BusinessDashboardCopyWithImpl<_BusinessDashboard>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$BusinessDashboardToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _BusinessDashboard&&(identical(other.placeId, placeId) || other.placeId == placeId)&&(identical(other.placeName, placeName) || other.placeName == placeName)&&(identical(other.dateRange, dateRange) || other.dateRange == dateRange)&&const DeepCollectionEquality().equals(other._kpiMetrics, _kpiMetrics)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._hourlyTraffic, _hourlyTraffic)&&const DeepCollectionEquality().equals(other._dailyTraffic, _dailyTraffic)&&(identical(other.reviewInsights, reviewInsights) || other.reviewInsights == reviewInsights)&&(identical(other.popularContent, popularContent) || other.popularContent == popularContent)&&const DeepCollectionEquality().equals(other._comparisons, _comparisons)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,placeId,placeName,dateRange,const DeepCollectionEquality().hash(_kpiMetrics),summary,const DeepCollectionEquality().hash(_hourlyTraffic),const DeepCollectionEquality().hash(_dailyTraffic),reviewInsights,popularContent,const DeepCollectionEquality().hash(_comparisons),lastUpdated,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'BusinessDashboard(placeId: $placeId, placeName: $placeName, dateRange: $dateRange, kpiMetrics: $kpiMetrics, summary: $summary, hourlyTraffic: $hourlyTraffic, dailyTraffic: $dailyTraffic, reviewInsights: $reviewInsights, popularContent: $popularContent, comparisons: $comparisons, lastUpdated: $lastUpdated, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$BusinessDashboardCopyWith<$Res> implements $BusinessDashboardCopyWith<$Res> {
  factory _$BusinessDashboardCopyWith(_BusinessDashboard value, $Res Function(_BusinessDashboard) _then) = __$BusinessDashboardCopyWithImpl;
@override @useResult
$Res call({
 String placeId, String placeName, DateRange dateRange, List<KpiMetric> kpiMetrics, DashboardSummary summary, List<HourlyData> hourlyTraffic, List<DailyData> dailyTraffic, ReviewInsights reviewInsights, PopularContent popularContent, List<ComparisonMetric> comparisons, DateTime lastUpdated, Map<String, dynamic>? metadata
});


@override $DateRangeCopyWith<$Res> get dateRange;@override $DashboardSummaryCopyWith<$Res> get summary;@override $ReviewInsightsCopyWith<$Res> get reviewInsights;@override $PopularContentCopyWith<$Res> get popularContent;

}
/// @nodoc
class __$BusinessDashboardCopyWithImpl<$Res>
    implements _$BusinessDashboardCopyWith<$Res> {
  __$BusinessDashboardCopyWithImpl(this._self, this._then);

  final _BusinessDashboard _self;
  final $Res Function(_BusinessDashboard) _then;

/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? placeId = null,Object? placeName = null,Object? dateRange = null,Object? kpiMetrics = null,Object? summary = null,Object? hourlyTraffic = null,Object? dailyTraffic = null,Object? reviewInsights = null,Object? popularContent = null,Object? comparisons = null,Object? lastUpdated = null,Object? metadata = freezed,}) {
  return _then(_BusinessDashboard(
placeId: null == placeId ? _self.placeId : placeId // ignore: cast_nullable_to_non_nullable
as String,placeName: null == placeName ? _self.placeName : placeName // ignore: cast_nullable_to_non_nullable
as String,dateRange: null == dateRange ? _self.dateRange : dateRange // ignore: cast_nullable_to_non_nullable
as DateRange,kpiMetrics: null == kpiMetrics ? _self._kpiMetrics : kpiMetrics // ignore: cast_nullable_to_non_nullable
as List<KpiMetric>,summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as DashboardSummary,hourlyTraffic: null == hourlyTraffic ? _self._hourlyTraffic : hourlyTraffic // ignore: cast_nullable_to_non_nullable
as List<HourlyData>,dailyTraffic: null == dailyTraffic ? _self._dailyTraffic : dailyTraffic // ignore: cast_nullable_to_non_nullable
as List<DailyData>,reviewInsights: null == reviewInsights ? _self.reviewInsights : reviewInsights // ignore: cast_nullable_to_non_nullable
as ReviewInsights,popularContent: null == popularContent ? _self.popularContent : popularContent // ignore: cast_nullable_to_non_nullable
as PopularContent,comparisons: null == comparisons ? _self._comparisons : comparisons // ignore: cast_nullable_to_non_nullable
as List<ComparisonMetric>,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DateRangeCopyWith<$Res> get dateRange {
  
  return $DateRangeCopyWith<$Res>(_self.dateRange, (value) {
    return _then(_self.copyWith(dateRange: value));
  });
}/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<$Res> get summary {
  
  return $DashboardSummaryCopyWith<$Res>(_self.summary, (value) {
    return _then(_self.copyWith(summary: value));
  });
}/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ReviewInsightsCopyWith<$Res> get reviewInsights {
  
  return $ReviewInsightsCopyWith<$Res>(_self.reviewInsights, (value) {
    return _then(_self.copyWith(reviewInsights: value));
  });
}/// Create a copy of BusinessDashboard
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PopularContentCopyWith<$Res> get popularContent {
  
  return $PopularContentCopyWith<$Res>(_self.popularContent, (value) {
    return _then(_self.copyWith(popularContent: value));
  });
}
}


/// @nodoc
mixin _$DashboardSummary {

 int get totalViews; int get uniqueVisitors; double get averageRating; int get totalReviews; int get totalFavorites; double get conversionRate; int get totalEvents; double get avgSessionDuration; int get previousTotalViews; int get previousUniqueVisitors; double get previousAverageRating; int get previousTotalReviews;
/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DashboardSummaryCopyWith<DashboardSummary> get copyWith => _$DashboardSummaryCopyWithImpl<DashboardSummary>(this as DashboardSummary, _$identity);

  /// Serializes this DashboardSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DashboardSummary&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews)&&(identical(other.uniqueVisitors, uniqueVisitors) || other.uniqueVisitors == uniqueVisitors)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.totalFavorites, totalFavorites) || other.totalFavorites == totalFavorites)&&(identical(other.conversionRate, conversionRate) || other.conversionRate == conversionRate)&&(identical(other.totalEvents, totalEvents) || other.totalEvents == totalEvents)&&(identical(other.avgSessionDuration, avgSessionDuration) || other.avgSessionDuration == avgSessionDuration)&&(identical(other.previousTotalViews, previousTotalViews) || other.previousTotalViews == previousTotalViews)&&(identical(other.previousUniqueVisitors, previousUniqueVisitors) || other.previousUniqueVisitors == previousUniqueVisitors)&&(identical(other.previousAverageRating, previousAverageRating) || other.previousAverageRating == previousAverageRating)&&(identical(other.previousTotalReviews, previousTotalReviews) || other.previousTotalReviews == previousTotalReviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalViews,uniqueVisitors,averageRating,totalReviews,totalFavorites,conversionRate,totalEvents,avgSessionDuration,previousTotalViews,previousUniqueVisitors,previousAverageRating,previousTotalReviews);

@override
String toString() {
  return 'DashboardSummary(totalViews: $totalViews, uniqueVisitors: $uniqueVisitors, averageRating: $averageRating, totalReviews: $totalReviews, totalFavorites: $totalFavorites, conversionRate: $conversionRate, totalEvents: $totalEvents, avgSessionDuration: $avgSessionDuration, previousTotalViews: $previousTotalViews, previousUniqueVisitors: $previousUniqueVisitors, previousAverageRating: $previousAverageRating, previousTotalReviews: $previousTotalReviews)';
}


}

/// @nodoc
abstract mixin class $DashboardSummaryCopyWith<$Res>  {
  factory $DashboardSummaryCopyWith(DashboardSummary value, $Res Function(DashboardSummary) _then) = _$DashboardSummaryCopyWithImpl;
@useResult
$Res call({
 int totalViews, int uniqueVisitors, double averageRating, int totalReviews, int totalFavorites, double conversionRate, int totalEvents, double avgSessionDuration, int previousTotalViews, int previousUniqueVisitors, double previousAverageRating, int previousTotalReviews
});




}
/// @nodoc
class _$DashboardSummaryCopyWithImpl<$Res>
    implements $DashboardSummaryCopyWith<$Res> {
  _$DashboardSummaryCopyWithImpl(this._self, this._then);

  final DashboardSummary _self;
  final $Res Function(DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalViews = null,Object? uniqueVisitors = null,Object? averageRating = null,Object? totalReviews = null,Object? totalFavorites = null,Object? conversionRate = null,Object? totalEvents = null,Object? avgSessionDuration = null,Object? previousTotalViews = null,Object? previousUniqueVisitors = null,Object? previousAverageRating = null,Object? previousTotalReviews = null,}) {
  return _then(_self.copyWith(
totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,uniqueVisitors: null == uniqueVisitors ? _self.uniqueVisitors : uniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,totalFavorites: null == totalFavorites ? _self.totalFavorites : totalFavorites // ignore: cast_nullable_to_non_nullable
as int,conversionRate: null == conversionRate ? _self.conversionRate : conversionRate // ignore: cast_nullable_to_non_nullable
as double,totalEvents: null == totalEvents ? _self.totalEvents : totalEvents // ignore: cast_nullable_to_non_nullable
as int,avgSessionDuration: null == avgSessionDuration ? _self.avgSessionDuration : avgSessionDuration // ignore: cast_nullable_to_non_nullable
as double,previousTotalViews: null == previousTotalViews ? _self.previousTotalViews : previousTotalViews // ignore: cast_nullable_to_non_nullable
as int,previousUniqueVisitors: null == previousUniqueVisitors ? _self.previousUniqueVisitors : previousUniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,previousAverageRating: null == previousAverageRating ? _self.previousAverageRating : previousAverageRating // ignore: cast_nullable_to_non_nullable
as double,previousTotalReviews: null == previousTotalReviews ? _self.previousTotalReviews : previousTotalReviews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DashboardSummary implements DashboardSummary {
  const _DashboardSummary({required this.totalViews, required this.uniqueVisitors, required this.averageRating, required this.totalReviews, required this.totalFavorites, required this.conversionRate, required this.totalEvents, required this.avgSessionDuration, this.previousTotalViews = 0, this.previousUniqueVisitors = 0, this.previousAverageRating = 0.0, this.previousTotalReviews = 0});
  factory _DashboardSummary.fromJson(Map<String, dynamic> json) => _$DashboardSummaryFromJson(json);

@override final  int totalViews;
@override final  int uniqueVisitors;
@override final  double averageRating;
@override final  int totalReviews;
@override final  int totalFavorites;
@override final  double conversionRate;
@override final  int totalEvents;
@override final  double avgSessionDuration;
@override@JsonKey() final  int previousTotalViews;
@override@JsonKey() final  int previousUniqueVisitors;
@override@JsonKey() final  double previousAverageRating;
@override@JsonKey() final  int previousTotalReviews;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DashboardSummaryCopyWith<_DashboardSummary> get copyWith => __$DashboardSummaryCopyWithImpl<_DashboardSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DashboardSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DashboardSummary&&(identical(other.totalViews, totalViews) || other.totalViews == totalViews)&&(identical(other.uniqueVisitors, uniqueVisitors) || other.uniqueVisitors == uniqueVisitors)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.totalFavorites, totalFavorites) || other.totalFavorites == totalFavorites)&&(identical(other.conversionRate, conversionRate) || other.conversionRate == conversionRate)&&(identical(other.totalEvents, totalEvents) || other.totalEvents == totalEvents)&&(identical(other.avgSessionDuration, avgSessionDuration) || other.avgSessionDuration == avgSessionDuration)&&(identical(other.previousTotalViews, previousTotalViews) || other.previousTotalViews == previousTotalViews)&&(identical(other.previousUniqueVisitors, previousUniqueVisitors) || other.previousUniqueVisitors == previousUniqueVisitors)&&(identical(other.previousAverageRating, previousAverageRating) || other.previousAverageRating == previousAverageRating)&&(identical(other.previousTotalReviews, previousTotalReviews) || other.previousTotalReviews == previousTotalReviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalViews,uniqueVisitors,averageRating,totalReviews,totalFavorites,conversionRate,totalEvents,avgSessionDuration,previousTotalViews,previousUniqueVisitors,previousAverageRating,previousTotalReviews);

@override
String toString() {
  return 'DashboardSummary(totalViews: $totalViews, uniqueVisitors: $uniqueVisitors, averageRating: $averageRating, totalReviews: $totalReviews, totalFavorites: $totalFavorites, conversionRate: $conversionRate, totalEvents: $totalEvents, avgSessionDuration: $avgSessionDuration, previousTotalViews: $previousTotalViews, previousUniqueVisitors: $previousUniqueVisitors, previousAverageRating: $previousAverageRating, previousTotalReviews: $previousTotalReviews)';
}


}

/// @nodoc
abstract mixin class _$DashboardSummaryCopyWith<$Res> implements $DashboardSummaryCopyWith<$Res> {
  factory _$DashboardSummaryCopyWith(_DashboardSummary value, $Res Function(_DashboardSummary) _then) = __$DashboardSummaryCopyWithImpl;
@override @useResult
$Res call({
 int totalViews, int uniqueVisitors, double averageRating, int totalReviews, int totalFavorites, double conversionRate, int totalEvents, double avgSessionDuration, int previousTotalViews, int previousUniqueVisitors, double previousAverageRating, int previousTotalReviews
});




}
/// @nodoc
class __$DashboardSummaryCopyWithImpl<$Res>
    implements _$DashboardSummaryCopyWith<$Res> {
  __$DashboardSummaryCopyWithImpl(this._self, this._then);

  final _DashboardSummary _self;
  final $Res Function(_DashboardSummary) _then;

/// Create a copy of DashboardSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalViews = null,Object? uniqueVisitors = null,Object? averageRating = null,Object? totalReviews = null,Object? totalFavorites = null,Object? conversionRate = null,Object? totalEvents = null,Object? avgSessionDuration = null,Object? previousTotalViews = null,Object? previousUniqueVisitors = null,Object? previousAverageRating = null,Object? previousTotalReviews = null,}) {
  return _then(_DashboardSummary(
totalViews: null == totalViews ? _self.totalViews : totalViews // ignore: cast_nullable_to_non_nullable
as int,uniqueVisitors: null == uniqueVisitors ? _self.uniqueVisitors : uniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,totalFavorites: null == totalFavorites ? _self.totalFavorites : totalFavorites // ignore: cast_nullable_to_non_nullable
as int,conversionRate: null == conversionRate ? _self.conversionRate : conversionRate // ignore: cast_nullable_to_non_nullable
as double,totalEvents: null == totalEvents ? _self.totalEvents : totalEvents // ignore: cast_nullable_to_non_nullable
as int,avgSessionDuration: null == avgSessionDuration ? _self.avgSessionDuration : avgSessionDuration // ignore: cast_nullable_to_non_nullable
as double,previousTotalViews: null == previousTotalViews ? _self.previousTotalViews : previousTotalViews // ignore: cast_nullable_to_non_nullable
as int,previousUniqueVisitors: null == previousUniqueVisitors ? _self.previousUniqueVisitors : previousUniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,previousAverageRating: null == previousAverageRating ? _self.previousAverageRating : previousAverageRating // ignore: cast_nullable_to_non_nullable
as double,previousTotalReviews: null == previousTotalReviews ? _self.previousTotalReviews : previousTotalReviews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$HourlyData {

 int get hour; int get views; int get uniqueVisitors; DateTime get date; int get interactions;
/// Create a copy of HourlyData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HourlyDataCopyWith<HourlyData> get copyWith => _$HourlyDataCopyWithImpl<HourlyData>(this as HourlyData, _$identity);

  /// Serializes this HourlyData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HourlyData&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.views, views) || other.views == views)&&(identical(other.uniqueVisitors, uniqueVisitors) || other.uniqueVisitors == uniqueVisitors)&&(identical(other.date, date) || other.date == date)&&(identical(other.interactions, interactions) || other.interactions == interactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,views,uniqueVisitors,date,interactions);

@override
String toString() {
  return 'HourlyData(hour: $hour, views: $views, uniqueVisitors: $uniqueVisitors, date: $date, interactions: $interactions)';
}


}

/// @nodoc
abstract mixin class $HourlyDataCopyWith<$Res>  {
  factory $HourlyDataCopyWith(HourlyData value, $Res Function(HourlyData) _then) = _$HourlyDataCopyWithImpl;
@useResult
$Res call({
 int hour, int views, int uniqueVisitors, DateTime date, int interactions
});




}
/// @nodoc
class _$HourlyDataCopyWithImpl<$Res>
    implements $HourlyDataCopyWith<$Res> {
  _$HourlyDataCopyWithImpl(this._self, this._then);

  final HourlyData _self;
  final $Res Function(HourlyData) _then;

/// Create a copy of HourlyData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? hour = null,Object? views = null,Object? uniqueVisitors = null,Object? date = null,Object? interactions = null,}) {
  return _then(_self.copyWith(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,uniqueVisitors: null == uniqueVisitors ? _self.uniqueVisitors : uniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,interactions: null == interactions ? _self.interactions : interactions // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _HourlyData implements HourlyData {
  const _HourlyData({required this.hour, required this.views, required this.uniqueVisitors, required this.date, this.interactions = 0});
  factory _HourlyData.fromJson(Map<String, dynamic> json) => _$HourlyDataFromJson(json);

@override final  int hour;
@override final  int views;
@override final  int uniqueVisitors;
@override final  DateTime date;
@override@JsonKey() final  int interactions;

/// Create a copy of HourlyData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HourlyDataCopyWith<_HourlyData> get copyWith => __$HourlyDataCopyWithImpl<_HourlyData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HourlyDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HourlyData&&(identical(other.hour, hour) || other.hour == hour)&&(identical(other.views, views) || other.views == views)&&(identical(other.uniqueVisitors, uniqueVisitors) || other.uniqueVisitors == uniqueVisitors)&&(identical(other.date, date) || other.date == date)&&(identical(other.interactions, interactions) || other.interactions == interactions));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,hour,views,uniqueVisitors,date,interactions);

@override
String toString() {
  return 'HourlyData(hour: $hour, views: $views, uniqueVisitors: $uniqueVisitors, date: $date, interactions: $interactions)';
}


}

/// @nodoc
abstract mixin class _$HourlyDataCopyWith<$Res> implements $HourlyDataCopyWith<$Res> {
  factory _$HourlyDataCopyWith(_HourlyData value, $Res Function(_HourlyData) _then) = __$HourlyDataCopyWithImpl;
@override @useResult
$Res call({
 int hour, int views, int uniqueVisitors, DateTime date, int interactions
});




}
/// @nodoc
class __$HourlyDataCopyWithImpl<$Res>
    implements _$HourlyDataCopyWith<$Res> {
  __$HourlyDataCopyWithImpl(this._self, this._then);

  final _HourlyData _self;
  final $Res Function(_HourlyData) _then;

/// Create a copy of HourlyData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? hour = null,Object? views = null,Object? uniqueVisitors = null,Object? date = null,Object? interactions = null,}) {
  return _then(_HourlyData(
hour: null == hour ? _self.hour : hour // ignore: cast_nullable_to_non_nullable
as int,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,uniqueVisitors: null == uniqueVisitors ? _self.uniqueVisitors : uniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,interactions: null == interactions ? _self.interactions : interactions // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$DailyData {

 DateTime get date; int get views; int get uniqueVisitors; int get newReviews; int get newFavorites; int get interactions; double get avgRating;
/// Create a copy of DailyData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$DailyDataCopyWith<DailyData> get copyWith => _$DailyDataCopyWithImpl<DailyData>(this as DailyData, _$identity);

  /// Serializes this DailyData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is DailyData&&(identical(other.date, date) || other.date == date)&&(identical(other.views, views) || other.views == views)&&(identical(other.uniqueVisitors, uniqueVisitors) || other.uniqueVisitors == uniqueVisitors)&&(identical(other.newReviews, newReviews) || other.newReviews == newReviews)&&(identical(other.newFavorites, newFavorites) || other.newFavorites == newFavorites)&&(identical(other.interactions, interactions) || other.interactions == interactions)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,views,uniqueVisitors,newReviews,newFavorites,interactions,avgRating);

@override
String toString() {
  return 'DailyData(date: $date, views: $views, uniqueVisitors: $uniqueVisitors, newReviews: $newReviews, newFavorites: $newFavorites, interactions: $interactions, avgRating: $avgRating)';
}


}

/// @nodoc
abstract mixin class $DailyDataCopyWith<$Res>  {
  factory $DailyDataCopyWith(DailyData value, $Res Function(DailyData) _then) = _$DailyDataCopyWithImpl;
@useResult
$Res call({
 DateTime date, int views, int uniqueVisitors, int newReviews, int newFavorites, int interactions, double avgRating
});




}
/// @nodoc
class _$DailyDataCopyWithImpl<$Res>
    implements $DailyDataCopyWith<$Res> {
  _$DailyDataCopyWithImpl(this._self, this._then);

  final DailyData _self;
  final $Res Function(DailyData) _then;

/// Create a copy of DailyData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? date = null,Object? views = null,Object? uniqueVisitors = null,Object? newReviews = null,Object? newFavorites = null,Object? interactions = null,Object? avgRating = null,}) {
  return _then(_self.copyWith(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,uniqueVisitors: null == uniqueVisitors ? _self.uniqueVisitors : uniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,newReviews: null == newReviews ? _self.newReviews : newReviews // ignore: cast_nullable_to_non_nullable
as int,newFavorites: null == newFavorites ? _self.newFavorites : newFavorites // ignore: cast_nullable_to_non_nullable
as int,interactions: null == interactions ? _self.interactions : interactions // ignore: cast_nullable_to_non_nullable
as int,avgRating: null == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _DailyData implements DailyData {
  const _DailyData({required this.date, required this.views, required this.uniqueVisitors, required this.newReviews, required this.newFavorites, this.interactions = 0, this.avgRating = 0.0});
  factory _DailyData.fromJson(Map<String, dynamic> json) => _$DailyDataFromJson(json);

@override final  DateTime date;
@override final  int views;
@override final  int uniqueVisitors;
@override final  int newReviews;
@override final  int newFavorites;
@override@JsonKey() final  int interactions;
@override@JsonKey() final  double avgRating;

/// Create a copy of DailyData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$DailyDataCopyWith<_DailyData> get copyWith => __$DailyDataCopyWithImpl<_DailyData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$DailyDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _DailyData&&(identical(other.date, date) || other.date == date)&&(identical(other.views, views) || other.views == views)&&(identical(other.uniqueVisitors, uniqueVisitors) || other.uniqueVisitors == uniqueVisitors)&&(identical(other.newReviews, newReviews) || other.newReviews == newReviews)&&(identical(other.newFavorites, newFavorites) || other.newFavorites == newFavorites)&&(identical(other.interactions, interactions) || other.interactions == interactions)&&(identical(other.avgRating, avgRating) || other.avgRating == avgRating));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,date,views,uniqueVisitors,newReviews,newFavorites,interactions,avgRating);

@override
String toString() {
  return 'DailyData(date: $date, views: $views, uniqueVisitors: $uniqueVisitors, newReviews: $newReviews, newFavorites: $newFavorites, interactions: $interactions, avgRating: $avgRating)';
}


}

/// @nodoc
abstract mixin class _$DailyDataCopyWith<$Res> implements $DailyDataCopyWith<$Res> {
  factory _$DailyDataCopyWith(_DailyData value, $Res Function(_DailyData) _then) = __$DailyDataCopyWithImpl;
@override @useResult
$Res call({
 DateTime date, int views, int uniqueVisitors, int newReviews, int newFavorites, int interactions, double avgRating
});




}
/// @nodoc
class __$DailyDataCopyWithImpl<$Res>
    implements _$DailyDataCopyWith<$Res> {
  __$DailyDataCopyWithImpl(this._self, this._then);

  final _DailyData _self;
  final $Res Function(_DailyData) _then;

/// Create a copy of DailyData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? date = null,Object? views = null,Object? uniqueVisitors = null,Object? newReviews = null,Object? newFavorites = null,Object? interactions = null,Object? avgRating = null,}) {
  return _then(_DailyData(
date: null == date ? _self.date : date // ignore: cast_nullable_to_non_nullable
as DateTime,views: null == views ? _self.views : views // ignore: cast_nullable_to_non_nullable
as int,uniqueVisitors: null == uniqueVisitors ? _self.uniqueVisitors : uniqueVisitors // ignore: cast_nullable_to_non_nullable
as int,newReviews: null == newReviews ? _self.newReviews : newReviews // ignore: cast_nullable_to_non_nullable
as int,newFavorites: null == newFavorites ? _self.newFavorites : newFavorites // ignore: cast_nullable_to_non_nullable
as int,interactions: null == interactions ? _self.interactions : interactions // ignore: cast_nullable_to_non_nullable
as int,avgRating: null == avgRating ? _self.avgRating : avgRating // ignore: cast_nullable_to_non_nullable
as double,
  ));
}


}


/// @nodoc
mixin _$ReviewInsights {

 int get totalReviews; double get averageRating; Map<int, int> get ratingDistribution; List<String> get topKeywords; List<String> get topComplaints; List<String> get topPraises; SentimentAnalysis get sentimentAnalysis; int get pendingReviews; int get thisWeekReviews;
/// Create a copy of ReviewInsights
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReviewInsightsCopyWith<ReviewInsights> get copyWith => _$ReviewInsightsCopyWithImpl<ReviewInsights>(this as ReviewInsights, _$identity);

  /// Serializes this ReviewInsights to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReviewInsights&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&const DeepCollectionEquality().equals(other.ratingDistribution, ratingDistribution)&&const DeepCollectionEquality().equals(other.topKeywords, topKeywords)&&const DeepCollectionEquality().equals(other.topComplaints, topComplaints)&&const DeepCollectionEquality().equals(other.topPraises, topPraises)&&(identical(other.sentimentAnalysis, sentimentAnalysis) || other.sentimentAnalysis == sentimentAnalysis)&&(identical(other.pendingReviews, pendingReviews) || other.pendingReviews == pendingReviews)&&(identical(other.thisWeekReviews, thisWeekReviews) || other.thisWeekReviews == thisWeekReviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalReviews,averageRating,const DeepCollectionEquality().hash(ratingDistribution),const DeepCollectionEquality().hash(topKeywords),const DeepCollectionEquality().hash(topComplaints),const DeepCollectionEquality().hash(topPraises),sentimentAnalysis,pendingReviews,thisWeekReviews);

@override
String toString() {
  return 'ReviewInsights(totalReviews: $totalReviews, averageRating: $averageRating, ratingDistribution: $ratingDistribution, topKeywords: $topKeywords, topComplaints: $topComplaints, topPraises: $topPraises, sentimentAnalysis: $sentimentAnalysis, pendingReviews: $pendingReviews, thisWeekReviews: $thisWeekReviews)';
}


}

/// @nodoc
abstract mixin class $ReviewInsightsCopyWith<$Res>  {
  factory $ReviewInsightsCopyWith(ReviewInsights value, $Res Function(ReviewInsights) _then) = _$ReviewInsightsCopyWithImpl;
@useResult
$Res call({
 int totalReviews, double averageRating, Map<int, int> ratingDistribution, List<String> topKeywords, List<String> topComplaints, List<String> topPraises, SentimentAnalysis sentimentAnalysis, int pendingReviews, int thisWeekReviews
});


$SentimentAnalysisCopyWith<$Res> get sentimentAnalysis;

}
/// @nodoc
class _$ReviewInsightsCopyWithImpl<$Res>
    implements $ReviewInsightsCopyWith<$Res> {
  _$ReviewInsightsCopyWithImpl(this._self, this._then);

  final ReviewInsights _self;
  final $Res Function(ReviewInsights) _then;

/// Create a copy of ReviewInsights
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalReviews = null,Object? averageRating = null,Object? ratingDistribution = null,Object? topKeywords = null,Object? topComplaints = null,Object? topPraises = null,Object? sentimentAnalysis = null,Object? pendingReviews = null,Object? thisWeekReviews = null,}) {
  return _then(_self.copyWith(
totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,ratingDistribution: null == ratingDistribution ? _self.ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<int, int>,topKeywords: null == topKeywords ? _self.topKeywords : topKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,topComplaints: null == topComplaints ? _self.topComplaints : topComplaints // ignore: cast_nullable_to_non_nullable
as List<String>,topPraises: null == topPraises ? _self.topPraises : topPraises // ignore: cast_nullable_to_non_nullable
as List<String>,sentimentAnalysis: null == sentimentAnalysis ? _self.sentimentAnalysis : sentimentAnalysis // ignore: cast_nullable_to_non_nullable
as SentimentAnalysis,pendingReviews: null == pendingReviews ? _self.pendingReviews : pendingReviews // ignore: cast_nullable_to_non_nullable
as int,thisWeekReviews: null == thisWeekReviews ? _self.thisWeekReviews : thisWeekReviews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}
/// Create a copy of ReviewInsights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentAnalysisCopyWith<$Res> get sentimentAnalysis {
  
  return $SentimentAnalysisCopyWith<$Res>(_self.sentimentAnalysis, (value) {
    return _then(_self.copyWith(sentimentAnalysis: value));
  });
}
}


/// @nodoc
@JsonSerializable()

class _ReviewInsights implements ReviewInsights {
  const _ReviewInsights({required this.totalReviews, required this.averageRating, required final  Map<int, int> ratingDistribution, required final  List<String> topKeywords, required final  List<String> topComplaints, required final  List<String> topPraises, required this.sentimentAnalysis, this.pendingReviews = 0, this.thisWeekReviews = 0}): _ratingDistribution = ratingDistribution,_topKeywords = topKeywords,_topComplaints = topComplaints,_topPraises = topPraises;
  factory _ReviewInsights.fromJson(Map<String, dynamic> json) => _$ReviewInsightsFromJson(json);

@override final  int totalReviews;
@override final  double averageRating;
 final  Map<int, int> _ratingDistribution;
@override Map<int, int> get ratingDistribution {
  if (_ratingDistribution is EqualUnmodifiableMapView) return _ratingDistribution;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_ratingDistribution);
}

 final  List<String> _topKeywords;
@override List<String> get topKeywords {
  if (_topKeywords is EqualUnmodifiableListView) return _topKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topKeywords);
}

 final  List<String> _topComplaints;
@override List<String> get topComplaints {
  if (_topComplaints is EqualUnmodifiableListView) return _topComplaints;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topComplaints);
}

 final  List<String> _topPraises;
@override List<String> get topPraises {
  if (_topPraises is EqualUnmodifiableListView) return _topPraises;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topPraises);
}

@override final  SentimentAnalysis sentimentAnalysis;
@override@JsonKey() final  int pendingReviews;
@override@JsonKey() final  int thisWeekReviews;

/// Create a copy of ReviewInsights
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReviewInsightsCopyWith<_ReviewInsights> get copyWith => __$ReviewInsightsCopyWithImpl<_ReviewInsights>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ReviewInsightsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReviewInsights&&(identical(other.totalReviews, totalReviews) || other.totalReviews == totalReviews)&&(identical(other.averageRating, averageRating) || other.averageRating == averageRating)&&const DeepCollectionEquality().equals(other._ratingDistribution, _ratingDistribution)&&const DeepCollectionEquality().equals(other._topKeywords, _topKeywords)&&const DeepCollectionEquality().equals(other._topComplaints, _topComplaints)&&const DeepCollectionEquality().equals(other._topPraises, _topPraises)&&(identical(other.sentimentAnalysis, sentimentAnalysis) || other.sentimentAnalysis == sentimentAnalysis)&&(identical(other.pendingReviews, pendingReviews) || other.pendingReviews == pendingReviews)&&(identical(other.thisWeekReviews, thisWeekReviews) || other.thisWeekReviews == thisWeekReviews));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalReviews,averageRating,const DeepCollectionEquality().hash(_ratingDistribution),const DeepCollectionEquality().hash(_topKeywords),const DeepCollectionEquality().hash(_topComplaints),const DeepCollectionEquality().hash(_topPraises),sentimentAnalysis,pendingReviews,thisWeekReviews);

@override
String toString() {
  return 'ReviewInsights(totalReviews: $totalReviews, averageRating: $averageRating, ratingDistribution: $ratingDistribution, topKeywords: $topKeywords, topComplaints: $topComplaints, topPraises: $topPraises, sentimentAnalysis: $sentimentAnalysis, pendingReviews: $pendingReviews, thisWeekReviews: $thisWeekReviews)';
}


}

/// @nodoc
abstract mixin class _$ReviewInsightsCopyWith<$Res> implements $ReviewInsightsCopyWith<$Res> {
  factory _$ReviewInsightsCopyWith(_ReviewInsights value, $Res Function(_ReviewInsights) _then) = __$ReviewInsightsCopyWithImpl;
@override @useResult
$Res call({
 int totalReviews, double averageRating, Map<int, int> ratingDistribution, List<String> topKeywords, List<String> topComplaints, List<String> topPraises, SentimentAnalysis sentimentAnalysis, int pendingReviews, int thisWeekReviews
});


@override $SentimentAnalysisCopyWith<$Res> get sentimentAnalysis;

}
/// @nodoc
class __$ReviewInsightsCopyWithImpl<$Res>
    implements _$ReviewInsightsCopyWith<$Res> {
  __$ReviewInsightsCopyWithImpl(this._self, this._then);

  final _ReviewInsights _self;
  final $Res Function(_ReviewInsights) _then;

/// Create a copy of ReviewInsights
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalReviews = null,Object? averageRating = null,Object? ratingDistribution = null,Object? topKeywords = null,Object? topComplaints = null,Object? topPraises = null,Object? sentimentAnalysis = null,Object? pendingReviews = null,Object? thisWeekReviews = null,}) {
  return _then(_ReviewInsights(
totalReviews: null == totalReviews ? _self.totalReviews : totalReviews // ignore: cast_nullable_to_non_nullable
as int,averageRating: null == averageRating ? _self.averageRating : averageRating // ignore: cast_nullable_to_non_nullable
as double,ratingDistribution: null == ratingDistribution ? _self._ratingDistribution : ratingDistribution // ignore: cast_nullable_to_non_nullable
as Map<int, int>,topKeywords: null == topKeywords ? _self._topKeywords : topKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,topComplaints: null == topComplaints ? _self._topComplaints : topComplaints // ignore: cast_nullable_to_non_nullable
as List<String>,topPraises: null == topPraises ? _self._topPraises : topPraises // ignore: cast_nullable_to_non_nullable
as List<String>,sentimentAnalysis: null == sentimentAnalysis ? _self.sentimentAnalysis : sentimentAnalysis // ignore: cast_nullable_to_non_nullable
as SentimentAnalysis,pendingReviews: null == pendingReviews ? _self.pendingReviews : pendingReviews // ignore: cast_nullable_to_non_nullable
as int,thisWeekReviews: null == thisWeekReviews ? _self.thisWeekReviews : thisWeekReviews // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

/// Create a copy of ReviewInsights
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SentimentAnalysisCopyWith<$Res> get sentimentAnalysis {
  
  return $SentimentAnalysisCopyWith<$Res>(_self.sentimentAnalysis, (value) {
    return _then(_self.copyWith(sentimentAnalysis: value));
  });
}
}


/// @nodoc
mixin _$SentimentAnalysis {

 double get positiveScore; double get neutralScore; double get negativeScore; SentimentTrend get trend; List<String> get positiveKeywords; List<String> get negativeKeywords;
/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SentimentAnalysisCopyWith<SentimentAnalysis> get copyWith => _$SentimentAnalysisCopyWithImpl<SentimentAnalysis>(this as SentimentAnalysis, _$identity);

  /// Serializes this SentimentAnalysis to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SentimentAnalysis&&(identical(other.positiveScore, positiveScore) || other.positiveScore == positiveScore)&&(identical(other.neutralScore, neutralScore) || other.neutralScore == neutralScore)&&(identical(other.negativeScore, negativeScore) || other.negativeScore == negativeScore)&&(identical(other.trend, trend) || other.trend == trend)&&const DeepCollectionEquality().equals(other.positiveKeywords, positiveKeywords)&&const DeepCollectionEquality().equals(other.negativeKeywords, negativeKeywords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,positiveScore,neutralScore,negativeScore,trend,const DeepCollectionEquality().hash(positiveKeywords),const DeepCollectionEquality().hash(negativeKeywords));

@override
String toString() {
  return 'SentimentAnalysis(positiveScore: $positiveScore, neutralScore: $neutralScore, negativeScore: $negativeScore, trend: $trend, positiveKeywords: $positiveKeywords, negativeKeywords: $negativeKeywords)';
}


}

/// @nodoc
abstract mixin class $SentimentAnalysisCopyWith<$Res>  {
  factory $SentimentAnalysisCopyWith(SentimentAnalysis value, $Res Function(SentimentAnalysis) _then) = _$SentimentAnalysisCopyWithImpl;
@useResult
$Res call({
 double positiveScore, double neutralScore, double negativeScore, SentimentTrend trend, List<String> positiveKeywords, List<String> negativeKeywords
});




}
/// @nodoc
class _$SentimentAnalysisCopyWithImpl<$Res>
    implements $SentimentAnalysisCopyWith<$Res> {
  _$SentimentAnalysisCopyWithImpl(this._self, this._then);

  final SentimentAnalysis _self;
  final $Res Function(SentimentAnalysis) _then;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? positiveScore = null,Object? neutralScore = null,Object? negativeScore = null,Object? trend = null,Object? positiveKeywords = null,Object? negativeKeywords = null,}) {
  return _then(_self.copyWith(
positiveScore: null == positiveScore ? _self.positiveScore : positiveScore // ignore: cast_nullable_to_non_nullable
as double,neutralScore: null == neutralScore ? _self.neutralScore : neutralScore // ignore: cast_nullable_to_non_nullable
as double,negativeScore: null == negativeScore ? _self.negativeScore : negativeScore // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as SentimentTrend,positiveKeywords: null == positiveKeywords ? _self.positiveKeywords : positiveKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,negativeKeywords: null == negativeKeywords ? _self.negativeKeywords : negativeKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _SentimentAnalysis implements SentimentAnalysis {
  const _SentimentAnalysis({required this.positiveScore, required this.neutralScore, required this.negativeScore, required this.trend, final  List<String> positiveKeywords = const [], final  List<String> negativeKeywords = const []}): _positiveKeywords = positiveKeywords,_negativeKeywords = negativeKeywords;
  factory _SentimentAnalysis.fromJson(Map<String, dynamic> json) => _$SentimentAnalysisFromJson(json);

@override final  double positiveScore;
@override final  double neutralScore;
@override final  double negativeScore;
@override final  SentimentTrend trend;
 final  List<String> _positiveKeywords;
@override@JsonKey() List<String> get positiveKeywords {
  if (_positiveKeywords is EqualUnmodifiableListView) return _positiveKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_positiveKeywords);
}

 final  List<String> _negativeKeywords;
@override@JsonKey() List<String> get negativeKeywords {
  if (_negativeKeywords is EqualUnmodifiableListView) return _negativeKeywords;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_negativeKeywords);
}


/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SentimentAnalysisCopyWith<_SentimentAnalysis> get copyWith => __$SentimentAnalysisCopyWithImpl<_SentimentAnalysis>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SentimentAnalysisToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SentimentAnalysis&&(identical(other.positiveScore, positiveScore) || other.positiveScore == positiveScore)&&(identical(other.neutralScore, neutralScore) || other.neutralScore == neutralScore)&&(identical(other.negativeScore, negativeScore) || other.negativeScore == negativeScore)&&(identical(other.trend, trend) || other.trend == trend)&&const DeepCollectionEquality().equals(other._positiveKeywords, _positiveKeywords)&&const DeepCollectionEquality().equals(other._negativeKeywords, _negativeKeywords));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,positiveScore,neutralScore,negativeScore,trend,const DeepCollectionEquality().hash(_positiveKeywords),const DeepCollectionEquality().hash(_negativeKeywords));

@override
String toString() {
  return 'SentimentAnalysis(positiveScore: $positiveScore, neutralScore: $neutralScore, negativeScore: $negativeScore, trend: $trend, positiveKeywords: $positiveKeywords, negativeKeywords: $negativeKeywords)';
}


}

/// @nodoc
abstract mixin class _$SentimentAnalysisCopyWith<$Res> implements $SentimentAnalysisCopyWith<$Res> {
  factory _$SentimentAnalysisCopyWith(_SentimentAnalysis value, $Res Function(_SentimentAnalysis) _then) = __$SentimentAnalysisCopyWithImpl;
@override @useResult
$Res call({
 double positiveScore, double neutralScore, double negativeScore, SentimentTrend trend, List<String> positiveKeywords, List<String> negativeKeywords
});




}
/// @nodoc
class __$SentimentAnalysisCopyWithImpl<$Res>
    implements _$SentimentAnalysisCopyWith<$Res> {
  __$SentimentAnalysisCopyWithImpl(this._self, this._then);

  final _SentimentAnalysis _self;
  final $Res Function(_SentimentAnalysis) _then;

/// Create a copy of SentimentAnalysis
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? positiveScore = null,Object? neutralScore = null,Object? negativeScore = null,Object? trend = null,Object? positiveKeywords = null,Object? negativeKeywords = null,}) {
  return _then(_SentimentAnalysis(
positiveScore: null == positiveScore ? _self.positiveScore : positiveScore // ignore: cast_nullable_to_non_nullable
as double,neutralScore: null == neutralScore ? _self.neutralScore : neutralScore // ignore: cast_nullable_to_non_nullable
as double,negativeScore: null == negativeScore ? _self.negativeScore : negativeScore // ignore: cast_nullable_to_non_nullable
as double,trend: null == trend ? _self.trend : trend // ignore: cast_nullable_to_non_nullable
as SentimentTrend,positiveKeywords: null == positiveKeywords ? _self._positiveKeywords : positiveKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,negativeKeywords: null == negativeKeywords ? _self._negativeKeywords : negativeKeywords // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}


/// @nodoc
mixin _$PopularContent {

 List<PopularItem> get topCategories; List<PopularItem> get topProducts; List<PopularItem> get topServices; List<PopularItem> get topOffers; List<PopularItem> get topSearchTerms;
/// Create a copy of PopularContent
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularContentCopyWith<PopularContent> get copyWith => _$PopularContentCopyWithImpl<PopularContent>(this as PopularContent, _$identity);

  /// Serializes this PopularContent to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularContent&&const DeepCollectionEquality().equals(other.topCategories, topCategories)&&const DeepCollectionEquality().equals(other.topProducts, topProducts)&&const DeepCollectionEquality().equals(other.topServices, topServices)&&const DeepCollectionEquality().equals(other.topOffers, topOffers)&&const DeepCollectionEquality().equals(other.topSearchTerms, topSearchTerms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(topCategories),const DeepCollectionEquality().hash(topProducts),const DeepCollectionEquality().hash(topServices),const DeepCollectionEquality().hash(topOffers),const DeepCollectionEquality().hash(topSearchTerms));

@override
String toString() {
  return 'PopularContent(topCategories: $topCategories, topProducts: $topProducts, topServices: $topServices, topOffers: $topOffers, topSearchTerms: $topSearchTerms)';
}


}

/// @nodoc
abstract mixin class $PopularContentCopyWith<$Res>  {
  factory $PopularContentCopyWith(PopularContent value, $Res Function(PopularContent) _then) = _$PopularContentCopyWithImpl;
@useResult
$Res call({
 List<PopularItem> topCategories, List<PopularItem> topProducts, List<PopularItem> topServices, List<PopularItem> topOffers, List<PopularItem> topSearchTerms
});




}
/// @nodoc
class _$PopularContentCopyWithImpl<$Res>
    implements $PopularContentCopyWith<$Res> {
  _$PopularContentCopyWithImpl(this._self, this._then);

  final PopularContent _self;
  final $Res Function(PopularContent) _then;

/// Create a copy of PopularContent
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? topCategories = null,Object? topProducts = null,Object? topServices = null,Object? topOffers = null,Object? topSearchTerms = null,}) {
  return _then(_self.copyWith(
topCategories: null == topCategories ? _self.topCategories : topCategories // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topProducts: null == topProducts ? _self.topProducts : topProducts // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topServices: null == topServices ? _self.topServices : topServices // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topOffers: null == topOffers ? _self.topOffers : topOffers // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topSearchTerms: null == topSearchTerms ? _self.topSearchTerms : topSearchTerms // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PopularContent implements PopularContent {
  const _PopularContent({required final  List<PopularItem> topCategories, required final  List<PopularItem> topProducts, required final  List<PopularItem> topServices, required final  List<PopularItem> topOffers, final  List<PopularItem> topSearchTerms = const []}): _topCategories = topCategories,_topProducts = topProducts,_topServices = topServices,_topOffers = topOffers,_topSearchTerms = topSearchTerms;
  factory _PopularContent.fromJson(Map<String, dynamic> json) => _$PopularContentFromJson(json);

 final  List<PopularItem> _topCategories;
@override List<PopularItem> get topCategories {
  if (_topCategories is EqualUnmodifiableListView) return _topCategories;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topCategories);
}

 final  List<PopularItem> _topProducts;
@override List<PopularItem> get topProducts {
  if (_topProducts is EqualUnmodifiableListView) return _topProducts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topProducts);
}

 final  List<PopularItem> _topServices;
@override List<PopularItem> get topServices {
  if (_topServices is EqualUnmodifiableListView) return _topServices;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topServices);
}

 final  List<PopularItem> _topOffers;
@override List<PopularItem> get topOffers {
  if (_topOffers is EqualUnmodifiableListView) return _topOffers;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topOffers);
}

 final  List<PopularItem> _topSearchTerms;
@override@JsonKey() List<PopularItem> get topSearchTerms {
  if (_topSearchTerms is EqualUnmodifiableListView) return _topSearchTerms;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_topSearchTerms);
}


/// Create a copy of PopularContent
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularContentCopyWith<_PopularContent> get copyWith => __$PopularContentCopyWithImpl<_PopularContent>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularContentToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularContent&&const DeepCollectionEquality().equals(other._topCategories, _topCategories)&&const DeepCollectionEquality().equals(other._topProducts, _topProducts)&&const DeepCollectionEquality().equals(other._topServices, _topServices)&&const DeepCollectionEquality().equals(other._topOffers, _topOffers)&&const DeepCollectionEquality().equals(other._topSearchTerms, _topSearchTerms));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_topCategories),const DeepCollectionEquality().hash(_topProducts),const DeepCollectionEquality().hash(_topServices),const DeepCollectionEquality().hash(_topOffers),const DeepCollectionEquality().hash(_topSearchTerms));

@override
String toString() {
  return 'PopularContent(topCategories: $topCategories, topProducts: $topProducts, topServices: $topServices, topOffers: $topOffers, topSearchTerms: $topSearchTerms)';
}


}

/// @nodoc
abstract mixin class _$PopularContentCopyWith<$Res> implements $PopularContentCopyWith<$Res> {
  factory _$PopularContentCopyWith(_PopularContent value, $Res Function(_PopularContent) _then) = __$PopularContentCopyWithImpl;
@override @useResult
$Res call({
 List<PopularItem> topCategories, List<PopularItem> topProducts, List<PopularItem> topServices, List<PopularItem> topOffers, List<PopularItem> topSearchTerms
});




}
/// @nodoc
class __$PopularContentCopyWithImpl<$Res>
    implements _$PopularContentCopyWith<$Res> {
  __$PopularContentCopyWithImpl(this._self, this._then);

  final _PopularContent _self;
  final $Res Function(_PopularContent) _then;

/// Create a copy of PopularContent
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? topCategories = null,Object? topProducts = null,Object? topServices = null,Object? topOffers = null,Object? topSearchTerms = null,}) {
  return _then(_PopularContent(
topCategories: null == topCategories ? _self._topCategories : topCategories // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topProducts: null == topProducts ? _self._topProducts : topProducts // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topServices: null == topServices ? _self._topServices : topServices // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topOffers: null == topOffers ? _self._topOffers : topOffers // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,topSearchTerms: null == topSearchTerms ? _self._topSearchTerms : topSearchTerms // ignore: cast_nullable_to_non_nullable
as List<PopularItem>,
  ));
}


}


/// @nodoc
mixin _$PopularItem {

 String get id; String get name; int get count; double get percentage; Map<String, dynamic>? get metadata;
/// Create a copy of PopularItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PopularItemCopyWith<PopularItem> get copyWith => _$PopularItemCopyWithImpl<PopularItem>(this as PopularItem, _$identity);

  /// Serializes this PopularItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PopularItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other.metadata, metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,count,percentage,const DeepCollectionEquality().hash(metadata));

@override
String toString() {
  return 'PopularItem(id: $id, name: $name, count: $count, percentage: $percentage, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class $PopularItemCopyWith<$Res>  {
  factory $PopularItemCopyWith(PopularItem value, $Res Function(PopularItem) _then) = _$PopularItemCopyWithImpl;
@useResult
$Res call({
 String id, String name, int count, double percentage, Map<String, dynamic>? metadata
});




}
/// @nodoc
class _$PopularItemCopyWithImpl<$Res>
    implements $PopularItemCopyWith<$Res> {
  _$PopularItemCopyWithImpl(this._self, this._then);

  final PopularItem _self;
  final $Res Function(PopularItem) _then;

/// Create a copy of PopularItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? count = null,Object? percentage = null,Object? metadata = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _PopularItem implements PopularItem {
  const _PopularItem({required this.id, required this.name, required this.count, required this.percentage, final  Map<String, dynamic>? metadata}): _metadata = metadata;
  factory _PopularItem.fromJson(Map<String, dynamic> json) => _$PopularItemFromJson(json);

@override final  String id;
@override final  String name;
@override final  int count;
@override final  double percentage;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of PopularItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PopularItemCopyWith<_PopularItem> get copyWith => __$PopularItemCopyWithImpl<_PopularItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PopularItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PopularItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.count, count) || other.count == count)&&(identical(other.percentage, percentage) || other.percentage == percentage)&&const DeepCollectionEquality().equals(other._metadata, _metadata));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,count,percentage,const DeepCollectionEquality().hash(_metadata));

@override
String toString() {
  return 'PopularItem(id: $id, name: $name, count: $count, percentage: $percentage, metadata: $metadata)';
}


}

/// @nodoc
abstract mixin class _$PopularItemCopyWith<$Res> implements $PopularItemCopyWith<$Res> {
  factory _$PopularItemCopyWith(_PopularItem value, $Res Function(_PopularItem) _then) = __$PopularItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int count, double percentage, Map<String, dynamic>? metadata
});




}
/// @nodoc
class __$PopularItemCopyWithImpl<$Res>
    implements _$PopularItemCopyWith<$Res> {
  __$PopularItemCopyWithImpl(this._self, this._then);

  final _PopularItem _self;
  final $Res Function(_PopularItem) _then;

/// Create a copy of PopularItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? count = null,Object? percentage = null,Object? metadata = freezed,}) {
  return _then(_PopularItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,count: null == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int,percentage: null == percentage ? _self.percentage : percentage // ignore: cast_nullable_to_non_nullable
as double,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}


/// @nodoc
mixin _$ComparisonMetric {

 String get metricName; double get currentValue; double get compareValue; String get compareLabel; ComparisonType get type;
/// Create a copy of ComparisonMetric
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ComparisonMetricCopyWith<ComparisonMetric> get copyWith => _$ComparisonMetricCopyWithImpl<ComparisonMetric>(this as ComparisonMetric, _$identity);

  /// Serializes this ComparisonMetric to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ComparisonMetric&&(identical(other.metricName, metricName) || other.metricName == metricName)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.compareValue, compareValue) || other.compareValue == compareValue)&&(identical(other.compareLabel, compareLabel) || other.compareLabel == compareLabel)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metricName,currentValue,compareValue,compareLabel,type);

@override
String toString() {
  return 'ComparisonMetric(metricName: $metricName, currentValue: $currentValue, compareValue: $compareValue, compareLabel: $compareLabel, type: $type)';
}


}

/// @nodoc
abstract mixin class $ComparisonMetricCopyWith<$Res>  {
  factory $ComparisonMetricCopyWith(ComparisonMetric value, $Res Function(ComparisonMetric) _then) = _$ComparisonMetricCopyWithImpl;
@useResult
$Res call({
 String metricName, double currentValue, double compareValue, String compareLabel, ComparisonType type
});




}
/// @nodoc
class _$ComparisonMetricCopyWithImpl<$Res>
    implements $ComparisonMetricCopyWith<$Res> {
  _$ComparisonMetricCopyWithImpl(this._self, this._then);

  final ComparisonMetric _self;
  final $Res Function(ComparisonMetric) _then;

/// Create a copy of ComparisonMetric
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? metricName = null,Object? currentValue = null,Object? compareValue = null,Object? compareLabel = null,Object? type = null,}) {
  return _then(_self.copyWith(
metricName: null == metricName ? _self.metricName : metricName // ignore: cast_nullable_to_non_nullable
as String,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,compareValue: null == compareValue ? _self.compareValue : compareValue // ignore: cast_nullable_to_non_nullable
as double,compareLabel: null == compareLabel ? _self.compareLabel : compareLabel // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ComparisonType,
  ));
}

}


/// @nodoc
@JsonSerializable()

class _ComparisonMetric implements ComparisonMetric {
  const _ComparisonMetric({required this.metricName, required this.currentValue, required this.compareValue, required this.compareLabel, required this.type});
  factory _ComparisonMetric.fromJson(Map<String, dynamic> json) => _$ComparisonMetricFromJson(json);

@override final  String metricName;
@override final  double currentValue;
@override final  double compareValue;
@override final  String compareLabel;
@override final  ComparisonType type;

/// Create a copy of ComparisonMetric
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ComparisonMetricCopyWith<_ComparisonMetric> get copyWith => __$ComparisonMetricCopyWithImpl<_ComparisonMetric>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ComparisonMetricToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ComparisonMetric&&(identical(other.metricName, metricName) || other.metricName == metricName)&&(identical(other.currentValue, currentValue) || other.currentValue == currentValue)&&(identical(other.compareValue, compareValue) || other.compareValue == compareValue)&&(identical(other.compareLabel, compareLabel) || other.compareLabel == compareLabel)&&(identical(other.type, type) || other.type == type));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,metricName,currentValue,compareValue,compareLabel,type);

@override
String toString() {
  return 'ComparisonMetric(metricName: $metricName, currentValue: $currentValue, compareValue: $compareValue, compareLabel: $compareLabel, type: $type)';
}


}

/// @nodoc
abstract mixin class _$ComparisonMetricCopyWith<$Res> implements $ComparisonMetricCopyWith<$Res> {
  factory _$ComparisonMetricCopyWith(_ComparisonMetric value, $Res Function(_ComparisonMetric) _then) = __$ComparisonMetricCopyWithImpl;
@override @useResult
$Res call({
 String metricName, double currentValue, double compareValue, String compareLabel, ComparisonType type
});




}
/// @nodoc
class __$ComparisonMetricCopyWithImpl<$Res>
    implements _$ComparisonMetricCopyWith<$Res> {
  __$ComparisonMetricCopyWithImpl(this._self, this._then);

  final _ComparisonMetric _self;
  final $Res Function(_ComparisonMetric) _then;

/// Create a copy of ComparisonMetric
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? metricName = null,Object? currentValue = null,Object? compareValue = null,Object? compareLabel = null,Object? type = null,}) {
  return _then(_ComparisonMetric(
metricName: null == metricName ? _self.metricName : metricName // ignore: cast_nullable_to_non_nullable
as String,currentValue: null == currentValue ? _self.currentValue : currentValue // ignore: cast_nullable_to_non_nullable
as double,compareValue: null == compareValue ? _self.compareValue : compareValue // ignore: cast_nullable_to_non_nullable
as double,compareLabel: null == compareLabel ? _self.compareLabel : compareLabel // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as ComparisonType,
  ));
}


}

// dart format on
