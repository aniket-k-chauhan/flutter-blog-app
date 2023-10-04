import "package:blog_app/auth/auth.dart";
import "package:flutter/material.dart";

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateInitialRoute();
  }

  void _navigateInitialRoute() async {
    await Future.delayed(const Duration(seconds: 2), () {
      final initialRoute =
          Auth.getLoggedInUser() == null ? "/register" : "/home";
      Navigator.of(context).pushReplacementNamed(initialRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Blog App",
              style: TextStyle(
                fontSize: 34,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 25,
            ),
            CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
