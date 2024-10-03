import 'package:flutter/material.dart';
import 'screens/start_application.dart'; // Import the StartApplication widget
import 'screens/multilanguage_support.dart'; // Import your multilingual support screen
import 'screens/home_screen.dart'; // Import the HomeScreen widget
import 'screens/recommendation.dart'; // Ensure this path is correct
import 'screens/self_notes.dart'; // Import your self notes screen
import 'screens/agronomist_screen.dart'; // Import your agronomist screen
import 'screens/profile_screen.dart'; // Import your profile screen
import 'screens/taskbar.dart'; // Import the Taskbar widget

void main() {
  runApp(MyApp());
}

// Main application class
class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _currentIndex = 0; // Track the current index for navigation

  final List<Widget> _screens = [
    HomeScreen(),
    SelfNotesScreen(),
    AgronomistScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'AI Crop Disease Prediction',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: Scaffold(
        body: _currentIndex == 0 || _currentIndex == 1 // Check for visibility
            ? _screens[_currentIndex]
            : _screens[_currentIndex],
        bottomNavigationBar: _currentIndex == 0 || _currentIndex == 1
            ? null // Hide taskbar on StartApplication and MultilingualSupport screens
            : Taskbar(
                currentIndex: _currentIndex,
                onTap: (index) {
                  setState(() {
                    _currentIndex = index; // Update the current index
                  });
                },
              ),
      ),
      routes: {
        '/multilanguage': (context) => MultilingualSupport(),
        '/home': (context) => HomeScreen(),
        '/recommendation': (context) => Recommendation(), // Ensure this line is present
        // Add other routes as needed
      },
    );
  }
}
