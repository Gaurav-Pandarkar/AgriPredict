// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _boxAnimation;

//   // TextEditingController to capture mobile number input
//   final TextEditingController _mobileController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();

//     _logoAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     _boxAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _mobileController
//         .dispose(); // Dispose the controller when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.green.shade100,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: ClampingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.1),

//                 // Logo with Animation
//                 ScaleTransition(
//                   scale: _logoAnimation,
//                   child: Center(
//                     child: Image.network(
//                       'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
//                       height: 120,
//                       width: 120,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//                 // Login Box and Fields
//                 FadeTransition(
//                   opacity: _boxAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green.shade900,
//                           ),
//                         ),
//                         SizedBox(height: 30),

//                         // Mobile Number Field
//                         TextField(
//                           controller: _mobileController, // Capture input here
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             labelText: 'Mobile Number',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.phone, color: Colors.green),
//                           ),
//                         ),
//                         SizedBox(height: 20),

//                         // Send OTP Button
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_mobileController.text.isNotEmpty) {
//                               // Navigate to VerifyOtpScreen with mobile number
//                               Navigator.pushNamed(
//                                 context,
//                                 '/verifyOtp',
//                                 arguments: _mobileController
//                                     .text, // Pass mobile number as argument
//                               );
//                             } else {
//                               // Show some error if mobile number is empty
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                     content: Text(
//                                         'Please enter a valid mobile number')),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green.shade700,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 50, vertical: 15),
//                           ),
//                           child: Text(
//                             'Login',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),

//                         // Don't Have An Account Text with Navigation
//                         TextButton(
//                           onPressed: () {
//                             // Navigate to the signup screen
//                             Navigator.pushNamed(context, '/signup');
//                           },
//                           child: Text(
//                             "Don't have an account?",
//                             style: TextStyle(
//                               color: Colors.green.shade800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 30), // Give some space before the skip button

//                 // Skip Button
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.0),
//                   child: TextButton.icon(
//                     onPressed: () {
//                       // Navigate to /multilanguage screen
//                       Navigator.pushNamed(context, '/multilanguage');
//                     },
//                     icon: Icon(Icons.arrow_forward, color: Colors.green),
//                     label: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.green.shade700,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

//working
// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _boxAnimation;

//   // TextEditingController to capture mobile number input
//   final TextEditingController _mobileController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();

//     _logoAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     _boxAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _mobileController
//         .dispose(); // Dispose the controller when the widget is disposed
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.green.shade100,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: ClampingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.1),

//                 // Logo with Animation
//                 ScaleTransition(
//                   scale: _logoAnimation,
//                   child: Center(
//                     child: Image.network(
//                       'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
//                       height: 120,
//                       width: 120,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//                 // Login Box and Fields
//                 FadeTransition(
//                   opacity: _boxAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green.shade900,
//                           ),
//                         ),
//                         SizedBox(height: 30),

//                         // Mobile Number Field
//                         TextField(
//                           controller: _mobileController, // Capture input here
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             labelText: 'Mobile Number',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.phone, color: Colors.green),
//                           ),
//                         ),
//                         SizedBox(height: 20),

//                         // Send OTP Button
//                         ElevatedButton(
//                           onPressed: () {
//                             if (_mobileController.text.isNotEmpty) {
//                               // Navigate to VerifyOtpScreen with mobile number
//                               Navigator.pushNamed(
//                                 context,
//                                 '/verifyOtp',
//                                 arguments: _mobileController
//                                     .text, // Pass mobile number as argument
//                               );
//                             } else {
//                               // Show some error if mobile number is empty
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 SnackBar(
//                                   content: Text(
//                                       'Please enter a valid mobile number'),
//                                 ),
//                               );
//                             }
//                           },
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green.shade700,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 50, vertical: 15),
//                           ),
//                           child: Text(
//                             'Login',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),

//                         // Don't Have An Account Text with Navigation
//                         TextButton(
//                           onPressed: () {
//                             // Navigate to the signup screen
//                             Navigator.pushNamed(context, '/signup');
//                           },
//                           child: Text(
//                             "Don't have an account?",
//                             style: TextStyle(
//                               color: Colors.green.shade800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 30), // Give some space before the skip button

