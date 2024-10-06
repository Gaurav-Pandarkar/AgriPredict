// import 'package:flutter/material.dart';

// class SelfNotesScreen extends StatefulWidget {
//   const SelfNotesScreen({Key? key}) : super(key: key);

//   @override
//   _SelfNotesScreenState createState() => _SelfNotesScreenState();
// }

// class _SelfNotesScreenState extends State<SelfNotesScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   List<Map<String, String>> notes = [
//     {
//       'title': 'Tip for the next planting season',
//       'content': 'Remember to rotate crops this year!'
//     },
//     {
//       'title': 'Weather Forecast',
//       'content': 'Expect rain next week. Plan accordingly.'
//     },
//     {'title': 'Market Day Reminder', 'content': 'Market on Saturday at 8 AM.'},
//   ];

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..forward();

//     _fadeAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   void _addNote(String title, String content) {
//     if (title.isNotEmpty && content.isNotEmpty) {
//       setState(() {
//         notes.add({'title': title, 'content': content});
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Note Added: $title')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Self Notes'),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: FadeTransition(
//         opacity: _fadeAnimation,
//         child: SingleChildScrollView(
//           padding: const EdgeInsets.all(16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               Text(
//                 'Your Notes',
//                 style: TextStyle(
//                   fontSize: 28,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.green.shade800,
//                 ),
//               ),
//               SizedBox(height: 20),
//               ...notes
//                   .map((note) =>
//                       _buildNoteCard(note['title']!, note['content']!))
//                   .toList(),
//             ],
//           ),
//         ),
//       ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddNoteDialog(),
//         backgroundColor: Colors.green.shade600,
//         child: ScaleTransition(
//           scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
//             parent: _controller,
//             curve: Curves.bounceIn,
//           )),
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }

//   Widget _buildNoteCard(String title, String content) {
//     return GestureDetector(
//       onTap: () {
//         // Navigate to a detailed view or toggle visibility
//         _showNoteDetailDialog(title, content);
//       },
//       child: Card(
//         elevation: 8,
//         margin: EdgeInsets.symmetric(vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         shadowColor: Colors.black.withOpacity(0.2),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Icon(Icons.note, color: Colors.green.shade600),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade800,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       content,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _showAddNoteDialog() {
//     String newNoteTitle = '';
//     String newNoteContent = '';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add a New Note'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Title'),
//                 onChanged: (value) {
//                   newNoteTitle = value;
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Content'),
//                 onChanged: (value) {
//                   newNoteContent = value;
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _addNote(newNoteTitle, newNoteContent);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   void _showNoteDetailDialog(String title, String content) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

//working
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'dart:convert'; // To convert JSON response into a usable format

// class SelfNotesScreen extends StatefulWidget {
//   const SelfNotesScreen({Key? key}) : super(key: key);

//   @override
//   _SelfNotesScreenState createState() => _SelfNotesScreenState();
// }

// class _SelfNotesScreenState extends State<SelfNotesScreen>
//     with SingleTickerProviderStateMixin {
//   late AnimationController _controller;
//   late Animation<double> _fadeAnimation;

//   List<Map<String, String>> notes = [];
//   bool isLoading = true; // Add a loading state to indicate API fetching
//   String errorMessage = ''; // To display error messages

//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//       duration: const Duration(seconds: 1),
//       vsync: this,
//     )..forward();

//     _fadeAnimation = CurvedAnimation(
//       parent: _controller,
//       curve: Curves.easeIn,
//     );

//     // Fetch notes from the API
//     _fetchNotes();
//   }

//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }

//   // Function to fetch notes from the API
//   Future<void> _fetchNotes() async {
//     const String mobileNo = '5050505050'; // Sample mobile number
//     final String apiUrl =
//         'http://192.168.97.193:8081/api/v1/notes/$mobileNo'; // Your API endpoint

//     try {
//       final response = await http.get(Uri.parse(apiUrl));

//       // Check if the API call was successful
//       if (response.statusCode == 200) {
//         final data = json.decode(response.body); // Decode the JSON response

