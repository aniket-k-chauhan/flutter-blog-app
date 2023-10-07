import 'package:flutter/material.dart';

class BlogFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 163, 213, 254),
      onPressed: () {
        Navigator.of(context).pushNamed("/blogForm");
      },
      tooltip: "Write Blog",
      child: const Icon(
        Icons.add,
        color: Color.fromARGB(223, 41, 88, 127),
      ),
    );
  }
}
