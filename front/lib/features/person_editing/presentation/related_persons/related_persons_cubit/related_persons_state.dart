import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

typedef BlocStateConstructor<T extends BlocState> = T Function({
  required RegisteredPerson currentPerson,
  required Set<RegisteredPerson> relatedPersons,
});

abstract class BlocState {
  final RegisteredPerson currentPerson;
  final Set<RegisteredPerson> relatedPersons;

  BlocState({
    required this.currentPerson,
    required this.relatedPersons,
  });

  T copyWith<T extends BlocState>(
    BlocStateConstructor<T> constructor, {
    RegisteredPerson? currentPerson,
    Set<RegisteredPerson>? relatedPersons,
  }) {
    return constructor(
      currentPerson: currentPerson ?? this.currentPerson,
      relatedPersons: relatedPersons ?? this.relatedPersons,
    );
  }
}

abstract class BlocStateBuild extends BlocState {
  BlocStateBuild({required super.currentPerson, required super.relatedPersons});
}

class BlocStateMain extends BlocStateBuild {
  BlocStateMain({required super.currentPerson, required super.relatedPersons});
}

class BlocStateLoading extends BlocStateBuild {
  BlocStateLoading({required super.currentPerson, required super.relatedPersons});
}

abstract class BlocStateListen extends BlocState {
  BlocStateListen({required super.currentPerson, required super.relatedPersons});
}

class BlocStateSelectPerson extends BlocStateListen {
  BlocStateSelectPerson({required super.currentPerson, required super.relatedPersons});
}
