import 'package:correct_speech/features/video_comment/data/entry/video_comment_entry.dart';
import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';

class VideoCommentMapper {
  VideoComment toDomain(VideoCommentEntry entry) {
    return VideoComment(
      videoId: entry.videoId,
      comment: entry.comment,
    );
  }

  VideoCommentEntry toEntry(VideoComment domain) {
    return VideoCommentEntry(
      id: domain.id,
      videoId: domain.videoId,
      comment: domain.comment,
    );
  }
}
