import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/views/home_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  runApp(
    GetMaterialApp(
      locale: Locale('zh', 'CH'),
      routingCallback: (routing) {
        if (routing.current == '/second') {
          // 如果登录。。。
        }
      },
      home: HomeView(),
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
        GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
        GlobalWidgetsLocalizations.delegate // 指定默认的文本排列方向, 由左到右或由右到左
      ],
      supportedLocales: [
        const Locale('zh', 'CH'),
      ],
      theme: ThemeData(
        brightness: Brightness.light,
        // primaryColor: Color.fromRGBO(63, 154, 86, 1.0),
        primaryColor: Colors.white,
        accentColor: Color.fromRGBO(63, 154, 86, 1.0),
        backgroundColor: Color.fromRGBO(242, 247, 251, 1),
      ),
    ),
  );
}
