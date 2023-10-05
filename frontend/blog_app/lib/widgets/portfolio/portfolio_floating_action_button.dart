import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/views/portfolio/portfolio_details.dart';
import 'package:flutter/material.dart';

class PortfolioFloatingActionButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton.extended(
      onPressed: () {
        Navigator.of(context).pushNamed("/portfolio",
            arguments:
                PortfolioDetailsArgumets(Auth.getLoggedInUser()!.email!));
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
