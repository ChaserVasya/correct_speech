import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:flutter/material.dart';

class StudentTile extends StatelessWidget {
  final Person student;
  final void Function()? onTilePressed;
  final void Function()? onDeletePressed;

  const StudentTile(
    this.student, {
    super.key,
    required this.onTilePressed,
    required this.onDeletePressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(student.fullName),
      subtitle: student.phone != null ? Text(student.phone!) : null,
      trailing: _buildEditingButtons(),
      onTap: onTilePressed,
    );
  }

  Widget _buildEditingButtons() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: onDeletePressed,
    );
  }
}
