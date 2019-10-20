import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import './community/index.dart';
import './chat/index.dart';
import './auth/login.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<String> _tabs = ['社区', '聊天室'];

  /// 默认头像地址
  String _defaultAvatarUrl = 'https://hu60.cn/upload/default.jpg';

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Scaffold(
      appBar: AppBar(
        title: TabBar(
          controller: _tabController,
          isScrollable: true,
          indicatorColor: Colors.white,
          indicatorSize: TabBarIndicatorSize.label,
          tabs: _tabs.map((title) {
            return Tab(
              text: title,
            );
          }).toList(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(
                '熊二哈',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(46.0),
                ),
              ),
              accountEmail: Text(
                'i@wispx.cn',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(38.0),
                ),
              ),
              currentAccountPicture: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: true,
                      builder: (context) => Login(),
                    ),
                  );
                },
                child: ClipOval(
                  child: CachedNetworkImage(
                    imageUrl: 'http://qiniu.img.hu60.cn/avatar/20048.jpg',
                    placeholder: (context, url) => Image.network(_defaultAvatarUrl),
                    errorWidget: (context, url, error) => Image.network(_defaultAvatarUrl),
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/banner.jpg'),
                ),
              ),
            ),
            ListTile(
              title: Text(
                '消息',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(40.0),
                ),
              ),
              leading: Icon(Icons.message),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text(
                '内信',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(40.0),
                ),
              ),
              leading: Icon(Icons.mail),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text(
                '收藏',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(40.0),
                ),
              ),
              leading: Icon(Icons.star),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text(
                '资料',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(40.0),
                ),
              ),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text(
                '设置',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(40.0),
                ),
              ),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text(
                '关于',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(40.0),
                ),
              ),
              leading: Icon(Icons.info),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          Community(),
          Chat(),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
