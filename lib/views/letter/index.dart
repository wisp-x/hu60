import 'package:flutter/material.dart';

class Index extends StatefulWidget {
  _IndexState createState() => _IndexState();
}

class _IndexState extends State<Index> {
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