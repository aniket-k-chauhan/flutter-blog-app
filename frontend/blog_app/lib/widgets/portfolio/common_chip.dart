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
      labelStyle: const TextStyle(
        fontSize: 18,
        color: Color.fromARGB(223, 41, 88, 127),
      ),
    );
  }
}
