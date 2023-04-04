import 'dart:async';

import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'student_creation_state.dart';

class StudentCreationCubit extends Cubit<BlocState?> {
  final StudentRepository _studentRepository;

  StudentCreationCubit(
    this._studentRepository,
  ) : super(null);

  Future<void> tryUndoStudentDeletion() async {
    emit(BlocStateTryUndoStudentCreation());
  }

  Future<void> createStudent(Person student) async {
    final registeredStudent = await _studentRepository.add(student);
    emit(BlocStateStudentCreated(registeredStudent));
  }
}
