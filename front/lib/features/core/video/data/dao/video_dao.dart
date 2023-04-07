import 'package:correct_speech/features/core/video/data/entry/video_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class VideoDao {
  @Query('SELECT * FROM Videos WHERE authorId = :authorId')
  Future<List<VideoEntry>> getVideosByAuthor(int authorId);

  @Query('SELECT * FROM Videos WHERE authorId = :authorId')
  Stream<List<VideoEntry>> streamVideosByAuthor(int authorId);

  @Query('SELECT * FROM Videos WHERE id = :id')
  Future<VideoEntry?> getVideoById(int id);

  @insert
  Future<int> insertVideo(VideoEntry video);

  @update
  Future<void> updateVideo(VideoEntry video);

  @delete
  Future<void> deleteVideo(VideoEntry video);
}
