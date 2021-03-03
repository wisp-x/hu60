import 'package:url_launcher/url_launcher.dart';

class Utils {
  // 打开 URL
  static void openUrl(String url) async {
    if (await canLaunch(url)) {
      await launch(
        url,
        forceWebView: true,
        enableJavaScript: true,
      );
    }
  }
}