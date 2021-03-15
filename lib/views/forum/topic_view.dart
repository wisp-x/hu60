import 'dart:ui' as ui;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/forum/topic_controller.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/forum/topic_entity.dart';
import 'package:hu60/http.dart';
import 'package:hu60/utils/html.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/utils/utils.dart';
import 'package:common_utils/common_utils.dart';
import 'package:hu60/views/component/comment.dart';
import 'package:hu60/views/forum/edit_topic_view.dart';
import 'package:hu60/views/forum/plate_view.dart';
import 'package:hu60/views/user/login_view.dart';
import 'package:hu60/views/user/user_info_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart' as dio;

class TopicView extends StatelessWidget {
  final int id; // 帖子ID
  const TopicView({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController());
    return GetBuilder<TopicController>(
      init: TopicController(id: id),
      tag: "topic-$id",
      builder: (c) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          title: Text("主题详情"),
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          actions: <Widget>[
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(
                Icons.more_horiz_rounded,
              ),
              onPressed: () {
                showCupertinoModalPopup(
                  context: context,
                  builder: (context) {
                    var meta = c.data.tMeta;
                    return CupertinoActionSheet(
                      actions: !c.loading && meta.uid != userController.user.uid
                          ? <Widget>[
                              _openUrlAction(id),
                            ]
                          : <Widget>[
                              _openUrlAction(id),
                              CupertinoActionSheetAction(
                                child: Text("修改"),
                                onPressed: () async {
                                  Get.back();
                                  var data = await Get.to(
                                    EditTopicView(id: id),
                                  );
                                  if (data != null && data) {
                                    c.refreshController.requestRefresh();
                                  }
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text("移动"),
                                onPressed: () async {
                                  Get.back();
                                  var data = await Get.to(PlateView());
                                  if (data != null) {
                                    c.move(context, id, data["id"], () {
                                      c.refreshController.requestRefresh();
                                    });
                                  }
                                },
                              ),
                              CupertinoActionSheetAction(
                                child: Text("下沉"),
                                onPressed: () {
                                  Get.back();
                                  c.sink(context, () {
                                    c.refreshController.requestRefresh();
                                  });
                                },
                              ),
                              CupertinoActionSheetAction(
                                isDestructiveAction: true,
                                child: Text('删除'),
                                onPressed: () {
                                  Get.back();
                                  c.delete(
                                    context,
                                    id,
                                    c.content.id,
                                    () {
                                      Get.back();
                                    },
                                  );
                                },
                              ),
                            ],
                      cancelButton: CupertinoActionSheetAction(
                        child: Text('取消'),
                        onPressed: () {
                          Get.back();
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ],
        ),
        body: c.loading ? Utils.loading(context) : _buildBody(context, c),
      ),
    );
  }

  Widget _openUrlAction(id) {
    return CupertinoActionSheetAction(
      child: Text('浏览器打开'),
      onPressed: () async {
        Get.back();
        Utils.openUrl("/bbs.topic.$id.html");
      },
    );
  }

  // 构建内容
  Widget _buildBody(BuildContext context, TopicController c) {
    return Column(
      children: <Widget>[
        Expanded(
          child: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            controller: c.refreshController,
            primary: false,
            scrollController: c.scrollController,
            onRefresh: c.onRefresh,
            onLoading: c.onLoading,
            child: ListView.builder(
              itemCount: c.contents.length,
              itemBuilder: (BuildContext context, int index) {
                TContents item = c.contents[index];
                if (index == 0) {
                  return _buildMeta(context, c, item);
                }

                return _buildComments(context, c, item, index);
              },
            ),
          ),
        ),
        Offstage(
          offstage: c.content.locked == 1,
          child: GestureDetector(
            onTap: () {
              c.textController.text = "";
              _toggleCommentModal(context, c);
            },
            child: Container(
              width: double.infinity,
              color: Colors.white,
              padding: EdgeInsets.only(
                top: 10,
                bottom: 30,
                left: 10,
                right: 10,
              ),
              child: Container(
                padding: EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                  left: 20,
                  right: 20,
                ),
                decoration: BoxDecoration(
                  color: Color(0xc8ececec),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Text(
                  "说点什么吧...",
                  style: TextStyle(
                    fontSize: ScreenUtil().setSp(30),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeta(BuildContext context, TopicController c, TContents item) {
    UserController userController = Get.put(UserController());
    String date = TimelineUtil.format(item.ctime * 1000, locale: "zh");
    TMeta meta = c.data.tMeta;
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: GestureDetector(
              child: User.getAvatar(
                context: context,
                url: meta.uAvatar,
                size: ScreenUtil().setWidth(100),
                borderRadius: 6.0,
              ),
              onTap: () => Get.to(() => UserInfoView(id: meta.uid)),
            ),
            title: Text.rich(
              TextSpan(children: [
                WidgetSpan(
                  child: Text(
                    "${meta.uName} ",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(35),
                    ),
                  ),
                ),
                WidgetSpan(
                  child: Container(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(4.0)),
                      color: Colors.green[400],
                    ),
                    child: Text(
                      c.data.fName,
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(34),
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 9),
              child: Text(
                "发布于 $date  ${meta.readCount}次点击  ${c.data.floorCount - 1}人回复",
                style: TextStyle(fontSize: ScreenUtil().setSp(32)),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 10, right: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5, bottom: 10),
                  child: Text(
                    meta.title,
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(36),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 5, right: 5),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                Html.decode(item.content),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              width: double.maxFinite,
              color: Color(0xffe7e7e7),
              child: Padding(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(
                      "回复列表(${c.data.floorCount - 1})",
                      style: TextStyle(
                        fontSize: ScreenUtil().setSp(32),
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    GestureDetector(
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            TextSpan(
                                text: userController.user.floorReverse
                                    ? "正序"
                                    : "倒序",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(32))),
                            WidgetSpan(
                              alignment: ui.PlaceholderAlignment.middle,
                              child: Icon(
                                Icons.sort_by_alpha,
                                size: ScreenUtil().setWidth(40),
                              ),
                            ),
                          ],
                        ),
                      ),
                      onTap: () {
                        userController.setFloorReverse(
                          !userController.user.floorReverse,
                          callback: (_) => c.refreshController.requestRefresh(),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildComments(
    BuildContext context,
    TopicController c,
    TContents item,
    int index,
  ) {
    UserController userController = Get.put(UserController());
    String date = TimelineUtil.format(item.ctime * 1000, locale: "zh");
    // 楼层
    int i = index;
    if (userController.user.floorReverse) {
      // 楼层倒序
      i = c.data.floorCount - index;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: ListTile(
            leading: GestureDetector(
              child: User.getAvatar(context: context, url: item.uAvatar),
              onTap: () => Get.to(() => UserInfoView(id: item.uid)),
            ),
            title: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    alignment: ui.PlaceholderAlignment.middle,
                    child: Text(
                      "${item.uName} ",
                      style: TextStyle(fontSize: ScreenUtil().setSp(35)),
                    ),
                  ),
                  WidgetSpan(
                    child: Offstage(
                      offstage: item.uid != 1,
                      child: Container(
                        margin: EdgeInsets.only(right: 5),
                        padding: EdgeInsets.only(left: 3, right: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Color(0xff197bcb),
                        ),
                        child: Text(
                          "站长",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(28),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                  WidgetSpan(
                    child: Offstage(
                      offstage: item.uid != c.data.tMeta.uid,
                      child: Container(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.red[400],
                        ),
                        child: Text(
                          "楼主",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(28),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 5),
              child: Text(
                date,
                style: TextStyle(fontSize: ScreenUtil().setSp(30)),
              ),
            ),
            trailing: Text(
              "# $i",
              style: TextStyle(
                fontSize: ScreenUtil().setSp(35),
                color: Colors.grey,
              ),
            ),
            onTap: () {
              if (c.content.locked == 1) return;
              c.textController.text = "@${item.uName}，";
              _toggleCommentModal(context, c);
            },
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 6, right: 6, bottom: 10),
          child: Html.decode(item.content),
        ),
        Container(
          margin: EdgeInsets.only(right: 20, bottom: 10),
          child: DefaultTextStyle(
            style: TextStyle(
              fontSize: 17,
              color: Colors.grey,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                Offstage(
                  offstage: c.content.locked == 1,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Text.rich(
                      TextSpan(
                        children: <InlineSpan>[
                          WidgetSpan(
                            child: Icon(
                              Icons.reply,
                              color: Colors.grey,
                              size: ScreenUtil().setWidth(36),
                            ),
                          ),
                          TextSpan(
                              text: "回复",
                              style:
                                  TextStyle(fontSize: ScreenUtil().setSp(35))),
                        ],
                      ),
                    ),
                    onTap: () {
                      c.textController.text = "@${item.uName}，";
                      _toggleCommentModal(context, c);
                    },
                  ),
                ),
                Offstage(
                  offstage:
                      item.uid != userController.user.uid || item.locked == 1,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Icon(
                                Icons.edit,
                                color: Colors.grey,
                                size: ScreenUtil().setWidth(36),
                              ),
                            ),
                            TextSpan(
                                text: "编辑",
                                style: TextStyle(
                                    fontSize: ScreenUtil().setSp(35))),
                          ],
                        ),
                      ),
                    ),
                    onTap: () async {
                      dio.Response floor = await Http.request(
                        "/bbs.edittopic.$id.${item.id}.json?_content=text",
                        method: Http.GET,
                      );
                      String content = floor.data["content"];
                      c.textController.text =
                          content.replaceAll("<!-- markdown -->\r\n", "");
                      _toggleCommentModal(
                        context,
                        c,
                        isEdit: true,
                        contentId: item.id,
                        callback: () {
                          c.updateFloor(id);
                        },
                      );
                    },
                  ),
                ),
                Offstage(
                  offstage:
                      item.uid != userController.user.uid || item.locked == 1,
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Container(
                      margin: EdgeInsets.only(left: 8),
                      child: Text.rich(
                        TextSpan(
                          children: <InlineSpan>[
                            WidgetSpan(
                              child: Icon(
                                Icons.delete,
                                color: Colors.red[300],
                                size: ScreenUtil().setWidth(36),
                              ),
                            ),
                            TextSpan(
                              text: "删除",
                              style: TextStyle(
                                fontSize: ScreenUtil().setSp(35),
                                color: Colors.red[300],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    onTap: () {
                      c.delete(context, id, item.id, () {
                        c.updateFloor(id);
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
        Offstage(
          offstage: index == c.data.floorCount,
          child: Divider(
            height: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  // 打开评论框
  _toggleCommentModal(
    BuildContext context,
    TopicController c, {
    Function callback,
    int contentId: 0,
    bool isEdit: false,
  }) {
    if (Get.find<UserController>().isLogin) {
      showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext context) {
          return Comment(
            topicId: id,
            contentId: contentId,
            isEdit: isEdit,
            controller: c.textController,
            callback: () => (callback != null ? callback() : () {}),
          );
        },
      ).then((val) {});
    } else {
      Get.to(() => LoginView(), fullscreenDialog: true);
    }
  }
}
