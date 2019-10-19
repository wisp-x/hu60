import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import './views/home.dart';
import './model/user.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider.value(value: User()),
    ],
    child: MaterialApp(
      home: Home(),
      theme: ThemeData(
        brightness: Brightness.light,
        primaryColor: Color.fromRGBO(25, 123, 48, 1),
        accentColor: Color.fromRGBO(25, 123, 48, 1),
      ),
    ),
  ));
}
