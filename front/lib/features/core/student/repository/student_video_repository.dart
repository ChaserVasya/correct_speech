import 'package:correct_speech/features/core/export.dart';

class StudentVideoRepository {
  Future<List<VideoInfo>> getAll(Student student) {}

  Future<void> moveToStudentFolder(Student student, VideoInfo videoInfo) {}
}
