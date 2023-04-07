import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/video/domain/model/registered_video.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';

abstract class StudentVideoRepository {
  Future<List<RegisteredVideo>> getStudentVideos(int studentId);
  Stream<List<RegisteredVideo>> streamStudentVideos(int studentId);

  Future<void> importVideos(Iterable<Video> video, RegisteredPerson student);
}
