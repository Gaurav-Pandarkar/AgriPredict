import 'package:flutter/material.dart';

class SelfNotesScreen extends StatelessWidget {
  const SelfNotesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Self Notes'),
      ),
      body: Center(
        child: Text(
          'This is the Self Notes Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
