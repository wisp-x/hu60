import 'dart:ui' as ui;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/forum/topic_controller.dart';
import 'package:hu60/entities/forum/topic_entity.dart';
import 'package:hu60/utils/html.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/utils/utils.dart';
import 'package:common_utils/common_utils.dart';
import 'package:hu60/views/component/comment.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicView extends StatelessWidget {
  TopicView({@required this.id});

  final id;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicController>(
      init: TopicController(id: id),
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
                Icons.open_in_new_outlined,
              ),
              onPressed: () {
                Utils.openUrl("https://hu60.cn/q.php/bbs.topic.$id.html");
              },
            ),
          ],
        ),
        body: c.loading ? Utils.loading(context) : _buildBody(context, c),
      ),
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
        GestureDetector(
          onTap: () {
            showModalBottomSheet(
              isScrollControlled: true,
              backgroundColor: Colors.white,
              context: context,
              builder: (BuildContext context) {
                return Comment(
                  controller: c.textController,
                );
              },
            ).then((val) {
              print(val);
            });
          },
          child: Container(
            width: double.infinity,
            color: Colors.white,
            padding: EdgeInsets.only(top: 10, bottom: 30, left: 10, right: 10),
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
              child: Text("说点什么吧..."),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMeta(BuildContext context, TopicController c, TContents item) {
    String date = TimelineUtil.format(item.ctime * 1000, locale: "zh");
    TMeta meta = c.topic.tMeta;
    return Container(
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                height: 50,
                width: 50,
                imageUrl: User.getAvatar(context, meta.uAvatar),
                placeholder: (context, url) => CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text.rich(
              TextSpan(children: [
                WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: Text(
                    "${meta.uName} ",
                    style: TextStyle(
                      fontSize: 18,
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
                      c.topic.fName,
                      style: TextStyle(
                        fontSize: 16,
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
                "发布于 $date  ${meta.readCount}次点击  ${c.topic.floorCount - 1}人回复",
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
                      fontSize: 17,
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
                child: Text(
                  "回复列表(${c.topic.floorCount - 1})",
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                  ),
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
    String date = TimelineUtil.format(item.ctime * 1000, locale: "zh");
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
          child: ListTile(
            leading: ClipRRect(
              borderRadius: BorderRadius.circular(6.0),
              child: CachedNetworkImage(
                height: 40,
                width: 40,
                imageUrl: User.getAvatar(context, item.uAvatar),
                placeholder: (context, url) => CupertinoActivityIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text.rich(
              TextSpan(
                children: <InlineSpan>[
                  WidgetSpan(
                    alignment: ui.PlaceholderAlignment.middle,
                    child: Text("${item.uName} "),
                  ),
                  WidgetSpan(
                    child: Offstage(
                      offstage: item.uid != c.topic.tMeta.uid,
                      child: Container(
                        padding: EdgeInsets.only(left: 3, right: 3),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          color: Colors.red[400],
                        ),
                        child: Text(
                          "楼主",
                          style: TextStyle(
                            fontSize: 15,
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
              child: Text(date),
            ),
            trailing: Text(
              "# $index",
              style: TextStyle(
                color: Colors.grey,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.only(left: 6, right: 6, bottom: 10),
          child: Html.decode(item.content),
        ),
        Offstage(
          offstage: index == c.topic.floorCount,
          child: Divider(
            height: 1,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