//         if (data['responseCode'] == '200') {
//           List<dynamic> fetchedNotes = data['notes'];
//           setState(() {
//             notes = fetchedNotes
//                 .map((note) => {
//                       'title': (note['title'] ?? '').toString(),
//                       'content': (note['content'] ?? '').toString(),
//                     })
//                 .toList();
//             isLoading = false; // Stop loading spinner after data is fetched
//           });
//         } else {
//           _showError('Error: ${data['message']}');
//         }
//       } else {
//         _showError('Failed to load notes. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       _showError('An error occurred: $e');
//     }
//   }

//   void _showError(String message) {
//     setState(() {
//       isLoading = false; // Stop the loading spinner
//       errorMessage = message; // Set the error message
//     });
//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text(message)),
//     );
//   }

//   void _addNote(String title, String content) {
//     if (title.isNotEmpty && content.isNotEmpty) {
//       setState(() {
//         notes.add({'title': title, 'content': content});
//       });
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('Note Added: $title')),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Self Notes'),
//         backgroundColor: Colors.green.shade700,
//       ),
//       body: isLoading
//           ? Center(
//               child:
//                   CircularProgressIndicator()) // Show loading spinner while fetching notes
//           : errorMessage.isNotEmpty
//               ? Center(
//                   child: Text(errorMessage,
//                       style: TextStyle(
//                           color: Colors.red))) // Show error message if any
//               : FadeTransition(
//                   opacity: _fadeAnimation,
//                   child: SingleChildScrollView(
//                     padding: const EdgeInsets.all(16.0),
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Your Notes',
//                           style: TextStyle(
//                             fontSize: 28,
//                             fontWeight: FontWeight.bold,
//                             color: Colors.green.shade800,
//                           ),
//                         ),
//                         SizedBox(height: 20),
//                         ...notes
//                             .map((note) => _buildNoteCard(
//                                 note['title']!, note['content']!))
//                             .toList(),
//                       ],
//                     ),
//                   ),
//                 ),
//       floatingActionButton: FloatingActionButton(
//         onPressed: () => _showAddNoteDialog(),
//         backgroundColor: Colors.green.shade600,
//         child: ScaleTransition(
//           scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
//             parent: _controller,
//             curve: Curves.bounceIn,
//           )),
//           child: Icon(Icons.add),
//         ),
//       ),
//     );
//   }

//   // Widget to display each note
//   Widget _buildNoteCard(String title, String content) {
//     return GestureDetector(
//       onTap: () {
//         _showNoteDetailDialog(title, content); // Show note details when tapped
//       },
//       child: Card(
//         elevation: 8,
//         margin: EdgeInsets.symmetric(vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
//         shadowColor: Colors.black.withOpacity(0.2),
//         child: Padding(
//           padding: const EdgeInsets.all(16.0),
//           child: Row(
//             children: [
//               Icon(Icons.note, color: Colors.green.shade600),
//               SizedBox(width: 12),
//               Expanded(
//                 child: Column(
//                   crossAxisAlignment: CrossAxisAlignment.start,
//                   children: [
//                     Text(
//                       title,
//                       style: TextStyle(
//                         fontSize: 20,
//                         fontWeight: FontWeight.bold,
//                         color: Colors.green.shade800,
//                       ),
//                     ),
//                     SizedBox(height: 8),
//                     Text(
//                       content,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.grey.shade700,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   // Show dialog to add a new note
//   void _showAddNoteDialog() {
//     String newNoteTitle = '';
//     String newNoteContent = '';

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text('Add a New Note'),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 decoration: InputDecoration(labelText: 'Title'),
//                 onChanged: (value) {
//                   newNoteTitle = value;
//                 },
//               ),
//               TextField(
//                 decoration: InputDecoration(labelText: 'Content'),
//                 onChanged: (value) {
//                   newNoteContent = value;
//                 },
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 _addNote(newNoteTitle, newNoteContent);
//                 Navigator.of(context).pop();
//               },
//               child: Text('Save'),
//             ),
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Cancel'),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   // Show note details in a dialog
//   void _showNoteDetailDialog(String title, String content) {
//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: [
//             TextButton(
//               onPressed: () {
//                 Navigator.of(context).pop();
//               },
//               child: Text('Close'),
//             ),
//           ],
//         );
//       },
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert'; // To convert JSON response into a usable format

class SelfNotesScreen extends StatefulWidget {
  const SelfNotesScreen({Key? key}) : super(key: key);

  @override
  _SelfNotesScreenState createState() => _SelfNotesScreenState();
}

