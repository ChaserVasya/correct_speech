import 'package:correct_speech/features/core/export.dart';

class StudentFolderRepository {
  String getStudentFolder(Student student) {
    return '${student.fullName} ${student.id}';
  }
}
