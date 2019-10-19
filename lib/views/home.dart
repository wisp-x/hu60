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

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
          tabs: <Widget>[
            Tab(
              icon: Icon(Icons.home),
            ),
            Tab(
              icon: Icon(Icons.chat),
            ),
          ],
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
                child: CircleAvatar(
                  backgroundImage: NetworkImage(
                    'https://www.gravatar.com/avatar/7a585313ed855e8d652cbb3154a6056e?s=300&d=mm&r=g',
                  ),
                ),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(
                    'https://img.ivsky.com/img/bizhi/pre/201906/27/senlin-006.jpg',
                  ),
                ),
              ),
            ),
            ListTile(
              title: Text(
                '消息',
                style: TextStyle(
                  fontSize: ScreenUtil.getInstance().setSp(35.0),
                ),
              ),
              leading: Icon(Icons.message),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text('内信'),
              leading: Icon(Icons.mail),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text('收藏'),
              leading: Icon(Icons.star),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text('资料'),
              leading: Icon(Icons.person),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text('设置'),
              leading: Icon(Icons.settings),
              trailing: Icon(Icons.chevron_right),
              onTap: () => {},
            ),
            ListTile(
              title: Text('关于'),
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
}
