// working properly
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

import 'input_capture.dart';
import 'taskbar.dart';

Map<String, String> weatherCodeDescriptions = {
  "1000": "Clear",
  "1100": "Mostly Clear",
  "1101": "Partly Cloudy",
  "1102": "Mostly Cloudy",
  "1001": "Cloudy",
  "2000": "Fog",
  "2100": "Light Fog",
  "3000": "Light Wind",
  "3001": "Wind",
  "3002": "Strong Wind",
  "4000": "Drizzle",
  "4001": "Rain",
  "4200": "Light Rain",
  "4201": "Heavy Rain",
  "5000": "Snow",
  "5001": "Flurries",
  "5100": "Light Snow",
  "5101": "Heavy Snow",
  "6000": "Freezing Drizzle",
  "6001": "Freezing Rain",
  "6200": "Light Freezing Rain",
  "6201": "Heavy Freezing Rain",
  "7000": "Ice Pellets",
  "7101": "Heavy Ice Pellets",
  "7102": "Light Ice Pellets",
  "8000": "Thunderstorm",
};

Future<String?> fetchCityName(double latitude, double longitude) async {
  final String apiKey =
      '07add8ab81c84173b7e0cf8364eb52a7'; // Replace with your actual API key
  final String url =
      'https://api.opencagedata.com/geocode/v1/json?q=$latitude,$longitude&key=$apiKey';

  try {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = json.decode(response.body);
      // Extracting _normalized_city from the JSON response
      final normalizedCity =
          jsonResponse['results'][0]['components']['_normalized_city'];
      return normalizedCity; // Return the city name
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  } catch (e) {
    print('Error occurred: $e');
  }

  return null; // Return null if there is an error or no city name found
}

class Weather {
  final String cityName;
  final double temperature;
  final String weatherDescription;

  Weather({
    required this.cityName,
    required this.temperature,
    required this.weatherDescription,
  });
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  Future<Weather>? weather;
  double cropBoxScale = 1.0;
  double weatherBoxScale = 1.0;
  String? errorMessage;
  bool isLoading = true;
  int _currentIndex = 0;
  late AnimationController _appBarController;
  late AnimationController _taskbarController;

  late AnimationController _animationController;
  late Animation<double> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 800),
    );

    // Define the slide animation
    _slideAnimation =
        Tween<double>(begin: -300, end: 0).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOut,
    ));

    // Start the animation when the screen is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController.forward();
    });

    fetchWeather();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      _showLocationDialog();
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition();
  }

  Future<void> _openLocationSettings() async {
    await Geolocator.openLocationSettings();
  }

  void _showLocationDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Location Services Disabled'),
        content: Text(
            'Location services are disabled. Please enable them in the settings.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              _openLocationSettings();
            },
            child: Text('Open Settings'),
          ),
        ],
      ),
    );
  }

  Future<void> fetchWeather() async {
    const String apiKey = 'WpNtxK3NOLZ4syiiroDQd6VMBROiNPi0';
    setState(() {
      isLoading = true;
    });

    try {
      Position position = await _determinePosition();
      double latitude = position.latitude;
      double longitude = position.longitude;

      // Fetch city name using latitude and longitude
      String? cityName = await fetchCityName(latitude, longitude);

      final String apiUrl =
          'https://api.tomorrow.io/v4/weather/realtime?location=$latitude,$longitude&apikey=$apiKey';

      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);

        await Future.delayed(Duration(seconds: 2));

        setState(() {
          // Fetch and map the weather code
          String rawWeatherCode =
              data['data']['values']['weatherCode']?.toString() ?? 'Unknown';
          String weatherDescription =
              weatherCodeDescriptions[rawWeatherCode] ?? 'Unknown';

          weather = Future.value(Weather(
            cityName: cityName ?? 'Unknown Location', // Use fetched city name
            temperature:
                (data['data']['values']['temperature'] as num).toDouble(),
            weatherDescription:
                weatherDescription, // Use the mapped description
          ));
          isLoading = false;
        });
      } else {
        setState(() {
          errorMessage = 'Failed to load weather data: ${response.statusCode}';
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        errorMessage = 'Error: $e';
        isLoading = false;
      });
    }
  }

