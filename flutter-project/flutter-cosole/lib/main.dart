import 'package:flutter/material.dart';
import 'screens/start_application.dart'; // Import the StartApplication widget
import 'screens/multilanguage_support.dart'; // Import your multilingual support screen
import 'screens/home_screen.dart'; // Import the HomeScreen widget
import 'screens/recommendation.dart'; // Import Recommendation screen
import 'screens/self_notes.dart'; // Import SelfNotes screen
import 'screens/agronomist_screen.dart'; // Import Agronomist screen
import 'screens/profile_screen.dart'; // Import Profile screen
import 'screens/taskbar.dart'; // Import Taskbar widget

void main() {
  runApp(MyApp());
}

// Main application class
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Crop Disease Prediction',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // Set StartApplication as the initial screen
      home: StartApplication(),
      routes: {
        '/start': (context) => StartApplication(),
        '/multilanguage': (context) => MultilingualSupport(),
        '/home': (context) => HomeScreen(),
        '/recommendation': (context) => Recommendation(),
      },
    );
  }
}
