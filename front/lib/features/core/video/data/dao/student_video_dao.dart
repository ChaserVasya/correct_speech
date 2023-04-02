import 'package:correct_speech/features/core/video/data/entry/student_video_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class StudentVideoDao {
  @Query('SELECT * WHERE id = :videoId')
  Future<StudentVideoEntry> getStudentVideo(int videoId);

  @Query('SELECT * WHERE studentId = :studentId')
  Future<List<StudentVideoEntry>> getStudentVideos(int studentId);

  @insert
  Future<void> insertStudentVideo(StudentVideoEntry video);

  @update
  Future<void> updateStudentVideo(StudentVideoEntry video);

  //TODO check how to delete
  @delete
  Future<void> deleteStudentVideo(StudentVideoEntry video);
}
