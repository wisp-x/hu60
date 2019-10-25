import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:common_utils/common_utils.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hu60/api/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:toast/toast.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/user.dart' as UserModel;

// ignore: must_be_immutable
class User extends StatefulWidget {
  var uid;

  User(this.uid);

  @override
  _UserState createState() => _UserState();
}

class _UserState extends State<User> {
  /// 默认头像地址
  String _defaultAvatarUrl = 'https://hu60.cn/upload/default.jpg';

  var _user;

  @override
  void initState() {
    super.initState();

    _setUser();
  }

  _setUser() async {
    await Http.request('user.info.${widget.uid}.json').then((response) {
      UserModel.User user = UserModel.User.fromJson(response.data);
      if (user.name != null) {
        setState(() {
          _user = user;
        });
      } else {
        Toast.show('没有找到该用户', context);
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _user == null
          ? SpinKitFadingCircle(
              color: Colors.green,
              size: 50.0,
            )
          : NestedScrollView(
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
                        _user.uid.toString(),
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
                        _user.signature == '' || _user.signature == null
                            ? '这个人太懒了, 居然没有填写签名'
                            : _user.signature,
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
                        _user.contact == '' || _user.contact == null
                            ? '没有填写联系方式'
                            : _user.contact,
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
                        _user.regtime == 0
                            ? '该用户是很早之前注册的, 那时候没有记录时间'
                            : DateUtil.getDateStrByMs(_user.regtime * 1000),
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: ScreenUtil.getInstance().setSp(45.0),
                        ),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),
            ),
    );
  }

  List<Widget> _sliverBuilder(BuildContext context, bool innerBoxIsScrolled) {
    ScreenUtil.instance = ScreenUtil.getInstance()..init(context);

    return <Widget>[
      SliverAppBar(
        leading: GestureDetector(
          child: Icon(Icons.arrow_back),
          onTap: () => Navigator.pop(context),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.public),
            color: Colors.white,
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              String url =
                  'https://hu60.cn/q.php/${prefs.getString('sid')}/user.info.${_user.uid}.html';
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
          title: Text(_user.name),
          background: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl:
                'http://qiniu.img.hu60.cn/avatar/${_user.uid}.jpg?t=${DateTime.now().day}',
            placeholder: (context, url) => Image.network(_defaultAvatarUrl),
            errorWidget: (context, url, error) =>
                Image.network(_defaultAvatarUrl),
          ),
        ),
      ),
    ];
  }

  @override
  void dispose() {
    super.dispose();
  }
}
