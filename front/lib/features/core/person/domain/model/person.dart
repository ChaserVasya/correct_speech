import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';

class Person {
  final String name;
  final String surname;
  String get fullName => '$name $surname';

  final String? phone;

  const Person({
    required this.name,
    required this.surname,
    required this.phone,
  });

  RegisteredPerson addId(int id) {
    return RegisteredPerson(
      id: id,
      name: name,
      surname: surname,
      phone: phone,
    );
  }
}
