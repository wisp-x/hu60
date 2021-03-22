import 'package:cached_network_image/cached_network_image.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/http.dart';
import 'package:hu60/services/common.dart';

class Comment extends StatefulWidget {
  final TextEditingController controller;
  final topicId; // 帖子ID
  final contentId; // 楼层ID
  final isEdit; // 是否是编辑
  final Function callback; // 回复成功后的回调

  Comment({
    Key key,
    @required this.topicId,
    this.contentId,
    this.isEdit = false,
    @required this.controller,
    this.callback,
  }) : super(key: key);

  @override
  _Comment createState() => _Comment();
}

class _Comment extends State<Comment> with SingleTickerProviderStateMixin {
  bool openFace = false;
  bool loading = false;
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.white,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              autofocus: true,
              maxLines: 5,
              keyboardType: TextInputType.multiline,
              controller: widget.controller,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.all(10),
                enabledBorder: OutlineInputBorder(
                  // 未选中时候的颜色
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Color(0xffbfbfbf),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  // 选中时外边框颜色
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Color(0xffb3b3b3),
                  ),
                ),
                hintText: "请勿发布不友善或者负能量的内容，与人为善，比聪明更重要！",
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                IconButton(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  icon: Icon(
                    Icons.tag_faces,
                    size: ScreenUtil().setWidth(60),
                    color: Color(0xff5a5a5a),
                  ),
                  onPressed: () {
                    setState(() {
                      openFace = !openFace;
                      _height = openFace ? 90 : 0;
                    });
                  },
                ),
                GestureDetector(
                  child: Container(
                    padding: EdgeInsets.only(
                      top: 5,
                      bottom: 5,
                      left: 10,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(4),
                      color: Theme.of(context).accentColor,
                    ),
                    child: Text(
                      widget.isEdit ? "保存修改" : "发送",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: ScreenUtil().setSp(30),
                      ),
                    ),
                  ),
                  onTap: () async {
                    if (widget.controller.text == "") {
                      Fluttertoast.showToast(msg: "请输入内容");
                      return;
                    }
                    if (loading) return;
                    setState(() {
                      loading = true;
                    });
                    if (!widget.isEdit) {
                      await _newCallback();
                    } else {
                      await _editCallback();
                    }
                    setState(() {
                      loading = false;
                    });
                  },
                ),
              ],
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 160),
              height: _height,
              child: GridView.builder(
                itemCount: FACES.length,
                itemBuilder: (BuildContext context, int index) {
                  var face = FACES[index];
                  return GestureDetector(
                    onTap: () {
                      String text = widget.controller.text;
                      widget.controller.text = "$text{${face["name"]}}";
                      widget.controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: text.length),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: "$FACE_URL${face["id"]}.gif",
                    ),
                  );
                },
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 40,
                  mainAxisSpacing: 8.0,
                  crossAxisSpacing: 8.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 发布新回复回调
  _newCallback() async {
    String text = widget.controller.text;
    dio.Response getToken = await Http.request(
      "/bbs.newreply.${widget.topicId}.json",
      method: Http.GET,
    );
    dio.Response response = await Http.request(
      "/bbs.newreply.${widget.topicId}.json",
      method: Http.POST,
      data: {
        "content": "<!-- markdown -->\r\n$text",
        "token": getToken.data["token"],
        "go": 1,
      },
    );
    if (response.data["success"]) {
      Get.back();
      if (widget.callback != null) {
        widget.callback();
      }
      Fluttertoast.showToast(msg: "回复成功");
    } else {
      Fluttertoast.showToast(
        msg: response.data["notice"] ?? "回复失败",
      );
    }
  }

  // 编辑回复回调
  _editCallback() async {
    String text = widget.controller.text;
    dio.Response getToken = await Http.request(
      "/bbs.edittopic.${widget.topicId}.${widget.contentId}.json",
      method: Http.GET,
    );
    dio.Response response = await Http.request(
      "/bbs.edittopic.${widget.topicId}.${widget.contentId}.json",
      method: Http.POST,
      data: {
        "content": "<!-- markdown -->\r\n$text",
        "token": getToken.data["token"],
        "go": 1,
      },
    );
    if (response.data["success"]) {
      Get.back();
      if (widget.callback != null) {
        widget.callback();
      }
      Fluttertoast.showToast(msg: "修改成功");
    } else {
      Fluttertoast.showToast(
        msg: response.data["notice"] ?? "修改失败",
      );
    }
  }
}
