import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/http.dart';
import 'package:hu60/views/forum/plate_view.dart';

class NewTopicView extends StatefulWidget {
  @override
  _NewTopicView createState() => _NewTopicView();
}

class _NewTopicView extends State<NewTopicView> {
  int _plateId = 0;
  TextEditingController _plateController = TextEditingController();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("发帖"),
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          IconButton(
            splashColor: Colors.transparent,
            icon: Icon(Icons.done_outlined),
            highlightColor: Colors.transparent,
            onPressed: () {
              if (_plateId == 0) {
                return Fluttertoast.showToast(msg: "请选择板块");
              }
              if (_titleController.text == "") {
                return Fluttertoast.showToast(msg: "请输入标题");
              }
              if (_contentController.text == "") {
                return Fluttertoast.showToast(msg: "请输入内容");
              }

              showCupertinoDialog(
                context: context,
                builder: (context) {
                  return CupertinoAlertDialog(
                    title: Text('确认发布？'),
                    actions: [
                      CupertinoDialogAction(
                        child: Text('确认'),
                        onPressed: () async {
                          Get.back();
                          _submit(context);
                        },
                      ),
                      CupertinoDialogAction(
                        child: Text('取消'),
                        isDestructiveAction: true,
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    ],
                  );
                },
              );
            },
          ),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: ListView(
          children: <Widget>[
            GestureDetector(
              child: TextField(
                controller: _plateController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  suffixIcon: Icon(Icons.chevron_right),
                  hintText: "请选择板块",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffd4d4d4)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffa5a5a5)),
                  ),
                  enabled: false,
                ),
              ),
              onTap: () async {
                var data = await Get.to(PlateView());
                if (data != null) {
                  setState(() {
                    _plateId = data["id"];
                  });
                  _plateController.text = data["name"];
                }
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _titleController,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  hintText: "请输入标题",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffd4d4d4)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffa5a5a5)),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 10),
              child: TextField(
                controller: _contentController,
                maxLines: 99,
                minLines: 10,
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.all(14),
                  hintText: "请输入内容",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffd4d4d4)),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Color(0xffa5a5a5)),
                  ),
                  filled: true,
                  fillColor: Color(0xc3f3f3f3),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) async {
    dio.Response response = await Http.request(
      "/bbs.newtopic.$_plateId.json",
      method: Http.GET,
    );
    dio.Response res = await Http.request(
      "/bbs.newtopic.$_plateId.json",
      method: Http.POST,
      data: {
        "markdown": "on",
        "title": _titleController.text,
        "content": "<!-- markdown -->\r\n${_contentController.text}",
        "go": 1,
        "token": response.data["token"],
      },
    );
    if (res.data["success"]) {
      Fluttertoast.showToast(msg: "发布成功");
      Get.back(result: true);
    } else {
      Fluttertoast.showToast(msg: res.data["notice"]);
    }
  }
}
