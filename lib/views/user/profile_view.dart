import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:http_parser/http_parser.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/http.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/views/common/forum.dart';
import 'package:hu60/views/common/photo_gallery.dart';
import 'package:hu60/views/user/change_name_view.dart';
import 'package:hu60/views/user/change_password_view.dart';
import 'package:hu60/views/user/change_sign_view.dart';
import 'package:image_picker/image_picker.dart';

import 'change_contact_view.dart';

class ProfileView extends StatefulWidget {
  @override
  _ProfileView createState() => _ProfileView();
}

class _ProfileView extends State<ProfileView> {
  final picker = ImagePicker();

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
                  Forum.buildListTile(
                    "头像",
                    content: Padding(
                      padding: EdgeInsets.only(top: 5, bottom: 5),
                      child: User.getAvatar(
                        context: context,
                        url: c.user.uAvatar,
                        size: ScreenUtil().setWidth(100),
                        borderRadius: 8.0,
                      ),
                    ),
                    onTap: () {
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
                                  _changeAvatar();
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
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Forum.buildListTile(
                    "用户名",
                    content: Text(
                      c.user.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                    ),
                    onTap: () => Get.to(() => ChangeNameView()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Forum.buildListTile(
                    "个性签名",
                    content: Text(
                      c.user.signature,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                    ),
                    onTap: () => Get.to(() => ChangeSignView()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Forum.buildListTile(
                    "联系方式",
                    content: Text(
                      c.user.contact,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                    ),
                    onTap: () => Get.to(() => ChangeContactView()),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 70),
                    child: Forum.buildListTileDivider(),
                  ),
                  Forum.buildListTile(
                    "密码",
                    onTap: () => Get.to(() => ChangePasswordView()),
                  ),
                ],
              ),
            ),
            Forum.buildListTileDivider(),
            Container(
              color: Colors.white,
              margin: EdgeInsets.only(top: 10),
              child: ListTile(
                title: Center(
                  child: Text(
                    "退出登录",
                    style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                  ),
                ),
                onTap: () {
                  showCupertinoModalPopup(
                    context: context,
                    builder: (context) {
                      return CupertinoActionSheet(
                        actions: <Widget>[
                          CupertinoActionSheetAction(
                            isDestructiveAction: true,
                            child: Text("确认退出"),
                            onPressed: () async {
                              c.logout();
                              Get.back();
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
                },
              ),
            ),
            Forum.buildListTileDivider(),
          ],
        ),
      ),
    );
  }

  void _changeAvatar() async {
    final pickedFile = await picker.getImage(
      source: ImageSource.gallery,
    );
    if (pickedFile == null) return;
    String path = pickedFile.path;
    /*String name = path.substring(
      path.lastIndexOf("/") + 1,
      path.length,
    );
    String suffix = name.substring(name.lastIndexOf(".") + 1, name.length);*/
    dio.Response response = await Http.request(
      "/user.avatar.json",
      method: Http.POST,
      data: dio.FormData.fromMap({
        "avatar": await dio.MultipartFile.fromFile(
          path,
          contentType: MediaType.parse("image/jpeg"),
        )
      }),
    );
    String msg = response.data["message"] ?? response.data["error"];
    Fluttertoast.showToast(msg: msg);
    Get.find<UserController>().init();
  }
}
