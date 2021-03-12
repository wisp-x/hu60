import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/views/common/forum.dart';
import 'package:hu60/views/user/login_view.dart';
import 'package:hu60/views/user/more_setting_view.dart';

class UserView extends StatefulWidget {
  @override
  _UserView createState() => _UserView();
}

class _UserView extends State<UserView> with AutomaticKeepAliveClientMixin {
  final dividerColor = Color(0xdce3e3e3);

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
        leading: User.getAvatar(
          context: context,
          url: c.user.uAvatar,
          size: ScreenUtil().setWidth(100),
          borderRadius: 8.0,
        ),
        title: Text(
          c.user.name,
          style: TextStyle(fontSize: ScreenUtil().setSp(40)),
        ),
        subtitle: Container(
          width: double.infinity,
          margin: EdgeInsets.only(top: 8),
          child: Text(
            c.user.signature,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: ScreenUtil().setSp(30),
            ),
          ),
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
          Divider(height: 1, color: dividerColor),
          Forum.buildListTile(Icons.format_list_bulleted, "我的帖子"),
          Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(height: 1, color: dividerColor),
          ),
          Forum.buildListTile(Icons.bookmark_outline, "我的收藏"),
          Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(height: 1, color: dividerColor),
          ),
          Forum.buildListTile(Icons.star_outline, "特别关注"),
          Padding(
            padding: EdgeInsets.only(left: 70),
            child: Divider(height: 1, color: dividerColor),
          ),
          Forum.buildListTile(Icons.list, "屏蔽用户"),
          Divider(height: 1, color: dividerColor),
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
          Divider(height: 1, color: dividerColor),
          ListTile(
            leading: Icon(Icons.settings, color: Colors.grey),
            title: Text(
              "更多设置",
              style: TextStyle(fontSize: ScreenUtil().setSp(35)),
            ),
            trailing: Icon(
              Icons.chevron_right,
              size: ScreenUtil().setWidth(45),
            ),
            onTap: () => Get.to(() => MoreSettingView()),
          ),
          Divider(height: 1, color: dividerColor),
        ],
      ),
    );
  }
}
