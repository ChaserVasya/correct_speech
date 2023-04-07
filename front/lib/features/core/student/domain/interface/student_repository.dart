import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

abstract class StudentRepository {
  Future<List<RegisteredPerson>> getAll();

  Stream<List<RegisteredPerson>> streamAll();

  Future<RegisteredPerson?> getById(int id);

  Future<RegisteredPerson> add(Person student);

  Future<void> delete(RegisteredPerson student);
}
