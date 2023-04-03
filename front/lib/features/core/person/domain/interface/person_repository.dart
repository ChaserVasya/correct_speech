import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

abstract class PersonRepository {
  Future<List<RegisteredPerson>> getAllPersons();

  Future<RegisteredPerson> registerPerson(Person person);

  Future<void> linkPersons(Registered p1, Registered p2);
}
