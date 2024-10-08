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

class _HomeScreenState extends State<HomeScreen> {
  Future<Weather>? weather;
  double cropBoxScale = 1.0;
  double weatherBoxScale = 1.0;
  String? errorMessage;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWeather();
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
                                    mainAxisAlignment: MainAxisAlignment.center,
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
        currentIndex: 0,
        onTap: (index) {
          switch (index) {
            case 0:
              break; // Already on home screen
            case 1:
              Navigator.pushNamed(
                  context, '/diseasePredict'); // Navigate to Disease Prediction
              break;
            case 2:
              Navigator.pushNamed(
                  context, '/manageCrops'); // Navigate to Manage Crops
              break;
            case 3:
              Navigator.pushNamed(context, '/settings'); // Navigate to Settings
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
