class Person {
  final int id;

  final String name;
  final String surname;
  String get fullName => '$name $surname';

  final String? phone;

  final List<Person> relatedPersons;

  const Person({
    required this.id,
    required this.name,
    required this.surname,
    required this.phone,
    this.relatedPersons = const [],
  });
}
