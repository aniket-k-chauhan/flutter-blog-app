import 'package:flutter/material.dart';

class CommonSnackBar {
  static SnackBar buildSnackBar(
      BuildContext context, String snackBarTextMessage,
      [String tag = "info"]) {
    return SnackBar(
      backgroundColor: _getColor(tag),
      padding: const EdgeInsets.symmetric(horizontal: 8),
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      content: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        child: Center(
            child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 10),
              child: Icon(
                _getIcon(tag),
                size: 34,
                color: _getIconColor(tag),
              ),
            ),
            Expanded(
              child: Text(
                snackBarTextMessage,
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
            ),
          ],
        )),
      ),
    );
  }

  static Color _getColor(String? tag) {
    switch (tag) {
      case "success":
        return const Color.fromARGB(255, 71, 141, 75);
      case "error":
        return const Color.fromARGB(255, 178, 58, 56);
      case "info":
        return const Color.fromARGB(255, 37, 37, 37);
      default:
        return const Color.fromARGB(255, 37, 37, 37);
    }
  }

  static IconData _getIcon(String? tag) {
    switch (tag) {
      case "success":
        return Icons.check_circle_rounded;
      case "error":
        return Icons.error_rounded;
      case "info":
        return Icons.info_rounded;
      default:
        return Icons.info_rounded;
    }
  }

  static Color _getIconColor(String? tag) {
    switch (tag) {
      case "success":
        return const Color.fromARGB(255, 163, 239, 167);
      case "error":
        return const Color.fromARGB(255, 227, 130, 123);
      case "info":
        return const Color.fromARGB(255, 179, 179, 179);
      default:
        return const Color.fromARGB(255, 179, 179, 179);
    }
  }
}
