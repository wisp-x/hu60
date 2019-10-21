import 'package:flutter/material.dart';

class Message extends StatefulWidget {
  _MessageState createState() => _MessageState();
}

class _MessageState extends State<Message> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('消息'),
      ),
      body: Text('消息'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}