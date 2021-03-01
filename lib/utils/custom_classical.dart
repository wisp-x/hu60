import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

// 自定义 EasyRefresh 组件 header 和 footer
class CustomClassical {
  static header() {
    return ClassicalHeader(
      refreshText: "下拉刷新",
      refreshReadyText: "松开后开始刷新",
      refreshingText: "正在刷新...",
      refreshedText: "刷新完成~",
      bgColor: Colors.transparent,
      textColor: Colors.black87,
      infoText: '更新于 %T',
    );
  }

  static footer() {
    return ClassicalFooter(
      loadText: "上拉加载更多",
      loadReadyText: "松开后开始加载",
      loadingText: "正在加载...",
      loadedText: "加载完成~",
      noMoreText: "我也是有底线的～",
      bgColor: Colors.transparent,
      textColor: Colors.black87,
      infoText: '更新于 %T',
    );
  }
}