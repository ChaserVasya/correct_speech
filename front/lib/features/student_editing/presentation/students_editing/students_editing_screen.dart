import 'package:correct_speech/features/student_editing/presentation/students_editing/students_editing_bloc.dart';
import 'package:correct_speech/features/student_editing/presentation/students_editing/widget/student_tile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class StudentsEditingScreen extends StatefulWidget {
  const StudentsEditingScreen({super.key});

  @override
  State<StudentsEditingScreen> createState() => _StudentsEditingScreenState();
}

class _StudentsEditingScreenState extends State<StudentsEditingScreen> {
  late final StudentsEditingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Injector.appInstance.get();
    _bloc.add(BlocEventInit());
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      builder: _buildState,
      listener: _listenState,
    );
  }

  Widget _buildState(BuildContext context, BlocState state) {
    if (state is BlocStateMain) {
      return _buildStateMain(state);
    } else if (state is BlocStateLoading) {
      return _buildStateLoading(state);
    } else {
      throw Exception();
    }
  }

  Widget _buildStateMain(BlocStateMain state) {
    return ListView.builder(
      itemBuilder: (_, i) {
        final student = state.students[i];
        return StudentTile(
          student,
          onTilePressed: () => _bloc.add(BlocEventOpenStudentScreen(student)),
          onDeletePressed: () => _bloc.add(BlocEventComfirmDeleteStudent(student)),
        );
      },
    );
  }

  Widget _buildStateLoading(BlocStateLoading state) {
    return const CircularProgressIndicator();
  }

  void _listenState(BuildContext context, BlocState state) async {
    if (state is BlocStateConfirmStudentDeletion) {
      final needDelete = await _showDialogConfirmStudentDeletion(context, state);
      _bloc.add(BlocEventDeleteStudent(state.removedStudent, needDelete));
    } else if (state is BlocStateOpenStudentScreen) {
      //TODO call student editing screen
    }
  }

  Future<bool?> _showDialogConfirmStudentDeletion(
    BuildContext context,
    BlocStateConfirmStudentDeletion state,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        content: Text('Удалить студента ${state.removedStudent.fullName}?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop<bool>(false),
            child: const Text('Отмена'),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop<bool>(true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
