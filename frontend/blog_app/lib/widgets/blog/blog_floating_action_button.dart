import 'package:flutter/material.dart';

class BlogFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {},
      label: Column(
        children: [
          const Text("Write Blog"),
        ],
      ),
      icon: Icon(Icons.add),
    );
  }
}
