import 'package:blog_app/auth/auth.dart';
import 'package:flutter/material.dart';

class PortfolioFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context)
            .pushNamed("/portfolio", arguments: Auth.getLoggedInUser()!.email);
      },
      label: Column(
        children: [
          const Text("Your"),
          const Text("Portfolio"),
        ],
      ),
      icon: Icon(Icons.edit),
    );
  }
}
