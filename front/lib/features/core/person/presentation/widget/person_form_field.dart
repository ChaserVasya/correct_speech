import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/features/core/person/presentation/widget/sex_radio_list.dart';
import 'package:correct_speech/uikit/field/name_form_field.dart';
import 'package:correct_speech/uikit/field/phone_form_field.dart';
import 'package:flutter/material.dart';

class PersonFormField extends StatefulWidget {
  final Person? person;
  final void Function(Person) onComplete;

  const PersonFormField({
    super.key,
    this.person,
    required this.onComplete,
  });

  @override
  State<PersonFormField> createState() => _PersonFormFieldState();
}

class _PersonFormFieldState extends State<PersonFormField> {
  late String? _name = widget.person?.name;
  late String? _surname = widget.person?.name;
  late String? _phone = widget.person?.phone;
  late Sex? _sex = widget.person?.sex;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SexRadioList(
          _sex,
          onChanged: (sex) => setState(() => _sex = sex),
        ),
        NameFormField(
          name: _name,
          hintText: 'Имя',
          onChanged: (name) => setState(() => _name = name),
        ),
        NameFormField(
          name: _surname,
          hintText: 'Фамилия',
          onChanged: (surname) => setState(() => _surname = surname),
        ),
        PhoneFormField(
          phone: _phone,
          hintText: 'Телефон',
          onChanged: (phone) => setState(() => _phone = phone),
        ),
        _buildCompleteButton(),
      ],
    );
  }

  Widget _buildCompleteButton() {
    final buttonIsEnabled = [_sex, _name, _surname, _phone].every(_isValid);
    return ElevatedButton(
      onPressed: buttonIsEnabled
          ? () {
              final person = Person(
                name: _name!,
                surname: _surname!,
                phone: _phone,
                sex: _sex!,
              );
              widget.onComplete(person);
            }
          : null,
      child: const Text('Принять изменения'),
    );
  }

  bool _isValid(Object? value) {
    return value != null;
  }
}
