// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';

// class VerifyOtpScreen extends StatefulWidget {
//   @override
//   _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
// }

// class _VerifyOtpScreenState extends State<VerifyOtpScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fieldAnimation;
//   late Animation<double> _buttonAnimation;
//   late bool _isVerifying;
//   late bool _isVerified;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();

//     _fieldAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.bounceOut,
//     );

//     _buttonAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     _isVerifying = false;
//     _isVerified = false;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _verifyOtp() async {
//     setState(() {
//       _isVerifying = true;
//     });

//     // Simulate OTP verification delay
//     await Future.delayed(Duration(seconds: 3));

//     setState(() {
//       _isVerifying = false;
//       _isVerified = true;
//     });

//     // Navigate to another screen or show success message
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
//                   scale: _fieldAnimation,
//                   child: Center(
//                     child: Image.network(
//                       'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
//                       height: 120,
//                       width: 120,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//                 // Verify OTP Box and Fields
//                 FadeTransition(
//                   opacity: _fieldAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           _isVerified ? 'OTP Verified!' : 'Verify OTP',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: _isVerified
//                                 ? Colors.green.shade700
//                                 : Colors.green.shade900,
//                           ),
//                         ),
//                         SizedBox(height: 30),

//                         // OTP Field (if not verified)
//                         if (!_isVerified)
//                           ScaleTransition(
//                             scale: _fieldAnimation,
//                             child: TextField(
//                               keyboardType: TextInputType.number,
//                               maxLength: 6, // Assuming OTP is 6 digits
//                               decoration: InputDecoration(
//                                 labelText: 'Enter OTP',
//                                 border: OutlineInputBorder(),
//                                 prefixIcon: Icon(Icons.lock_outline,
//                                     color: Colors.green),
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 20),

//                         // Verify OTP Button or Success Message
//                         _isVerifying
//                             ? CircularProgressIndicator(
//                                 color: Colors.green,
//                               )
//                             : ElevatedButton(
//                                 onPressed: _verifyOtp,
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.green.shade700,
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 50, vertical: 15),
//                                 ),
//                                 child: Text(
//                                   _isVerified ? 'Success!' : 'Verify OTP',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),

//                         SizedBox(height: 20),

//                         // Resend OTP TextButton (if not verified)
//                         if (!_isVerified)
//                           TextButton(
//                             onPressed: () {
//                               // Implement resend OTP functionality
//                             },
//                             child: Text(
//                               "Didn't receive the OTP? Resend",
//                               style: TextStyle(
//                                 color: Colors.green.shade800,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 30), // Add space before the skip button

//                 // Skip Button
//                 Padding(
//                   padding: const EdgeInsets.only(bottom: 20.0),
//                   child: TextButton.icon(
//                     onPressed: () {
//                       // Navigate to the dashboard or multilanguage screen
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

class VerifyOtpScreen extends StatefulWidget {
  @override
  _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
}

