import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/user/user_info_entity.dart';
import 'package:dio/dio.dart' as dio;
import 'package:hu60/utils/user.dart';
import 'package:hu60/utils/utils.dart';

import '../../http.dart';

class UserInfoView extends StatefulWidget {
  final id;

  const UserInfoView({Key key, @required this.id}) : super(key: key); // 用户ID

  @override
  _UserInfoView createState() => _UserInfoView();
}

class _UserInfoView extends State<UserInfoView>
    with SingleTickerProviderStateMixin {
  bool loading = true;
  UserInfoEntity user;
  final dividerColor = Color(0xdccdcdcd);
  TabController tabController;

  @override
  void initState() {
    super.initState();
    _getUserInfo();
    this.tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Text(loading ? "用户信息" : user.name),
          centerTitle: true,
          elevation: 0,
        ),
        backgroundColor: Theme.of(context).backgroundColor,
        body: loading ? Utils.loading(context) : _buildContent(),
      ),
    );
  }

  Widget _buildContent() {
    return CustomScrollView(
      slivers: <Widget>[
        _buildMeta(),
        _buildTabs(),
        SliverFillRemaining(
          child: TabBarView(
            controller: this.tabController,
            children: <Widget>[
              _tabUserInfo(),
              _tabTopics(),
              _tabReplies(),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMeta() {
    return SliverToBoxAdapter(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            //渐变位置
            begin: Alignment.centerLeft, //右上
            end: Alignment.centerRight, //左下
            //渐变颜色[始点颜色, 结束颜色]
            colors: [
              Color.fromRGBO(83, 187, 109, 1.0),
              Color.fromRGBO(84, 196, 111, 1.0),
              Color.fromRGBO(83, 187, 109, 1.0),
            ],
          ),
        ),
        padding: EdgeInsets.all(40),
        alignment: Alignment.center,
        child: User.getAvatar(
          context: context,
          url: user.uAvatar,
          size: 80,
          borderRadius: 50,
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return SliverPersistentHeader(
      pinned: true,
      delegate: StickyTabBarDelegate(
        child: TabBar(
          automaticIndicatorColorAdjustment: false,
          labelColor: Colors.black,
          controller: this.tabController,
          tabs: <Widget>[
            Tab(text: '资料'),
            Tab(text: '主题'),
            Tab(text: '回复'),
          ],
        ),
      ),
    );
  }

  Widget _tabUserInfo() {
    return Center(child: Text('资料'));
  }

  Widget _tabTopics() {
    return Center(child: Text('主题'));
  }

  Widget _tabReplies() {
    return Center(child: Text('回复'));
  }

  void _getUserInfo() async {
    setState(() => loading = true);
    dio.Response res =
        await Http.request("/user.info.${widget.id}.json?_uinfo=avatar");
    if (res.data != "") {
      UserInfoEntity entity = UserInfoEntity.fromJson(res.data);
      if (entity.uid == null) {
        Fluttertoast.showToast(msg: "不存在该用户");
      } else {
        setState(() {
          loading = false;
          this.user = entity;
        });
      }
    }
  }
}

class StickyTabBarDelegate extends SliverPersistentHeaderDelegate {
  final TabBar child;

  StickyTabBarDelegate({@required this.child});

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
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
