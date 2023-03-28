import 'package:correct_speech/features/core/export.dart';

class StudentRepository {
  Future<List<Student>> getAll();

  Future<void> add(Student student);

  Future<void> update(Student student);

  Future<void> delete(Student student);
}
