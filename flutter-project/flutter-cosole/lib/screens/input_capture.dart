import 'package:flutter/material.dart';

class ImageCaptureSection extends StatelessWidget {
  const ImageCaptureSection({Key? key}) : super(key: key);

  // Updated detectDisease method to navigate to the Recommendation screen
  void detectDisease(BuildContext context) {
    Navigator.pushNamed(context, '/recommendation');
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity, // Elongate the box to full width
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
                onPressed: () {
                  // Implement camera capture functionality
                },
              ),
              _buildImageButton(
                iconUrl:
                    'https://icons.veryicon.com/png/o/business/general-office-icon/general-upload-file.png',
                label: 'Upload',
                onPressed: () {
                  // Implement upload functionality
                },
              ),
            ],
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () => detectDisease(context), // Pass context here
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
}