//                 // Skip Button
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.0),
//                   child: TextButton.icon(
//                     onPressed: () {
//                       // Navigate to /multilanguage screen
//                       Navigator.pushNamed(context, '/multilanguage');
//                     },
//                     icon: Icon(Icons.arrow_forward, color: Colors.green),
//                     label: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.green.shade700,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';
// import 'package:http/http.dart' as http; // Import the http package
// import 'dart:convert'; // For encoding and decoding JSON

// class LoginScreen extends StatefulWidget {
//   @override
//   _LoginScreenState createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _boxAnimation;

//   // TextEditingController to capture mobile number input
//   final TextEditingController _mobileController = TextEditingController();
//   bool _isMobileValid = true; // Track the validity of the mobile number

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();

//     _logoAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     _boxAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _mobileController
//         .dispose(); // Dispose the controller when the widget is disposed
//     super.dispose();
//   }

//   // Function to validate the mobile number
//   bool _validateMobileNumber(String input) {
//     final RegExp mobileRegExp =
//         RegExp(r'^[6-9]\d{9}$'); // Regex for Indian mobile numbers
//     return mobileRegExp.hasMatch(input);
//   }

//   // Function to send OTP
//   Future<void> _sendOtp() async {
//     final String mobileNo = _mobileController.text;

//     // Ensure the mobile number is valid
//     if (!_isMobileValid) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Please enter a valid mobile number'),
//         ),
//       );
//       return;
//     }

//     final url =
//         Uri.parse('http://192.168.97.193:8081/api/v1/otp/send'); // API endpoint

//     final Map<String, String> requestPayload = {
//       'mobileNo':
//           "+91" + mobileNo, // Sending the mobile number in the request body
//     };

//     try {
//       final response = await http.post(
//         url,
//         headers: {'Content-Type': 'application/json'},
//         body: json.encode(requestPayload), // Encode request body to JSON
//       );

//       if (response.statusCode == 200) {
//         // If the API call is successful, navigate to the OTP verification screen
//         Navigator.pushNamed(
//           context,
//           '/verifyOtp',
//           arguments: mobileNo, // Pass the mobile number to the next screen
//         );
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//             content: Text('Failed to send OTP. Please try again.'),
//           ),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(
//           content: Text('Error: $e'),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       resizeToAvoidBottomInset: true,
//       backgroundColor: Colors.green.shade100,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           physics: ClampingScrollPhysics(),
//           child: Padding(
//             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.1),

//                 // Logo with Animation
//                 ScaleTransition(
//                   scale: _logoAnimation,
//                   child: Center(
//                     child: Image.network(
//                       'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
//                       height: 120,
//                       width: 120,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//                 // Login Box and Fields
//                 FadeTransition(
//                   opacity: _boxAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           'Login',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green.shade900,
//                           ),
//                         ),
//                         SizedBox(height: 30),

//                         // Mobile Number Field
//                         Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             TextField(
//                               controller:
//                                   _mobileController, // Capture input here
//                               keyboardType: TextInputType.phone,
//                               decoration: InputDecoration(
//                                 labelText: 'Mobile Number',
//                                 border: OutlineInputBorder(),
//                                 prefixIcon:
//                                     Icon(Icons.phone, color: Colors.green),
//                                 errorText: _isMobileValid
//                                     ? null
//                                     : 'Invalid mobile number',
//                               ),
//                               onChanged: (input) {
//                                 setState(() {
//                                   _isMobileValid = _validateMobileNumber(input);
//                                 });
//                               },
//                             ),
//                             SizedBox(height: 5),
//                             // Optionally, display an error message directly below the field
//                             if (!_isMobileValid)
//                               Text(
//                                 '',
//                                 style:
//                                     TextStyle(color: Colors.red, fontSize: 12),
//                               ),
//                           ],
//                         ),
//                         SizedBox(height: 20),

//                         // Send OTP Button
//                         ElevatedButton(
//                           onPressed: _isMobileValid
//                               ? _sendOtp
//                               : null, // Call _sendOtp only if mobile number is valid
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green.shade700,
//                             padding: EdgeInsets.symmetric(
//                                 horizontal: 50, vertical: 15),
//                           ),
//                           child: Text(
//                             'Login',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),

//                         // Don't Have An Account Text with Navigation
//                         TextButton(
//                           onPressed: () {
//                             // Navigate to the signup screen
//                             Navigator.pushNamed(context, '/signup');
//                           },
//                           child: Text(
//                             "Don't have an account?",
//                             style: TextStyle(
//                               color: Colors.green.shade800,
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 30), // Give some space before the skip button

