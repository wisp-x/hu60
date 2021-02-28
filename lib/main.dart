import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/views/home_view.dart';

void main() {
  runApp(GetMaterialApp(
    routingCallback: (routing) {
      if (routing.current == '/second') {
        // 如果登录。。。
      }
    },
    home: HomeView(),
    theme: ThemeData(
      brightness: Brightness.light,
      // primaryColor: Color.fromRGBO(63, 154, 86, 1.0),
      primaryColor: Colors.white,
      accentColor: Color.fromRGBO(63, 154, 86, 1.0),
      backgroundColor: Color.fromRGBO(242, 247, 251, 1)
    ),
  ));
}
