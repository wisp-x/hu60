import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/user/user_info_entity.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hu60/utils/utils.dart';

import '../../http.dart';

class UserInfoView extends StatefulWidget {
  final id;

  const UserInfoView({Key key, @required this.id}) : super(key: key); // 用户ID

  @override
  _UserInfoView createState() => _UserInfoView();
}

class _UserInfoView extends State<UserInfoView> {
  bool loading = true;
  UserInfoEntity user;
  final dividerColor = Color(0xdccdcdcd);

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: loading ? Utils.loading(context) : Text("111"),
      ),
    );
  }

  void _getUserInfo() async {
    setState(() => loading = true);
    dio.Response res =
        await Http.request("/user.info.${widget.id}.json?_uinfo=avatar");
    if (res.data != "") {
      UserInfoEntity entity = UserInfoEntity.fromJson(res.data);
      if (entity.uid == null) {
        Fluttertoast.showToast(msg: "不存在该用户");
      } else {
        setState(() {
          loading = false;
          this.user = entity;
        });
      }
    }
  }
}
