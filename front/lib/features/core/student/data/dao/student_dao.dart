import 'package:correct_speech/features/core/student/export.dart';
import 'package:floor/floor.dart';

@dao
abstract class StudentDao {
  @Query('SELECT * FROM Student')
  Future<List<Student>> getAllStudents();

  @insert
  Future<void> addStudent(Student student);

  @update
  Future<void> updateStudent(Student student);

  @delete
  Future<void> deleteStudent(Student student);
}
