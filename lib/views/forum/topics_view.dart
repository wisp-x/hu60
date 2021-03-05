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
import 'package:pull_to_refresh/pull_to_refresh.dart';

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
    return ListView.builder(
      itemCount: c.topics.length,
      itemBuilder: (BuildContext context, int index) {
        if (c.topics.length < index) {
          return null;
        }
        TopicList item = c.topics[index];
        String avatarUrl = User.getAvatar(context, item.uAvatar);
        String date = TimelineUtil.format(item.mtime * 1000, locale: "zh");
        return ListTile(
          leading: ClipOval(
            child: CachedNetworkImage(
              imageUrl: avatarUrl,
              placeholder: (context, url) => CupertinoActivityIndicator(),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
          title: Text.rich(
            TextSpan(children: [
              WidgetSpan(
                child: Offstage(
                  offstage: item.locked == 0,
                  child: Text(
                    "锁 ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              WidgetSpan(
                child: Offstage(
                  offstage: item.essence == 0,
                  child: Text(
                    "精 ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              WidgetSpan(
                child: Offstage(
                  offstage: item.level != -1,
                  child: Text(
                    "沉 ",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              TextSpan(text: item.title)
            ]),
          ),
          subtitle: Text.rich(
            TextSpan(children: [
              WidgetSpan(
                child: Icon(
                  Icons.chat,
                  color: Colors.black26,
                  size: 16,
                ),
              ),
              TextSpan(text: " ${item.replyCount}  "),
              WidgetSpan(
                child: Icon(
                  Icons.remove_red_eye,
                  color: Colors.black26,
                  size: 17,
                ),
              ),
              TextSpan(text: " ${item.readCount} / 最后回复于 $date"),
            ]),
          ),
          onTap: () => Get.to(() => TopicView(id: item.id)),
        );
      },
    );
  }
}
