import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/student/presentation/students_list/students_list.dart';
import 'package:correct_speech/features/person_screen/person_editing/person_editing_screen.dart';
import 'package:correct_speech/features/student_creation/student_creation_screen.dart';
import 'package:correct_speech/uikit/base_screen.dart';
import 'package:flutter/material.dart';

class StudentsInfoScreen extends StatelessWidget {
  const StudentsInfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Студенты',
      child: _buildContent(context),
    );
  }

  Widget _buildContent(BuildContext context) {
    return Column(
      children: [
        Flexible(
          child: StudentsList(
            onStudentTap: (person) => _openStudentEditingScreen(context, person),
          ),
        ),
        ElevatedButton(
          onPressed: () => _openStudentCreationScreen(context),
          child: const Text('Создать ученика'),
        ),
      ],
    );
  }

  void _openStudentEditingScreen(BuildContext context, RegisteredPerson person) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PersonEditingScreen(person),
      ),
    );
  }

  void _openStudentCreationScreen(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => const StudentCreationScreen(),
      ),
    );
  }
}
