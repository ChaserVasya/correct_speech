import 'package:floor/floor.dart';

abstract class PersonEntry {
  @PrimaryKey(autoGenerate: true)
  final int? id;

  final String name;
  final String surname;
  final String? phone;

  String get fullName => '$name $surname';

  const PersonEntry({
    required this.id,
    required this.name,
    required this.surname,
    this.phone,
  });
}
