import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/views/forum/topic_view.dart';
import 'package:hu60/views/user/user_info_view.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

class Forum {
  // 构建帖子列表视图
  static Widget buildTopics(List<TopicList> topics) {
    return ListView.separated(
      itemCount: topics.length,
      separatorBuilder: (BuildContext context, int index) => Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Divider(
          height: 1.0,
          color: Color(0xffcecece),
        ),
      ),
      itemBuilder: (BuildContext context, int index) {
        if (topics.length < index) {
          return null;
        }
        TopicList item = topics[index];
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                buildTopicsHeader(context, item),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: buildTopicsTitle(item),
                ),
                buildTopicsFooter(item),
              ],
            ),
          ),
          onTap: () => Get.to(() => TopicView(id: item.id)),
        );
      },
    );
  }

  // 构建帖子列表头部内容
  static Widget buildTopicsHeader(BuildContext context, TopicList item) {
    return Row(
      children: <Widget>[
        GestureDetector(
          child: Container(
            margin: EdgeInsets.only(right: 5),
            child: User.getAvatar(
              context: context,
              url: item.uAvatar,
              size: 25,
              borderRadius: 50,
            ),
          ),
          onTap: () => Get.to(() => UserInfoView(id: item.uid)),
        ),
        Expanded(
          child: Text.rich(
            TextSpan(
              children: <InlineSpan>[
                WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: GestureDetector(
                    child: Container(
                      margin: EdgeInsets.only(right: 5),
                      child: Text(
                        item.uName,
                        style: TextStyle(fontSize: 17),
                      ),
                    ),
                    onTap: () => Get.to(
                      () => UserInfoView(id: item.uid),
                    ),
                  ),
                ),
                WidgetSpan(
                  alignment: ui.PlaceholderAlignment.middle,
                  child: Container(
                    padding: EdgeInsets.only(left: 3, right: 3),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4.0),
                      ),
                      color: Colors.green[400],
                    ),
                    child: Text(
                      item.forumName,
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        )
      ],
    );
  }

  // 构建帖子列表标题
  static Widget buildTopicsTitle(TopicList item) {
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(
          alignment: ui.PlaceholderAlignment.middle,
          child: Offstage(
            offstage: item.locked == 0,
            child: Text(
              "锁 ",
              style: TextStyle(
                fontSize: 17,
                color: Colors.grey,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        WidgetSpan(
          alignment: ui.PlaceholderAlignment.middle,
          child: Offstage(
            offstage: item.essence == 0,
            child: Text(
              "精 ",
              style: TextStyle(
                fontSize: 17,
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        WidgetSpan(
          alignment: ui.PlaceholderAlignment.middle,
          child: Offstage(
            offstage: item.level != -1,
            child: Text(
              "沉 ",
              style: TextStyle(
                fontSize: 17,
                color: Colors.redAccent,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        TextSpan(
          text: item.title,
          style: TextStyle(
            fontSize: 17,
          ),
        )
      ]),
    );
  }

  // 构建帖子列表底部内容
  static Widget buildTopicsFooter(TopicList item) {
    String date = TimelineUtil.format(item.mtime * 1000, locale: "zh");
    return Text.rich(
      TextSpan(children: [
        WidgetSpan(
          child: Icon(
            Icons.chat,
            color: Colors.grey,
            size: 16,
          ),
        ),
        TextSpan(
          text: " ${item.replyCount}  ",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        WidgetSpan(
          child: Icon(
            Icons.remove_red_eye,
            color: Colors.grey,
            size: 17,
          ),
        ),
        TextSpan(
          text: " ${item.readCount} · 最后回复于 $date",
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
      ]),
    );
  }
}
