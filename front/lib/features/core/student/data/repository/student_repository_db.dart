import 'package:correct_speech/features/core/person/data/dao/person_dao.dart';
import 'package:correct_speech/features/core/person/data/mapper/person_mapper.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/data/dao/student_dao.dart';
import 'package:correct_speech/features/core/student/data/mapper/student_mapper.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';

class StudentRepositoryDB implements StudentRepository {
  final StudentDao _studentDao;
  final PersonDao _personDao;
  final PersonMapper _personMapper;
  final StudentMapper _studentMapper;

  const StudentRepositoryDB(
    this._studentDao,
    this._personDao,
    this._personMapper,
    this._studentMapper,
  );

  //TODO Change to JOIN query
  @override
  Future<Iterable<RegisteredPerson>> getAll() async {
    final studentsTable = await _studentDao.getAllStudents();
    final studentsIds = studentsTable.map((entry) => entry.personId).toList();
    final personsTable = await _personDao.getPersonsByIds(studentsIds);
    return personsTable.map(_personMapper.toDomain);
  }

  @override
  Future<void> add(Registered student) async {
    final entry = _studentMapper.toEntry(student);
    await _studentDao.insertStudent(entry);
  }

  @override
  Future<void> delete(RegisteredPerson student) async {
    final entry = _personMapper.toEntry(student);
    await _personDao.deletePerson(entry);
  }

  @override
  Future<RegisteredPerson?> getById(int id) async {
    final studentEntry = await _studentDao.getStudent(id);
    if (studentEntry == null) return null;
    final personEntry = await _personDao.getPersonById(studentEntry.personId);
    return _personMapper.toDomain(personEntry!);
  }

  @override
  Future<void> update(RegisteredPerson student) async {
    final entry = _personMapper.toEntry(student);
    await _personDao.updatePerson(entry);
  }
}
