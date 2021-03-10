import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/forum/topics_controller.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/forum/topic_view.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/views/user/user_info_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui' as ui;

class TopicsView extends StatefulWidget {
  @override
  _TopicsView createState() => _TopicsView();
}

class _TopicsView extends State<TopicsView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  final TopicsController c = Get.put(TopicsController());

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TopicsController>(
      init: TopicsController(),
      builder: (c) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: TabBar(
            labelColor: Theme.of(context).accentColor,
            indicatorColor: Theme.of(context).accentColor,
            controller: c.tabController,
            onTap: (int i) {
              c.type = i;
              c.init();
            },
            tabs: [
              Tab(text: "新帖"),
              Tab(text: "精华"),
            ],
          ),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            controller: c.refreshController,
            primary: false,
            scrollController: c.scrollController,
            onRefresh: c.onRefresh,
            onLoading: c.onLoading,
            child: _list(context, c),
          ),
        );
      },
    );
  }

  // 构建列表项
  Widget _list(BuildContext context, TopicsController c) {
    if (c.loading) return Utils.loading(context);
    return ListView.separated(
      itemCount: c.topics.length,
      separatorBuilder: (BuildContext context, int index) => Container(
        margin: EdgeInsets.only(top: 15),
        padding: EdgeInsets.only(left: 20, right: 20),
        child: Divider(
          height: 1.0,
          color: Color(0xffcecece),
        ),
      ),
      itemBuilder: (BuildContext context, int index) {
        if (c.topics.length < index) {
          return null;
        }
        TopicList item = c.topics[index];
        String avatarUrl = User.getAvatar(context, item.uAvatar);
        String date = TimelineUtil.format(item.mtime * 1000, locale: "zh");
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          child: Padding(
            padding: EdgeInsets.only(left: 20, top: 15, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Row(
                    children: <Widget>[
                      Container(
                        width: 25,
                        height: 25,
                        margin: EdgeInsets.only(right: 5),
                        child: ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: avatarUrl,
                            placeholder: (_, url) =>
                                CupertinoActivityIndicator(),
                            errorWidget: (context, url, error) => Center(
                              child: Icon(Icons.error),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Text.rich(
                          TextSpan(
                            children: <InlineSpan>[
                              WidgetSpan(
                                alignment: ui.PlaceholderAlignment.middle,
                                child: Container(
                                  margin: EdgeInsets.only(right: 5),
                                  child: Text(
                                    item.uName,
                                    style: TextStyle(fontSize: 17),
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
                  ),
                  onTap: () => Get.to(() => UserInfoView(id: item.uid)),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8, bottom: 8),
                  child: Text.rich(
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
                  ),
                ),
                Text.rich(
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
                )
              ],
            ),
          ),
          onTap: () => Get.to(() => TopicView(id: item.id)),
        );
      },
    );
  }
}
