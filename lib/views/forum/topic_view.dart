import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
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

        return ListTile(title: Text("哈哈哈"));
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
              padding: EdgeInsets.only(top: 10),
              child: Text("发布于 $date   ${meta.readCount} 人浏览"),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(left: 15, top: 5, right: 15, bottom: 5),
            child: Text(
              meta.title,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.bold,
              ),
            ),
          )
        ],
      ),
    );
  }
}
