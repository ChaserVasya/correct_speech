import 'dart:async';

import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'person_editing_state.dart';

class PersonEditingCubit extends Cubit<BlocState?> {
  final PersonRepository _personRepository;

  PersonEditingCubit(
    this._personRepository,
  ) : super(null);

  FutureOr<void> init(RegisteredPerson person) async {
    emit(BlocStateMain(person: person));
  }

  FutureOr<void> editPersonWith(RegisteredPerson editedPerson) async {
    await _personRepository.update(editedPerson);
    await _refreshState();
  }

  FutureOr<void> tryDeletePerson() {
    emit(state!.copyWith(BlocStateConfirmPersonDeletion.new));
  }

  FutureOr<void> deletePerson() async {
    emit(state!.copyWith(BlocStateLoading.new));
    await _personRepository.delete(state!.person);
    await _refreshState();
  }

  Future<void> _refreshState() async {
    final person = await _personRepository.getById(state!.person.id);
    emit(state!.copyWith(BlocStateMain.new, person: person!));
  }
}
