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
  ));
}
