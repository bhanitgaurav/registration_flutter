import 'package:flutter/material.dart';

class CommonTextFormField extends StatelessWidget {
  const CommonTextFormField({
    required this.label,
    required this.controller,
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
  final TextEditingController controller;

  final String? Function(String? value) validator;
  final void Function(String value) onSaved;
  final void Function(String value)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      onChanged: onChanged,
      maxLength: maxLength,
      decoration: InputDecoration(
        label: Text(label),
      ),
      keyboardType: keyboardType,
      validator: (value) {
        return validator(value);
      },
      onSaved: (value) {
        onSaved(value!);
      },
    );
  }
}
