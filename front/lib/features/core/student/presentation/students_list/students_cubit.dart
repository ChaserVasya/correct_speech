import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsCubit extends Cubit<List<RegisteredPerson>?> {
  final StudentRepository _studentRepository;

  StudentsCubit(
    this._studentRepository,
  ) : super(null);

  Future<void> init() async {
    final students = await _studentRepository.getAll();
    emit(students.toList());
  }
}
