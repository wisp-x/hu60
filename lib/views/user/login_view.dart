import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/home_controller.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/user/user_entity.dart';
import 'package:hu60/http.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginView extends StatefulWidget {
  @override
  _LoginView createState() => _LoginView();
}

class _LoginView extends State<LoginView> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool hidePassword = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("登录账号"),
        centerTitle: false,
        elevation: 0,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xa62da100), Color(0x9200a050)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Center(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Color(0x20939393),
                  offset: Offset(0.0, 5.0),
                  blurRadius: 9.0,
                  spreadRadius: 1.0,
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(14),
                    hintText: "请输入用户名",
                    prefixIcon: Icon(
                      Icons.account_circle,
                      color: Color(0xff767676),
                    ),
                    // contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50),
                      borderSide: BorderSide.none,
                    ),
                    filled: true,
                    fillColor: Color(0xffeeeeee),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 20, bottom: 20),
                  child: TextField(
                    obscureText: hidePassword,
                    controller: passwordController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.all(14),
                      hintText: "请输入密码",
                      prefixIcon: Icon(
                        Icons.lock,
                        color: Color(0xff767676),
                      ),
                      // contentPadding: EdgeInsets.all(10),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: Color(0xffeeeeee),
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            hidePassword = !hidePassword;
                          });
                        },
                        child: Icon(
                          hidePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ),
                ),
                TextButton(
                  child: Text(
                    "登录",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.green,
                    minimumSize: Size(double.infinity, 45),
                  ),
                  onPressed: () async {
                    var response = await Http.request(
                      "/user.login.json",
                      method: Http.POST,
                      data: {
                        "type": 1,
                        "name": nameController.text,
                        "pass": passwordController.text,
                        "go": 1,
                      },
                    );
                    if (!response.data["success"]) {
                      Fluttertoast.showToast(msg: response.data["notice"]);
                    } else {
                      UserController controller = Get.put(UserController());
                      SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      prefs.setString("sid", response.data["sid"]);
                      var res = await Http.request("/user.index.json");
                      if (res.data != "") {
                        UserEntity entity = UserEntity.fromJson(res.data);
                        controller.setUser(entity);
                        Get.back();
                      } else {
                        Fluttertoast.showToast(msg: "登录失败");
                      }
                    }
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
