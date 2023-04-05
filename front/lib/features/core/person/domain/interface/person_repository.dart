import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

abstract class PersonRepository {
  Future<List<RegisteredPerson>> getAll();

  Future<RegisteredPerson?> getById(int id);

  Future<List<RegisteredPerson>> getByIds(List<int> ids);

  Future<RegisteredPerson> register(Person person);

  Future<void> delete(RegisteredPerson person);

  Future<List<RegisteredPerson>> getRelatedToPerson(Registered person);

  Future<void> link(Registered person1, Registered person2);

  Future<void> unlink(Registered person1, Registered person2);

  Future<void> update(RegisteredPerson person);
}
