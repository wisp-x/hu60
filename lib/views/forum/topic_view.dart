import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/forum/topic_controller.dart';
import 'package:hu60/entities/forum/topic_entity.dart';
import 'package:hu60/utils/user.dart';
import 'package:loading_indicator/loading_indicator.dart';
import 'package:common_utils/common_utils.dart';

class TopicView extends StatelessWidget {
  TopicView({@required this.id});

  final id;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicController>(
      init: TopicController(id: id),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text("主题详情"),
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: c.loading ? _loading(context) : _buildBody(context, c),
      ),
    );
  }

  // 加载组件
  Widget _loading(BuildContext context) {
    return Center(
      child: Container(
        width: 50,
        height: 50,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            LoadingIndicator(
              indicatorType: Indicator.pacman,
              color: Theme.of(context).hintColor,
            )
          ],
        ),
      ),
    );
  }

  // 构建内容
  Widget _buildBody(BuildContext context, TopicController c) {
    return ListView.builder(
      physics: BouncingScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        TContents item = c.topic.tContents[index];
        if (index == 0) {
          return _buildMeta(context, c, item);
        }

        return _buildComments(context, c, item, index);
      },
      itemCount: c.topic.tContents.length,
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
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text.rich(
              TextSpan(children: [
                WidgetSpan(child: Text("${meta.uName} ")),
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
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 8),
              child: Text(
                "发布于 $date   ${meta.readCount}人浏览  ${c.topic.floorCount}人回复",
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, right: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Text(
                    meta.title,
                    style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 10),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
                Html(
                  data: item.content,
                ),
              ],
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10),
            child: Container(
              height: 40,
              alignment: Alignment.centerLeft,
              width: double.maxFinite,
              color: Colors.grey[300],
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
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text(item.uName),
            subtitle: Padding(
              padding: EdgeInsets.only(top: 2),
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
          padding: EdgeInsets.only(left: 16, right: 16, bottom: 10),
          child: Html(
            data: item.content ?? "", // TODO 处理控制台报错
          ),
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
