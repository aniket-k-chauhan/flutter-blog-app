import 'package:flutter/material.dart';

class CommonChip extends StatelessWidget {
  const CommonChip({
    super.key,
    required this.labelText,
  });

  final String labelText;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Text(labelText),
      labelStyle: TextStyle(
        fontSize: 16,
      ),
    );
  }
}
