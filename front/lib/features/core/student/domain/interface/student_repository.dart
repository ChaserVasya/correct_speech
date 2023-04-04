import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

abstract class StudentRepository {
  Future<Iterable<RegisteredPerson>> getAll();

  Future<RegisteredPerson?> getById(int id);

  Future<void> add(Registered student);

  Future<void> delete(RegisteredPerson student);
}
