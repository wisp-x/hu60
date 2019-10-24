import 'package:flutter/material.dart';

class Letter extends StatefulWidget {
  _LetterState createState() => _LetterState();
}

class _LetterState extends State<Letter> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('内信'),
      ),
      body: Text('内信'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}