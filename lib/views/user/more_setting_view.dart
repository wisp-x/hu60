import 'dart:async';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/http.dart';
import 'package:hu60/services/utils.dart';
import 'package:hu60/views/common/forum.dart';

class MoreSettingView extends StatefulWidget {
  @override
  _MoreSettingView createState() => _MoreSettingView();
}

class _MoreSettingView extends State<MoreSettingView> {
  String version = "v2.0-beta"; // TODO 当前版本
  double ver = 2.0; // TODO
  int buildDate = 20210318; // 打包时间
  bool check = false; // 检测更新

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("更多设置"),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Forum.buildListTileDivider(),
                  Forum.buildListTile(
                    "楼层倒序",
                    icon: Icons.sort_by_alpha,
                    trailing: CupertinoSwitch(
                      value: c.user.floorReverse,
                      onChanged: (bool value) {
                        c.setFloorReverse(value);
                      },
                    ),
                  ),
                  Forum.buildListTileDivider()
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Forum.buildListTileDivider(),
                  Forum.buildListTile("反馈建议", icon: Icons.edit, onTap: () {
                    Utils.openUrl("https://github.com/wisp-x/hu60");
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Offstage(
                    offstage: !GetPlatform.isAndroid,
                    child: Column(
                      children: <Widget>[
                        Forum.buildListTile(
                          "检测更新",
                          icon: Icons.update,
                          trailing: check
                              ? CupertinoActivityIndicator()
                              : Icon(
                                  Icons.chevron_right,
                                  color: Colors.grey,
                                  size: ScreenUtil().setWidth(45),
                                ),
                          onTap: () {
                            if (!check) _check();
                          },
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 70),
                          child: Forum.buildListTileDivider(),
                        )
                      ],
                    ),
                  ),
                  Forum.buildListTile(
                    "版本信息",
                    icon: Icons.info,
                    trailing: Text(
                      "$version build ${buildDate}",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                  ),
                  Forum.buildListTileDivider()
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _check() async {
    setState(() => check = true);
    String url = "https://api.github.com/repos/wisp-x/hu60/releases";
    dio.Response response = await Http.dio.get(url);
    Map<String, dynamic> data = response.data[0];
    double version = double.parse(RegExp(r"\d+", multiLine: true)
        .allMatches(data["tag_name"])
        .map((e) => e.group(0))
        .first);
    setState(() => check = false);
    if (version > this.ver) {
      Fluttertoast.showToast(msg: "检测到新版本，即将跳转至下载页!");
      Timer(Duration(seconds: 3), () {
        Utils.openUrl(data["html_url"]);
      });
    }
  }
}
