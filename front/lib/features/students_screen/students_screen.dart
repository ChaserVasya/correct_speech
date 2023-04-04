import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/person_tile/person_tile.dart';
import 'package:correct_speech/features/students_screen/students_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

//TODO should i stream database updating student or i can just update screen on didUpdate and etc.?
class StudentsScreen extends StatefulWidget {
  const StudentsScreen({super.key});

  @override
  State<StudentsScreen> createState() => _StudentsScreenState();
}

class _StudentsScreenState extends State<StudentsScreen> {
  late final StudentsCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Injector.appInstance.get();
    _cubit.init();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: _cubit,
      builder: _buildState,
    );
  }

  Widget _buildState(BuildContext context, List<RegisteredPerson>? students) {
    if (students == null) {
      return _buildLoading();
    }
    return _buildStudentsList(students);
  }

  Widget _buildStudentsList(List<RegisteredPerson> students) {
    return ListView.builder(
      itemBuilder: (_, i) => PersonTile(students[i]),
    );
  }

  Widget _buildLoading() {
    return const CircularProgressIndicator();
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
