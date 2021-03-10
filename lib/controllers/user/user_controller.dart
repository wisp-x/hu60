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

  // 设置楼层倒序/正序，倒序=true，正序=false
  setFloorReverse(bool value, {Function callback}) async {
    String url = "/user.index.json?floorReverse=${value ? 1 : 0}";
    dio.Response res = await Http.request(url);
    user.floorReverse = res.data["floorReverse"];
    update();
    if (callback != null) callback();
  }
}
