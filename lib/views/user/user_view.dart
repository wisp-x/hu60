import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/views/user/login_view.dart';
import 'package:hu60/views/user/more_setting_view.dart';

class UserView extends StatefulWidget {
  @override
  _UserView createState() => _UserView();
}

class _UserView extends State<UserView> with AutomaticKeepAliveClientMixin {
  final dividerColor = Color(0xdccdcdcd);

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: c.isLogin
              ? ListView(
                  children: <Widget>[
                    _buildProfile(context, c),
                    _buildSettings(context, c),
                    _buildMore(context, c),
                  ],
                )
              : TextButton(
                  child: Text(
                    "点我登录",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50)),
                    ),
                    elevation: 0,
                    backgroundColor: Colors.green,
                    minimumSize: Size(100, 45),
                  ),
                  onPressed: () => Get.to(
                    () => LoginView(),
                    fullscreenDialog: true,
                  ),
                ),
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, UserController c) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.only(top: 15, bottom: 15),
      child: ListTile(
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8.0),
          child: CachedNetworkImage(
            height: 60,
            width: 60,
            imageUrl: User.getAvatar(context, c.user.uAvatar),
            placeholder: (context, url) => CupertinoActivityIndicator(),
            errorWidget: (context, url, error) => Icon(Icons.error),
          ),
        ),
        title: Text(c.user.name),
        subtitle: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 8),
          child: Text(c.user.signature, overflow: TextOverflow.ellipsis),
        ),
        trailing: Icon(Icons.chevron_right),
        onTap: () {},
      ),
    );
  }

  Widget _buildSettings(BuildContext context, UserController c) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          Divider(height: 0.2, color: dividerColor),
          ListTile(
            leading: Icon(Icons.format_list_bulleted, color: Colors.grey),
            title: Text("我的帖子"),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 0.2, color: dividerColor),
          ListTile(
            leading: Icon(Icons.bookmark_outline, color: Colors.grey),
            title: Text("我的收藏"),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 0.2, color: dividerColor),
          ListTile(
            leading: Icon(Icons.star_outline, color: Colors.grey),
            title: Text("特别关注"),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 0.2, color: dividerColor),
          ListTile(
            leading: Icon(Icons.list, color: Colors.grey),
            title: Text("屏蔽用户"),
            trailing: Icon(Icons.chevron_right),
          ),
          Divider(height: 0.2, color: dividerColor),
        ],
      ),
    );
  }

  Widget _buildMore(BuildContext context, UserController c) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: Column(
        children: <Widget>[
          Divider(height: 0.2, color: dividerColor),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text("更多设置"),
            trailing: Icon(Icons.chevron_right),
            onTap: () => Get.to(() => MoreSettingView()),
          ),
          Divider(height: 0.2, color: dividerColor),
        ],
      ),
    );
  }
}
