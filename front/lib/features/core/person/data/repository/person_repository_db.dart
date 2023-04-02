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
    return personTable.map(_personMapper.fromEntry).toList();
  }

  @override
  Future<RegisteredPerson> registerPerson({
    required Person person,
    required Iterable<Registered> relatedPersons,
  }) async {
    final entry = _personMapper.toEntry(person);
    final id = await _personDao.insertPerson(entry);
    final registeredPerson = person.addId(id);

    final junctionTable = _personMapper.toJunctionEntries(registeredPerson, relatedPersons);
    await _relatedPersonsDao.insertRelatedPersons(junctionTable);

    return registeredPerson;
  }
}
