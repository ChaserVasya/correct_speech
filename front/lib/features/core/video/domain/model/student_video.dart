import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/video/domain/model/video.dart';

class StudentVideo extends Video {
  final int studentId;

  const StudentVideo({
    required super.path,
    required this.studentId,
  });

  static StudentVideo combine(Video video, RegisteredPerson student) {
    return StudentVideo(
      path: video.path,
      studentId: student.id,
    );
  }
}
