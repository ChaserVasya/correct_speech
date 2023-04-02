import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered.dart';

class RegisteredPerson extends Person implements Registered {
  @override
  final int id;

  const RegisteredPerson({
    required this.id,
    required super.name,
    required super.surname,
    required super.phone,
  });
}
