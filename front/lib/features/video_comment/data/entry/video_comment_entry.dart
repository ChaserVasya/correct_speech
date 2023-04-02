import 'package:floor/floor.dart';

@entity
class VideoCommentEntry {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final int authorId;
  final int videoId;

  final String comment;

  const VideoCommentEntry({
    this.id,
    required this.authorId,
    required this.videoId,
    required this.comment,
  });
}
