import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';

class ChangeSignView extends StatefulWidget {
  @override
  _ChangeSignView createState() => _ChangeSignView();
}

class _ChangeSignView extends State<ChangeSignView> {
  TextEditingController _textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _textController.text = Get.find<UserController>().user.signature;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("修改个性签名"),
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
                    c.changeSign(_textController.text, callback: (response) {
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
                maxLines: 3,
                controller: _textController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(10),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(0),
                    borderSide: BorderSide.none,
                  ),
                  hintText: "输入个性签名",
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Text(
                "用一个好的签名彰显个性，让其他用户更好的了解你。",
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
