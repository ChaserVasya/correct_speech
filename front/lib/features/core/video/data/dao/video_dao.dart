import 'package:correct_speech/features/core/video/data/entry/video_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class VideoDao {
  @Query('SELECT * FROM Videos WHERE id = :id')
  Future<VideoEntry?> getVideoById(int id);

  @Query('SELECT * FROM Videos WHERE authorId = :authorId')
  Future<List<VideoEntry>> getVideosByAuthor(int authorId);

  @insert
  Future<int> insertVideo(VideoEntry video);

  @update
  Future<void> updateVideo(VideoEntry video);

  @Query('DELETE * FROM Videos WHERE id = :id')
  Future<void> deleteVideoById(int id);
}
