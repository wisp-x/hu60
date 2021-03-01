import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:hu60/entities/forum_entity.dart';
import 'package:hu60/http.dart';
import 'package:hu60/utils/custom_classical.dart';
import 'package:cached_network_image/cached_network_image.dart';

class ForumView extends StatefulWidget {
  @override
  _ForumView createState() => _ForumView();
}

class _ForumView extends State<ForumView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  TabController _tabController; // 选项卡控制器
  EasyRefreshController _controller;
  ScrollController _scrollController;
  int _page = 1; // 页码
  List<TopicList> _topics = []; // 帖子列表
  int _type = 0; // 类型，0:新帖，1:精华贴

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller = EasyRefreshController();
    _scrollController = ScrollController();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        appBar: AppBar(
          titleSpacing: 0,
          elevation: 0,
          backgroundColor: Theme.of(context).backgroundColor,
          title: TabBar(
            labelColor: Theme.of(context).accentColor,
            indicatorColor: Theme.of(context).accentColor,
            controller: _tabController,
            onTap: (int i) {
              setState(() {
                _type = i;
              });
              _init();
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
          controller: _controller,
          scrollController: _scrollController,
          header: CustomClassical.header(),
          footer: CustomClassical.footer(),
          onRefresh: () async {
            setState(() {
              _page = 1;
              _topics = [];
            });
            ForumEntity response = await _getData(_page);
            setState(() {
              _topics = response.topicList;
            });
            _controller.resetLoadState();
          },
          onLoad: () async {
            ForumEntity response = await _getData(_page + 1);
            setState(() {
              _page++;
              _topics.addAll(response.topicList);
            });
            _controller.finishLoad(
                noMore: response.currPage == response.maxPage);
          },
          slivers: [_list(context)],
        ),
      ),
    );
  }

  // 构建列表项
  Widget _list(BuildContext context) {
    return SliverList(
      delegate: SliverChildBuilderDelegate(
        (context, index) {
          TopicList item = _topics[index];
          String avatarUrl = item.uAvatar;
          if (avatarUrl == "/upload/default.jpg") {
            avatarUrl = "https://hu60.cn/upload/default.jpg";
          }
          return ListTile(
            leading: ClipOval(
              child: CachedNetworkImage(
                imageUrl: avatarUrl,
                placeholder: (context, url) => CircularProgressIndicator(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
            title: Text(item.title),
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
                TextSpan(text: "${item.readCount} / 最后回复于 13 分钟前"),
              ]),
            ),
            onTap: () => {},
          );
        },
        childCount: _topics.length,
      ),
    );
  }

  // 获取数据
  Future<ForumEntity> _getData(int page) async {
    var response = await Http.request(
      "/bbs.forum.0.$page.$_type.json?_uinfo=name,avatar",
      method: Http.POST,
    );
    return ForumEntity.fromJson(response.data);
  }

  // 初始化列表
  void _init() async {
    _backTop();
    ForumEntity response = await _getData(_page);
    setState(() {
      _topics = response.topicList;
    });
    _controller.resetLoadState();
  }

  // 回到顶部
  void _backTop() {
    _scrollController.animateTo(
      .0,
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }
}
