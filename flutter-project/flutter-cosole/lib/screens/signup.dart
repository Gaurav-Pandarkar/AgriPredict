// // import 'package:flutter/material.dart';

// // class SignUpScreen extends StatelessWidget {
// //   const SignUpScreen({Key? key}) : super(key: key);

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Container(
// //         decoration: BoxDecoration(
// //           gradient: LinearGradient(
// //             colors: [
// //               Colors.green.shade300,
// //               Colors.green.shade700,
// //             ],
// //             begin: Alignment.topLeft,
// //             end: Alignment.bottomRight,
// //           ),
// //         ),
// //         child: Center(
// //           child: SingleChildScrollView(
// //             child: Column(
// //               mainAxisAlignment: MainAxisAlignment.center,
// //               children: [
// //                 // Logo with Animation
// //                 AnimatedContainer(
// //                   duration: Duration(seconds: 1),
// //                   curve: Curves.easeInOut,
// //                   width: 100,
// //                   height: 100,
// //                   child: Image.network(
// //                     'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
// //                   ),
// //                 ),
// //                 SizedBox(height: 20),

// //                 // Sign Up Box
// //                 Container(
// //                   width: 300,
// //                   padding: EdgeInsets.symmetric(vertical: 20, horizontal: 16),
// //                   decoration: BoxDecoration(
// //                     color: Colors.white,
// //                     borderRadius: BorderRadius.circular(12),
// //                     boxShadow: [
// //                       BoxShadow(
// //                         color: Colors.black.withOpacity(0.2),
// //                         blurRadius: 10,
// //                         offset: Offset(0, 5),
// //                       ),
// //                     ],
// //                   ),
// //                   child: Column(
// //                     children: [
// //                       // Sign Up Text
// //                       Text(
// //                         'Sign Up',
// //                         style: TextStyle(
// //                           fontSize: 24,
// //                           fontWeight: FontWeight.bold,
// //                           color: Colors.green.shade700,
// //                         ),
// //                       ),
// //                       SizedBox(height: 20),

// //                       // Username Field
// //                       TextField(
// //                         decoration: InputDecoration(
// //                           labelText: 'Username',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(height: 16),

// //                       // Mobile Number Field
// //                       TextField(
// //                         decoration: InputDecoration(
// //                           labelText: 'Mobile Number',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(height: 16),

// //                       // Password Field
// //                       TextField(
// //                         obscureText: true,
// //                         decoration: InputDecoration(
// //                           labelText: 'Password',
// //                           border: OutlineInputBorder(
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                         ),
// //                       ),
// //                       SizedBox(height: 20),

// //                       // Sign Up Button
// //                       ElevatedButton(
// //                         onPressed: () {
// //                           // Handle sign up
// //                         },
// //                         child: Text('Sign Up'),
// //                         style: ElevatedButton.styleFrom(
// //                           primary: Colors.green.shade600,
// //                           padding: EdgeInsets.symmetric(vertical: 12),
// //                           shape: RoundedRectangleBorder(
// //                             borderRadius: BorderRadius.circular(8),
// //                           ),
// //                         ),
// //                       ),
// //                     ],
// //                   ),
// //                 ),
// //               ],
// //             ),
// //           ),
// //         ),
// //       ),
// //     );
// //   }
// // }
// import 'package:flutter/material.dart';
// import 'otpverify.dart'; // Make sure to create this screen
// import 'login.dart'; // Make sure to create this screen

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({Key? key}) : super(key: key);

//   @override
//   _SignUpScreenState createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _logoAnimation;
//   late Animation<double> _boxAnimation;

//   final TextEditingController _mobileController = TextEditingController();
//   bool _isMobileValid = true;

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
//     _mobileController.dispose();
//     super.dispose();
//   }

//   bool _validateMobileNumber(String input) {
//     final RegExp mobileRegExp = RegExp(r'^[6-9]\d{9}$');
//     return mobileRegExp.hasMatch(input);
//   }

//   void _navigateToVerifyOtp() {
//     if (_validateMobileNumber(_mobileController.text)) {
//       // Check if the widget is mounted before navigating
//       if (mounted) {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//               builder: (context) =>
//                   VerifyOtpScreen()), // Replace with your OTP screen
//         );
//       }
//     } else {
//       setState(() {
//         _isMobileValid = false;
//       });
//     }
//   }

