import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField({
    required this.label,
    required this.keyboardType,
    required this.validator,
    required this.onSaved,
    this.onChanged,
    this.maxLength = 50,
    super.key,
  });

  final String label;
  final TextInputType keyboardType;
  final int maxLength;

  final String? Function(String? value) validator;
  final void Function(String value) onSaved;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChanged,
      maxLength: maxLength,
      decoration: InputDecoration(
        label: Text(label),
      ),
      keyboardType: keyboardType,
      initialValue: '',
      validator: (value) {
        return validator(value);
      },
      onSaved: (value) {
        onSaved(value!);
      },
    );
  }
}
