import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';

@entity
class Student extends Equatable {
  @primaryKey
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
  List<Object?> get props => [
        id,
        name,
        surname,
        patronymic,
      ];
}
