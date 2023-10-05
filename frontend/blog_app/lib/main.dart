import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';

import 'package:blog_app/firebase_options.dart';
import 'package:blog_app/routes/route_generator.dart';
import 'package:blog_app/screens/SplashScreen.dart';

void main() async {
  // Initialize the Flutter app by creating an instance of WidgetsFlutterBinding
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      onGenerateRoute: RouteGenerator.generateRoute,
      home: SplashScreen(),
    );
  }
}
