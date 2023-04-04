import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PersonCubit extends Cubit<BlocState> {
  final PersonRepository _personRepository;

  PersonCubit(this._personRepository) : super(BlocState.main);

  void tryDeletePerson(RegisteredPerson person) {
    emit(BlocState.confirmPersonDeleting);
  }

  Future<void> deletePerson(bool? shouldDeletePerson, RegisteredPerson person) async {
    if (shouldDeletePerson == null) return;
    if (!shouldDeletePerson) return;
    await _personRepository.delete(person);

    emit(BlocState.main);
  }
}

enum BlocState {
  main,
  confirmPersonDeleting,
}
