import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/person/domain/model/sex.dart';

class Person {
  final String name;
  final String surname;
  String get fullName => '$name $surname';

  final Sex sex;

  final String? phone;

  const Person({
    required this.name,
    required this.surname,
    required this.phone,
    required this.sex,
  });

  RegisteredPerson addId(int id) {
    return RegisteredPerson(
      id: id,
      name: name,
      surname: surname,
      phone: phone,
      sex: sex,
    );
  }
}
