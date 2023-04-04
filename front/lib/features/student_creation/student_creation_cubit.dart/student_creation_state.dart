import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

abstract class BlocState {}

class BlocStateTryUndoStudentCreation extends BlocState {}

class BlocStateStudentCreated extends BlocState {
  final RegisteredPerson student;

  BlocStateStudentCreated(this.student);
}
