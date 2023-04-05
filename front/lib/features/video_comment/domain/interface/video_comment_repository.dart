import 'package:correct_speech/features/video_comment/domain/model/video_comment.dart';

abstract class VideoCommentRepository {
  Future<List<VideoComment>> getCommentsOfVideo(int videoId);

  Future<void> addComment(VideoComment comment);

  Future<void> updateComment(VideoComment comment);

  Future<void> deleteComment(int commentId);
}
