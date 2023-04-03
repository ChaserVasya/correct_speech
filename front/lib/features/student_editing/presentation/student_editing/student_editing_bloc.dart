import 'dart:async';

import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentEditingBloc extends Bloc<BlocEvent, BlocState> {
  final StudentRepository _studentRepository;

  StudentEditingBloc(
    this._studentRepository,
  ) : super(BlocStateLoading()) {
    on(_onEventInit);
    on(_onEventEditStudent);
    on(_onEventTryingDeleteStudent);
    on(_onEventDeleteStudent);
  }

  FutureOr<void> _onEventInit(BlocEventInit event, Emitter<BlocState> emit) {
    emit(BlocStateMain(event.student));
  }

  FutureOr<void> _onEventEditStudent(BlocEventEditStudent event, Emitter<BlocState> emit) async {
    await _studentRepository.update(event.editedStudent);
  }

  FutureOr<void> _onEventTryingDeleteStudent(BlocEventTryingDeleteStudent event, Emitter<BlocState> emit) {
    final state = this.state as BlocStateMain;
    emit(BlocStateConfirmStudentDeletion(state.student));
  }

  FutureOr<void> _onEventDeleteStudent(BlocEventDeleteStudent event, Emitter<BlocState> emit) async {
    await _studentRepository.delete(event.studentForDeletion);
    emit(BlocStateFinish());
  }
}

abstract class BlocEvent {}

class BlocEventInit extends BlocEvent {
  final RegisteredPerson student;

  BlocEventInit(this.student);
}

class BlocEventEditStudent extends BlocEvent {
  final RegisteredPerson editedStudent;

  BlocEventEditStudent(this.editedStudent);
}

class BlocEventTryingDeleteStudent extends BlocEvent {}

class BlocEventDeleteStudent extends BlocEvent {
  final RegisteredPerson studentForDeletion;

  BlocEventDeleteStudent(this.studentForDeletion);
}

abstract class BlocState {}

class BlocStateLoading extends BlocState {}

class BlocStateMain extends BlocState {
  final RegisteredPerson student;

  BlocStateMain(this.student);
}

class BlocStateConfirmStudentDeletion extends BlocState {
  final RegisteredPerson student;

  BlocStateConfirmStudentDeletion(this.student);
}

class BlocStateFinish extends BlocState {}
