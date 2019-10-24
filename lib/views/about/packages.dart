import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class Packages extends StatelessWidget {
  final List<Map> _list = [
    {
      'name': 'Dio',
      'key': 'dio',
      'about': 'A powerful Http client for Dart, which supports Interceptors, FormData, Request Cancellation, File Downloading, Timeout etc.',
    },
    {
      'name': 'Provider',
      'key': 'provider',
      'about': 'A mixture between dependency injection and state management, built with widgets for widgets.',
    },
    {
      'name': 'Screenutil',
      'key': 'flutter_screenutil',
      'about': 'A flutter plugin for adapting screen and font size.Guaranteed to look good on different models',
    },
    {
      'name': 'JsonSerializable',
      'key': 'json_serializable',
      'about': 'Automatically generate code for converting to and from JSON by annotating Dart classes.',
    },
    {
      'name': 'BuildRunner',
      'key': 'build_runner',
      'about': 'Tools to write binaries that run builders.',
    },
    {
      'name': 'Flutterpinkit',
      'key': 'flutter_spinkit',
      'about': 'A collection of loading indicators animated with flutter. Heavily inspired by @tobiasahlin\'s SpinKit.',
    },
    {
      'name': 'CachedNetworkImage',
      'key': 'cached_network_image',
      'about': 'Flutter library to load and cache network images. Can also be used with placeholder and error widgets.',
    },
    {
      'name': 'CommonUtils',
      'key': 'common_utils',
      'about':
      'Dart common utils library.Contain DateUtil,TimelineUtil,RegexUtil,TimerUtil,MoneyUtil,NumUtil,ObjectUtil,LogUtil.',
    },
    {
      'name': 'SharedPreferences',
      'key': 'shared_preferences',
      'about': 'Flutter plugin for reading and writing simple key-value pairs. Wraps NSUserDefaults on iOS and SharedPreferences on Android.',
    },
    {
      'name': 'FlutterHtml',
      'key': 'flutter_html',
      'about': 'A Flutter widget for rendering static html tags as Flutter widgets. (Will render over 70 different html tags!)',
    },
    {
      'name': 'UrlLauncher',
      'key': 'url_launcher',
      'about': 'Flutter plugin for launching a URL on Android and iOS. Supports web, phone, SMS, and email schemes.',
    },
    {
      'name': 'PullToRefresh',
      'key': 'pull_to_refresh',
      'about': 'a widget provided to the flutter scroll component drop-down refresh and pull up load.',
    },
    {
      'name': 'Toast',
      'key': 'toast',
      'about': 'A Flutter Toast plugin.',
    },
    {
      'name': 'FlutterLauncherIcons',
      'key': 'flutter_launcher_icons',
      'about': 'A package which simplifies the task of updating your Flutter app\'s launcher icon. Fully flexible, allowing you to choose what platform you wish to update the launcher icon for and if you want, the option to keep your old launcher icon in case you want to revert back sometime in the future.',
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text('开源库'),
      ),
      body: ListView.builder(
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              ListTile(
                title: Container(
                  margin: EdgeInsets.only(top: 10.0),
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(_list[index]['name']),
                ),
                subtitle: Padding(
                  padding: EdgeInsets.only(bottom: 10.0),
                  child: Text(_list[index]['about']),
                ),
                trailing: Icon(Icons.chevron_right),
                onTap: () async {
                  String url = 'https://pub.dev/packages/${_list[index]['key']}';
                  if (await canLaunch(url)) {
                    await launch(url);
                  }
                },
              ),
              Divider(height: 1.0, color: Colors.grey[300],),
            ],
          );
        },
        itemCount: _list.length,
      ),
    );
  }
}
