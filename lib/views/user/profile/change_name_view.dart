import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';

class ChangeNameView extends StatefulWidget {
  @override
  _ChangeNameView createState() => _ChangeNameView();
}

class _ChangeNameView extends State<ChangeNameView> {
  TextEditingController _textController = TextEditingController();

  bool validated = false; // 是否验证通过

  @override
  void initState() {
    super.initState();
    _textController.text = Get.find<UserController>().user.name;
    validated = _textController.text != "";
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("修改用户名"),
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
                    if (_textController.text == c.user.name) {
                      return Fluttertoast.showToast(msg: "请输入新的用户名");
                    }
                    c.changeName(_textController.text, callback: (response) {
                      if (response["success"]) {
                        Get.back();
                        return Fluttertoast.showToast(msg: "修改成功");
                      } else {
                        return Fluttertoast.showToast(
                          msg: response["notice"],
                        );
                      }
                    });
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
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "输入新的用户名",
                ),
                onChanged: (val) {
                  setState(() {
                    validated = val != "";
                  });
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "用户名是你在虎绿林的所展示并且是唯一的名称，一个有意义的名称能使别人更容易记住你。",
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(28),
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
