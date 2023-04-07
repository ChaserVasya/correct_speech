import 'dart:async';

import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class StudentsCubit extends Cubit<List<RegisteredPerson>?> {
  final StudentRepository _studentRepository;

  StudentsCubit(
    this._studentRepository,
  ) : super(null);

  StreamSubscription? _subscription;

  Future<void> init() async {
    _subscription = _studentRepository.streamAll().listen((students) {
      emit(students);
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}
