import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';

import 'package:blog_app/firebase_options.dart';
import 'package:blog_app/routes/route_generator.dart';
import 'package:blog_app/screens/SplashScreen.dart';
import 'package:blog_app/provider/blog_provider.dart';

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
    return ChangeNotifierProvider<BlogUpdateModel>(
      create: (context) => BlogUpdateModel(),
      child: MaterialApp(
        theme: ThemeData.light(useMaterial3: true),
        onGenerateRoute: RouteGenerator.generateRoute,
        home: SplashScreen(),
      ),
    );
  }
}
