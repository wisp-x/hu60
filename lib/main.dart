import 'package:flutter/material.dart';
import './views/home.dart';

void main() {
  runApp(
    MaterialApp(
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(25, 123, 48, 1),
        accentColor: Color.fromRGBO(25, 123, 48, 1),
      ),
    ),
  );
}

