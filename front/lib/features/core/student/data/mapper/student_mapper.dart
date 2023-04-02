import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/data/entry/student_entry.dart';

class StudentMapper {
  StudentEntry toEntry(RegisteredPerson student) {
    return StudentEntry(student.id);
  }
}
