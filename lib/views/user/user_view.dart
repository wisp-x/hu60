import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/home_controller.dart';
import 'package:hu60/utils/user.dart';

class UserView extends StatefulWidget {
  @override
  _UserView createState() => _UserView();
}

class _UserView extends State<UserView> with AutomaticKeepAliveClientMixin {
  List settings = [
    {"text": "我的帖子", "icon": Icons.format_list_bulleted, "page": ""},
    {"text": "我的收藏", "icon": Icons.bookmark_outline, "page": ""},
    {"text": "我的关注", "icon": Icons.star_outline, "page": ""},
    {"text": "屏蔽用户", "icon": Icons.list, "page": ""},
  ];

  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (c) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: ListView(
            children: <Widget>[
              _buildProfile(context, c),
              _buildSettings(context, c),
              _buildMore(context, c),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildProfile(BuildContext context, HomeController c) {
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

  Widget _buildSettings(BuildContext context, HomeController c) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      color: Colors.white,
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Icon(
              Icons.format_list_bulleted,
              color: Colors.grey,
            ),
            title: Text("我的帖子"),
            trailing: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
          Divider(height: 0.2, indent: 0.0, color: Color(0xdccdcdcd)),
          ListTile(
            leading: Icon(
              Icons.bookmark_outline,
              color: Colors.grey,
            ),
            title: Text("我的收藏"),
            trailing: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
          Divider(height: 0.2, indent: 0.0, color: Color(0xdccdcdcd)),
          ListTile(
            leading: Icon(
              Icons.star_outline,
              color: Colors.grey,
            ),
            title: Text("我的关注"),
            trailing: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
          Divider(height: 0.2, indent: 0.0, color: Color(0xdccdcdcd)),
          ListTile(
            leading: Icon(
              Icons.list,
              color: Colors.grey,
            ),
            title: Text("屏蔽用户"),
            trailing: IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.chevron_right),
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMore(BuildContext context, HomeController c) {
    return Container(
      color: Colors.white,
      margin: EdgeInsets.only(top: 10),
      child: ListTile(
        leading: Icon(
          Icons.settings,
          color: Colors.grey,
        ),
        title: Text("更多设置"),
        trailing: IconButton(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          icon: Icon(Icons.chevron_right),
          onPressed: () {},
        ),
      ),
    );
  }
}
