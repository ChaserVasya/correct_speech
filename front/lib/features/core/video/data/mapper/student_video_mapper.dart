import 'package:correct_speech/features/core/video/data/entry/student_video_entry.dart';
import 'package:correct_speech/features/core/video/domain/model/student_video.dart';

class StudentVideoMapper {
  StudentVideo fromEntry(StudentVideoEntry entry) {
    return StudentVideo(
      path: entry.path,
      studentId: entry.studentId,
    );
  }

  StudentVideoEntry toEntry(StudentVideo video) {
    return StudentVideoEntry(
      id: null,
      path: video.path,
      studentId: video.studentId,
    );
  }
}
