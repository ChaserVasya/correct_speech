import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/features/core/person/presentation/widget/person_selection_bottomsheet.dart';
import 'package:correct_speech/features/person_screen/person_editing/person_editing_screen.dart';
import 'package:correct_speech/features/person_tile/person_tile.dart';
import 'package:correct_speech/infrastructure/bloc/bloc_narrowed_consumer.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

import 'related_persons_cubit/related_persons_cubit.dart';
import 'related_persons_cubit/related_persons_state.dart';

class RelatedPersonsList extends StatefulWidget {
  final RegisteredPerson person;

  const RelatedPersonsList(this.person, {super.key});

  @override
  State<RelatedPersonsList> createState() => _RelatedPersonsListState();
}

class _RelatedPersonsListState extends State<RelatedPersonsList> {
  late final RelatedPersonsCubit _cubit;

  @override
  void initState() {
    _cubit = Injector.appInstance.get();
    _cubit.init(widget.person);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocNarrowedConsumer(
      bloc: _cubit,
      builder: _buildState,
      listener: _listenState,
    );
  }

  Widget _buildState(BuildContext context, BlocStateBuild? state) {
    if (state == null) {
      return _buildNoState();
    } else if (state is BlocStateLoading) {
      return _buildLoadingState(state);
    } else {
      return _buildMainState(state as BlocStateMain);
    }
  }

  Widget _buildNoState() {
    return const CircularProgressIndicator();
  }

  Widget _buildLoadingState(BlocStateLoading state) {
    return const CircularProgressIndicator();
  }

  Widget _buildMainState(BlocStateMain state) {
    return Column(
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            for (final relatedPerson in state.relatedPersons)
              PersonTile(
                relatedPerson,
                onTap: _openPersonEditingScreen,
                additionalButtons: [
                  _buildRemoveRelatedPersonButton(relatedPerson),
                ],
              )
          ],
        ),
        ElevatedButton(
          onPressed: _cubit.needAddRelatedPerson,
          child: const Text('Добавить контактное лицо'),
        ),
      ],
    );
  }

  void _openPersonEditingScreen(RegisteredPerson person) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PersonEditingScreen(person),
      ),
    );
  }

  Widget _buildRemoveRelatedPersonButton(RegisteredPerson relatedPerson) {
    return IconButton(
      onPressed: () => _cubit.removeRelatedPerson(relatedPerson),
      icon: const Icon(Icons.link_off),
    );
  }

  void _listenState(BuildContext context, BlocStateListen state) async {
    if (state is BlocStateSelectPerson) {
      final person = await showPersonSelectionBottomsheet(context);
      if (person != null) await _cubit.addRelatedPerson(person);
    }
  }
}
