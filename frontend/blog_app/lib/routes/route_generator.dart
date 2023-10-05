import 'package:blog_app/screens/DashboardScreen.dart';
import 'package:blog_app/screens/RegisterScreen.dart';
import 'package:blog_app/views/portfolio/portfolio_details.dart';
import "package:flutter/material.dart";

import 'package:blog_app/screens/LoginScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator
    final args = settings.arguments;

    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: ((context) => LoginScreen()));
      case "/register":
        return MaterialPageRoute(builder: ((context) => RegisterScreen()));
      case "/home":
        return MaterialPageRoute(builder: ((context) => DashboardScreen()));
      case "/portfolio":
        if (args is PortfolioDetailsArgumets) {
          return MaterialPageRoute(
              builder: ((context) => PortfolioDetails(
                    email: args.email,
                    isReadOnly: args.isReadOnly,
                  )));
        }
        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: ((context) {
      return const Scaffold(
        body: Center(
          child: Text(
            "Incorrect route",
            style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }));
  }
}