//   @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
          // Return false to prevent navigating back
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            toolbarHeight: 100,
            backgroundColor:
                Color(0xFF387F39), // A deep green color for the background
            automaticallyImplyLeading: false,
            elevation: 6,
            title: Row(
              mainAxisAlignment: MainAxisAlignment
                  .spaceBetween, // Use space-between to prevent overflow
              children: [
                Row(
                  // Wrap this in a Row to handle logo and texts together
                  children: [
                    ClipOval(
                      child: Image.asset(
                        'assets/agriAI-logo.png',
                        height: 70,
                        width: 70,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'AgroAI',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w900,
                            color: Colors.white,
                            letterSpacing: 1.5,
                          ),
                        ),
                        SizedBox(
                            height:
                                5), // Small space between title and subtitle
                        Text(
                          'Smart Crop Management',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w300,
                            color: Color(0xFFFFFFFF), // White for subtitle
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                PopupMenuButton<String>(
                  icon: Icon(Icons.more_vert,
                      color: Colors.white), // Three dots icon
                  onSelected: (value) {
                    // Handle menu selections
                    if (value == 'settings') {
                      // Navigate to settings
                    } else if (value == 'notifications') {
                      // Navigate to notifications
                    }
                  },
                  itemBuilder: (BuildContext context) {
                    return [
                      PopupMenuItem<String>(
                        value: 'settings',
                        child: Row(
                          children: [
                            Icon(Icons.settings, color: Colors.black),
                            SizedBox(width: 10),
                            Text('Settings'),
                          ],
                        ),
                      ),
                      PopupMenuItem<String>(
                        value: 'notifications',
                        child: Row(
                          children: [
                            Icon(Icons.notifications, color: Colors.black),
                            SizedBox(width: 10),
                            Text('Notifications'),
                          ],
                        ),
                      ),
                    ];
                  },
                ),
              ],
            ),
          ),
          body: Container(
            decoration: BoxDecoration(color: Colors.green[100]),
            child: Column(
              children: [
                SizedBox(height: 8),

                GestureDetector(
                  onTap: () {},
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      cropBoxScale = details.delta.dx > 0 ? 1.1 : 1.0;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      cropBoxScale = 1.0;
                    });
                  },
                  child: AnimatedScale(
                    scale: cropBoxScale,
                    duration: Duration(milliseconds: 200),
                    child: MajorCropsSection(),
                  ),
                ),
                SizedBox(height: 20),

                GestureDetector(
                  onTap: fetchWeather,
                  onHorizontalDragUpdate: (details) {
                    setState(() {
                      weatherBoxScale = details.delta.dx > 0 ? 1.1 : 1.0;
                    });
                  },
                  onHorizontalDragEnd: (details) {
                    setState(() {
                      weatherBoxScale = 1.0;
                    });
                  },
                  child: AnimatedScale(
                    scale: weatherBoxScale,
                    duration: Duration(milliseconds: 200),
                    child: isLoading
                        ? CircularProgressIndicator()
                        : FutureBuilder<Weather>(
                            future: weather,
                            builder: (context, snapshot) {
                              if (snapshot.connectionState ==
                                  ConnectionState.waiting) {
                                return CircularProgressIndicator();
                              } else if (snapshot.hasError) {
                                return Text('Error: ${snapshot.error}');
                              } else if (snapshot.hasData) {
                                final weatherData = snapshot.data!;
                                return AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                  width: 250,
                                  height: 100,
                                  padding: EdgeInsets.all(16.0),
                                  decoration: BoxDecoration(
                                    color: Colors.grey[200],
                                    borderRadius: BorderRadius.circular(15),
                                    border: Border.all(
                                      color: Colors.blue,
                                      width: 2,
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black26,
                                        blurRadius: 4,
                                        offset: Offset(2, 2),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.network(
                                        'https://uxwing.com/wp-content/themes/uxwing/download/weather/weather-icon.png',
                                        height: 40,
                                        width: 40,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            weatherData.cityName,
                                            style: TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black87),
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
                                            weatherData.weatherDescription,
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
                              } else {
                                return Text('No data available');
                              }
                            },
                          ),
                  ),
                ),
                SizedBox(height: 10),

                // Image Capture Section
                ImageCaptureSection(),
              ],
            ),
          ),
          bottomNavigationBar: Taskbar(
            currentIndex: _currentIndex,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
        ));
  }
}

// Custom ClipPath for the curved background
class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    Path path = Path();
    path.lineTo(0, size.height - 80); // Start the curve from the bottom left
    path.quadraticBezierTo(size.width / 2, size.height, size.width,
        size.height - 80); // Create the curve
    path.lineTo(size.width, 0); // Finish the path at the top right
    path.close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    return true; // Reclip when the size changes
  }
}

class CropCard extends StatelessWidget {
  final Widget image; // Accepts an Image widget

  CropCard({required this.image});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80, // Smaller width
      height: 80, // Smaller height
      decoration: BoxDecoration(
        color: Colors.white, // White background color
        shape: BoxShape.circle, // Circular shape
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(
            40.0), // Half of width/height for circular display
        child: image, // Display the image passed to CropCard
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
                image: Image.asset('assets/soyabin.png',
                    fit: BoxFit.cover), // Local asset for Soybean
              ),
              CropCard(
                image: Image.asset('assets/cotton.png',
                    fit: BoxFit.cover), // Local asset for Cotton
              ),
              CropCard(
                image: Image.asset('assets/sugarcane.png',
                    fit: BoxFit.cover), // Local asset for Sugarcane
              ),
            ],
          ),
        ],
      ),
    );
  }
}
