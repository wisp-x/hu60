import 'package:flutter/material.dart';

class About extends StatefulWidget {
  _AboutState createState() => _AboutState();
}

class _AboutState extends State<About> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('关于'),
      ),
      body: Text('关于'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}