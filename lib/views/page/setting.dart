import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('系统设置'),
      ),
      body: Text('系统设置'),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
