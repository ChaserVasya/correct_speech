import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/video/domain/model/student_video.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';

abstract class StudentVideoRepository {
  Future<List<StudentVideo>> getStudentVideos(int studentId);

  Future<void> importVideos(List<Video> video, RegisteredPerson student);
}
