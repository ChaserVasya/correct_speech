import 'dart:async';

import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'related_persons_state.dart';

class RelatedPersonsCubit extends Cubit<BlocState?> {
  final PersonRepository _personRepository;

  RelatedPersonsCubit(
    this._personRepository,
  ) : super(null);

  Future<void> init(RegisteredPerson person) async {
    final relatedPersons = await _personRepository.getRelatedToPerson(person);

    emit(BlocStateMain(
      currentPerson: person,
      relatedPersons: relatedPersons,
    ));
  }

  Future<void> removeRelatedPerson(RegisteredPerson relatedPerson) async {
    emit(state!.copyWith(BlocStateLoading.new));
    await _personRepository.unlink(relatedPerson, state!.currentPerson);
    await _refreshState();
  }

  void needAddRelatedPerson() {
    emit(state!.copyWith(BlocStateSelectPerson.new));
  }

  Future<void> addRelatedPerson(RegisteredPerson relatedPerson) async {
    await _personRepository.link(relatedPerson, state!.currentPerson);
    _refreshState();
  }

  Future<void> _refreshState() async {
    final relatedPersons = await _personRepository.getRelatedToPerson(state!.currentPerson);
    emit(state!.copyWith(BlocStateMain.new, relatedPersons: relatedPersons));
  }
}
