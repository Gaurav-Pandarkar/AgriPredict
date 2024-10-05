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
import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

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
                        TextField(
                          controller: _mobileController, // Capture input here
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                            labelText: 'Mobile Number',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.phone, color: Colors.green),
                          ),
                        ),
                        SizedBox(height: 20),

                        // Send OTP Button
                        ElevatedButton(
                          onPressed: () {
                            if (_mobileController.text.isNotEmpty) {
                              // Navigate to VerifyOtpScreen with mobile number
                              Navigator.pushNamed(
                                context,
                                '/verifyOtp',
                                arguments: _mobileController
                                    .text, // Pass mobile number as argument
                              );
                            } else {
                              // Show some error if mobile number is empty
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Please enter a valid mobile number'),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            primary: Colors.green.shade700,
                            padding: EdgeInsets.symmetric(
                                horizontal: 50, vertical: 15),
                          ),
                          child: Text(
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
