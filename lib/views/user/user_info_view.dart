import 'package:common_utils/common_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_info_controller.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/entities/user/user_info_entity.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/common/forum.dart';
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

  final Map<String, String> permissions = {
    "PERMISSION_EDIT_TOPIC": "帖子编辑权限",
    "PERMISSION_SET_BLOCK_POST": "设置禁言权限",
    "PERMISSION_SET_ESSENCE_TOPIC": "帖子加精权限",
    "PERMISSION_REVIEW_POST": "审核用户发言权限"
  };

  final Map<String, String> status = {
    "DEBUFF_UBB_DISABLE_STYLE": "用户被禁止使用 div、span 标签",
    "DEBUFF_BLOCK_POST": "用户被禁言",
    "DEBUFF_BLOCK_ATINFO": "用户被禁止@他人",
    "DEBUFF_POST_NEED_REVIEW": "发言需要审核",
  };

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserInfoController>(
      init: UserInfoController(widget.id),
      tag: "user-info-${widget.id}",
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text(c.infoLoading ? "用户信息" : c.user.name),
          centerTitle: true,
          elevation: 0,
          actions: c.infoLoading
              ? []
              : <Widget>[
                  GestureDetector(
                    child: Center(
                      child: Container(
                        padding: EdgeInsets.only(right: 13),
                        child: Text(
                          c.user.isFollow ? "取消关注" : "关注TA",
                          style: TextStyle(
                            fontSize: ScreenUtil().setSp(33),
                            fontWeight: FontWeight.bold,
                            color: c.user.isFollow
                                ? Colors.redAccent
                                : Colors.green,
                          ),
                        ),
                      ),
                    ),
                    onTap: () => c.user.isFollow ? c.unfollow() : c.follow(),
                  ),
                ],
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
        child: Column(
          children: [
            Container(
              alignment: Alignment.center,
              margin: EdgeInsets.only(top: 45),
              child: User.getAvatar(
                context: context,
                url: c.user.uAvatar,
                size: ScreenUtil().setWidth(160),
                borderRadius: 50,
              ),
            ),
            Container(
              margin: EdgeInsets.only(bottom: 10, right: 10),
              alignment: Alignment.bottomRight,
              child: GestureDetector(
                child: Icon(
                  c.user.isBlock ? Icons.block_flipped : Icons.block,
                  size: ScreenUtil().setWidth(60),
                  color: c.user.isBlock ? Colors.black54 : Colors.redAccent,
                ),
                onTap: () {
                  if (c.user.isBlock) {
                    c.unblock();
                  } else {
                    showCupertinoDialog(
                      context: context,
                      builder: (context) {
                        return CupertinoAlertDialog(
                          title: Text("屏蔽该用户"),
                          content: Text(
                            "屏蔽后你将看不见该用户的帖子、回复和聊天室中的发言，并且该用户无法向您发送内信和@消息，你确定要屏蔽该用户吗？",
                          ),
                          actions: [
                            CupertinoDialogAction(
                              isDestructiveAction: true,
                              child: Text('确认'),
                              onPressed: () async {
                                Get.back();
                                c.block();
                              },
                            ),
                            CupertinoDialogAction(
                              child: Text('取消'),
                              onPressed: () {
                                Get.back();
                              },
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
              ),
            )
          ],
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
    return ListView(
      children: <Widget>[
        ..._getPermissionLabels(c),
        Container(
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
        )
      ],
    );
  }

  List<Widget> _getPermissionLabels(UserInfoController c) {
    List<Widget> a = [];
    List<Widget> b = [];
    c.user.permissions.forEach((permission) {
      if (permissions.containsKey(permission)) {
        a.add(Container(
          color: Color(0xff3bb7c9),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.admin_panel_settings,
                      color: Color(0xffe54f4f),
                      size: ScreenUtil().setWidth(35),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        "拥有${permissions[permission]}",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(32),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 0.2,
                color: Colors.white,
              )
            ],
          ),
        ));
      }
      if (status.containsKey(permission)) {
        b.add(Container(
          color: Color(0xffc45f5f),
          child: Column(
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(5),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      Icons.error,
                      color: Color(0xffadadad),
                      size: ScreenUtil().setWidth(35),
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Text(
                        status[permission],
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: ScreenUtil().setSp(32),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Divider(
                height: 0.2,
                color: Colors.white,
              )
            ],
          ),
        ));
      }
    });
    return [...a, ...b];
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
          return GestureDetector(
            behavior: HitTestBehavior.opaque,
            child: Padding(
              padding: EdgeInsets.only(left: 20, top: 15, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.only(bottom: 8),
                    child: Forum.buildTopicsTitle(item),
                  ),
                  Forum.buildTopicsFooter(item),
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
    return ListView.builder(itemBuilder: (c, _) => Text('hhh'));
  }

  Widget _getItem(String name, dynamic value) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(18),
        child: Row(
          mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            Text(
              name,
              style: TextStyle(
                color: Colors.grey[600],
                fontSize: ScreenUtil().setSp(30),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(left: 20),
                child: Text(
                  value.toString(),
                  style: TextStyle(fontSize: ScreenUtil().setSp(30)),
                ),
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
  Widget build(
    BuildContext context,
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
