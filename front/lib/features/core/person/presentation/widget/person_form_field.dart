import 'package:correct_speech/features/core/person/domain/model/person.dart';
import 'package:correct_speech/features/core/person/domain/model/sex.dart';
import 'package:correct_speech/features/core/person/presentation/widget/sex_radio.dart';
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
      children: [
        SexRadio(
          _sex,
          onChanged: (sex) => _sex = sex,
        ),
        NameFormField(
          name: _name,
          hintText: 'Имя',
          onComplete: (name) => _name = name,
        ),
        NameFormField(
          name: _surname,
          hintText: 'Фамилия',
          onComplete: (surname) => _surname = surname,
        ),
        PhoneFormField(
          phone: _phone,
          hintText: 'Телефон',
          onComplete: (phone) => _phone = phone,
        ),
        _buildCompleteButton(),
      ],
    );
  }

  Widget _buildCompleteButton() {
    return ElevatedButton(
      onPressed: () {
        final person = Person(
          name: _name!,
          surname: _surname!,
          phone: _phone,
          sex: _sex!,
        );
        widget.onComplete(person);
      },
      child: const Text('Принять изменения'),
    );
  }
}
