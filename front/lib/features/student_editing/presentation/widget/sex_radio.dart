import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/features/core/person/presentation/model/sex_ui_mapper.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class SexRadio extends StatelessWidget {
  SexRadio(
    this.currentSex, {
    required this.onChanged,
    super.key,
  });

  final SexUIMapper _sexUIMapper = Injector.appInstance.get();

  final Sex? currentSex;

  final void Function(Sex?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final sex in Sex.values)
          RadioListTile<Sex>(
            value: sex,
            groupValue: currentSex,
            onChanged: onChanged,
            title: Text(_sexUIMapper.toText(sex)),
          ),
      ],
    );
  }
}
