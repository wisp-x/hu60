import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';

class ForumView extends StatefulWidget {
  @override
  _ForumView createState() => _ForumView();
}

class _ForumView extends State<ForumView>
    with AutomaticKeepAliveClientMixin, SingleTickerProviderStateMixin {
  // 选项卡控制器
  TabController _tabController;
  EasyRefreshController _controller;
  int _count = 20;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    _controller = EasyRefreshController();
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
              print(i);
            },
            tabs: [
              Tab(text: "新帖"),
              Tab(text: "精华"),
            ],
          ),
        ),
        body: EasyRefresh.custom(
          enableControlFinishRefresh: false,
          enableControlFinishLoad: true,
          controller: _controller,
          header: ClassicalHeader(),
          footer: ClassicalFooter(),
          onRefresh: () async {
            await Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _count = 20;
              });
              _controller.resetLoadState();
            });
          },
          onLoad: () async {
            await Future.delayed(Duration(seconds: 2), () {
              setState(() {
                _count += 10;
              });
              _controller.finishLoad(noMore: _count >= 40);
            });
          },
          slivers: [
            SliverList(
              delegate: SliverChildBuilderDelegate(
                (context, index) {
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          NetworkImage("https://file.hu60.cn/avatar/1.jpg"),
                    ),
                    title: Text("震惊🤯，虎绿林竟然！！"),
                    subtitle: Text.rich(
                      TextSpan(children: [
                        WidgetSpan(
                          child: Icon(
                            Icons.chat,
                            color: Colors.black26,
                            size: 15,
                          ),
                        ),
                        TextSpan(text: "12，"),
                        TextSpan(text: " 共 12 次浏览，最后回复于 13 分钟前"),
                      ]),
                    ),
                    onTap: () => {},
                  );
                },
                childCount: _count,
              ),
            )
          ],
        ),
      ),
    );
  }
}
