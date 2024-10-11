import 'dart:convert'; // For handling JSON
import 'dart:io'; // For file handling
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:permission_handler/permission_handler.dart'; // For permission handling
import 'package:http/http.dart' as http; // For sending HTTP requests
import 'recommendation.dart'; // Import your recommendation screen

class ImageCaptureSection extends StatefulWidget {
  @override
  _ImageCaptureSectionState createState() => _ImageCaptureSectionState();
}

class _ImageCaptureSectionState extends State<ImageCaptureSection> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;
  bool _isLoading = false; // To control the spinner

  Future<void> _pickImageFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _imageFile = image;
        _convertToJpgAndSend(File(image.path));
      }
    } else {
      _showPermissionDeniedSnackBar('Camera permission is denied.');
    }
  }

  Future<void> _pickImageFromGallery() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _imageFile = image;
        _convertToJpgAndSend(File(image.path));
      }
    } else {
      _showPermissionDeniedSnackBar('Gallery access is denied.');
    }
  }

  Future<void> _convertToJpgAndSend(File imageFile) async {
    try {
      // Show loading spinner
      setState(() {
        _isLoading = true;
      });

      // Sending to the API
      print("Selected Image File Path: ${imageFile.path}");
      await _sendImageToServer(imageFile);
    } catch (e) {
      print('Error processing image: $e');
    } finally {
      // Hide loading spinner
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<void> _sendImageToServer(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'https://59c9-103-174-140-112.ngrok-free.app/identify'), // Replace with your API endpoint
    );

    // Add the image to the request
    request.files
        .add(await http.MultipartFile.fromPath('image', imageFile.path));

    // Add headers if needed
    request.headers.addAll({
      'Content-Type': 'multipart/form-data',
    });

    var response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await http.Response.fromStream(response);
      print('Success: ${responseBody.body}');

      var jsonResponse = jsonDecode(responseBody.body);

      // Check for errors in the response
      if (jsonResponse.containsKey('error')) {
        String errorMessage = jsonResponse['error'];
        _showErrorAlert(errorMessage);
      } else {
        // Extract disease and plant name
        String disease = jsonResponse['disease'];
        String plantName =
            jsonResponse['plant_name']; // Make sure the API provides this value

        print('Disease: $disease');
        print('Plant: $plantName');

        // Navigate to RecommendationScreen with the disease name and plant name
        _navigateToRecommendationScreen(disease, plantName);
      }
    } else {
      print('Error: ${response.statusCode}');
      _showErrorAlert('An error occurred while processing your request.');
    }
  }

  void _navigateToRecommendationScreen(String disease, String plantName) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => RecommendationScreen(
          disease: disease,
          plantName:
              plantName, // Pass the plant name to the RecommendationScreen
        ),
      ),
    );
  }

  void _showPermissionDeniedSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _showErrorAlert(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AnimatedOpacity(
          opacity: 1.0,
          duration: Duration(milliseconds: 300),
          child: AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // Rounded corners
            ),
            backgroundColor: Colors.white, // Solid white background
            title: Text(
              'Error',
              style: TextStyle(
                color: Colors.redAccent, // Attractive title color
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            content: Text(
              message,
              style: TextStyle(
                color: Colors.black, // Text color
                fontSize: 16,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close the dialog
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                    color: Colors.blueAccent, // Button text color
                    fontSize: 18,
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        border: Border.all(color: Colors.blue, width: 2), // Added blue border
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            blurRadius: 10,
            offset: Offset(0, 5), // Shadow offset
          ),
        ],
      ),
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Capture or Upload Image',
            style: TextStyle(
              fontSize: 22, // Reduced font size for better fitting
              fontWeight: FontWeight.bold,
              color: Colors.black, // Text color set to black
              letterSpacing: 1.2,
            ),
            maxLines: 1, // Ensure text is in one line
            overflow:
                TextOverflow.ellipsis, // Handle overflow if text is too long
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(
                child: _buildImageButton(
                  iconUrl:
                      'assets/camera.png', // Use local asset for the camera icon
                  label: 'Camera',
                  onPressed: _pickImageFromCamera,
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                child: _buildImageButton(
                  iconUrl:
                      'assets/upload.png', // Use local asset for the upload icon
                  label: 'Upload',
                  onPressed: _pickImageFromGallery,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          if (_isLoading) ...[
            Center(
              child: CircularProgressIndicator(
                valueColor:
                    AlwaysStoppedAnimation<Color>(Colors.teal), // Spinner color
              ),
            ),
            SizedBox(height: 20),
          ],
        ],
      ),
    );
  }

  Widget _buildImageButton({
    required String iconUrl,
    required String label,
    required VoidCallback onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        decoration: BoxDecoration(
          color: Colors.teal[600], // Changed button color to teal
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.teal.withOpacity(0.3),
              blurRadius: 8,
              offset: Offset(0, 4),
            ),
          ],
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              iconUrl,
              height: 28,
              width: 28,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                color: Colors.white, // Keep text color white for contrast
                fontSize: 16, // Reduced font size to fit better
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
