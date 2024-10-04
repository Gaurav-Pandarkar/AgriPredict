// import 'package:flutter/material.dart';
// import 'screens/start_application.dart'; // Import the StartApplication widget
// import 'screens/multilanguage_support.dart'; // Import your multilingual support screen
// import 'screens/home_screen.dart'; // Import the HomeScreen widget
// import 'screens/recommendation.dart'; // Ensure this path is correct
// import 'screens/self_notes.dart'; // Import your self notes screen
// import 'screens/agronomist_screen.dart'; // Import your agronomist screen
// import 'screens/profile_screen.dart'; // Import your profile screen
// import 'screens/taskbar.dart'; // Import the Taskbar widget

// void main() {
//   runApp(MyApp());
// }

// // Main application class
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int _currentIndex = 0; // Track the current index for navigation

//   final List<Widget> _screens = [
//     HomeScreen(),
//     SelfNotesScreen(),
//     AgronomistScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AI Crop Disease Prediction',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       home: Scaffold(
//         body: _currentIndex == 0 || _currentIndex == 1 // Check for visibility
//             ? _screens[_currentIndex]
//             : _screens[_currentIndex],
//         bottomNavigationBar: _currentIndex == 0 || _currentIndex == 1
//             ? null // Hide taskbar on StartApplication and MultilingualSupport screens
//             : Taskbar(
//                 currentIndex: _currentIndex,
//                 onTap: (index) {
//                   setState(() {
//                     _currentIndex = index; // Update the current index
//                   });
//                 },
//               ),
//       ),
//       routes: {
//         '/multilanguage': (context) => MultilingualSupport(),
//         '/home': (context) => HomeScreen(),
//         '/recommendation': (context) => Recommendation(), // Ensure this line is present
//         // Add other routes as needed
//       },
//     );
//   }
// }

//working
// import 'package:flutter/material.dart';
// import 'screens/start_application.dart'; // Import the StartApplication widget
// import 'screens/multilanguage_support.dart'; // Import your multilingual support screen
// import 'screens/home_screen.dart'; // Import the HomeScreen widget
// import 'screens/recommendation.dart'; // Ensure this path is correct
// import 'screens/self_notes.dart'; // Import your self notes screen
// import 'screens/agronomist_screen.dart'; // Import your agronomist screen
// import 'screens/profile_screen.dart'; // Import your profile screen
// import 'screens/taskbar.dart'; // Import the Taskbar widget

// void main() {
//   runApp(MyApp());
// }

// // Main application class
// class MyApp extends StatefulWidget {
//   @override
//   _MyAppState createState() => _MyAppState();
// }

// class _MyAppState extends State<MyApp> {
//   int _currentIndex = 0; // Track the current index for navigation

//   final List<Widget> _screens = [
//     HomeScreen(),
//     SelfNotesScreen(),
//     AgronomistScreen(),
//     ProfileScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'AI Crop Disease Prediction',
//       theme: ThemeData(
//         primarySwatch: Colors.green,
//       ),
//       // Set StartApplication as the initial screen
//       home: StartApplication(),
//       routes: {
//         '/start': (context) => StartApplication(),
//         '/multilanguage': (context) => MultilingualSupport(),
//         '/home': (context) => HomeScreen(),
//         '/recommendation': (context) => Recommendation(),
//         // Add other routes as needed
//       },
//     );
//   }
// }

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




// import 'dart:convert'; // For decoding JSON
// import 'package:http/http.dart' as http; // HTTP package
// import 'package:flutter/material.dart'; // Flutter UI
// import 'package:geolocator/geolocator.dart'; // For getting the real-time location
// import 'package:permission_handler/permission_handler.dart'; // For opening settings

// void main() => runApp(MyApp());

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: WeatherScreen(),
//     );
//   }
// }

// class WeatherScreen extends StatefulWidget {
//   @override
//   _WeatherScreenState createState() => _WeatherScreenState();
// }

// class _WeatherScreenState extends State<WeatherScreen> {
//   double? temperature;
//   String? weatherCode;
//   String? errorMessage;

//   // Function to get the current location
//   Future<Position> _determinePosition() async {
//     bool serviceEnabled;
//     LocationPermission permission;

//     // Check if location services are enabled
//     serviceEnabled = await Geolocator.isLocationServiceEnabled();
//     if (!serviceEnabled) {
//       // Prompt the user to enable location services
//       _showLocationDialog();
//       return Future.error('Location services are disabled.');
//     }

//     // Check location permission status
//     permission = await Geolocator.checkPermission();
//     if (permission == LocationPermission.denied) {
//       permission = await Geolocator.requestPermission();
//       if (permission == LocationPermission.denied) {
//         return Future.error('Location permissions are denied');
//       }
//     }

//     if (permission == LocationPermission.deniedForever) {
//       return Future.error(
//           'Location permissions are permanently denied, we cannot request permissions.');
//     }

//     // Get current position
//     return await Geolocator.getCurrentPosition();
//   }

//   // Function to open location settings on Android
//   Future<void> _openLocationSettings() async {
//     await Geolocator.openLocationSettings();
//   }

//   // Show dialog to prompt the user to enable location services
//   void _showLocationDialog() {
//     showDialog(
//       context: context,
//       builder: (context) => AlertDialog(
//         title: Text('Location Services Disabled'),
//         content: Text(
//             'Location services are disabled. Please enable them in the settings.'),
//         actions: [
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//             },
//             child: Text('Cancel'),
//           ),
//           TextButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               _openLocationSettings(); // Open location settings
//             },
//             child: Text('Open Settings'),
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to fetch weather data using the real-time location
//   Future<void> fetchWeather() async {
//     const String apiKey = 'WpNtxK3NOLZ4syiiroDQd6VMBROiNPi0';

//     try {
//       // Get the current position (latitude and longitude)
//       Position position = await _determinePosition();
//       double latitude = position.latitude;
//       double longitude = position.longitude;

//       final String apiUrl =
//           'https://api.tomorrow.io/v4/weather/realtime?location=$latitude,$longitude&apikey=$apiKey';

//       // Send the GET request
//       final response = await http.get(Uri.parse(apiUrl));

//       // Check if the request was successful
//       if (response.statusCode == 200) {
//         // Parse the JSON response
//         final Map<String, dynamic> data = jsonDecode(response.body);

//         // Debugging: Log the full response to see the structure
//         print('Response: $data');

//         // Extract temperature and weather code
//         setState(() {
//           temperature =
//               (data['data']['values']['temperature'] as num?)?.toDouble();
//           weatherCode = data['data']['values']['weatherCode']
//               ?.toString(); // Converting to string safely
//         });
//       } else {
//         // Handle error response
//         setState(() {
//           errorMessage = 'Failed to load weather data: ${response.statusCode}';
//         });
//       }
//     } catch (e) {
//       // Handle any exceptions
//       setState(() {
//         errorMessage = 'Error: $e';
//       });
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     fetchWeather(); // Fetch weather data when the app starts
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Weather App'),
//       ),
//       body: Center(
//         child: errorMessage != null
//             ? Text(errorMessage!) // Display error message if present
//             : temperature != null && weatherCode != null
//                 ? Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       Text('Temperature: ${temperature!.toStringAsFixed(2)}°C'),
//                       Text('Weather Code: $weatherCode'),
//                     ],
//                   )
//                 : CircularProgressIndicator(), // Show loading indicator while fetching data
//       ),
//     );
//   }
// }
