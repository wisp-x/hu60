import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hu60/controllers/forum/topics_controller.dart';
import 'package:hu60/entities/forum_entity.dart';
import 'package:hu60/utils/custom_classical.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:common_utils/common_utils.dart';
import 'package:hu60/views/forum/topic_view.dart';

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
          appBar: AppBar(
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Theme.of(context).backgroundColor,
            title: TabBar(
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
          ),
          body: EasyRefresh.custom(
            firstRefresh: true,
            enableControlFinishRefresh: false,
            enableControlFinishLoad: true,
            controller: c.easyRefreshController,
            scrollController: c.scrollController,
            header: CustomClassical.header(),
            footer: CustomClassical.footer(),
            onRefresh: c.onRefresh,
            onLoad: c.onLoad,
            slivers: [_list(context)],
          ),
        );
      },
    );
  }

  // 构建列表项
  Widget _list(BuildContext context) {
    return GetBuilder(
      builder: (_) => SliverList(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            if (c.topics.length < index) {
              return null;
            }
            TopicList item = c.topics[index];
            String avatarUrl = _getAvatar(item.uAvatar);
            String date = TimelineUtil.format(item.mtime * 1000, locale: "zh");
            return ListTile(
              leading: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: avatarUrl,
                  placeholder: (context, url) => CircularProgressIndicator(),
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
                  TextSpan(text: item.title)
                ]),
              ),
              subtitle: Text.rich(
                TextSpan(children: [
                  WidgetSpan(
                    child: Icon(
                      Icons.chat,
                      color: Colors.black26,
                      size: 15,
                    ),
                  ),
                  TextSpan(text: "${item.replyCount} / "),
                  WidgetSpan(
                    child: Icon(
                      Icons.remove_red_eye,
                      color: Colors.black26,
                      size: 15,
                    ),
                  ),
                  TextSpan(text: "${item.readCount} / 最后回复于 $date"),
                ]),
              ),
              onTap: () => Get.to(TopicView()),
            );
          },
          childCount: c.topics.length,
        ),
      ),
    );
  }

  String _getAvatar(avatarUrl) {
    if (avatarUrl == "/upload/default.jpg" || null == avatarUrl) {
      avatarUrl = "https://hu60.cn/upload/default.jpg";
    }
    // TODO 部分头像会出现 404 和 403，使用 precacheImage function 预加载图像
    // 这样操作会影响性能，但是可以通过错误回调设置正常的头像地址，等老虎修复！
    precacheImage(
      CachedNetworkImageProvider(avatarUrl),
      context,
      onError: (e, stackTrace) {
        avatarUrl = "https://hu60.cn/upload/default.jpg";
      },
    );
    return avatarUrl;
  }
}
