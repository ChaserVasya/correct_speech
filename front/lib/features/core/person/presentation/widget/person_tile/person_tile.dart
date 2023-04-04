import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/person/presentation/widget/person_tile/person_tile_cubit.dart';
import 'package:correct_speech/features/person_screen/presentation/person_editing/person_editing_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injector/injector.dart';

//TODO should I add Key for update preventing? (bloc in initState not consistent with widget.person)
class PersonTile extends StatefulWidget {
  final RegisteredPerson person;
  final List<Widget>? additionalButtons;

  const PersonTile(
    this.person, {
    super.key,
    this.additionalButtons,
  });

  @override
  State<PersonTile> createState() => _PersonTileState();
}

class _PersonTileState extends State<PersonTile> {
  late final PersonCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = Injector.appInstance.get();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener(
      bloc: _cubit,
      listener: _listenState,
      child: _buildContent(),
    );
  }

  Widget _buildContent() {
    final person = widget.person;
    return ListTile(
      title: Text(person.fullName),
      subtitle: person.phone != null ? Text(person.phone!) : null,
      trailing: Row(
        children: [
          _buildEditingButtons(),
          if (widget.additionalButtons != null) ...widget.additionalButtons!,
        ],
      ),
      onTap: _openPersonEditingScreen,
    );
  }

  Widget _buildEditingButtons() {
    return IconButton(
      icon: const Icon(Icons.delete),
      onPressed: () => _cubit.tryDeletePerson(widget.person),
    );
  }

  void _listenState(BuildContext context, BlocState state) async {
    switch (state) {
      case BlocState.confirmPersonDeleting:
        final shouldDeletePerson = await _showPersonDeletingConfirmationDialog();
        await _cubit.deletePerson(shouldDeletePerson, widget.person);
        break;
      case BlocState.main:
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

  void _openPersonEditingScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PersonEditingScreen(widget.person),
      ),
    );
  }

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }
}
