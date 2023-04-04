import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/data/dao/student_dao.dart';
import 'package:correct_speech/features/core/student/data/mapper/student_mapper.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';

class StudentRepositoryDB implements StudentRepository {
  final StudentDao _studentDao;
  final StudentMapper _studentMapper;
  final PersonRepository _personRepository;

  const StudentRepositoryDB(
    this._studentDao,
    this._studentMapper,
    this._personRepository,
  );

  //TODO Change to JOIN query
  @override
  Future<Set<RegisteredPerson>> getAll() async {
    final studentsTable = await _studentDao.getAllStudents();
    final studentsIds = studentsTable.map((entry) => entry.personId).toList();
    return await _personRepository.getByIds(studentsIds);
  }

  @override
  Future<RegisteredPerson> add(Person student) async {
    final registeredStudent = await _personRepository.register(student);
    final entry = _studentMapper.toEntry(registeredStudent);
    await _studentDao.insertStudent(entry);
    return registeredStudent;
  }

  @override
  Future<void> delete(RegisteredPerson student) async {
    _personRepository.delete(student);
  }

  @override
  Future<RegisteredPerson?> getById(int id) async {
    final studentEntry = await _studentDao.getStudent(id);
    if (studentEntry == null) return null;
    return await _personRepository.getById(studentEntry.personId);
  }

  @override
  Future<void> update(RegisteredPerson student) async {
    await _personRepository.update(student);
  }
}
