import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';
import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/infrastructure/helper/nullable.dart';
import 'package:equatable/equatable.dart';

class RegisteredPerson extends Person with EquatableMixin implements Registered {
  @override
  final int id;

  const RegisteredPerson({
    required this.id,
    required super.name,
    required super.surname,
    required super.phone,
    required super.sex,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        surname,
        phone,
        sex,
      ];

  RegisteredPerson copyWith({
    int? id,
    String? name,
    String? surname,
    Nullable<String?>? phone,
    Sex? sex,
  }) {
    return RegisteredPerson(
      id: id ?? this.id,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      phone: (phone != null) ? phone.value : this.phone,
      sex: sex ?? this.sex,
    );
  }
}
