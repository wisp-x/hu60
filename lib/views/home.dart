import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/http.dart';
import './community/index.dart';
import './chat/index.dart';
import './auth/login.dart';
import '../views/page/setting.dart';
import '../views/page/about.dart';
import '../views/page/letter.dart';
import '../views/page/message.dart';
import '../views/page/post.dart';
import '../views/user/index.dart' as UserPage;
import '../model/user.dart' as UserModel;
import '../store/user.dart' as UserState;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  TabController _tabController;

  List<String> _tabs = ['社区', /*'聊天室'*/];

  /// 默认头像地址
  String _defaultAvatarUrl = 'https://hu60.cn/upload/default.jpg';

  /// 默认banner地址
  String _bannerUrl = 'assets/images/banner.jpg';

  @override
  initState() {
    super.initState();
    _tabController = TabController(length: _tabs.length, vsync: this)
      ..addListener(() {
        if (_tabController.index.toDouble() == _tabController.animation.value) {
          switch (_tabController.index) {
            case 0:
              break;
            case 1:
              break;
          }
        }
      });

    _validateLogin();
  }

  @override
  Widget build(BuildContext context) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return Consumer<UserState.User>(
      builder: (context, UserState.User user, _) => Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Theme(
            /// 使用局部主题去除点击涟漪效果
            data: ThemeData(
              brightness: Theme.of(context).brightness,
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: TabBar(
              isScrollable: true,
              controller: _tabController,
              labelStyle: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: ScreenUtil.getInstance().setSp(50.0),
              ),
              unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: ScreenUtil.getInstance().setSp(40.0),
              ),
              labelColor: Colors.white,
              indicator: UnderlineTabIndicator(
                borderSide: BorderSide(style: BorderStyle.none),
              ),
              tabs: _tabs.map((title) => Text(title)).toList(),
            ),
          ),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              _buildHeaderUser(user),
              ListTile(
                title: Text(
                  '消息',
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(40.0),
                  ),
                ),
                leading: Icon(Icons.message),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: !user.isLogin,
                      builder: (context) => user.isLogin ? Message() : Login(),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: !user.isLogin,
                      builder: (context) => user.isLogin ? Letter() : Login(),
                    ),
                  );
                },
              ),
              ListTile(
                title: Text(
                  '帖子',
                  style: TextStyle(
                    fontSize: ScreenUtil.getInstance().setSp(40.0),
                  ),
                ),
                leading: Icon(Icons.library_books),
                trailing: Icon(Icons.chevron_right),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      fullscreenDialog: !user.isLogin,
                      builder: (context) => user.isLogin ? Post() : Login(),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Setting(),
                    ),
                  );
                },
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
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => About(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        body: TabBarView(
          controller: _tabController,
          children: <Widget>[
            Community(),
//            Chat(),
          ],
        ),
      ),
    );
  }

  Future _validateLogin() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String sid = prefs.get('sid');
    if (sid != null) {
      Http.request('user.index.json').then((response) {
        UserModel.User user = UserModel.User.fromJson(response.data);
        if (user.name != null) {
          Provider.of<UserState.User>(context, listen: false).setUserInfo(user);
        } else {
          /// 状态失效了, 清除sid
          prefs.remove('sid');
        }
      });
    }
  }

  Widget _buildHeaderUser(UserState.User user) {
    if (user.isLogin) {
      return UserAccountsDrawerHeader(
        accountName: Text(
          user.name,
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(46.0),
          ),
        ),
        accountEmail: Text(
          user.contact,
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(38.0),
          ),
        ),
        currentAccountPicture: GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => UserPage.User(),
              ),
            );
          },
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl:
                  'http://qiniu.img.hu60.cn/avatar/${user.uid}.jpg?t=${DateTime.now().day}',
              placeholder: (context, url) => Image.network(_defaultAvatarUrl),
              errorWidget: (context, url, error) =>
                  Image.network(_defaultAvatarUrl),
            ),
          ),
        ),
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(_bannerUrl),
          ),
        ),
      );
    }

    return Column(
      children: <Widget>[
        Container(
          decoration: BoxDecoration(
            /*image: DecorationImage(
              fit: BoxFit.cover,
              image: AssetImage(_bannerUrl),
            ),*/
            color: Theme.of(context).primaryColor,
          ),
          padding: EdgeInsets.only(top: 80.0, bottom: 60.0),
          child: Column(
            children: <Widget>[
              Center(
                child: IconButton(
                  icon: Icon(Icons.account_circle),
                  iconSize: 70.0,
                  color: Colors.white,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => Login(),
                      ),
                    );
                  },
                ),
              ),
              Center(
                child: Text(
                  '点击头像登录',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: ScreenUtil.getInstance().setSp(45.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }
}
