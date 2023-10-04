import 'package:blog_app/screens/DashboardScreen.dart';
import 'package:blog_app/screens/RegisterScreen.dart';
import "package:flutter/material.dart";

import 'package:blog_app/screens/LoginScreen.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator
    // final args = settings.arguments;

    switch (settings.name) {
      case "/login":
        return MaterialPageRoute(builder: ((context) => LoginScreen()));
      case "/register":
        return MaterialPageRoute(builder: ((context) => RegisterScreen()));
      case "/home":
        return MaterialPageRoute(builder: ((context) => DashboardScreen()));
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
