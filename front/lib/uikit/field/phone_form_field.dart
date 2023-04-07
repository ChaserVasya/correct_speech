import 'package:correct_speech/features/core/person/domain/formatter/phone_formatter.dart';
import 'package:correct_speech/features/core/person/domain/validator/phone_validator.dart';
import 'package:correct_speech/uikit/field/smart_form_field.dart';
import 'package:flutter/material.dart';
import 'package:injector/injector.dart';

class PhoneFormField extends StatefulWidget {
  const PhoneFormField({
    super.key,
    required this.phone,
    required this.onChanged,
    required this.hintText,
  });

  final String? phone;
  final void Function(String?) onChanged;
  final String? hintText;

  @override
  State<PhoneFormField> createState() => _PhoneFormFieldState();
}

class _PhoneFormFieldState extends State<PhoneFormField> {
  final PhoneFormatter _phoneFormatter = Injector.appInstance.get();
  final PhoneValidator _phoneValidator = Injector.appInstance.get();

  @override
  Widget build(BuildContext context) {
    return SmartFormField(
      initialValue: widget.phone,
      hintText: widget.hintText,
      keyboardType: TextInputType.phone,
      validator: _phoneValidator.validate,
      formatter: _phoneFormatter.format,
      onChanged: widget.onChanged,
    );
  }
}
