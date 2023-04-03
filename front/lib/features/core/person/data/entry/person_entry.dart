import 'package:floor/floor.dart';

@Entity(tableName: 'Persons')
class PersonEntry {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final String surname;
  final String? phone;

  final int sexCode;

  String get fullName => '$name $surname';

  const PersonEntry({
    required this.id,
    required this.name,
    required this.surname,
    required this.sexCode,
    this.phone,
  });
}
