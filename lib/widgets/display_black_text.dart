import 'package:flutter/material.dart';
import 'package:registration_flutter/utils/extensions.dart';

class DisplayBlackText extends StatelessWidget {
  const DisplayBlackText({
    super.key,
    required this.text,
    this.size,
    this.fontWeight,
  });

  final String text;
  final double? size;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: context.textTheme.headlineSmall?.copyWith(
        color: context.colorScheme.onSurface,
        fontSize: size,
        fontWeight: fontWeight ?? FontWeight.bold,
      ),
    );
  }
}
