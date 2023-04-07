import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SmartFormField extends StatefulWidget {
  const SmartFormField({
    super.key,
    required this.initialValue,
    required this.onChanged,
    required this.hintText,
    required this.validator,
    required this.formatter,
    required this.keyboardType,
  });

  final String? initialValue;
  final void Function(String?) onChanged;
  final String? hintText;
  final FormFieldValidator<String> validator;
  final String Function(String) formatter;
  final TextInputType keyboardType;

  @override
  State<SmartFormField> createState() => _SmartFormFieldState();
}

class _SmartFormFieldState extends State<SmartFormField> {
  final _formKey = GlobalKey<FormFieldState<String>>();

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      key: _formKey,
      decoration: InputDecoration(hintText: widget.hintText),
      initialValue: widget.initialValue,
      validator: widget.validator,
      keyboardType: widget.keyboardType,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      inputFormatters: [
        TextInputFormatter.withFunction(
          (_, value) {
            final formattedText = widget.formatter(value.text);
            return TextEditingValue(
              text: formattedText,
              selection: TextSelection.collapsed(offset: formattedText.length),
            );
          },
        )
      ],
      onChanged: (input) {
        if (_formKey.currentState!.isValid) {
          widget.onChanged(input);
        } else {
          widget.onChanged(null);
        }
      },
    );
  }
}
