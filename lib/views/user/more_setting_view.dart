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
  final dividerColor = Color(0xdccdcdcd);

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
                  Divider(height: 0.2, color: dividerColor),
                  Forum.buildListTile(
                    Icons.sort_by_alpha,
                    "楼层倒序",
                    trailing: CupertinoSwitch(
                      value: c.user.floorReverse,
                      onChanged: (bool value) {
                        c.setFloorReverse(value);
                      },
                    ),
                  ),
                  Divider(height: 0.2, color: dividerColor)
                ],
              ),
            ),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              child: Column(
                children: <Widget>[
                  Divider(height: 0.2, color: dividerColor),
                  Forum.buildListTile(Icons.edit, "反馈建议", onTap: () {
                    Utils.openUrl("https://github.com/wisp-x/hu60");
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Divider(height: 0.2, color: dividerColor),
                  ),
                  Forum.buildListTile(
                    Icons.info,
                    "版本信息",
                    trailing: Text(
                      "v2.0 build 20210310",
                      style: TextStyle(
                        color: Colors.grey[500],
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                  ),
                  Divider(height: 0.2, color: dividerColor)
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
