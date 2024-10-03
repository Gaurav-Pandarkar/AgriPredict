import 'package:flutter/material.dart';

class AgronomistScreen extends StatelessWidget {
  const AgronomistScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Agronomist'),
      ),
      body: Center(
        child: Text(
          'This is the Agronomist Screen',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
