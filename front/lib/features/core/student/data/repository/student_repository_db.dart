import 'package:correct_speech/features/core/student/data/dao/person_dao.dart';
import 'package:correct_speech/features/core/student/export.dart';

class StudentRepositoryDB implements StudentRepository {
  final StudentDao _studentDao;
  final PersonDao _personDao;
  final PersonMapper _personMapper;

  const StudentRepositoryDB(
    StudentDao studentDao,
    PersonDao personDao,
    PersonMapper personMapper,
  )   : _studentDao = studentDao,
        _personDao = personDao,
        _studentMapper = studentMapper,
        _personMapper = personMapper;

  @override
  Future<List<Student>> getAll() async {
    final studentEntries = await _studentDao.getAllStudents();
    final personEntries = await _personDao.getAllPersons();
    return _studentMapper.fromEntries(studentEntries, personEntries).toList();
  }

  @override
  Future<void> add(Student student) async {
    await _studentDao.insertStudent(_studentMapper.toEntry(student));
    for (final person in student.contacts) {
      await _personDao.insertPerson(_personMapper.toEntry(person));
    }
  }

  @override
  Future<void> update(Student student) async {
    await _studentDao.updateStudent(_studentMapper.toEntry(student));
  }

  @override
  Future<void> delete(Student student) async {
    await _studentDao.deleteStudent(_studentMapper.toEntry(student));
  }
}
