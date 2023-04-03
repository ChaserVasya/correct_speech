import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/infrastructure/helper/nullable.dart';

extension PersonCopy on Person {
  Person copy({
    String? name,
    String? surname,
    Nullable<String>? phone,
    Sex? sex,
  }) {
    return Person(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      sex: sex ?? this.sex,
      phone: (phone == null) ? this.phone : phone.value,
    );
  }
}

extension RegisteredPersonCopy on RegisteredPerson {
  RegisteredPerson copy({
    String? name,
    String? surname,
    Nullable<String>? phone,
    Sex? sex,
    int? id,
  }) {
    return RegisteredPerson(
      name: name ?? this.name,
      surname: surname ?? this.surname,
      sex: sex ?? this.sex,
      phone: (phone == null) ? this.phone : phone.value,
      id: id ?? this.id,
    );
  }
}
