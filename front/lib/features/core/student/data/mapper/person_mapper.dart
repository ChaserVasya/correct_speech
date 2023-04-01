import 'package:correct_speech/features/core/export.dart';

class PersonMapper {
  Iterable<Student> fromEntries(
    Iterable<StudentEntry> studentEntries,
    Iterable<PersonEntry> personEntries,
  ) {
    final studentById = {
      for (final studentEntry in studentEntries)
        studentEntry.id!: Student(
          id: studentEntry.id!,
          name: studentEntry.name,
          surname: studentEntry.surname,
          phone: studentEntry.phone,
          contacts: [],
        )
    };

    for (final personEntry in personEntries) {
      final student = studentById[personEntry.childId]!;
      final person = Person(
        child: student,
        id: personEntry.id!,
        name: personEntry.name,
        surname: personEntry.surname,
        phone: personEntry.phone,
      );
      student.contacts.add(person);
    }

    return studentById.values;
  }

  StudentEntry toEntry(Student student) {
    return StudentEntry(
      id: student.id,
      name: student.name,
      surname: student.surname,
      phone: student.phone,
    );
  }
}
