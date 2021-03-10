import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';
import 'package:hu60/entities/user/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http.dart';

class UserController extends GetxController {
  UserEntity user; // 用户数据
  bool isLogin = false;

  // 初始化用户数据
  init() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.getString("sid");
    if (sid != "" && sid != null) {
      dio.Response res = await Http.request("/user.index.json?_uinfo=avatar");
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
    this.user = UserEntity(0, "", "", "", 0, false, false, false, [], "");
    update();
  }
}
