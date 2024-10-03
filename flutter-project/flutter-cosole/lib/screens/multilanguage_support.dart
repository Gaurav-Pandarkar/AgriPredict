import 'package:flutter/material.dart';

class MultilingualSupport extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 10,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              'Select Your Language',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.green[700],
              ),
            ),
            SizedBox(height: 20),

            // Major languages in India as a List
            Expanded(
              child: ListView(
                children: [
                  _languageListItem(context, 'Hindi (हिन्दी)',
                      Colors.orange.withOpacity(0.7)),
                  _languageListItem(
                      context, 'English', Colors.lightBlue.withOpacity(0.7)),
                  _languageListItem(context, 'Bengali (বাংলা)',
                      Colors.pinkAccent.withOpacity(0.7)),
                  _languageListItem(context, 'Telugu (తెలుగు)',
                      Colors.lightGreen.withOpacity(0.7)),
                  _languageListItem(context, 'Marathi (मराठी)',
                      Colors.amberAccent.withOpacity(0.7)),
                  _languageListItem(context, 'Tamil (தமிழ்)',
                      Colors.purpleAccent.withOpacity(0.7)),
                  _languageListItem(
                      context, 'Urdu (اردو)', Colors.cyan.withOpacity(0.7)),
                  _languageListItem(context, 'Gujarati (ગુજરાતી)',
                      Colors.lightBlueAccent.withOpacity(0.7)),
                  _languageListItem(context, 'Malayalam (മലയാളം)',
                      Colors.teal.withOpacity(0.7)),
                  _languageListItem(context, 'Kannada (ಕನ್ನಡ)',
                      Colors.indigoAccent.withOpacity(0.7)),
                  _languageListItem(
                      context, 'Odia (ଓଡ଼ିଆ)', Colors.lime.withOpacity(0.7)),
                  _languageListItem(context, 'Punjabi (ਪੰਜਾਬੀ)',
                      Colors.deepOrangeAccent.withOpacity(0.7)),
                ],
              ),
            ),

            // Navigation Button
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Align(
                alignment: Alignment.bottomLeft,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                        context, '/home'); // Navigate to home screen
                  },
                  child: Text('Go to Home'),
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green[600], // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          20), // Rounded corners for button
                    ),
                    padding: EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10), // Adjust padding for a smaller button
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _languageListItem(BuildContext context, String language, Color color) {
    return Card(
      color: color,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      margin: EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        title: Text(
          language,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        trailing: Icon(Icons.check,
            color: Colors.black), // Add check icon for selection feedback
        onTap: () {
          // You can add language selection functionality here
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('$language selected!')),
          );
        },
      ),
    );
  }
}
