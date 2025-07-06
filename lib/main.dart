import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // Importing the main home screen of the app

/// Entry point of the Flutter application
void main() {
  runApp(const MyApp()); // Runs the root widget of the app
}

/// Root widget of the News App
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // Removes the debug banner in the top-right corner
      title: 'News App', // Title of the app
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue), // Defines primary color scheme
        useMaterial3: true, // Enables Material Design 3 styling
      ),
      home: const HomeScreen(), // Sets the initial screen of the app
    );
  }
}
