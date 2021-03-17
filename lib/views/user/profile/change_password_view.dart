import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'dart:ui' as ui;

import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/home_view.dart';
import 'package:hu60/views/user/user_view.dart';

class ChangePasswordView extends StatefulWidget {
  @override
  _ChangePasswordView createState() => _ChangePasswordView();
}

class _ChangePasswordView extends State<ChangePasswordView> {
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _confirmNewPasswordController = TextEditingController();

  bool validated = false; // 是否验证通过

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("修改密码"),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: validated ? Colors.green : Colors.grey,
                      borderRadius: BorderRadius.all(Radius.circular(3)),
                    ),
                    alignment: Alignment.center,
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    margin: EdgeInsets.only(right: 10),
                    child: Text("修改", style: TextStyle(color: Colors.white)),
                  ),
                  onTap: () {
                    if (!validated) return false;
                    if (_newPasswordController.text !=
                        _confirmNewPasswordController.text) {
                      return Fluttertoast.showToast(msg: "两次输入的密码不一致");
                    }
                    c.changePassword(
                      _oldPasswordController.text,
                      _newPasswordController.text,
                      callback: (response) {
                        if (response["success"]) {
                          Timer(Duration(seconds: 1), () {
                            c.logout();
                            Get.back();
                            Get.back();
                          });
                          return Fluttertoast.showToast(msg: "修改成功，请重新登录");
                        } else {
                          return Fluttertoast.showToast(
                              msg: response["notice"]);
                        }
                      },
                    );
                  },
                ),
              ],
            )
          ],
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: ListView(
          children: <Widget>[
            Container(
              color: Colors.white,
              child: TextField(
                obscureText: true,
                controller: _oldPasswordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "输入旧密码",
                ),
                onChanged: (val) => _checkFrom(),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 5, bottom: 5),
              color: Colors.white,
              child: TextField(
                obscureText: true,
                controller: _newPasswordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "输入新密码",
                ),
                onChanged: (val) => _checkFrom(),
              ),
            ),
            Container(
              color: Colors.white,
              child: TextField(
                obscureText: true,
                controller: _confirmNewPasswordController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "确认新密码",
                ),
                onChanged: (val) => _checkFrom(),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text.rich(TextSpan(children: <InlineSpan>[
                TextSpan(
                  text: "修改密码后需要重新登录，找回密码请访问网页端虎绿林，需要找回密码请 ",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(28),
                    color: Colors.grey[600],
                  ),
                ),
                WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: GestureDetector(
                    child: Text(
                      "点击我",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(28),
                        color: Colors.blue,
                      ),
                    ),
                    onTap: () {
                      Utils.openUrl("/user.reset_pwd.html");
                    },
                  ),
                )
              ])),
            ),
          ],
        ),
      ),
    );
  }

  void _checkFrom() {
    setState(() {
      validated = _oldPasswordController.text != "" &&
          _newPasswordController.text != "" &&
          _confirmNewPasswordController.text != "";
    });
  }
}
