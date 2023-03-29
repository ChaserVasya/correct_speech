import 'package:correct_speech/features/core/student/export.dart';
import 'package:injector/injector.dart';

class AppFolder {
  StudentFolder folderOf(Student student) {
    return StudentFolder(
      student: student,
      videoManager: Injector.appInstance.get(),
    );
  }
}
