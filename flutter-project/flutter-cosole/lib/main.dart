// import 'package:ai_crop_disease_system/screens/login.dart';
// import 'package:ai_crop_disease_system/screens/otpverify.dart';
// import 'package:ai_crop_disease_system/screens/schedule_consultation.dart';
// import 'package:ai_crop_disease_system/screens/signup.dart';
// import 'package:flutter/material.dart';
// import 'screens/start_application.dart'; // Import the StartApplication widget
// import 'screens/multilanguage_support.dart'; // Import your multilingual support screen
// import 'screens/home_screen.dart'; // Import the HomeScreen widget
// import 'screens/recommendation.dart'; // Import Recommendation screen
// import 'screens/self_notes.dart'; // Import SelfNotes screen
// import 'screens/agronomist_screen.dart'; // Import Agronomist screen
// import 'screens/profile_screen.dart'; // Import Profile screen
// import 'screens/taskbar.dart'; // Import Taskbar widget

// void main() {
//   runApp(MyApp());
// }

// // Main application class
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//         title: 'AI Crop Disease Prediction',
//         debugShowCheckedModeBanner: false,
//         theme: ThemeData(
//           primarySwatch: Colors.green,
//         ),
//         // Set StartApplication as the initial screen
//         home: StartApplication(),
//         routes: {
//           '/start': (context) => StartApplication(),
//           '/multilanguage': (context) => MultilingualSupport(),
//           '/home': (context) => HomeScreen(),
//           '/recommendation': (context) => RecommendationScreen(),
//           '/self_notes': (context) => SelfNotesScreen(),
//           '/agronomist': (context) => AgronomistScreen(),
//           '/profile': (context) => FarmerProfileScreen(),
//           '/login': (context) => LoginScreen(),
//           '/verifyOtp': (context) => VerifyOtpScreen(),
//           '/signup': (context) => SignUpScreen(),
//           '/Schedule': (context) => ScheduleConsultationScreen()
//         });
//   }
// }

import 'package:ai_crop_disease_system/screens/login.dart';
import 'package:ai_crop_disease_system/screens/otpverify.dart';
import 'package:ai_crop_disease_system/screens/schedule_consultation.dart';
import 'package:ai_crop_disease_system/screens/signup.dart';
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
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        // Set StartApplication as the initial screen
        home: StartApplication(),
        routes: {
          '/start': (context) => StartApplication(),
          '/multilanguage': (context) => MultilingualSupport(),
          '/home': (context) => HomeScreen(),
          '/self_notes': (context) => SelfNotesScreen(),
          '/agronomist': (context) => AgronomistScreen(),
          '/profile': (context) => FarmerProfileScreen(),
          '/login': (context) => LoginScreen(),
          '/verifyOtp': (context) => VerifyOtpScreen(),
          '/signup': (context) => SignUpScreen(),
          '/Schedule': (context) => ScheduleConsultationScreen()
        });
  }
}
