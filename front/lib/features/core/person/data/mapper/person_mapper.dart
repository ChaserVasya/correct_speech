import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:correct_speech/features/core/person/data/entry/related_persons_entry.dart';
import 'package:correct_speech/features/core/person/data/mapper/sex_mapper.dart';
import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

class PersonMapper {
  final SexMapper _sexMapper;

  const PersonMapper(this._sexMapper);

  RegisteredPerson toDomain(PersonEntry personEntry) {
    return RegisteredPerson(
      id: personEntry.id!,
      name: personEntry.name,
      surname: personEntry.surname,
      phone: personEntry.phone,
      sex: _sexMapper.toSex(personEntry.sexCode),
    );
  }

  PersonEntry toEntry(Person person) {
    return PersonEntry(
      id: (person is RegisteredPerson) ? person.id : null,
      name: person.name,
      surname: person.surname,
      phone: person.phone,
      sexCode: _sexMapper.toCode(person.sex),
    );
  }

  List<RelatedPersonsEntry> toJunctionEntries(Registered person1, Registered person2) {
    return [
      RelatedPersonsEntry(person1.id, person2.id),
      RelatedPersonsEntry(person2.id, person1.id),
    ];
  }
}
