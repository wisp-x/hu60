import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';

class ChangeContactView extends StatefulWidget {
  @override
  _ChangeContactView createState() => _ChangeContactView();
}

class _ChangeContactView extends State<ChangeContactView> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = Get.find<UserController>().user.contact;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("修改联系方式"),
          centerTitle: true,
          elevation: 0,
          actions: <Widget>[
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                GestureDetector(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.green,
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
                    c.changeContact(_textController.text, callback: (response) {
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
                  hintText: "输入联系方式",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "🔒 请注意保护你的隐私，虎绿林不保证你的联系方式不会被爬取。",
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
