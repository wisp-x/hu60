import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/views/common/forum.dart';
import 'package:hu60/views/common/photo_gallery.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileView createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("个人信息"),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: Column(
                children: <Widget>[
                  Forum.buildListTile("头像",
                      content: Padding(
                        padding: EdgeInsets.only(top: 5, bottom: 5),
                        child: User.getAvatar(
                          context: context,
                          url: c.user.uAvatar,
                          size: ScreenUtil().setWidth(100),
                          borderRadius: 8.0,
                        ),
                      ), onTap: () {
                    showCupertinoModalPopup(
                      context: context,
                      builder: (context) {
                        return CupertinoActionSheet(
                          actions: <Widget>[
                            CupertinoActionSheetAction(
                              child: Text("查看大图"),
                              onPressed: () async {
                                Get.back();
                                Get.to(
                                  () => PhotoGallery(
                                    index: 0,
                                    images: [c.user.uAvatar],
                                    heroTag: c.user.uAvatar,
                                  ),
                                );
                              },
                            ),
                            CupertinoActionSheetAction(
                              child: Text("更换头像"),
                              onPressed: () async {
                                Get.back();
                              },
                            ),
                          ],
                          cancelButton: CupertinoActionSheetAction(
                            child: Text('取消'),
                            onPressed: () {
                              Get.back();
                            },
                          ),
                        );
                      },
                    );
                  }),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Forum.buildListTile(
                    "用户名",
                    content: Text(
                      c.user.name,
                      style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Forum.buildListTile("个性签名&联系方式"),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Forum.buildListTile("密码"),
                  Forum.buildListTileDivider(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