class _SelfNotesScreenState extends State<SelfNotesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  List<Map<String, String>> notes = [];
  bool isLoading = true; // Loading state to indicate API fetching
  String errorMessage = ''; // To display error messages
  final String mobileNo = '5050505050'; // Hardcoded mobile number for request

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..forward();

    _fadeAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );

    // Fetch notes from the API
    _fetchNotes();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  // Function to fetch notes from the API
  Future<void> _fetchNotes() async {
    final String apiUrl =
        'http://192.168.97.193:8081/api/v1/notes/$mobileNo'; // Your API endpoint

    try {
      final response = await http.get(Uri.parse(apiUrl));

      // Check if the API call was successful
      if (response.statusCode == 200) {
        final data = json.decode(response.body); // Decode the JSON response

        if (data['responseCode'] == '200') {
          List<dynamic> fetchedNotes = data['notes'];
          setState(() {
            notes = fetchedNotes
                .map((note) => {
                      'title': (note['title'] ?? '').toString(),
                      'content': (note['content'] ?? '').toString(),
                    })
                .toList();
            isLoading = false; // Stop loading spinner after data is fetched
          });
        } else {
          _showError('Error: ${data['message']}');
        }
      } else {
        _showError('Failed to load notes. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      _showError('An error occurred: $e');
    }
  }

  // Function to show error messages
  void _showError(String message) {
    setState(() {
      isLoading = false; // Stop the loading spinner
      errorMessage = message; // Set the error message
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Function to send the note to the API and add to local list
  Future<void> _addNoteToApi(String title, String content) async {
    final String apiUrl =
        'http://192.168.97.193:8081/api/v1/notes/userNotes'; // POST endpoint

    // Create request payload
    final Map<String, dynamic> requestPayload = {
      'mobileNo': mobileNo,
      'notes': [
        {'title': title, 'content': content}
      ]
    };

    try {
      // Send POST request
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(requestPayload),
      );

      if (response.statusCode == 200) {
        setState(() {
          notes.add({'title': title, 'content': content}); // Add to local list
        });
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Note added: $title')),
        );
      } else {
        _showError('Failed to save note. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      _showError('An error occurred while saving the note: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Notes'),
        backgroundColor: Colors.green.shade700,
      ),
      body: isLoading
          ? Center(
              child:
                  CircularProgressIndicator()) // Show loading spinner while fetching notes
          : errorMessage.isNotEmpty
              ? Center(
                  child: Text(errorMessage,
                      style: TextStyle(
                          color: Colors.red))) // Show error message if any
              : FadeTransition(
                  opacity: _fadeAnimation,
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Your Notes',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade800,
                          ),
                        ),
                        SizedBox(height: 20),
                        ...notes
                            .map((note) => _buildNoteCard(
                                note['title']!, note['content']!))
                            .toList(),
                      ],
                    ),
                  ),
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddNoteDialog(),
        backgroundColor: Colors.green.shade600,
        child: ScaleTransition(
          scale: Tween(begin: 1.0, end: 1.2).animate(CurvedAnimation(
            parent: _controller,
            curve: Curves.bounceIn,
          )),
          child: Icon(Icons.add),
        ),
      ),
    );
  }

  // Widget to display each note
  Widget _buildNoteCard(String title, String content) {
    return GestureDetector(
      onTap: () {
        _showNoteDetailDialog(title, content); // Show note details when tapped
      },
      child: Card(
        elevation: 8,
        margin: EdgeInsets.symmetric(vertical: 10),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        shadowColor: Colors.black.withOpacity(0.2),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Row(
            children: [
              Icon(Icons.note, color: Colors.green.shade600),
              SizedBox(width: 12),
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
                    SizedBox(height: 8),
                    Text(
                      content,
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
      ),
    );
  }

  // Show dialog to add a new note
  void _showAddNoteDialog() {
    String newNoteTitle = '';
    String newNoteContent = '';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add a New Note'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                onChanged: (value) {
                  newNoteTitle = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Content'),
                onChanged: (value) {
                  newNoteContent = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Call function to save note to API and close the dialog
                _addNoteToApi(newNoteTitle, newNoteContent);
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  // Show note details in a dialog
  void _showNoteDetailDialog(String title, String content) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Close'),
            ),
          ],
        );
      },
    );
  }
}
