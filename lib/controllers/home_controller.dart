import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/user/user_entity.dart';
import 'package:hu60/views/chat/chat_view.dart';
import 'package:hu60/views/forum/topics_view.dart';
import 'package:hu60/views/message/message_view.dart';
import 'package:hu60/views/user/user_view.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../http.dart';

class HomeController extends GetxController {
  final pages = <Widget>[TopicsView(), ChatView(), MessageView(), UserView()];
  final PageController pageController = PageController();
  int index = 0; // 当前导航索引
  UserEntity user; // 用户数据
  bool isLogin = false;

  // define field instance
  final GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

  onInit() async {
    super.onInit();
    // 初始化用户数据
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.getString("sid");
    if (sid != "" && sid != null) {
      var res = await Http.request("/user.index.json");
      if (res.data != "") {
        UserEntity entity = UserEntity.fromJson(res.data);
        this.user = entity;
        this.isLogin = true;
        update();
      }
    }
  }

  setUser(UserEntity user) {
    this.user = user;
    this.isLogin = true;
    update();
  }

  logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.remove("sid");
    this.isLogin = false;
    update();
  }
}
