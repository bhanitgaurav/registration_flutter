import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
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
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  late bool _passwordVisible;
  String? _errorText;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      onChanged: widget.onChanged,
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        errorText: _errorText,
        label: Text(widget.label),
        suffixIcon: suffixIcon(),
      ),
      keyboardType: widget.keyboardType,
      validator: (value) {
        return widget.validator(value);
      },
      onSaved: (value) {
        widget.onSaved(value!);
      },
      obscureText: !_passwordVisible,
    );
  }

  suffixIcon() {
    return IconButton(
      icon: Icon(
        // Based on passwordVisible state choose the icon
        _passwordVisible ? Icons.visibility : Icons.visibility_off,
        color: Theme.of(context).primaryColorDark,
      ),
      onPressed: () {
        setState(() {
          _passwordVisible = !_passwordVisible;
        });
      },
    );
  }
}
