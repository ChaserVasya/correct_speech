import 'package:correct_speech/features/core/video/data/entry/video_entry.dart';
import 'package:floor/floor.dart';

@Entity(
  foreignKeys: [
    ForeignKey(
      childColumns: ['videoId'],
      parentColumns: ['id'],
      entity: VideoEntry,
      onDelete: ForeignKeyAction.cascade,
    ),
  ],
)
class VideoCommentEntry {
  @PrimaryKey(autoGenerate: true)
  final int? id;
  final int videoId;
  final String comment;

  const VideoCommentEntry({
    this.id,
    required this.videoId,
    required this.comment,
  });
}
