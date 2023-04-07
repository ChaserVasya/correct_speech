import 'package:correct_speech/features/core/person/data/dao/person_dao.dart';
import 'package:correct_speech/features/core/person/data/dao/related_persons_dao.dart';
import 'package:correct_speech/features/core/person/data/entry/person_entry.dart';
import 'package:correct_speech/features/core/person/data/entry/related_persons_entry.dart';
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
  Future<List<RegisteredPerson>> getAll() async {
    final table = await _personDao.getAllPersons();
    return _mapPersonsTableToDomain(table);
  }

  @override
  Stream<List<RegisteredPerson>> streamAll() async* {
    final personsStream = _personDao.streamAllPersons();
    yield* personsStream.map(_mapPersonsTableToDomain);
  }

  @override
  Future<List<RegisteredPerson>> getRelatedToPerson(Registered person) async {
    final relatedPersonsTable = await _relatedPersonsDao.getRelatedToPerson(person.id);
    return _mapRelatedPersonsTableToDomain(relatedPersonsTable);
  }

  @override
  Stream<List<RegisteredPerson>> streamRelatedToPerson(Registered person) async* {
    final relatedPersonsStream = _relatedPersonsDao.streamRelatedToPerson(person.id);
    yield* relatedPersonsStream.asyncMap(_mapRelatedPersonsTableToDomain);
  }

  @override
  Future<List<RegisteredPerson>> getByIds(List<int> ids) async {
    final table = await _personDao.getPersonsByIds(ids);
    return _mapPersonsTableToDomain(table);
  }

  @override
  Stream<List<RegisteredPerson>> streamByIds(List<int> ids) async* {
    final personsTableStream = _personDao.streamPersonsByIds(ids);
    yield* personsTableStream.map(_mapPersonsTableToDomain);
  }

  @override
  Future<RegisteredPerson?> getById(int id) async {
    final entry = await _personDao.getPersonById(id);
    if (entry == null) return null;
    return _mapper.toDomain(entry);
  }

  List<RegisteredPerson> _mapPersonsTableToDomain(List<PersonEntry> table) {
    return table.map(_mapper.toDomain).toList();
  }

  Future<List<RegisteredPerson>> _mapRelatedPersonsTableToDomain(List<RelatedPersonsEntry> relatedPersonsTable) async {
    if (relatedPersonsTable.isEmpty) return [];
    final relatedPersonIds = relatedPersonsTable.map((entry) => entry.id2).toList();
    final personsTable = await _personDao.getPersonsByIds(relatedPersonIds);
    return _mapPersonsTableToDomain(personsTable);
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
}
