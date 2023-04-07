import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';

abstract class VideoRepository {
  Future<RegisteredVideo?> getVideo(int id);

  Future<List<RegisteredVideo>> getVideosByAuthor(int authorId);
  Stream<List<RegisteredVideo>> streamVideosByAuthor(int authorId);

  Future<RegisteredVideo> addVideo(Video video, Registered author);

  Future<void> updateVideo(RegisteredVideo video);

  Future<void> deleteVideo(RegisteredVideo video);
}
