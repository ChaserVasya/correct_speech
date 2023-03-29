import 'package:correct_speech/features/core/student/export.dart';

class StudentRepositoryDB implements StudentRepository {
  final StudentDao _studentDao;

  StudentRepositoryDB(StudentDao studentDao) : _studentDao = studentDao;

  @override
  Future<List<Student>> getAll() => _studentDao.getAllStudents();

  @override
  Future<void> add(Student student) => _studentDao.addStudent(student);

  @override
  Future<void> update(Student student) => _studentDao.updateStudent(student);

  @override
  Future<void> delete(Student student) => _studentDao.deleteStudent(student);
}
