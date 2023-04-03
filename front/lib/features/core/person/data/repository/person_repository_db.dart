import 'package:correct_speech/features/core/person/data/dao/person_dao.dart';
import 'package:correct_speech/features/core/person/data/dao/related_persons_dao.dart';
import 'package:correct_speech/features/core/person/data/mapper/person_mapper.dart';
import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

class PersonRepositoryDb implements PersonRepository {
  final PersonDao _personDao;
  final RelatedPersonsDao _relatedPersonsDao;
  final PersonMapper _personMapper;

  const PersonRepositoryDb(
    this._personDao,
    this._relatedPersonsDao,
    this._personMapper,
  );

  @override
  Future<List<RegisteredPerson>> getAllPersons() async {
    final personTable = await _personDao.getAllPersons();
    return personTable.map(_personMapper.toDomain).toList();
  }

  @override
  Future<RegisteredPerson> registerPerson(Person person) async {
    final entry = _personMapper.toEntry(person);
    final id = await _personDao.insertPerson(entry);
    final registeredPerson = person.addId(id);

    return registeredPerson;
  }

  @override
  Future<void> linkPersons(Registered person1, Registered person2) async {
    final junctionTable = _personMapper.toJunctionEntries(person1, person2);
    await _relatedPersonsDao.insertRelatedPersons(junctionTable);
  }
}
