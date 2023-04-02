import 'package:correct_speech/features/video_comment/data/entry/video_comment_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class VideoCommentDao {
  @Query('SELECT * FROM videoComments WHERE authorId = :authorId')
  Future<List<VideoCommentEntry>> selectVideoCommentsByAuthorId(int authorId);

  @insert
  Future<void> insertVideoComment(VideoCommentEntry videoComment);

  @update
  Future<void> updateVideoComment(VideoCommentEntry videoComment);

  @delete
  Future<void> deleteVideoComment(VideoCommentEntry videoComment);
}
