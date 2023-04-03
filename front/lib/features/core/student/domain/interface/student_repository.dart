import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

abstract class StudentRepository {
  Future<List<RegisteredPerson>> getAll();

  Future<RegisteredPerson?> getById(int id);

  Future<void> add(RegisteredPerson student);

  Future<void> delete(RegisteredPerson student);

  Future<void> update(RegisteredPerson student);
}