//   void _navigateToLogin() {
//     if (mounted) {
//       Navigator.pushReplacement(
//         context,
//         MaterialPageRoute(
//             builder: (context) =>
//                 LoginScreen()), // Replace with your login screen
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

//                 // Sign Up Box and Fields
//                 FadeTransition(
//                   opacity: _boxAnimation,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.stretch,
//                       children: [
//                         Text(
//                           'Sign Up',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green.shade900,
//                           ),
//                         ),
//                         SizedBox(height: 30),

//                         // Mobile Number Field
//                         TextField(
//                           controller: _mobileController,
//                           keyboardType: TextInputType.phone,
//                           decoration: InputDecoration(
//                             labelText: 'Mobile Number',
//                             errorText:
//                                 _isMobileValid ? null : 'Invalid mobile number',
//                             border: OutlineInputBorder(),
//                             prefixIcon: Icon(Icons.phone, color: Colors.green),
//                           ),
//                           onChanged: (input) {
//                             setState(() {
//                               _isMobileValid = _validateMobileNumber(input);
//                             });
//                           },
//                         ),
//                         SizedBox(height: 20),

//                         // Next Button
//                         ElevatedButton(
//                           onPressed: _navigateToVerifyOtp,
//                           style: ElevatedButton.styleFrom(
//                             primary: Colors.green.shade700,
//                             padding: EdgeInsets.symmetric(vertical: 15),
//                           ),
//                           child: Text(
//                             'Next',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.bold,
//                             ),
//                           ),
//                         ),
//                         SizedBox(height: 20),

//                         // Already have an Account? Navigate to Login
//                         TextButton(
//                           onPressed: _navigateToLogin,
//                           child: Text(
//                             "Already have an account? Login",
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
//                       if (mounted) {
//                         Navigator.pushNamed(context, '/multilanguage');
//                       }
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
import 'otpverify.dart'; // Make sure to create this screen
import 'login.dart'; // Make sure to create this screen

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _logoAnimation;
  late Animation<double> _boxAnimation;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _mobileController = TextEditingController();
  bool _isMobileValid = true;

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
    _usernameController.dispose();
    _mobileController.dispose();
    super.dispose();
  }

  bool _validateMobileNumber(String input) {
    final RegExp mobileRegExp = RegExp(r'^[6-9]\d{9}$');
    return mobileRegExp.hasMatch(input);
  }

  void _navigateToVerifyOtp() {
    if (_validateMobileNumber(_mobileController.text)) {
      // Check if the widget is mounted before navigating
      if (mounted) {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  VerifyOtpScreen()), // Replace with your OTP screen
        );
      }
    } else {
      setState(() {
        _isMobileValid = false;
      });
    }
  }

  void _navigateToLogin() {
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
            builder: (context) =>
                LoginScreen()), // Replace with your login screen
      );
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

                // Sign Up Box and Fields
                FadeTransition(
                  opacity: _boxAnimation,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 30.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade900,
                          ),
                        ),
                        SizedBox(height: 30),

                        // Username Field
                        TextField(
                          controller: _usernameController,
                          decoration: InputDecoration(
                            labelText: 'Username',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.person, color: Colors.green),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Mobile Number Field
                        TextField(
                          controller: _mobileController,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            errorText:
                                _isMobileValid ? null : 'Invalid mobile number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone, color: Colors.green),
                          ),
                          onChanged: (input) {
                            setState(() {
                              _isMobileValid = _validateMobileNumber(input);
                            });
                          },
                        ),
                        SizedBox(height: 20),

                        // Next Button
                        ElevatedButton(
                          onPressed: _navigateToVerifyOtp,
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade700,
                            padding: EdgeInsets.symmetric(vertical: 15),
                          ),
                          child: Text(
                            'Next',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Already have an Account? Navigate to Login
                        TextButton(
                          onPressed: _navigateToLogin,
                          child: Text(
                            "Already have an account? Login",
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
                      if (mounted) {
                        Navigator.pushNamed(context, '/multilanguage');
                      }
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
