import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hu60/views/home.dart';
import 'package:provider/provider.dart';
import 'package:common_utils/common_utils.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user.dart' as UserModel;
import '../../store/user.dart' as UserState;

class User extends StatefulWidget {
  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> with TickerProviderStateMixin {
  /// 默认banner地址
  String _bannerUrl = 'assets/images/banner.jpg';

  /// 默认头像地址
  String _defaultAvatarUrl = 'https://hu60.cn/upload/default.jpg';

  @override
  Widget build(BuildContext context) {
    return Consumer<UserState.User>(
      builder: (context, UserState.User user, _) => Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: _sliverBuilder,
        body: DefaultTextStyle(
          style: TextStyle(
            fontSize: ScreenUtil.getInstance().setSp(40.0),
            color: Colors.grey,
          ),
          child: ListView(
            children: <Widget>[
              Divider(),
              ListTile(
                leading: Container(
                  width: 90.0,
                  child: Text('UID'),
                ),
                title: Text(
                  user.uid.toString(),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.getInstance().setSp(45.0),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Container(
                  width: 90.0,
                  child: Text('邮箱'),
                ),
                title: Text(
                  user.mail == '' || user.mail == null ? '没有填写邮箱' : user.mail,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.getInstance().setSp(45.0),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Container(
                  width: 90.0,
                  child: Text('个人签名'),
                ),
                title: Text(
                  user.signature == '' || user.signature == null
                      ? '你太懒了, 居然不填写个人签名'
                      : user.signature,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.getInstance().setSp(45.0),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Container(
                  width: 90.0,
                  child: Text('联系方式'),
                ),
                title: Text(
                  user.contact == '' || user.contact == null
                      ? '没有填写联系方式'
                      : user.contact,
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.getInstance().setSp(45.0),
                  ),
                ),
              ),
              Divider(),
              ListTile(
                leading: Container(
                  width: 90.0,
                  child: Text('注册时间'),
                ),
                title: Text(
                  user.regtime == 0
                      ? '注册太早了, 那时候还没有记录时间'
                      : DateUtil.getDateStrByMs(user.regtime * 1000),
                  style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: ScreenUtil.getInstance().setSp(45.0),
                  ),
                ),
              ),
              Divider(),
              Center(
                child: FlatButton(
                  child: Text(
                    '退出登录',
                    style: TextStyle(
                      fontSize: ScreenUtil.getInstance().setSp(45.0),
                      color: Colors.red,
                    ),
                  ),
                  onPressed: _logout,
                ),
              ),
            ],
          ),
        ),
      )),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return <Widget>[
      Consumer<UserState.User>(
        builder: (context, UserState.User user, _) => SliverAppBar(
          leading: GestureDetector(
            child: Icon(Icons.arrow_back),
            onTap: () => Navigator.pop(context),
          ),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.public),
              color: Colors.white,
              onPressed: () async {
                SharedPreferences prefs =
                await SharedPreferences.getInstance();
                String url =
                    'https://hu60.cn/q.php/${prefs.getString('sid')}/user.index.html';
                if (await canLaunch(url)) {
                  await launch(url);
                }
              },
            ),
          ],
          automaticallyImplyLeading: true,
          centerTitle: true,
          elevation: 0.0,
          forceElevated: true,
          backgroundColor: Theme.of(context).primaryColor,
          brightness: Brightness.dark,
          primary: true,
          titleSpacing: 16.0,
          expandedHeight: 350.0,
          floating: false,
          pinned: true,
          snap: false,
          flexibleSpace: FlexibleSpaceBar(
            centerTitle: true,
            title: Text(user.name),
            background: CachedNetworkImage(
              fit: BoxFit.cover,
              imageUrl:
                  'http://qiniu.img.hu60.cn/avatar/${user.uid}.jpg?t=${DateTime.now().day}',
              placeholder: (context, url) => Image.network(_defaultAvatarUrl),
              errorWidget: (context, url, error) =>
                  Image.network(_defaultAvatarUrl),
            ),
          ),
        ),
      ),
    ];
  }

  _logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("退出登录"),
          content: Text("确认退出账号?"),
          actions: <Widget>[
            FlatButton(
              onPressed: () {
                prefs.remove('sid');
                Provider.of<UserState.User>(
                  context,
                  listen: false,
                ).clearUserInfo();
                Navigator.pushAndRemoveUntil(
                  context,
                  PageRouteBuilder(
                    transitionDuration: Duration(milliseconds: 160),
                    pageBuilder: (
                      BuildContext context,
                      Animation animation,
                      Animation secondaryAnimation,
                    ) {
                      return SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(-1, 0),
                          end: Offset.zero,
                        ).animate(animation),
                        child: Home(),
                      );
                    },
                  ),
                  (route) => route == null,
                );
              },
              child: Text("确认"),
            ),
            FlatButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('取消'),
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
