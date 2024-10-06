// import 'dart:io'; // For file handling
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images
// import 'package:permission_handler/permission_handler.dart'; // For permission handling
// import 'recommendation.dart'; // Import your recommendation screen

// class ImageCaptureSection extends StatefulWidget {
//   @override
//   _ImageCaptureSectionState createState() => _ImageCaptureSectionState();
// }

// class _ImageCaptureSectionState extends State<ImageCaptureSection> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;

//   Future<void> _pickImageFromCamera() async {
//     var status = await Permission.camera.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         _processImage(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Camera permission is denied.');
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     var status = await Permission.storage.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         _processImage(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Gallery access is denied.');
//     }
//   }

//   void _processImage(File imageFile) {
//     final imageBytes = imageFile.readAsBytesSync();
//     print("Image processed and ready for model input: ${imageFile.path}");
//   }

//   void _showPermissionDeniedSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

// working properly without error
// import 'dart:convert'; // For handling JSON
// import 'dart:io'; // For file handling
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images
// import 'package:permission_handler/permission_handler.dart'; // For permission handling
// import 'package:http/http.dart' as http; // For sending HTTP requests
// import 'recommendation.dart'; // Import your recommendation screen

// class ImageCaptureSection extends StatefulWidget {
//   @override
//   _ImageCaptureSectionState createState() => _ImageCaptureSectionState();
// }

// class _ImageCaptureSectionState extends State<ImageCaptureSection> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;

//   Future<void> _pickImageFromCamera() async {
//     var status = await Permission.camera.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Camera permission is denied.');
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     var status = await Permission.storage.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Gallery access is denied.');
//     }
//   }

//   Future<void> _convertToJpgAndSend(File imageFile) async {
//     try {
//       // Ensure the file is in JPG format (though the picker mostly provides correct formats)
//       final jpgImageFile = await _convertToJpg(imageFile);

//       // Sending to the API
//       print("Selected Image File Path: ${jpgImageFile.path}");
//       await _sendImageToServer(jpgImageFile);
//     } catch (e) {
//       print('Error processing image: $e');
//     }
//   }

//   Future<File> _convertToJpg(File imageFile) async {
//     // In most cases, if the image is already a .jpg or .jpeg, you don’t need to do anything
//     if (imageFile.path.endsWith('.jpg') || imageFile.path.endsWith('.jpeg')) {
//       return imageFile;
//     }

//     return imageFile;
//   }

//   Future<void> _sendImageToServer(File imageFile) async {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(
//           'http://192.168.97.238:5000/identify'), // Replace with your API endpoint
//     );

//     // Add the image to the request
//     request.files
//         .add(await http.MultipartFile.fromPath('image', imageFile.path));

//     // Add headers if needed
//     request.headers.addAll({
//       'Content-Type': 'multipart/form-data',
//     });

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       var responseBody = await http.Response.fromStream(response);
//       print('Success: ${responseBody.body}');

//       var jsonResponse = jsonDecode(responseBody.body);

//       // Extract disease and confidence
//       String disease = jsonResponse['disease'];
//       //  double confidence = jsonResponse['confidence'];

//       print('Disease: $disease');

//       // Navigate to RecommendationScreen with the disease name
//       _navigateToRecommendationScreen(disease);
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   }

//   void _navigateToRecommendationScreen(String disease) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => RecommendationScreen(disease: disease),
//       ),
//     );
//   }

//   void _showPermissionDeniedSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blueAccent, width: 2),
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.all(16.0),
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             'Capture or Upload Image',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildImageButton(
//                 iconUrl:
//                     'https://cdn-icons-png.flaticon.com/512/1042/1042390.png',
//                 label: 'Camera',
//                 onPressed: _pickImageFromCamera,
//               ),
//               _buildImageButton(
//                 iconUrl:
//                     'https://icons.veryicon.com/png/o/business/general-office-icon/general-upload-file.png',
//                 label: 'Upload',
//                 onPressed: _pickImageFromGallery,
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }

//   Widget _buildImageButton({
//     required String iconUrl,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         decoration: BoxDecoration(
//           color: Colors.blueAccent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.network(
//               iconUrl,
//               height: 24,
//               width: 24,
//             ),
//             SizedBox(width: 10),
//             Text(
//               label,
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert'; // For handling JSON
// import 'dart:io'; // For file handling
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images
// import 'package:permission_handler/permission_handler.dart'; // For permission handling
// import 'package:http/http.dart' as http; // For sending HTTP requests
// import 'recommendation.dart'; // Import your recommendation screen

// class ImageCaptureSection extends StatefulWidget {
//   @override
//   _ImageCaptureSectionState createState() => _ImageCaptureSectionState();
// }

