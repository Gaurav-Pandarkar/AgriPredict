import 'dart:io'; // For file handling
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // For picking images
import 'package:permission_handler/permission_handler.dart'; // For permission handling

class ImageCaptureSection extends StatefulWidget {
  @override
  _ImageCaptureSectionState createState() => _ImageCaptureSectionState();
}

class _ImageCaptureSectionState extends State<ImageCaptureSection> {
  final ImagePicker _picker = ImagePicker();
  XFile? _imageFile;

  // Method to request camera permission and capture image
  Future<void> _pickImageFromCamera() async {
    var status = await Permission.camera.request();
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.camera);
      if (image != null) {
        _processImage(
            File(image.path)); // Process the image without displaying it
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Camera permission is denied.')),
      );
    }
  }

  // Method to request gallery permission and pick image
  // Future<void> _pickImageFromGallery() async {
  //   var status = await Permission.photos.request();
  //   if (status.isGranted) {
  //     final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
  //     if (image != null) {
  //       _processImage(
  //           File(image.path)); // Process the image without displaying it
  //     }
  //   } else {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Gallery access is denied.')),
  //     );
  //   }
  // }

  // Method to request gallery permission and pick image
  Future<void> _pickImageFromGallery() async {
    var status = await Permission.storage.request(); // Use storage permission
    if (status.isGranted) {
      final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      if (image != null) {
        _processImage(
            File(image.path)); // Process the image without displaying it
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gallery access is denied.')),
      );
    }
  }

  // Method to process the image and pass it to the deep learning model
  void _processImage(File imageFile) {
    // Convert the image to bytes or the necessary format for your deep learning model
    final imageBytes = imageFile.readAsBytesSync();

    // Here, pass the bytes or the file to your deep learning model
    // Example: model.predict(imageBytes);

    print("Image processed and ready for model input: ${imageFile.path}");
    // You can remove the print statement and handle the model input accordingly
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
                onPressed: _pickImageFromCamera, // Call camera function
              ),
              _buildImageButton(
                iconUrl:
                    'https://icons.veryicon.com/png/o/business/general-office-icon/general-upload-file.png',
                label: 'Upload',
                onPressed: _pickImageFromGallery, // Call gallery function
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => detectDisease(context),
            style: ElevatedButton.styleFrom(
              primary: Colors.red,
              padding: EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.network(
                  'https://cdn3.iconfinder.com/data/icons/40-set-corona-pandemic-virus-1/512/005-virus-512.png',
                  height: 24,
                  width: 24,
                ),
                SizedBox(width: 10),
                Text('Detect Disease'),
              ],
            ),
          ),
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

  void detectDisease(BuildContext context) {
    Navigator.pushNamed(context, '/recommendation');
  }
}
