import 'package:correct_speech/features/core/person/domain/helper/person_copy.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/student_editing/presentation/student_editing/student_editing_bloc.dart';
import 'package:correct_speech/features/student_editing/presentation/student_editing/widget/name_form_field.dart';
import 'package:correct_speech/features/student_editing/presentation/student_editing/widget/phone_form_field.dart';
import 'package:correct_speech/features/student_editing/presentation/widget/sex_radio.dart';
import 'package:correct_speech/infrastructure/helper/nullable.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

class StudentEditingScreen extends StatefulWidget {
  const StudentEditingScreen({super.key});

  @override
  State<StudentEditingScreen> createState() => _StudentEditingScreenState();
}

class _StudentEditingScreenState extends State<StudentEditingScreen> {
  late final StudentEditingBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = Injector.appInstance.get();
    final person = ModalRoute.of(context)!.settings.arguments as RegisteredPerson;
    _bloc.add(BlocEventInit(person));
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer(
      bloc: _bloc,
      builder: _buildState,
      listener: _listenState,
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }

  Widget _buildState(BuildContext context, BlocState state) {
    if (state is BlocStateLoading) {
      return _buildStateLoading(state);
    } else if (state is BlocStateMain) {
      return _buildStateMain(state);
    } else {
      throw Exception();
    }
  }

  void _listenState(BuildContext context, BlocState state) {}

  Widget _buildStateLoading(BlocStateLoading state) {
    return const CircularProgressIndicator();
  }

  Widget _buildStateMain(BlocStateMain state) {
    final student = state.student;
    return ListView(
      children: [
        SexRadio(
          student.sex,
          onChanged: (sex) => _bloc.add(BlocEventEditStudent(student.copy(sex: sex))),
        ),
        NameFormField(
          name: student.name,
          hintText: 'Имя',
          onComplete: (name) => _bloc.add(BlocEventEditStudent(student.copy(name: name))),
        ),
        NameFormField(
          name: student.surname,
          hintText: 'Фамилия',
          onComplete: (surname) => _bloc.add(BlocEventEditStudent(student.copy(surname: surname))),
        ),
        PhoneFormField(
          phone: student.phone,
          hintText: 'Телефон',
          onComplete: (phone) => _bloc.add(BlocEventEditStudent(student.copy(phone: Nullable(phone)))),
        ),
      ],
    );
  }
}
