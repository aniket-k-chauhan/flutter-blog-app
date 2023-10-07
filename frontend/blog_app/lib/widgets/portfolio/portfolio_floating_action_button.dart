import 'package:flutter/material.dart';

import 'package:blog_app/auth/auth.dart';
import 'package:blog_app/views/portfolio/portfolio_details.dart';

class PortfolioFloatingActionButton extends StatelessWidget {
  const PortfolioFloatingActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 163, 213, 254),
      onPressed: () {
        Navigator.of(context).pushNamed("/portfolio",
            arguments:
                PortfolioDetailsArgumets(Auth.getLoggedInUser()!.email!));
      },
      tooltip: "Edit Your Portfolio",
      child: const Icon(
        Icons.edit,
        color: Color.fromARGB(223, 41, 88, 127),
      ),
    );
  }
}