// class _ImageCaptureSectionState extends State<ImageCaptureSection> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;
//   bool _isLoading = false; // To control the spinner

//   Future<void> _pickImageFromCamera() async {
//     var status = await Permission.camera.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Camera permission is denied.');
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     var status = await Permission.storage.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Gallery access is denied.');
//     }
//   }

//   Future<void> _convertToJpgAndSend(File imageFile) async {
//     try {
//       // Show loading spinner
//       setState(() {
//         _isLoading = true;
//       });

//       // Sending to the API
//       print("Selected Image File Path: ${imageFile.path}");
//       await _sendImageToServer(imageFile);
//     } catch (e) {
//       print('Error processing image: $e');
//     } finally {
//       // Hide loading spinner
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _sendImageToServer(File imageFile) async {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(
//           'http://192.168.97.238:5000/identify'), // Replace with your API endpoint
//     );

//     // Add the image to the request
//     request.files
//         .add(await http.MultipartFile.fromPath('image', imageFile.path));

//     // Add headers if needed
//     request.headers.addAll({
//       'Content-Type': 'multipart/form-data',
//     });

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       var responseBody = await http.Response.fromStream(response);
//       print('Success: ${responseBody.body}');

//       var jsonResponse = jsonDecode(responseBody.body);

//       // Extract disease and confidence
//       String disease = jsonResponse['disease'];
//       print('Disease: $disease');

//       // Navigate to RecommendationScreen with the disease name
//       _navigateToRecommendationScreen(disease);
//     } else {
//       print('Error: ${response.statusCode}');
//     }
//   }

//   void _navigateToRecommendationScreen(String disease) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => RecommendationScreen(disease: disease),
//       ),
//     );
//   }

//   void _showPermissionDeniedSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blueAccent, width: 2),
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.all(16.0),
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             'Capture or Upload Image',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildImageButton(
//                 iconUrl:
//                     'https://cdn-icons-png.flaticon.com/512/1042/1042390.png',
//                 label: 'Camera',
//                 onPressed: _pickImageFromCamera,
//               ),
//               _buildImageButton(
//                 iconUrl:
//                     'https://icons.veryicon.com/png/o/business/general-office-icon/general-upload-file.png',
//                 label: 'Upload',
//                 onPressed: _pickImageFromGallery,
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           if (_isLoading) CircularProgressIndicator(), // Show loading spinner
//         ],
//       ),
//     );
//   }

//   Widget _buildImageButton({
//     required String iconUrl,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         decoration: BoxDecoration(
//           color: Colors.blueAccent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.network(
//               iconUrl,
//               height: 24,
//               width: 24,
//             ),
//             SizedBox(width: 10),
//             Text(
//               label,
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert'; // For handling JSON
// import 'dart:io'; // For file handling
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images
// import 'package:permission_handler/permission_handler.dart'; // For permission handling
// import 'package:http/http.dart' as http; // For sending HTTP requests
// import 'recommendation.dart'; // Import your recommendation screen

// class ImageCaptureSection extends StatefulWidget {
//   @override
//   _ImageCaptureSectionState createState() => _ImageCaptureSectionState();
// }

// class _ImageCaptureSectionState extends State<ImageCaptureSection> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;
//   bool _isLoading = false; // To control the spinner

//   Future<void> _pickImageFromCamera() async {
//     var status = await Permission.camera.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Camera permission is denied.');
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     var status = await Permission.storage.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Gallery access is denied.');
//     }
//   }

//   Future<void> _convertToJpgAndSend(File imageFile) async {
//     try {
//       // Show loading spinner
//       setState(() {
//         _isLoading = true;
//       });

//       // Sending to the API
//       print("Selected Image File Path: ${imageFile.path}");
//       await _sendImageToServer(imageFile);
//     } catch (e) {
//       print('Error processing image: $e');
//     } finally {
//       // Hide loading spinner
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _sendImageToServer(File imageFile) async {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(
//           'http://192.168.97.238:5000/identify'), // Replace with your API endpoint
//     );

//     // Add the image to the request
//     request.files
//         .add(await http.MultipartFile.fromPath('image', imageFile.path));

//     // Add headers if needed
//     request.headers.addAll({
//       'Content-Type': 'multipart/form-data',
//     });

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       var responseBody = await http.Response.fromStream(response);
//       print('Success: ${responseBody.body}');

//       var jsonResponse = jsonDecode(responseBody.body);

//       // Check for errors in the response
//       if (jsonResponse.containsKey('error')) {
//         String errorMessage = jsonResponse['error'];
//         _showErrorAlert(errorMessage);
//       } else {
//         // Extract disease and confidence
//         String disease = jsonResponse['disease'];
//         print('Disease: $disease');

//         // Navigate to RecommendationScreen with the disease name
//         _navigateToRecommendationScreen(disease);
//       }
//     } else {
//       print('Error: ${response.statusCode}');
//       _showErrorAlert('An error occurred while processing your request.');
//     }
//   }

//   void _navigateToRecommendationScreen(String disease) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => RecommendationScreen(disease: disease),
//       ),
//     );
//   }

//   void _showPermissionDeniedSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   void _showErrorAlert(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blueAccent, width: 2),
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.all(16.0),
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             'Capture or Upload Image',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildImageButton(
//                 iconUrl:
//                     'https://cdn-icons-png.flaticon.com/512/1042/1042390.png',
//                 label: 'Camera',
//                 onPressed: _pickImageFromCamera,
//               ),
//               _buildImageButton(
//                 iconUrl:
//                     'https://icons.veryicon.com/png/o/business/general-office-icon/general-upload-file.png',
//                 label: 'Upload',
//                 onPressed: _pickImageFromGallery,
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           if (_isLoading) CircularProgressIndicator(), // Show loading spinner
//         ],
//       ),
//     );
//   }

//   Widget _buildImageButton({
//     required String iconUrl,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         decoration: BoxDecoration(
//           color: Colors.blueAccent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.network(
//               iconUrl,
//               height: 24,
//               width: 24,
//             ),
//             SizedBox(width: 10),
//             Text(
//               label,
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// import 'dart:convert'; // For handling JSON
// import 'dart:io'; // For file handling
// import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart'; // For picking images
// import 'package:permission_handler/permission_handler.dart'; // For permission handling
// import 'package:http/http.dart' as http; // For sending HTTP requests
// import 'recommendation.dart'; // Import your recommendation screen

// class ImageCaptureSection extends StatefulWidget {
//   @override
//   _ImageCaptureSectionState createState() => _ImageCaptureSectionState();
// }

// class _ImageCaptureSectionState extends State<ImageCaptureSection> {
//   final ImagePicker _picker = ImagePicker();
//   XFile? _imageFile;
//   bool _isLoading = false; // To control the spinner

//   Future<void> _pickImageFromCamera() async {
//     var status = await Permission.camera.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.camera);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Camera permission is denied.');
//     }
//   }

//   Future<void> _pickImageFromGallery() async {
//     var status = await Permission.storage.request();
//     if (status.isGranted) {
//       final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
//       if (image != null) {
//         _imageFile = image;
//         _convertToJpgAndSend(File(image.path));
//       }
//     } else {
//       _showPermissionDeniedSnackBar('Gallery access is denied.');
//     }
//   }

//   Future<void> _convertToJpgAndSend(File imageFile) async {
//     try {
//       // Show loading spinner
//       setState(() {
//         _isLoading = true;
//       });

//       // Sending to the API
//       print("Selected Image File Path: ${imageFile.path}");
//       await _sendImageToServer(imageFile);
//     } catch (e) {
//       print('Error processing image: $e');
//     } finally {
//       // Hide loading spinner
//       setState(() {
//         _isLoading = false;
//       });
//     }
//   }

//   Future<void> _sendImageToServer(File imageFile) async {
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse(
//           'http://192.168.97.238:5000/identify'), // Replace with your API endpoint
//     );

//     // Add the image to the request
//     request.files
//         .add(await http.MultipartFile.fromPath('image', imageFile.path));

//     // Add headers if needed
//     request.headers.addAll({
//       'Content-Type': 'multipart/form-data',
//     });

//     var response = await request.send();

//     if (response.statusCode == 200) {
//       var responseBody = await http.Response.fromStream(response);
//       print('Success: ${responseBody.body}');

//       var jsonResponse = jsonDecode(responseBody.body);

//       // Check for errors in the response
//       if (jsonResponse.containsKey('error')) {
//         String errorMessage = jsonResponse['error'];
//         _showErrorAlert(errorMessage);
//       } else {
//         // Extract disease and confidence
//         String disease = jsonResponse['disease'];
//         print('Disease: $disease');

//         // Navigate to RecommendationScreen with the disease name
//         _navigateToRecommendationScreen(disease);
//       }
//     } else {
//       print('Error: ${response.statusCode}');
//       _showErrorAlert('An error occurred while processing your request.');
//     }
//   }

//   void _navigateToRecommendationScreen(String disease) {
//     Navigator.of(context).push(
//       MaterialPageRoute(
//         builder: (context) => RecommendationScreen(disease: disease),
//       ),
//     );
//   }

//   void _showPermissionDeniedSnackBar(String message) {
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   void _showErrorAlert(String message) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Error'),
//           content: Text(message),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('OK'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: double.infinity,
//       decoration: BoxDecoration(
//         border: Border.all(color: Colors.blueAccent, width: 2),
//         borderRadius: BorderRadius.circular(15),
//         color: Colors.white,
//       ),
//       padding: EdgeInsets.all(16.0),
//       margin: EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           Text(
//             'Capture or Upload Image',
//             style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
//           ),
//           SizedBox(height: 20),
//           Row(
//             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//             children: [
//               _buildImageButton(
//                 iconUrl:
//                     'https://cdn-icons-png.flaticon.com/512/1042/1042390.png',
//                 label: 'Camera',
//                 onPressed: _pickImageFromCamera,
//               ),
//               _buildImageButton(
//                 iconUrl:
//                     'https://icons.veryicon.com/png/o/business/general-office-icon/general-upload-file.png',
//                 label: 'Upload',
//                 onPressed: _pickImageFromGallery,
//               ),
//             ],
//           ),
//           SizedBox(height: 20),
//           if (_isLoading) CircularProgressIndicator(), // Show loading spinner
//         ],
//       ),
//     );
//   }

//   Widget _buildImageButton({
//     required String iconUrl,
//     required String label,
//     required VoidCallback onPressed,
//   }) {
//     return GestureDetector(
//       onTap: onPressed,
//       child: AnimatedContainer(
//         duration: Duration(milliseconds: 300),
//         decoration: BoxDecoration(
//           color: Colors.blueAccent,
//           borderRadius: BorderRadius.circular(10),
//         ),
//         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//         child: Row(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Image.network(
//               iconUrl,
//               height: 24,
//               width: 24,
//             ),
//             SizedBox(width: 10),
//             Text(
//               label,
//               style: TextStyle(color: Colors.white, fontSize: 18),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

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

  // Future<void> _sendImageToServer(File imageFile) async {
  //   var request = http.MultipartRequest(
  //     'POST',
  //     Uri.parse(
  //         'http://192.168.97.238:5000/identify'), // Replace with your API endpoint
  //   );

  //   // Add the image to the request
  //   request.files
  //       .add(await http.MultipartFile.fromPath('image', imageFile.path));

  //   // Add headers if needed
  //   request.headers.addAll({
  //     'Content-Type': 'multipart/form-data',
  //   });

  //   var response = await request.send();

  //   if (response.statusCode == 200) {
  //     var responseBody = await http.Response.fromStream(response);
  //     print('Success: ${responseBody.body}');

  //     var jsonResponse = jsonDecode(responseBody.body);

  //     // Check for errors in the response
  //     if (jsonResponse.containsKey('error')) {
  //       String errorMessage = jsonResponse['error'];
  //       _showErrorAlert(errorMessage);
  //     } else {
  //       // Extract disease and confidence
  //       String disease = jsonResponse['disease'];
  //       print('Disease: $disease');

  //       // Navigate to RecommendationScreen with the disease name
  //       _navigateToRecommendationScreen(disease);
  //     }
  //   } else {
  //     print('Error: ${response.statusCode}');
  //     _showErrorAlert('An error occurred while processing your request.');
  //   }
  // }

  Future<void> _sendImageToServer(File imageFile) async {
    var request = http.MultipartRequest(
      'POST',
      Uri.parse(
          'http://192.168.97.238:5000/identify'), // Replace with your API endpoint
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

  // void _navigateToRecommendationScreen(String disease) {
  //   Navigator.of(context).push(
  //     MaterialPageRoute(
  //       builder: (context) => RecommendationScreen(disease: disease),
  //     ),
  //   );
  // }

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
                  Navigator.of(context).pop();
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

    // Automatically dismiss the dialog after 3 seconds
    Future.delayed(Duration(seconds: 3), () {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent, width: 2),
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
      ),
      padding: EdgeInsets.all(16.0),
      margin: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(
            'Capture or Upload Image',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImageButton(
                iconUrl:
                    'https://cdn-icons-png.flaticon.com/512/1042/1042390.png',
                label: 'Camera',
                onPressed: _pickImageFromCamera,
              ),
              _buildImageButton(
                iconUrl:
                    'https://icons.veryicon.com/png/o/business/general-office-icon/general-upload-file.png',
                label: 'Upload',
                onPressed: _pickImageFromGallery,
              ),
            ],
          ),
          SizedBox(height: 20),
          if (_isLoading) CircularProgressIndicator(), // Show loading spinner
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
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(10),
        ),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(
              iconUrl,
              height: 24,
              width: 24,
            ),
            SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(color: Colors.white, fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
