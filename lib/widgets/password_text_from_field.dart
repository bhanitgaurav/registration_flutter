import 'package:flutter/material.dart';

class PasswordTextFormField extends StatefulWidget {
  const PasswordTextFormField({
    required this.label,
    required this.keyboardType,
    required this.validator,
    required this.onSaved,
    this.maxLength = 50,
    super.key,
  });

  final String label;
  final TextInputType keyboardType;
  final int maxLength;

  final String? Function(String? value) validator;
  final void Function(String value) onSaved;

  @override
  State<PasswordTextFormField> createState() => _PasswordTextFormFieldState();
}

class _PasswordTextFormFieldState extends State<PasswordTextFormField> {
  late bool _passwordVisible;

  @override
  void initState() {
    _passwordVisible = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      maxLength: widget.maxLength,
      decoration: InputDecoration(
        label: Text(widget.label),
        suffixIcon: suffixIcon(),
      ),
      keyboardType: widget.keyboardType,
      initialValue: '',
      validator: (value) {
        return widget.validator(value);
      },
      onSaved: (value) {
        widget.onSaved(value!);
      },
      obscureText: _passwordVisible,
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
