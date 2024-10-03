import 'package:flutter/material.dart';
import 'input_capture.dart';
import 'taskbar.dart'; // Import the Taskbar widget

class Weather {
  final String cityName;
  final double temperature;
  final String weatherDescription;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
  });

  static Weather fakeWeather() {
    return Weather(
      cityName: "Pune",
      temperature: 30.0,
      weatherDescription: "Partly Cloudy",
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<Weather> weather;
  double cropBoxScale = 1.0; // Scale for crop box hover effect
  double weatherBoxScale = 1.0; // Scale for weather box hover effect

  @override
  void initState() {
    super.initState();
    weather = Future.delayed(Duration(seconds: 2), () => Weather.fakeWeather());
  }

  void refreshWeather() {
    setState(() {
      weather =
          Future.delayed(Duration(seconds: 2), () => Weather.fakeWeather());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 100,
        backgroundColor: Colors.green[800],
        elevation: 5,
        title: Row(
          children: [
            ClipOval(
              child: Image.network(
                'https://www.pngplay.com/wp-content/uploads/6/Agriculture-Logo-Clipart-PNG.png',
                height: 70,
                width: 70,
                fit: BoxFit.cover,
              ),
            ),
            SizedBox(width: 10),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('AgriPredict',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ],
            ),
          ],
        ),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.green[100]),
        child: Column(
          children: [
            SizedBox(height: 8), // Small gap between AppBar and boxes

            // Crop box with animation and hover effect
            GestureDetector(
              onTap: () {}, // You can add any functionality on tap
              onHorizontalDragUpdate: (details) {
                // Allow dragging the crop box
                setState(() {
                  cropBoxScale = details.delta.dx > 0 ? 1.1 : 1.0;
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  cropBoxScale = 1.0; // Reset scale after drag
                });
              },
              child: AnimatedScale(
                scale: cropBoxScale,
                duration: Duration(milliseconds: 200),
                child: MajorCropsSection(), // Add the crop section here
              ),
            ),
            SizedBox(height: 20),

            // Weather box with animation and hover effect
            GestureDetector(
              onTap: refreshWeather, // Refresh the weather data
              onHorizontalDragUpdate: (details) {
                // Allow dragging the weather box
                setState(() {
                  weatherBoxScale = details.delta.dx > 0 ? 1.1 : 1.0;
                });
              },
              onHorizontalDragEnd: (details) {
                setState(() {
                  weatherBoxScale = 1.0; // Reset scale after drag
                });
              },
              child: AnimatedScale(
                scale: weatherBoxScale,
                duration: Duration(milliseconds: 200),
                child: FutureBuilder<Weather>(
                  future: weather,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      final weatherData = snapshot.data!;
                      return AnimatedContainer(
                        duration:
                            Duration(milliseconds: 300), // Animation duration
                        curve: Curves.easeInOut, // Animation curve
                        width: 250, // Adjusted width
                        height: 100, // Adjusted height for the weather box
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.grey[200], // Whitish-gray inner color
                          borderRadius:
                              BorderRadius.circular(15), // Rounded box
                          border: Border.all(
                            color: Colors.blue, // Blue border
                            width: 2,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 4,
                              offset: Offset(2, 2), // Shadow position
                            ),
                          ],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment
                              .spaceEvenly, // Align horizontally
                          children: [
                            Image.network(
                              'https://uxwing.com/wp-content/themes/uxwing/download/weather/weather-icon.png', // Weather icon
                              height: 40,
                              width: 40,
                            ),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${weatherData.cityName}',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color:
                                          Colors.black87), // Darker text color
                                ),
                                Text(
                                  '${weatherData.temperature} °C',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                Text(
                                  '${weatherData.weatherDescription}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black54,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }
                  },
                ),
              ),
            ),

            SizedBox(height: 20), // Spacing before the image capture section

            // Add ImageCaptureSection here
            ImageCaptureSection(), // Integrate the image capture section here
          ],
        ),
      ),
      bottomNavigationBar: Taskbar(
        // Add the Taskbar here
        currentIndex: 0, // Set the current index as needed
        onTap: (index) {
          // Handle the tap on the taskbar
          // You can implement navigation to the respective screens based on the index
          switch (index) {
            case 0:
              Navigator.pushNamed(context, '/home'); // Home
              break;
            case 1:
              Navigator.pushNamed(context, '/selfnotes'); // SelfNotes
              break;
            case 2:
              Navigator.pushNamed(context, '/agronomist'); // Agronomist
              break;
            case 3:
              Navigator.pushNamed(context, '/profile'); // Profile
              break;
          }
        },
      ),
    );
  }
}

class CropCard extends StatelessWidget {
  final String imageUrl;

  CropCard({required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white, // Inner background color
          border: Border.all(
            color: Colors.blueAccent, // Border color
            width: 2,
          ),
        ),
        child: ClipOval(
          child: Image.network(
            imageUrl,
            height: 80,
            width: 80,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

class MajorCropsSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              CropCard(
                imageUrl:
                    "https://media.istockphoto.com/vectors/vector-bunch-with-outline-soybean-or-soy-bean-plant-with-ripe-pods-vector-id1057630574?k=6&m=1057630574&s=612x612&w=0&h=8Q9Yjru4kFSkJ3Nx_2HW1ltsIIUl6cbK12s0mGbDHrM=",
              ),
              CropCard(
                imageUrl:
                    "https://media.istockphoto.com/id/486069279/vector/cotton.jpg?s=612x612&w=0&k=20&c=R5jY1zRMrJU_ikfYkKOtw-5r0PtRS4QmnfSFXv6xTq0=",
              ),
              CropCard(
                imageUrl:
                    "https://static.vecteezy.com/system/resources/previews/032/329/721/large_2x/sugarcane-transparent-background-ai-generative-free-png.png",
              ),
            ],
          ),
        ],
      ),
    );
  }
}
