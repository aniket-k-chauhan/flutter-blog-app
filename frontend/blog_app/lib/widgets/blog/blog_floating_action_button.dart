import 'package:flutter/material.dart';

class BlogFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).pushNamed("/addBlog");
      },
      label: Column(
        children: [
          const Text("Write Blog"),
        ],
      ),
      icon: Icon(Icons.add),
    );
  }
}
