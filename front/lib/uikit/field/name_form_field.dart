import 'package:correct_speech/features/person_editing/domain/formatter/name_formatter.dart';
import 'package:correct_speech/features/person_editing/domain/validator/name_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:injector/injector.dart';

class NameFormField extends StatelessWidget {
  NameFormField({
    super.key,
    required this.name,
    required this.onComplete,
    required this.hintText,
  });

  final String? name;
  final void Function(String) onComplete;
  final String? hintText;

  final NameFormatter _nameFormatter = Injector.appInstance.get();
  final NameValidator _nameValidator = Injector.appInstance.get();

  late final _controller = TextEditingController(text: name);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(hintText: hintText),
      initialValue: name,
      controller: _controller,
      validator: _nameValidator.validate,
      inputFormatters: [
        TextInputFormatter.withFunction(
          (_, value) => value.copyWith(
            text: _nameFormatter.format(value.text),
          ),
        )
      ],
      onEditingComplete: () => onComplete(_controller.text),
    );
  }
}
