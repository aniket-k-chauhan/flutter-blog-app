import 'package:flutter/material.dart';

class CommonSnackBar {
  static SnackBar buildSnackBar(
      BuildContext context, String snackBarTextMessage) {
    return SnackBar(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Center(
            child: Text(
          snackBarTextMessage,
          style: const TextStyle(
            fontSize: 17,
          ),
        )),
      ),
    );
  }
}
