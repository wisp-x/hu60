import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/common/forum.dart';

class MoreSettingView extends StatefulWidget {
  @override
  _MoreSettingView createState() => _MoreSettingView();
}

class _MoreSettingView extends State<MoreSettingView> {
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
                  Forum.buildListTile(
                    "版本信息",
                    icon: Icons.info,
                    trailing: Text(
                      "v2.0 build 20210310",
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
}
