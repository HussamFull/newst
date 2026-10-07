import 'package:flutter/material.dart';
import 'package:newst/core/datasource/local_source/preference_manager.dart';
import 'package:newst/features/splash/splash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize PreferenceManager
  final preferenceManager = PreferenceManager();
  await preferenceManager.init();

  // Start application
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Newst App',

      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),

      home: const SplashScreen(),
    );
  }
}