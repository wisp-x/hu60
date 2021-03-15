import 'package:flutter/material.dart';
import 'package:hu60/http.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:loading_indicator/loading_indicator.dart';

class Utils {
  // 打开 URL
  static void openUrl(String url) async {
    if (url.substring(0, 1) == "/") {
      url = await Http.getBaseUrl() + url;
    }
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
      );
    }
  }

  // 满屏加载组件
  static Widget loading(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(
              indicatorType: Indicator.pacman,
              color: Theme.of(context).hintColor,
            )
          ],
        ),
      ),
    );
  }
}
