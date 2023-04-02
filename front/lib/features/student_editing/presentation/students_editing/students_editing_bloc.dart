import 'dart:async';

import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

//TODO add loading state before async operations if needed
class StudentsEditingBloc extends Bloc<BlocEvent, BlocState> {
  final StudentRepository _studentRepository;

  StudentsEditingBloc(
    this._studentRepository,
  ) : super(BlocStateLoading()) {
    on(_eventInit);
    on(_eventAddStudent);
    on(_eventConfirmDeleteStudent);
    on(_eventDeleteStudent);
    on(_eventOpenStudentScreen);
  }

  FutureOr<void> _eventInit(
    BlocEventInit event,
    Emitter<BlocState> emit,
  ) async {
    emit(BlocStateLoading());
  }

  FutureOr<void> _eventAddStudent(
    BlocEventAddStudent event,
    Emitter<BlocState> emit,
  ) {
    emit(BlocStateOpenStudentScreen());
  }

  FutureOr<void> _eventConfirmDeleteStudent(
    BlocEventComfirmDeleteStudent event,
    Emitter<BlocState> emit,
  ) {
    emit(BlocStateConfirmStudentDeletion(event.removedStudent));
  }

  FutureOr<void> _eventDeleteStudent(
    BlocEventDeleteStudent event,
    Emitter<BlocState> emit,
  ) async {
    await _studentRepository.delete(event.studentForDeletion);
    await _refreshAndEmit(emit);
  }

  FutureOr<void> _eventOpenStudentScreen(
    BlocEventOpenStudentScreen event,
    Emitter<BlocState> emit,
  ) {
    emit(BlocStateOpenStudentScreen());
  }

  Future<void> _refreshAndEmit(Emitter<BlocState> emit) async {
    //TODO for consistency. Optimize.
    final students = await _studentRepository.getAll();
    emit(BlocStateMain(students: students));
  }
}

abstract class BlocEvent {}

class BlocEventInit extends BlocEvent {}

class BlocEventAddStudent extends BlocEvent {}

class BlocEventComfirmDeleteStudent extends BlocEvent {
  final RegisteredPerson removedStudent;

  BlocEventComfirmDeleteStudent(this.removedStudent);
}

class BlocEventDeleteStudent extends BlocEvent {
  final RegisteredPerson studentForDeletion;
  final bool? needDelete;

  BlocEventDeleteStudent(this.studentForDeletion, this.needDelete);
}

class BlocEventOpenStudentScreen extends BlocEvent {
  final RegisteredPerson student;

  BlocEventOpenStudentScreen(this.student);
}

abstract class BlocState {}

class BlocStateLoading extends BlocState {}

class BlocStateMain extends BlocState {
  List<RegisteredPerson> students;

  BlocStateMain({this.students = const []});
}

class BlocStateOpenStudentScreen extends BlocState {}

class BlocStateConfirmStudentDeletion extends BlocState {
  RegisteredPerson removedStudent;

  BlocStateConfirmStudentDeletion(this.removedStudent);
}
