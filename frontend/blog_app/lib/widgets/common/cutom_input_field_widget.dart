import 'package:flutter/material.dart';

class CustomInputFieldWidget extends StatelessWidget {
  final String labelText;
  final bool obscureText;
  final TextEditingController controller;
  final int? maxLine;

  const CustomInputFieldWidget({
    super.key,
    required this.labelText,
    required this.obscureText,
    required this.controller,
    this.maxLine,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: TextFormField(
        maxLines: maxLine,
        controller: controller,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return "Please enter ${labelText.toLowerCase()}";
          }

          return null;
        },
        obscureText: obscureText,
        style: TextStyle(fontSize: 17),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(
            fontSize: 17,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1.5,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.grey,
              width: 1,
            ),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red[200]!,
              width: 1.5,
            ),
          ),
          focusedErrorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              color: Colors.red[200]!,
              width: 1.5,
            ),
          ),
        ),
      ),
    );
  }
}
