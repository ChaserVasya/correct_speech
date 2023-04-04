import 'dart:async';

import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonEditingBloc extends Bloc<BlocEvent, BlocState> {
  final StudentRepository _studentRepository;
  final PersonRepository _personRepository;

  PersonEditingBloc(
    this._studentRepository,
    this._personRepository,
  ) : super(BlocStateLoading()) {
    on(_onEventInit);

    on(_onEventEditStudent);

    on(_onEventTryingDeleteStudent);
    on(_onEventDeleteStudent);
  }

  FutureOr<void> _onEventInit(BlocEventInit event, Emitter<BlocState> emit) async {
    final student = event.student;
    final relatedPersons = await _personRepository.getRelatedToPerson(student);

    emit(BlocStateMain(
      person: student,
      relatedPersons: relatedPersons,
    ));
  }

  FutureOr<void> _onEventEditStudent(BlocEventEditPerson event, Emitter<BlocState> emit) async {
    await _personRepository.update(event.editedStudent);
  }

  FutureOr<void> _onEventTryingDeleteStudent(BlocEventTryingDeletePerson event, Emitter<BlocState> emit) {
    final state = this.state as BlocStateMain;
    emit(BlocStateConfirmPersonDeletion(state.person));
  }

  FutureOr<void> _onEventDeleteStudent(BlocEventDeletePerson event, Emitter<BlocState> emit) async {
    await _studentRepository.delete(event.studentForDeletion);
    emit(BlocStateFinish());
  }
}

abstract class BlocEvent {}

class BlocEventInit extends BlocEvent {
  final RegisteredPerson student;

  BlocEventInit(this.student);
}

class BlocEventEditPerson extends BlocEvent {
  final RegisteredPerson editedStudent;

  BlocEventEditPerson(this.editedStudent);
}

class BlocEventTryingDeletePerson extends BlocEvent {}

class BlocEventDeletePerson extends BlocEvent {
  final RegisteredPerson studentForDeletion;

  BlocEventDeletePerson(this.studentForDeletion);
}

abstract class BlocState {}

abstract class BlocStateBuild extends BlocState {}

class BlocStateLoading extends BlocStateBuild {}

class BlocStateMain extends BlocStateBuild {
  final RegisteredPerson person;
  final Iterable<RegisteredPerson> relatedPersons;

  BlocStateMain({required this.person, required this.relatedPersons});
}

abstract class BlocStateListen extends BlocState {}

class BlocStateConfirmPersonDeletion extends BlocStateListen {
  final RegisteredPerson student;

  BlocStateConfirmPersonDeletion(this.student);
}

class BlocStatePersonDeleted extends BlocStateListen {}
