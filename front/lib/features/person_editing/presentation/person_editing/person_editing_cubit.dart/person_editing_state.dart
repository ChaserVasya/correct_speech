import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

typedef BlocStateConstructor<T extends BlocState> = T Function({
  required RegisteredPerson person,
});

abstract class BlocState {
  final RegisteredPerson person;

  BlocState({
    required this.person,
  });

  T copyWith<T extends BlocState>(
    BlocStateConstructor<T> constructor, {
    RegisteredPerson? person,
  }) {
    return constructor(
      person: person ?? this.person,
    );
  }
}

abstract class BlocStateBuild extends BlocState {
  BlocStateBuild({required super.person});
}

class BlocStateLoading extends BlocStateBuild {
  BlocStateLoading({required super.person});
}

class BlocStateMain extends BlocStateBuild {
  BlocStateMain({required super.person});
}

abstract class BlocStateListen extends BlocState {
  BlocStateListen({required super.person});
}

class BlocStateConfirmPersonDeletion extends BlocStateListen {
  BlocStateConfirmPersonDeletion({required super.person});
}

class BlocStatePersonDeleted extends BlocStateListen {
  BlocStatePersonDeleted({required super.person});
}
