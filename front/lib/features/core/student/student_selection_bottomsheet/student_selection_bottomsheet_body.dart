import 'package:correct_speech/features/core/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

Future<Student?> showStudentSelectionBottomsheet(BuildContext context) {
  return showModalBottomSheet<Student>(
    context: context,
    builder: (_) => const StudentSelectionBottomsheetBody(),
  );
}

class StudentSelectionBottomsheetBody extends StatefulWidget {
  const StudentSelectionBottomsheetBody({super.key});

  @override
  State<StudentSelectionBottomsheetBody> createState() => _StudentSelectionBottomsheetBodyState();
}

class _StudentSelectionBottomsheetBodyState extends State<StudentSelectionBottomsheetBody> {
  late final StudentSelectionBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Injector.appInstance.get<StudentSelectionBloc>();
  }

  @override
  void dispose() async {
    await _bloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: Injector.appInstance.get<StudentSelectionBloc>(),
      builder: _buildState,
      listener: (context, state) {
        if (state is StudentSelectionStateStudentSelected) {
          Navigator.of(context).pop(state.selectedStudent);
        }
      },
    );
  }

  Widget _buildState(BuildContext context, StudentSelectionState state) {
    if (state is StudentSelectionStateInit) {
      return _buildStateInit();
    } else if (state is StudentSelectionStateMain) {
      return _buildStateMain(state);
    } else {
      //TODO do exception system
      throw Exception();
    }
  }

  Widget _buildStateInit() {
    return const CircularProgressIndicator();
  }

  Widget _buildStateMain(StudentSelectionStateMain state) {
    final students = state.students;
    return Column(
      children: List.generate(
        students.length,
        (i) => ListTile(
          title: Text(students[i].fullName),
          onTap: () => _bloc.add(StudentSelectionEventStudentSelected(i)),
        ),
      ),
    );
  }
}
