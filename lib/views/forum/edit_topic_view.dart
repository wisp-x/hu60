import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/forum/topic_entity.dart';
import 'package:hu60/http.dart';
import 'package:hu60/services/utils.dart';

class EditTopicView extends StatefulWidget {
  final int id; // 帖子ID

  const EditTopicView({Key key, @required this.id}) : super(key: key);

  @override
  _EditTopicView createState() => _EditTopicView();
}

class _EditTopicView extends State<EditTopicView> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _contentController = TextEditingController();
  TContents topic;
  String token;
  bool canEditTitle = false;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _getTopic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("修改帖子"),
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        actions: <Widget>[
          Offstage(
            offstage: _loading,
            child: IconButton(
              splashColor: Colors.transparent,
              icon: Icon(Icons.done_outlined),
              highlightColor: Colors.transparent,
              onPressed: () {
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
                      title: Text('确认修改？'),
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
          ),
        ],
      ),
      body: _loading
          ? Utils.loading(context)
          : Container(
              padding: EdgeInsets.all(15),
              child: ListView(
                children: <Widget>[
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
                        enabled: canEditTitle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 10),
                    child: TextField(
                      controller: _contentController,
                      maxLines: 99,
                      minLines: 2,
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
      "/bbs.edittopic.${topic.topicId}.${topic.id}.1.json",
      method: Http.POST,
      data: {
        "markdown": "on",
        "title": _titleController.text,
        "content": "<!-- markdown -->\r\n${_contentController.text}",
        "go": 1,
        "token": token,
      },
    );
    if (response.data["success"]) {
      Fluttertoast.showToast(msg: "修改成功");
      Get.back(result: true);
    } else {
      Fluttertoast.showToast(msg: response.data["notice"]);
    }
  }

  void _getTopic() async {
    setState(() {
      _loading = true;
    });
    dio.Response response = await Http.request(
      "/bbs.topic.${widget.id}.json?_content=text",
      method: Http.GET,
    );
    TopicEntity topic = TopicEntity.fromJson(response.data);
    setState(() {
      this.topic = topic.tContents[0];
      _titleController.text = topic.tMeta.title;
      _contentController.text = this.topic.content;
    });
    dio.Response meta = await Http.request(
      "/bbs.edittopic.${this.topic.topicId}.${this.topic.id}.1.json",
      method: Http.GET,
    );
    setState(() {
      this.token = meta.data["token"];
      this.canEditTitle = meta.data["editTitle"];
      _loading = false;
    });
  }
}