class _VerifyOtpScreenState extends State<VerifyOtpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fieldAnimation;
  late Animation<double> _buttonAnimation;
  late bool _isVerifying;
  late bool _isVerified;

  TextEditingController _otpController =
      TextEditingController(); // Controller for OTP input
  String mobileNo =
      ''; // Placeholder for mobile number received from previous screen

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _fieldAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.bounceOut,
    );

    _buttonAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );

    _isVerifying = false;
    _isVerified = false;
  }

  @override
  void dispose() {
    _controller.dispose();
    _otpController.dispose(); // Dispose the OTP controller
    super.dispose();
  }

  // Function to verify OTP by hitting API
  Future<void> _verifyOtp() async {
    setState(() {
      _isVerifying = true;
    });

    final String enteredOtp = _otpController.text;

    // Ensure OTP is not empty
    if (enteredOtp.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the OTP'),
        ),
      );
      setState(() {
        _isVerifying = false;
      });
      return;
    }

    final url = Uri.parse(
        'http://192.168.97.193:8081/api/v1/otp/verify'); // API endpoint

    final Map<String, String> requestPayload = {
      'mobileNo': "+91" + mobileNo, // Mobile number entered by the user
      'otp': enteredOtp, // OTP entered by the user
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestPayload), // Encode request body to JSON
      );

      if (response.statusCode == 200) {
        final responseData = json.decode(response.body);

        // Check if the responseCode is 200
        if (responseData['responseCode'] == "200") {
          setState(() {
            _isVerified = true;
          });

          // Show success message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(responseData['message']),
            ),
          );

          // Navigate to the multilanguage support screen
          Navigator.pushNamed(context, '/multilanguage');
        } else {
          // If responseCode is not 200, show failure message
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('OTP verification failed. Please try again.'),
            ),
          );

          // Navigate back to login screen
          Navigator.pushNamed(context, '/login');
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to verify OTP. Please try again.'),
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: $e'),
        ),
      );
    }

    setState(() {
      _isVerifying = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    // Retrieve the mobile number passed from the previous screen
    final String? mobileArgument =
        ModalRoute.of(context)?.settings.arguments as String?;
    if (mobileArgument != null) {
      mobileNo = mobileArgument; // Set mobile number
    }

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
                  scale: _fieldAnimation,
                  child: Center(
                    child: Image.network(
                      'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
                      height: 120,
                      width: 120,
                    ),
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),

                // Verify OTP Box and Fields
                FadeTransition(
                  opacity: _fieldAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      children: [
                        Text(
                          _isVerified ? 'OTP Verified!' : 'Verify OTP',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: _isVerified
                                ? Colors.green.shade700
                                : Colors.green.shade900,
                          ),
                        ),
                        SizedBox(height: 30),

                        // OTP Field (if not verified)
                        if (!_isVerified)
                          ScaleTransition(
                            scale: _fieldAnimation,
                            child: TextField(
                              controller: _otpController, // Capture OTP input
                              keyboardType: TextInputType.number,
                              maxLength: 6, // Assuming OTP is 6 digits
                              decoration: InputDecoration(
                                labelText: 'Enter OTP',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(Icons.lock_outline,
                                    color: Colors.green),
                              ),
                            ),
                          ),
                        SizedBox(height: 20),

                        // Verify OTP Button or Success Message
                        _isVerifying
                            ? CircularProgressIndicator(
                                color: Colors.green,
                              )
                            : ElevatedButton(
                                onPressed:
                                    _verifyOtp, // Call _verifyOtp on button press
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.green.shade700,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 50, vertical: 15),
                                ),
                                child: Text(
                                  _isVerified ? 'Success!' : 'Verify OTP',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                        SizedBox(height: 20),

                        // Resend OTP TextButton (if not verified)
                        if (!_isVerified)
                          TextButton(
                            onPressed: () {
                              // Implement resend OTP functionality
                            },
                            child: Text(
                              "Didn't receive the OTP? Resend",
                              style: TextStyle(
                                color: Colors.green.shade800,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),

                SizedBox(height: 30), // Add space before the skip button

                // Skip Button
                Padding(
                  padding: const EdgeInsets.only(bottom: 20.0),
                  child: TextButton.icon(
                    onPressed: () {
                      // Navigate to the dashboard or multilanguage screen
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













//not working
// import 'package:flutter/material.dart';
// import 'package:flutter/animation.dart';

// class VerifyOtpScreen extends StatefulWidget {
//   @override
//   _VerifyOtpScreenState createState() => _VerifyOtpScreenState();
// }

// class _VerifyOtpScreenState extends State<VerifyOtpScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fieldAnimation;
//   late Animation<double> _buttonAnimation;
//   late bool _isVerifying;
//   late bool _isVerified;
//   final TextEditingController _otpController = TextEditingController();

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();

//     _fieldAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.bounceOut,
//     );

//     _buttonAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeInOut,
//     );

//     _isVerifying = false;
//     _isVerified = false;
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     _otpController.dispose();
//     super.dispose();
//   }

//   void _verifyOtp() async {
//     // Validate OTP input
//     if (_otpController.text.length < 6) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text("Please enter a valid OTP")),
//       );
//       return;
//     }

//     setState(() {
//       _isVerifying = true;
//     });

//     // Simulate OTP verification delay
//     await Future.delayed(Duration(seconds: 3));

//     setState(() {
//       _isVerifying = false;
//       _isVerified = true;
//     });

//     // Navigate based on the route
//     String currentRoute = ModalRoute.of(context)?.settings.name ?? '';
//     await Future.delayed(Duration(seconds: 3)); // Delay before navigation
//     if (currentRoute == '/signup') {
//       Navigator.pushReplacementNamed(context, '/login');
//     } else if (currentRoute == '/login') {
//       Navigator.pushReplacementNamed(context, '/multilanguage');
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
//                   scale: _fieldAnimation,
//                   child: Center(
//                     child: Image.network(
//                       'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
//                       height: 120,
//                       width: 120,
//                     ),
//                   ),
//                 ),
//                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),

//                 // Verify OTP Box and Fields
//                 FadeTransition(
//                   opacity: _fieldAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Column(
//                       children: [
//                         Text(
//                           _isVerified ? 'OTP Verified!' : 'Verify OTP',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: _isVerified
//                                 ? Colors.green.shade700
//                                 : Colors.green.shade900,
//                           ),
//                         ),
//                         SizedBox(height: 30),

//                         // OTP Field (if not verified)
//                         if (!_isVerified)
//                           ScaleTransition(
//                             scale: _fieldAnimation,
//                             child: TextField(
//                               controller: _otpController,
//                               keyboardType: TextInputType.number,
//                               maxLength: 6, // Assuming OTP is 6 digits
//                               decoration: InputDecoration(
//                                 labelText: 'Enter OTP',
//                                 border: OutlineInputBorder(),
//                                 prefixIcon: Icon(Icons.lock_outline,
//                                     color: Colors.green),
//                               ),
//                             ),
//                           ),
//                         SizedBox(height: 20),

//                         // Verify OTP Button or Success Message
//                         _isVerifying
//                             ? CircularProgressIndicator(
//                                 color: Colors.green,
//                               )
//                             : ElevatedButton(
//                                 onPressed: _verifyOtp,
//                                 style: ElevatedButton.styleFrom(
//                                   primary: Colors.green.shade700,
//                                   padding: EdgeInsets.symmetric(
//                                       horizontal: 50, vertical: 15),
//                                 ),
//                                 child: Text(
//                                   _isVerified ? 'Success!' : 'Verify OTP',
//                                   style: TextStyle(
//                                     color: Colors.white,
//                                     fontSize: 18,
//                                     fontWeight: FontWeight.bold,
//                                   ),
//                                 ),
//                               ),

//                         SizedBox(height: 20),

//                         // Resend OTP TextButton (if not verified)
//                         if (!_isVerified)
//                           TextButton(
//                             onPressed: () {
//                               // Implement resend OTP functionality
//                             },
//                             child: Text(
//                               "Didn't receive the OTP? Resend",
//                               style: TextStyle(
//                                 color: Colors.green.shade800,
//                                 fontWeight: FontWeight.w600,
//                               ),
//                             ),
//                           ),
//                       ],
//                     ),
//                   ),
//                 ),

//                 SizedBox(height: 30), // Removed Skip Button space
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
