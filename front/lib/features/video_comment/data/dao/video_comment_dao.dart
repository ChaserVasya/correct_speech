import 'package:correct_speech/features/video_comment/data/entry/video_comment_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class VideoCommentDao {
  @Query('SELECT * FROM VideoComments WHERE videoId = :videoId')
  Future<List<VideoCommentEntry>> getVideoComments(int videoId);

  @Query('SELECT * FROM VideoComments WHERE videoId = :videoId')
  Stream<List<VideoCommentEntry>> streamVideoComments(int videoId);

  @insert
  Future<void> insertVideoComment(VideoCommentEntry videoComment);

  @update
  Future<void> updateVideoComment(VideoCommentEntry videoComment);

  @delete
  Future<void> deleteVideoComment(VideoCommentEntry videoComment);
}
