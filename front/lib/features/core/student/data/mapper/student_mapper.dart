import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/student/data/entry/student_entry.dart';

class StudentMapper {
  StudentEntry toEntry(Registered student) {
    return StudentEntry(student.id);
  }
}
