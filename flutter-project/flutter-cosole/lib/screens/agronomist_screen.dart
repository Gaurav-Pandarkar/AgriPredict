// import 'package:flutter/material.dart';

// class AgronomistScreen extends StatefulWidget {
//   const AgronomistScreen({Key? key}) : super(key: key);

//   @override
//   _AgronomistScreenState createState() => _AgronomistScreenState();
// }

// class _AgronomistScreenState extends State<AgronomistScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeInAnimation;

//   @override
//   void initState() {
//     super.initState();

//     // Animation controller for smooth entrance of content
//     _controller = AnimationController(
//       duration: const Duration(seconds: 2),
//       vsync: this,
//     )..forward();

//     // Fade-in animation for smooth transition
//     _fadeInAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Agronomist'),
//         backgroundColor:
//             Colors.green.shade700, // A green, nature-friendly color
//       ),
//       body: Stack(
//         children: [
//           // Animated Background
//           AnimatedBackground(),
//           FadeTransition(
//             opacity: _fadeInAnimation,
//             child: Padding(
//               padding: const EdgeInsets.all(16.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.stretch,
//                 children: [
//                   SizedBox(height: 20),

//                   // Title
//                   Text(
//                     'Agronomist Services',
//                     textAlign: TextAlign.center,
//                     style: TextStyle(
//                       fontSize: 28,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green.shade900,
//                     ),
//                   ),
//                   SizedBox(height: 20),

//                   // Card with Information
//                   Expanded(
//                     child: ListView(
//                       children: [
//                         _buildInfoCard(
//                           icon: Icons.agriculture,
//                           title: 'Soil Analysis',
//                           description:
//                               'Get detailed soil analysis for optimal crop growth.',
//                         ),
//                         _buildInfoCard(
//                           icon: Icons.nature,
//                           title: 'Crop Consultation',
//                           description:
//                               'Receive expert advice on crop selection and care.',
//                         ),
//                         _buildInfoCard(
//                           icon: Icons.water_damage,
//                           title: 'Irrigation Techniques',
//                           description:
//                               'Optimize irrigation methods for better water usage.',
//                         ),
//                       ],
//                     ),
//                   ),

//                   // Schedule Consultation Button
//                   Padding(
//                     padding: const EdgeInsets.symmetric(vertical: 16.0),
//                     child: ElevatedButton(
//                       onPressed: () {
//                         // Handle button press to schedule a consultation
//                       },
//                       style: ElevatedButton.styleFrom(
//                         primary: Colors.green.shade600,
//                         padding:
//                             EdgeInsets.symmetric(vertical: 15, horizontal: 30),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(25),
//                         ),
//                       ),
//                       child: Text(
//                         'Schedule Consultation',
//                         style: TextStyle(
//                           fontSize: 18,
//                           color: Colors.white,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   // Function to build each info card
//   Widget _buildInfoCard(
//       {required IconData icon,
//       required String title,
//       required String description}) {
//     return Card(
//       elevation: 4,
//       margin: EdgeInsets.symmetric(vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Row(
//           children: [
//             Icon(icon, size: 40, color: Colors.green.shade700),
//             SizedBox(width: 20),
//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     title,
//                     style: TextStyle(
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.green.shade800,
//                     ),
//                   ),
//                   SizedBox(height: 5),
//                   Text(
//                     description,
//                     style: TextStyle(
//                       fontSize: 16,
//                       color: Colors.grey.shade700,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// // Custom Animated Background Widget
// class AnimatedBackground extends StatefulWidget {
//   @override
//   _AnimatedBackgroundState createState() => _AnimatedBackgroundState();
// }

// class _AnimatedBackgroundState extends State<AnimatedBackground>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<Color?> _colorAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 5),
//       vsync: this,
//     )..repeat(reverse: true); // Repeat animation

//     _colorAnimation = ColorTween(
//       begin: Colors.lightGreen.shade100,
//       end: Colors.lightGreen.shade300,
//     ).animate(_controller);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return AnimatedBuilder(
//       animation: _colorAnimation,
//       builder: (context, child) {
//         return Container(
//           color: _colorAnimation.value,
//         );
//       },
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
// }
import 'package:flutter/material.dart';
import 'schedule_consultation.dart';  // Import your new screen

class AgronomistScreen extends StatefulWidget {
  const AgronomistScreen({Key? key}) : super(key: key);

  @override
  _AgronomistScreenState createState() => _AgronomistScreenState();
}

class _AgronomistScreenState extends State<AgronomistScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeInAnimation;

  @override
  void initState() {
    super.initState();

    // Animation controller for smooth entrance of content
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    // Fade-in animation for smooth transition
    _fadeInAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agronomist'),
        backgroundColor: Colors.green.shade700,
      ),
      body: Stack(
        children: [
          // Animated Background
          // AnimatedBackground(),
          FadeTransition(
            opacity: _fadeInAnimation,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(height: 20),
                  Text(
                    'Agronomist Services',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  SizedBox(height: 20),
                  Expanded(
                    child: ListView(
                      children: [
                        _buildInfoCard(
                          icon: Icons.agriculture,
                          title: 'Soil Analysis',
                          description:
                              'Get detailed soil analysis for optimal crop growth.',
                        ),
                        _buildInfoCard(
                          icon: Icons.nature,
                          title: 'Crop Consultation',
                          description:
                              'Receive expert advice on crop selection and care.',
                        ),
                        _buildInfoCard(
                          icon: Icons.water_damage,
                          title: 'Irrigation Techniques',
                          description:
                              'Optimize irrigation methods for better water usage.',
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 16.0),
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ScheduleConsultationScreen(),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.green.shade600,
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text(
                        'Schedule Consultation',
                        style: TextStyle(
                          fontSize: 18,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInfoCard({
    required IconData icon,
    required String title,
    required String description,
  }) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Icon(icon, size: 40, color: Colors.green.shade700),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade800,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    description,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
