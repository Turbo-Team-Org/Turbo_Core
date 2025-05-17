import 'package:freezed_annotation/freezed_annotation.dart';

part 'schedule.freezed.dart';
part 'schedule.g.dart';

@freezed
class Schedule with _$Schedule {
  const factory Schedule({
    required String opening,
    required String closing,
    @Default(false) bool isFullDay,
    @Default('') String dayName,
  }) = _Schedule;

  const Schedule._();

  factory Schedule.fromJson(Map<String, dynamic> json) =>
      _$ScheduleFromJson(json);

  @override
  // TODO: implement closing
  String get closing => throw UnimplementedError();

  @override
  // TODO: implement dayName
  String get dayName => throw UnimplementedError();

  @override
  // TODO: implement isFullDay
  bool get isFullDay => throw UnimplementedError();

  @override
  // TODO: implement opening
  String get opening => throw UnimplementedError();

  @override
  Map<String, dynamic> toJson() {
    // TODO: implement toJson
    throw UnimplementedError();
  }
}
