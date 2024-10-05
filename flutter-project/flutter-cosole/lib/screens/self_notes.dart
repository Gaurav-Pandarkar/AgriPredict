import 'package:flutter/material.dart';

class SelfNotesScreen extends StatefulWidget {
  const SelfNotesScreen({Key? key}) : super(key: key);

  @override
  _SelfNotesScreenState createState() => _SelfNotesScreenState();
}

class _SelfNotesScreenState extends State<SelfNotesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  List<Map<String, String>> notes = [
    {
      'title': 'Tip for the next planting season',
      'content': 'Remember to rotate crops this year!'
    },
    {
      'title': 'Weather Forecast',
      'content': 'Expect rain next week. Plan accordingly.'
    },
    {'title': 'Market Day Reminder', 'content': 'Market on Saturday at 8 AM.'},
  ];

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
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _addNote(String title, String content) {
    if (title.isNotEmpty && content.isNotEmpty) {
      setState(() {
        notes.add({'title': title, 'content': content});
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Note Added: $title')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Notes'),
        backgroundColor: Colors.green.shade700,
      ),
      body: FadeTransition(
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
                  .map((note) =>
                      _buildNoteCard(note['title']!, note['content']!))
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

  Widget _buildNoteCard(String title, String content) {
    return GestureDetector(
      onTap: () {
        // Navigate to a detailed view or toggle visibility
        _showNoteDetailDialog(title, content);
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
                _addNote(newNoteTitle, newNoteContent);
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
