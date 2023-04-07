import 'package:correct_speech/features/core/person/domain/formatter/name_formatter.dart';
import 'package:correct_speech/features/core/person/domain/validator/name_validator.dart';
import 'package:correct_speech/uikit/field/smart_form_field.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class NameFormField extends StatefulWidget {
  const NameFormField({
    super.key,
    required this.name,
    required this.onChanged,
    required this.hintText,
  });

  final String? name;
  final void Function(String?) onChanged;
  final String? hintText;

  @override
  State<NameFormField> createState() => _NameFormFieldState();
}

class _NameFormFieldState extends State<NameFormField> {
  final NameFormatter _nameFormatter = Injector.appInstance.get();
  final NameValidator _nameValidator = Injector.appInstance.get();

  @override
  Widget build(BuildContext context) {
    return SmartFormField(
      initialValue: widget.name,
      hintText: widget.hintText,
      keyboardType: TextInputType.name,
      validator: _nameValidator.validate,
      formatter: _nameFormatter.format,
      onChanged: widget.onChanged,
    );
  }
}
