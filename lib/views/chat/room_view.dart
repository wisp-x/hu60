import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/chat/room_controller.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/chat/room_entity.dart';
import 'package:hu60/services/common.dart';
import 'package:hu60/services/expanded_viewport.dart';
import 'package:hu60/services/html.dart';
import 'package:hu60/services/user.dart';
import 'package:hu60/services/utils.dart';
import 'package:hu60/views/user/user_info_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoomView extends StatefulWidget {
  final name;

  const RoomView({Key key, @required this.name}) : super(key: key);

  @override
  _RoomView createState() => _RoomView();
}

class _RoomView extends State<RoomView> {
  UserController user = Get.put(UserController());
  bool openFace = false;
  double _height = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.name),
        centerTitle: true,
        titleSpacing: 0,
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: SafeArea(
        child: GetBuilder<RoomController>(
          init: RoomController(widget.name),
          builder: (c) => c.loading
              ? Utils.loading(context)
              : Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Expanded(
                      child: SmartRefresher(
                        enablePullDown: false,
                        onLoading: c.onLoading,
                        footer: CustomFooter(
                          loadStyle: LoadStyle.ShowAlways,
                          builder: (context, mode) {
                            if (mode == LoadStatus.loading) {
                              return Container(
                                height: 60.0,
                                child: Container(
                                  height: 20.0,
                                  width: 20.0,
                                  child: CupertinoActivityIndicator(),
                                ),
                              );
                            } else
                              return Container();
                          },
                        ),
                        enablePullUp: true,
                        child: Scrollable(
                          controller: c.scrollController,
                          axisDirection: AxisDirection.up,
                          viewportBuilder: (context, offset) {
                            return ExpandedViewport(
                              offset: offset,
                              axisDirection: AxisDirection.up,
                              slivers: <Widget>[
                                SliverExpanded(),
                                SliverList(
                                  delegate: SliverChildBuilderDelegate(
                                    (_, i) {
                                      ChatList item = c.list[i];
                                      return _MessageItem(
                                        content: item.content,
                                        author: item.uinfo.name,
                                        isMe: user.user.uid == item.uid,
                                        url: item.uAvatar,
                                        uid: item.uid,
                                      );
                                    },
                                    childCount: c.list.length,
                                  ),
                                )
                              ],
                            );
                          },
                        ),
                        controller: c.refreshController,
                      ),
                    ),
                    Offstage(
                      offstage: !user.isLogin,
                      child: Container(
                        color: Colors.white,
                        height: 56.0,
                        child: Row(
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
                                  _height = openFace ? 110 : 0;
                                });
                              },
                            ),
                            Expanded(
                              child: Container(
                                height: 38,
                                child: TextField(
                                  autofocus: true,
                                  keyboardType: TextInputType.multiline,
                                  controller: c.textController,
                                  decoration: InputDecoration(
                                    contentPadding: EdgeInsets.all(8),
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
                                    hintText: "输入要发送的消息",
                                  ),
                                  onSubmitted: (val) => _submit(c),
                                ),
                                margin: EdgeInsets.only(right: 10),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.only(right: 10),
                              child: TextButton(
                                child: Text(
                                  "发送",
                                  style: TextStyle(color: Colors.white),
                                ),
                                style: TextButton.styleFrom(
                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(4)),
                                  ),
                                  elevation: 0,
                                  backgroundColor: Colors.green,
                                ),
                                onPressed: () => _submit(c),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 160),
                      height: _height,
                      padding: EdgeInsets.all(10),
                      child: GridView.builder(
                        itemCount: FACES.length,
                        itemBuilder: (BuildContext context, int index) {
                          var face = FACES[index];
                          return GestureDetector(
                            onTap: () {
                              String text = c.textController.text;
                              c.textController.text = "$text{${face["name"]}}";
                              c.textController.selection =
                                  TextSelection.fromPosition(
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
      ),
    );
  }

  _submit(RoomController c) {
    c.speak(c.textController.text);
  }
}

class _MessageItem extends StatelessWidget {
  final String content;
  final String author;
  final bool isMe;
  final String url;
  final int uid;

  _MessageItem({this.content, this.author, this.isMe, this.url, this.uid});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      child: Wrap(
        textDirection: isMe ? TextDirection.rtl : TextDirection.ltr,
        children: <Widget>[
          GestureDetector(
            child: User.getAvatar(context: context, url: url),
            onTap: () => Get.to(() => UserInfoView(id: uid)),
          ),
          Container(width: 15.0),
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                height: 25.0,
                width: ScreenUtil().screenWidth - 120,
                alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                child: Text(
                  author,
                  style: TextStyle(
                    color: Colors.grey,
                    fontSize: ScreenUtil().setSp(32),
                  ),
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  maxWidth: ScreenUtil().screenWidth - 120,
                ),
                alignment: isMe ? Alignment.topRight : Alignment.topLeft,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Html.decode(content),
              )
            ],
          )
        ],
      ),
    );
  }
}
