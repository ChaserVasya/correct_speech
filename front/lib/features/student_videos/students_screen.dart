import 'package:correct_speech/features/core/student/presentation/students_list/students_list.dart';
import 'package:correct_speech/features/student_videos/student_videos_screen.dart';
import 'package:flutter/material.dart';

class StudentOnVideoSelectionScreen extends StatelessWidget {
  const StudentOnVideoSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StudentsList(
      onStudentTap: (student) => Navigator.of(context).push(
        MaterialPageRoute(
          builder: (_) => StudentVideosScreen(student),
        ),
      ),
    );
  }
}
