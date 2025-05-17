import 'package:freezed_annotation/freezed_annotation.dart';
part 'feed.freezed.dart';
part 'feed.g.dart';

@Freezed()
sealed class Feed with _$Feed {
  const factory Feed({
    required int id,
    required String author,
    required String content,
    required String imageUrl,
    required DateTime timestamp,
  }) = _Feed;

  factory Feed.fromJson(Map<String, dynamic> json) => _$FeedFromJson(json);
}
