import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/views/home_view.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() {
  runApp(
    RefreshConfiguration(
      headerBuilder: () => WaterDropHeader(),
      // 配置默认头部指示器,假如你每个页面的头部指示器都一样的话,你需要设置这个
      footerBuilder: () => ClassicFooter(),
      // 配置默认底部指示器
      enableLoadingWhenFailed: true,
      //在加载失败的状态下,用户仍然可以通过手势上拉来触发加载更多
      hideFooterWhenNotFull: false,
      // Viewport不满一屏时,禁用上拉加载更多功能
      enableBallisticLoad: true,
      // 可以通过惯性滑动触发加载更多
      child: GetMaterialApp(
        debugShowMaterialGrid: false,
        locale: Locale('zh', 'CH'),
        routingCallback: (Routing routing) {
          if (routing.current == '/second') {
            // 如果登录。。。
          }
        },
        home: HomeView(),
        localizationsDelegates: [
          RefreshLocalizations.delegate,
          GlobalMaterialLocalizations.delegate, // 指定本地化的字符串和一些其他的值
          GlobalCupertinoLocalizations.delegate, // 对应的Cupertino风格
          GlobalWidgetsLocalizations.delegate // 指定默认的文本排列方向, 由左到右或由右到左
        ],
        supportedLocales: [
          const Locale('zh', 'CH'),
        ],
        localeResolutionCallback: (
          Locale locale,
          Iterable<Locale> supportedLocales,
        ) {
          return locale;
        },
        theme: ThemeData(
          // bottomSheetTheme: BottomSheetThemeData(backgroundColor: Colors.red),
          brightness: Brightness.light,
          primaryColor: Colors.white,
          accentColor: Color.fromRGBO(63, 154, 86, 1.0),
          backgroundColor: Color.fromRGBO(242, 247, 251, 1),
        ),
      ),
    ),
  );
}
