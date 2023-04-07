import 'package:correct_speech/features/core/student/data/entry/student_entry.dart';
import 'package:floor/floor.dart';

@dao
abstract class StudentDao {
  @Query('SELECT * FROM Students')
  Future<List<StudentEntry>> getAllStudents();

  @Query('SELECT * FROM Students')
  Stream<List<StudentEntry>> streamAllStudents();

  @Query('SELECT * FROM Students WHERE id = :id')
  Future<StudentEntry?> getStudent(int id);

  @insert
  Future<void> insertStudent(StudentEntry student);

  @update
  Future<void> updateStudent(StudentEntry student);

  @delete
  Future<void> deleteStudent(StudentEntry student);
}
