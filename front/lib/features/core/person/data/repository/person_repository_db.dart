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
  final PersonMapper _mapper;

  const PersonRepositoryDb(
    this._personDao,
    this._relatedPersonsDao,
    this._mapper,
  );

  @override
  Future<Set<RegisteredPerson>> getAll() async {
    final personTable = await _personDao.getAllPersons();
    return personTable.map(_mapper.toDomain).toSet();
  }

  @override
  Future<RegisteredPerson> register(Person person) async {
    final entry = _mapper.toEntry(person);
    final id = await _personDao.insertPerson(entry);
    return person.addId(id);
  }

  @override
  Future<void> link(Registered person1, Registered person2) async {
    final junctionTable = _mapper.toJunctionEntries(person1, person2);
    await _relatedPersonsDao.insertRelatedPersons(junctionTable);
  }

  @override
  Future<Set<RegisteredPerson>> getRelatedToPerson(Registered person) async {
    final relatedPersonsTable = await _relatedPersonsDao.getRelatedToPerson(person.id);
    if (relatedPersonsTable.isEmpty) return {};
    final relatedPersonIds = relatedPersonsTable.map((entry) => entry.id2).toList();
    final personTable = await _personDao.getPersonsByIds(relatedPersonIds);
    return personTable.map(_mapper.toDomain).toSet();
  }

  @override
  Future<void> unlink(Registered person1, Registered person2) async {
    final linkedPersonsTable = _mapper.toJunctionEntries(person1, person2);
    await _relatedPersonsDao.deleteRelatedPersons(linkedPersonsTable);
  }

  @override
  Future<void> delete(RegisteredPerson person) async {
    final personEntry = _mapper.toEntry(person);
    await _personDao.deletePerson(personEntry);
  }

  @override
  Future<void> update(RegisteredPerson person) async {
    final personEntry = _mapper.toEntry(person);
    await _personDao.updatePerson(personEntry);
  }

  @override
  Future<RegisteredPerson?> getById(int id) async {
    final entry = await _personDao.getPersonById(id);
    if (entry == null) return null;
    return _mapper.toDomain(entry);
  }

  @override
  Future<Set<RegisteredPerson>> getByIds(List<int> ids) async {
    final table = await _personDao.getPersonsByIds(ids);
    return table.map(_mapper.toDomain).toSet();
  }
}
