class Student {
  final int id;

  final String name;
  final String surname;
  final String patronymic;
  String get fullName => '$name $surname $patronymic';

  const Student({
    required this.id,
    required this.name,
    required this.surname,
    required this.patronymic,
  });

  @override
  bool operator ==(Object other) {
    if (other is! Student) {
      return false;
    }

    return id == other.id;
  }

  @override
  int get hashCode => Object.hashAll([id]);
}
