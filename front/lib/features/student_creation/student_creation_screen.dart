import 'package:correct_speech/features/core/person/presentation/widget/person_form_field.dart';
import 'package:correct_speech/uikit/base_screen.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

import 'student_creation_cubit.dart/student_creation_cubit.dart';
import 'student_creation_cubit.dart/student_creation_state.dart';

class StudentCreationScreen extends StatefulWidget {
  const StudentCreationScreen({super.key});

  @override
  State<StudentCreationScreen> createState() => _StudentCreationScreenState();
}

class _StudentCreationScreenState extends State<StudentCreationScreen> {
  late final StudentCreationCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Injector.appInstance.get();
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Создание студента',
      child: BlocListener(
        bloc: _cubit,
        listener: _listenState,
        child: _buildContent(),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Widget _buildContent() {
    return Column(
      children: [
        PersonFormField(onComplete: _cubit.createStudent),
      ],
    );
  }

  void _listenState(BuildContext context, BlocState? state) async {
    final navigator = Navigator.of(context);

    if (state == null) {
      return;
    } else if (state is BlocStateTryUndoStudentCreation) {
      final undoStudentCreation = await _showPersonDeletingConfirmationDialog();
      if (undoStudentCreation == true) navigator.pop();
    } else if (state is BlocStateStudentCreated) {
      navigator.pop(state.student);
    }
  }

  Future<bool?> _showPersonDeletingConfirmationDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: const Text('Отменить создание студента?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Продолжить'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Отменить'),
          ),
        ],
      ),
    );
  }
}
