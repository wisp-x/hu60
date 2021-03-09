import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class Comment extends StatefulWidget {
  final TextEditingController controller;
  final faceUrl = "https://hu60.cn/img/face/";
  final List<Map<String, String>> faces = [
    {"id": "e586b7", "name": "冷"},
    {"id": "e58b89e5bcba", "name": "勉强"},
    {"id": "e59090e8888c", "name": "吐舌"},
    {"id": "e59090", "name": "吐"},
    {"id": "e591b5e591b5", "name": "呵呵"},
    {"id": "e591bc", "name": "呼"},
    {"id": "e592a6", "name": "咦"},
    {"id": "e59388e59388", "name": "哈哈"},
    {"id": "e5958a", "name": "啊"},
    {"id": "e596b7", "name": "喷"},
    {"id": "e5a4aae5bc80e5bf83", "name": "太开心"},
    {"id": "e5a794e5b188", "name": "委屈"},
    {"id": "e5bc80e5bf83", "name": "开心"},
    {"id": "e68092", "name": "怒"},
    {"id": "e6838ae593ad", "name": "惊哭"},
    {"id": "e6838ae8aeb6", "name": "惊讶"},
    {"id": "e6b197", "name": "汗"},
    {"id": "e6b3aa", "name": "泪"},
    {"id": "e68092", "name": "怒"},
    {"id": "e6bb91e7a8bd", "name": "滑稽"},
    {"id": "e78b82e6b197", "name": "狂汗"},
    {"id": "e79691e997ae", "name": "疑问"},
    {"id": "e79c9fe6a392", "name": "真棒"},
    {"id": "e79da1e8a789", "name": "睡觉"},
    {"id": "e7ac91e79cbc", "name": "笑眼"},
    {"id": "e88ab1e5bf83", "name": "花心"},
    {"id": "e98499e8a786", "name": "鄙视"},
    {"id": "e985b7", "name": "酷"},
    {"id": "e992b1", "name": "钱"},
    {"id": "e998b4e999a9", "name": "阴险"},
    {"id": "e9bb91e7babf", "name": "黑线"},
    {"id": "e4b88de9ab98e585b4", "name": "不高兴"},
    {"id": "e4b996", "name": "乖"},
    {"id": "e78b97e5a4b4", "name": "狗头"},
    {"id": "e59b9ee5a4b4e79c8b", "name": "回头看"},
  ];

  Comment({Key key, @required this.controller}) : super(key: key);

  @override
  _Comment createState() => _Comment();
}

class _Comment extends State<Comment> with SingleTickerProviderStateMixin {
  bool openFace = false;
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
              maxLines: 3,
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
                    color: Color(0xff6d6d6d),
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
                    size: 30,
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
                  onTap: () {},
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
                      "发送",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
            AnimatedContainer(
              duration: Duration(milliseconds: 160),
              height: _height,
              child: GridView.builder(
                itemCount: widget.faces.length,
                itemBuilder: (BuildContext context, int index) {
                  var face = widget.faces[index];
                  return GestureDetector(
                    onTap: () {
                      widget.controller.text =
                          "${widget.controller.text}{${face["name"]}}";
                      widget.controller.selection = TextSelection.fromPosition(
                        TextPosition(offset: widget.controller.text.length),
                      );
                    },
                    child: CachedNetworkImage(
                      imageUrl: "${widget.faceUrl}${face["id"]}.gif",
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
}