//                 // Skip Button
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.0),
//                   child: TextButton.icon(
//                     onPressed: () {
//                       // Navigate to /multilanguage screen
//                       Navigator.pushNamed(context, '/multilanguage');
//                     },
//                     icon: Icon(Icons.arrow_forward, color: Colors.green),
//                     label: Text(
//                       'Skip',
//                       style: TextStyle(
//                         color: Colors.green.shade700,
//                         fontSize: 16,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';
import 'package:http/http.dart' as http; // Import the http package
import 'dart:convert'; // For encoding and decoding JSON

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _boxAnimation;

  // TextEditingController to capture mobile number input
  final TextEditingController _mobileController = TextEditingController();
  bool _isMobileValid = true; // Track the validity of the mobile number
  bool _isLoggingIn = false; // Track if the user is logging in

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _logoAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _boxAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _mobileController
        .dispose(); // Dispose the controller when the widget is disposed
    super.dispose();
  }

  // Function to validate the mobile number
  bool _validateMobileNumber(String input) {
    final RegExp mobileRegExp =
        RegExp(r'^[6-9]\d{9}$'); // Regex for Indian mobile numbers
    return mobileRegExp.hasMatch(input);
  }

  // Function to send OTP
  Future<void> _sendOtp() async {
    final String mobileNo = _mobileController.text;

    // Ensure the mobile number is valid
    if (!_isMobileValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a valid mobile number'),
        ),
      );
      return;
    }

    setState(() {
      _isLoggingIn = true; // Show loading state
    });

    final url =
        Uri.parse('http://192.168.97.193:8081/api/v1/otp/send'); // API endpoint

    final Map<String, String> requestPayload = {
      'mobileNo':
          "+91" + mobileNo, // Sending the mobile number in the request body
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestPayload), // Encode request body to JSON
      );

      if (response.statusCode == 200) {
        // If the API call is successful, navigate to the OTP verification screen
        Navigator.pushNamed(
          context,
          '/verifyOtp',
          arguments: mobileNo, // Pass the mobile number to the next screen
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to send OTP. Please try again.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    } finally {
      setState(() {
        _isLoggingIn = false; // Hide loading state
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: Colors.green.shade100,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),

                // Logo with Animation
                ScaleTransition(
                  scale: _logoAnimation,
                  child: Center(
                    child: Image.network(
                      'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // Login Box and Fields
                FadeTransition(
                  opacity: _boxAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Mobile Number Field
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextField(
                              controller:
                                  _mobileController, // Capture input here
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                labelText: 'Mobile Number',
                                border: OutlineInputBorder(),
                                prefixIcon:
                                    Icon(Icons.phone, color: Colors.green),
                                errorText: _isMobileValid
                                    ? null
                                    : 'Invalid mobile number',
                              ),
                              onChanged: (input) {
                                setState(() {
                                  _isMobileValid = _validateMobileNumber(input);
                                });
                              },
                            ),
                            SizedBox(height: 5),
                            // Optionally, display an error message directly below the field
                            if (!_isMobileValid)
                              Text(
                                '',
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                          ],
                        ),
                        SizedBox(height: 20),

                        // Send OTP Button
                        ElevatedButton(
                          onPressed: _isMobileValid && !_isLoggingIn
                              ? _sendOtp
                              : null, // Call _sendOtp only if mobile number is valid
                          style: ElevatedButton.styleFrom(
                            primary: _isMobileValid
                                ? Colors.green.shade700
                                : Colors.green.shade400, // Change button color
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: _isLoggingIn
                              ? CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Text(
                                  'Login',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),

                        // Don't Have An Account Text with Navigation
                        TextButton(
                          onPressed: () {
                            // Navigate to the signup screen
                            Navigator.pushNamed(context, '/signup');
                          },
                          child: Text(
                            "Don't have an account?",
                            style: TextStyle(
                              color: Colors.green.shade800,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30), // Give some space before the skip button

                // Skip Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextButton.icon(
                    onPressed: () {
                      // Navigate to /multilanguage screen
                      Navigator.pushNamed(context, '/multilanguage');
                    },
                    icon: Icon(Icons.arrow_forward, color: Colors.green),
                    label: Text(
                      'Skip',
                      style: TextStyle(
                        color: Colors.green.shade700,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
