import 'package:correct_speech/features/video_comment/data/entry/video_comment_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class VideoCommentDao {
  @Query('SELECT * FROM VideoComments WHERE authorId = :authorId')
  Future<List<VideoCommentEntry>> getVideoCommentsByAuthorId(int authorId);

  @Query('SELECT * FROM VideoComments WHERE videoId = :videoId')
  Future<List<VideoCommentEntry>> getVideoCommentsOfVideo(int videoId);

  @insert
  Future<void> insertVideoComment(VideoCommentEntry videoComment);

  @update
  Future<void> updateVideoComment(VideoCommentEntry videoComment);

  @Query('DELETE * FROM VideoComments WHERE id = :id')
  Future<void> deleteVideoCommentById(int id);
}
