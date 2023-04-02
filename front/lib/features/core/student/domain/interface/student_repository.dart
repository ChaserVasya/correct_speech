import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

abstract class StudentRepository {
  Future<List<RegisteredPerson>> getAll();

  Future<void> add(RegisteredPerson student);

  Future<void> delete(RegisteredPerson student);
}
