import 'package:dio/dio.dart' as dio;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/home_controller.dart';
import 'package:hu60/controllers/message/message_controller.dart';
import 'package:hu60/entities/user/user_entity.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../http.dart';

class UserController extends GetxController {
  UserEntity user; // 用户数据
  bool isLogin = false;

  // 初始化用户数据
  init({Function callback}) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.getString("sid");
    if (sid != "" && sid != null) {
      dio.Response res = await Http.request(
          "/user.index.json?_myself=newMsg,newAtInfo&_uinfo=avatar");
      if (res.data != "") {
        UserEntity entity = UserEntity.fromJson(res.data);
        this.user = entity;
        this.user.floorReverse = this.user.floorReverse ?? false;
        this.isLogin = true;
        update();
        Get.put(MessageController()).update();
        Get.put(HomeController()).update();
        if (callback != null) callback();
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
    this.user = UserEntity(0, "", "", "", 0, null, null, null, [], null, "");
    update();
    Get.put(MessageController()).update();
    Get.put(HomeController()).update();
  }

  // 设置楼层倒序/正序，倒序=true，正序=false
  setFloorReverse(bool value, {Function callback}) async {
    String url = "/user.index.json?floorReverse=${value ? 1 : 0}";
    dio.Response response = await Http.request(url);
    user.floorReverse = response.data["floorReverse"];
    update();
    if (callback != null) callback(response.data);
  }

  // 修改用户名
  changeName(String name, {Function callback}) async {
    dio.Response response = await Http.request(
      "/user.chname.json",
      method: Http.POST,
      data: {
        "newName": name,
        "go": 1,
      },
    );
    if (response.data["success"]) {
      user.name = name;
      update();
    }
    if (callback != null) callback(response.data);
  }

  // 修改个性签名
  changeSign(String sign, {Function callback}) async {
    dio.Response response = await Http.request(
      "/user.chinfo.json",
      method: Http.POST,
      data: {
        "signature": sign,
        "contact": user.contact,
        "go": 1,
      },
    );
    if (response.data["success"]) {
      user.signature = sign;
      update();
    }
    if (callback != null) callback(response.data);
  }

  // 修改联系方式
  changeContact(String contact, {Function callback}) async {
    dio.Response response = await Http.request(
      "/user.chinfo.json",
      method: Http.POST,
      data: {
        "signature": user.signature,
        "contact": contact,
        "go": 1,
      },
    );
    if (response.data["success"]) {
      user.contact = contact;
      update();
    }
    if (callback != null) callback(response.data);
  }

  // 修改密码
  changePassword(String oldPassword,
      String newPassword, {
        Function callback,
      }) async {
    dio.Response response = await Http.request(
      "/user.chpwd.json",
      method: Http.POST,
      data: {
        "step": 2,
        "oldPassword": oldPassword,
        "newPassword": newPassword,
        "newPasswordAgain": newPassword,
        "go": 1,
      },
    );
    if (callback != null) callback(response.data);
  }

  // 收藏帖子
  void collect(int id, {Function callback}) async {
    dio.Response response = await Http.request(
      "/bbs.setfavoritetopic.$id.json",
      method: Http.POST,
    );
    if (callback != null) callback();
    if (response.data["success"]) {
      Fluttertoast.showToast(msg: "收藏成功");
    } else {
      Fluttertoast.showToast(msg: response.data["notice"]);
    }
  }

  // 取消帖子收藏
  void cancelCollect(int id, {Function callback}) async {
    dio.Response response = await Http.request(
      "/bbs.unsetfavoritetopic.$id.json",
      method: Http.POST,
    );
    if (callback != null) callback();
    if (response.data["success"]) {
      Fluttertoast.showToast(msg: "已取消收藏");
    } else {
      Fluttertoast.showToast(msg: response.data["notice"]);
    }
  }
}
