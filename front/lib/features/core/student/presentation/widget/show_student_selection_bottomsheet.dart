import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/domain/interface/student_repository.dart';
import 'package:correct_speech/uikit/bottomsheet/selection_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

Future<RegisteredPerson?> showStudentSelectionBottomsheet(BuildContext context) async {
  final studentRepository = Injector.appInstance.get<StudentRepository>();
  final students = await studentRepository.getAll();
  if (context.mounted) {
    return showSelectionBottomsheet(
      context: context,
      items: students.toList(),
      createTitle: (student) => student.fullName,
    );
  }
  return null;
}
