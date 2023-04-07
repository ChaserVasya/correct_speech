import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/features/core/person/presentation/model/sex_ui_mapper.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class SexRadioList extends StatefulWidget {
  const SexRadioList(
    this.initialValue, {
    required this.onChanged,
    super.key,
  });

  final Sex? initialValue;

  final void Function(Sex?) onChanged;

  @override
  State<SexRadioList> createState() => _SexRadioListState();
}

class _SexRadioListState extends State<SexRadioList> {
  final SexUIMapper _sexUIMapper = Injector.appInstance.get();

  late Sex? _currentSex = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (final sex in Sex.values)
          Flexible(
            child: RadioListTile<Sex>(
              value: sex,
              groupValue: _currentSex,
              onChanged: (sex) {
                setState(() => _currentSex = sex);
                widget.onChanged(sex);
              },
              title: Text(_sexUIMapper.toText(sex)),
            ),
          ),
      ],
    );
  }
}
