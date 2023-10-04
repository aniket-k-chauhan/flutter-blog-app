import 'package:flutter/material.dart';

class CustomLoader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.symmetric(vertical: 16),
      child: CircularProgressIndicator(),
    );
  }
}
