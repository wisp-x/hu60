import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_info_controller.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/entities/user/user_info_entity.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/forum/topic_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'dart:ui' as ui;

class UserInfoView extends StatefulWidget {
  final id;

  const UserInfoView({Key key, @required this.id}) : super(key: key); // 用户ID

  @override
  _UserInfoView createState() => _UserInfoView();
}

class _UserInfoView extends State<UserInfoView> {
  final dividerColor = Color(0xdccdcdcd);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserInfoController>(
      init: UserInfoController(widget.id),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text(c.infoLoading ? "用户信息" : c.user.name),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: c.infoLoading ? Utils.loading(context) : _buildContent(c),
      ),
    );
  }

  Widget _buildContent(UserInfoController c) {
    return CustomScrollView(
      // TODO 吸附 tab 后滚动时会导致内容被 tab 覆盖，暂时禁止滚动
      physics: NeverScrollableScrollPhysics(),
      slivers: <Widget>[
        _buildMeta(c),
        _buildTabs(c),
        // TODO
        SliverFillRemaining(
          child: TabBarView(
            physics: BouncingScrollPhysics(),
            controller: c.tabController,
            children: <Widget>[
              _tabUserInfo(c),
              _tabTopics(c),
              _tabReplies(c),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMeta(UserInfoController c) {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //渐变位置
            begin: Alignment.centerLeft, //右上
            end: Alignment.centerRight, //左下
            //渐变颜色[始点颜色, 结束颜色]
            colors: [
              Color.fromRGBO(99, 184, 120, 1.0),
              Color.fromRGBO(54, 201, 90, 1.0),
              Color.fromRGBO(99, 184, 120, 1.0),
            ],
          ),
        ),
        padding: EdgeInsets.all(40),
        alignment: Alignment.center,
        child: User.getAvatar(
          context: context,
          url: c.user.uAvatar,
          size: 80,
          borderRadius: 50,
        ),
      ),
    );
  }

  Widget _buildTabs(UserInfoController c) {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: TabBar(
          labelColor: Theme.of(context).accentColor,
          indicatorColor: Theme.of(context).accentColor,
          controller: c.tabController,
          tabs: <Widget>[
            Tab(text: '资料'),
            Tab(text: '主题'),
            Tab(text: '回复'),
          ],
        ),
      ),
    );
  }

  Widget _tabUserInfo(UserInfoController c) {
    UserInfoEntity u = c.user;
    String defaultRegTime = "远古时期";
    String regTime = u.regtime == 0
        ? defaultRegTime
        : DateUtil.formatDateMs(u.regtime * 1000);
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      child: Column(
        children: <Widget>[
          Divider(height: 0.2, color: dividerColor),
          _getItem("UID", c.user.uid),
          Padding(
            padding: EdgeInsets.only(left: 60),
            child: Divider(height: 0.2, color: dividerColor),
          ),
          _getItem("昵称", c.user.name),
          Padding(
            padding: EdgeInsets.only(left: 60),
            child: Divider(height: 0.2, color: dividerColor),
          ),
          _getItem("签名", c.user.signature ?? "-"),
          Padding(
            padding: EdgeInsets.only(left: 60),
            child: Divider(height: 0.2, color: dividerColor),
          ),
          _getItem("联系方式", u.contact ?? "-"),
          Padding(
            padding: EdgeInsets.only(left: 60),
            child: Divider(height: 0.2, color: dividerColor),
          ),
          _getItem("注册时间", regTime),
          Divider(height: 0.2, color: dividerColor),
        ],
      ),
    );
  }

  Widget _tabTopics(UserInfoController c) {
    if (c.topicLoading) return Utils.loading(context);
    return SmartRefresher(
      enablePullDown: true,
      enablePullUp: true,
      header: WaterDropHeader(),
      footer: ClassicFooter(),
      controller: c.topicRefreshController,
      primary: false,
      scrollController: c.topicScrollController,
      onLoading: c.onLoadingByTopic,
      onRefresh: c.onRefreshByTopic,
      child: ListView.separated(
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
          String date = TimelineUtil.format(item.mtime * 1000, locale: "zh");
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 15, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
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
      ),
    );
  }

  Widget _tabReplies(UserInfoController c) {
    return Center(child: Text('回复'));
  }

  Widget _getItem(String name, dynamic value) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(name),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(value.toString()),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;
  final Function callback;

  StickyTabBarDelegate({@required this.child, this.callback});

  @override
  Widget build(BuildContext context,
      double shrinkOffset, // child 偏移值 minExtent~maxExtent
      bool overlapsContent, // SliverPersistentHeader覆盖其他子组件返回true，否则返回false
      ) {
    if (callback != null) {
      callback(shrinkOffset, overlapsContent);
    }
    return this.child;
  }

  @override
  double get maxExtent => this.child.preferredSize.height;

  @override
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
