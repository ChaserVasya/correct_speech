import 'package:correct_speech/features/person_screen/domain/formatter/phone_formatter.dart';
import 'package:correct_speech/features/person_screen/domain/validator/phone_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injector/injector.dart';

//TODO maybe I can create something like 'Field mixin' because of repeating name/phone field functions
class PhoneFormField extends StatelessWidget {
  PhoneFormField({
    super.key,
    required this.phone,
    required this.onComplete,
    required this.hintText,
  });

  final String? phone;
  final void Function(String) onComplete;
  final String? hintText;

  final PhoneFormatter _phoneFormatter = Injector.appInstance.get();
  final PhoneValidator _phoneValidator = Injector.appInstance.get();

  late final _controller = TextEditingController(text: phone);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      initialValue: phone,
      controller: _controller,
      validator: _phoneValidator.validate,
      inputFormatters: [
        TextInputFormatter.withFunction(
          (_, value) => value.copyWith(
            text: _phoneFormatter.format(value.text),
          ),
        )
      ],
      //TODO How to call after validation and formatting?
      onEditingComplete: () => onComplete(_controller.text),
    );
  }
}
