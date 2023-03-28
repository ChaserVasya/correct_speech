import 'dart:async';

import 'package:correct_speech/features/core/export.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentSelectionBloc extends Bloc<StudentSelectionEvent, StudentSelectionState> {
  final StudentRepository _studentRepository;

  StudentSelectionBloc(StudentRepository studentRepository)
      : _studentRepository = studentRepository,
        super(StudentSelectionStateInit()) {
    on(_onEventInit);
    on(_onEventStudentSelected);
  }

  FutureOr<void> _onEventInit(
    StudentSelectionEventInit event,
    Emitter<StudentSelectionState> emit,
  ) async {
    final students = await _studentRepository.getAll();
    emit(StudentSelectionStateMain(students: students));
  }

  FutureOr<void> _onEventStudentSelected(
    StudentSelectionEventStudentSelected event,
    Emitter<StudentSelectionState> emit,
  ) {
    final state = this.state as StudentSelectionStateMain;
    final selectedStudent = state.students[event.selectedStudentIndex];
    emit(StudentSelectionStateStudentSelected(selectedStudent));
  }
}

abstract class StudentSelectionEvent {}

class StudentSelectionEventInit extends StudentSelectionEvent {}

class StudentSelectionEventStudentSelected extends StudentSelectionEvent {
  final int selectedStudentIndex;

  StudentSelectionEventStudentSelected(this.selectedStudentIndex);
}

abstract class StudentSelectionState {}

class StudentSelectionStateInit extends StudentSelectionState {}

class StudentSelectionStateMain extends StudentSelectionState {
  final List<Student> students;

  StudentSelectionStateMain({required this.students});
}

class StudentSelectionStateStudentSelected extends StudentSelectionState {
  final Student selectedStudent;

  StudentSelectionStateStudentSelected(this.selectedStudent);
}
