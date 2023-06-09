import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/person/presentation/widget/person_form_field.dart';
import 'package:correct_speech/features/person_screen/related_persons/related_persons_list.dart';
import 'package:correct_speech/infrastructure/bloc/bloc_narrowed_consumer.dart';
import 'package:correct_speech/uikit/base_screen.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'person_editing_cubit/person_editing_cubit.dart';
import 'person_editing_cubit/person_editing_state.dart';

class PersonEditingScreen extends StatefulWidget {
  final RegisteredPerson person;

  const PersonEditingScreen(this.person, {super.key});

  @override
  State<PersonEditingScreen> createState() => _PersonEditingScreenState();
}

class _PersonEditingScreenState extends State<PersonEditingScreen> {
  late final PersonEditingCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Injector.appInstance.get();
    _cubit.init(widget.person);
  }

  @override
  Widget build(BuildContext context) {
    return BaseScreen(
      title: 'Редактирование',
      child: BlocNarrowedConsumer(
        bloc: _cubit,
        builder: _buildState,
        listener: _listenState,
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Widget _buildState(BuildContext context, BlocStateBuild? state) {
    if (state == null) {
      return _buildNoState();
    } else if (state is BlocStateLoading) {
      return _buildStateLoading(state);
    } else if (state is BlocStateMain) {
      return _buildStateMain(state);
    } else {
      throw Exception();
    }
  }

  Widget _buildNoState() {
    return const CircularProgressIndicator();
  }

  Widget _buildStateLoading(BlocStateLoading state) {
    return const CircularProgressIndicator();
  }

  Widget _buildStateMain(BlocStateMain state) {
    final person = state.person;
    return Column(
      children: [
        PersonFormField(
          person: person,
          onComplete: (editedPerson) => _cubit.editPersonWith(editedPerson.addId(person.id)),
        ),
        RelatedPersonsList(person),
      ],
    );
  }

  void _listenState(BuildContext context, BlocStateListen state) async {
    if (state is BlocStateConfirmPersonDeletion) {
      final shouldDelete = await _showPersonDeletingConfirmationDialog();
      if (shouldDelete != true) return null;
      await _cubit.deletePerson();
    } else if (state is BlocStatePersonDeleted) {
      Navigator.of(context).pop();
    }
  }

  Future<bool?> _showPersonDeletingConfirmationDialog() {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: Text('Удалить "${widget.person.fullName}"?'),
        actions: [
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Отменить'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text('Удалить'),
          ),
        ],
      ),
    );
  }
}
