import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:correct_speech/features/core/person/data/entry/related_persons_entry.dart';
import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

class PersonMapper {
  RegisteredPerson fromEntry(PersonEntry personEntry) {
    return RegisteredPerson(
      id: personEntry.id!,
      name: personEntry.name,
      surname: personEntry.surname,
      phone: personEntry.phone,
    );
  }

  PersonEntry toEntry(Person person) {
    return PersonEntry(
      id: null,
      name: person.name,
      surname: person.surname,
      phone: person.phone,
    );
  }

  List<RelatedPersonsEntry> toJunctionEntries(Registered person, Iterable<Registered> relatedPersons) {
    final relations = <RelatedPersonsEntry>[];
    for (final relatedPerson in relatedPersons) {
      relations.add(RelatedPersonsEntry(person.id, relatedPerson.id));
      relations.add(RelatedPersonsEntry(relatedPerson.id, person.id));
    }
    return relations;
  }
}
