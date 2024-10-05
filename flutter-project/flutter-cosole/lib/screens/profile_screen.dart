import 'package:flutter/material.dart';

class FarmerProfileScreen extends StatefulWidget {
  const FarmerProfileScreen({Key? key}) : super(key: key);

  @override
  _FarmerProfileScreenState createState() => _FarmerProfileScreenState();
}

class _FarmerProfileScreenState extends State<FarmerProfileScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    // Initialize the animation controller
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    // Define a fade animation
    _fadeAnimation = CurvedAnimation(
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
        title: Text('Farmer Profile'),
        backgroundColor: Colors.green.shade900,
      ),
      body: FadeTransition(
        opacity: _fadeAnimation,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Farmer Profile Card
              _buildProfileCard(),
              SizedBox(height: 20),
              // Additional Information Cards
              _buildInfoCard('Crops Grown', 'Wheat, Corn, Soybean', Icons.grain),
              _buildInfoCard('Farm Size', '25 acres', Icons.landscape),
              _buildInfoCard('Recent Activities', 'Planted new wheat seeds', Icons.update),
              _buildInfoCard('Soil Quality', 'Loamy, pH: 6.5', Icons.grass),
              _buildInfoCard('Weather Condition', 'Sunny, 30°C', Icons.wb_sunny),
              _buildInfoCard('Irrigation System', 'Drip irrigation', Icons.water),
            ],
          ),
        ),
      ),
      floatingActionButton: _buildEditProfileButton(),
    );
  }

  // Function to build the farmer's profile card
  Widget _buildProfileCard() {
    return Card(
      elevation: 8,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Row(
          children: [
            Hero(
              tag: 'farmerProfile',
              child: CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(
                  'https://www.pngrepo.com/png/39708/512/farmer.png',
                ),
              ),
            ),
            SizedBox(width: 20),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'John Doe',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.green.shade900,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Farmer since 2010',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey.shade700,
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Location: Springfield',
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

  // Function to build additional information cards
  Widget _buildInfoCard(String title, String info, IconData icon) {
    return GestureDetector(
      onTap: () {
        // Add functionality on tap (e.g., navigate to a detailed page)
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Card(
          elevation: 8,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          child: ListTile(
            leading: Icon(icon, size: 40, color: Colors.green.shade600),
            title: Text(
              title,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.green.shade800,
              ),
            ),
            subtitle: Text(
              info,
              style: TextStyle(
                fontSize: 16,
                color: Colors.grey.shade700,
              ),
            ),
          ),
        ),
      ),
    );
  }

  // Function to build the Edit Profile button
  Widget _buildEditProfileButton() {
    return ScaleTransition(
      scale: Tween(begin: 0.8, end: 1.0).animate(CurvedAnimation(
        parent: _controller,
        curve: Curves.elasticOut,
      )),
      child: FloatingActionButton(
        onPressed: () {
          // Add functionality for editing the profile
        },
        backgroundColor: Colors.green.shade600,
        child: AnimatedContainer(
          duration: Duration(milliseconds: 300),
          curve: Curves.easeInOut,
          child: Icon(Icons.edit, size: 30, color: Colors.white),
        ),
      ),
    );
  }
}
