import 'package:correct_speech/features/core/person/domain/interface/person_repository.dart';
import 'package:correct_speech/features/core/person/domain/model/registered_person.dart';
import 'package:correct_speech/infrastructure/extensions.dart';
import 'package:correct_speech/uikit/bottomsheet/selection_bottomsheet.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

Future<RegisteredPerson?> showPersonSelectionBottomsheet(BuildContext context, List<RegisteredPerson> excluded) async {
  final personRepository = Injector.appInstance.get<PersonRepository>();
  final persons = await personRepository.getAll();
  if (context.mounted) {
    return showSelectionBottomsheet(
      context: context,
      items: persons.whereNot(excluded.contains).toList(),
      createTitle: (person) => person.fullName,
    );
  }
  return null;
}
