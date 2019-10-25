import 'package:flutter/material.dart';

class Setting extends StatefulWidget {
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('系统设置'),
      ),
      body: Center(
        child: Text(
          '这里还没有东西呢~',
          style: TextStyle(fontWeight: FontWeight.w500, fontSize: 15.0),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
