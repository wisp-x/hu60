import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/views/forum/plate_view.dart';

class NewTopicView extends StatefulWidget {
  @override
  _NewTopicView createState() => _NewTopicView();
}

class _NewTopicView extends State<NewTopicView> {
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
            onPressed: () {},
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
                _plateController.text = data != null ? data["name"] : "";
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
}
