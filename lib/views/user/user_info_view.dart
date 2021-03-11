import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/user/user_info_entity.dart';
import 'package:hu60/utils/utils.dart';
import 'package:dio/dio.dart' as dio;

import '../../http.dart';

class UserInfoView extends StatefulWidget {
  final id;

  const UserInfoView({Key key, @required this.id}) : super(key: key); // 用户ID

  @override
  _UserInfoView createState() => _UserInfoView();
}

class _UserInfoView extends State<UserInfoView> {
  bool loading = true;
  UserInfoEntity user;
  final dividerColor = Color(0xdccdcdcd);

  @override
  void initState() {
    super.initState();
    _getUserInfo();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      init: UserController(),
      builder: (c) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: CustomScrollView(
          slivers: <Widget>[
            SliverAppBar(
              pinned: true,
              centerTitle: true,
              elevation: 0,
              expandedHeight: 100.0,
              flexibleSpace: FlexibleSpaceBar(
                title: Text('Demo'),
              ),
            ),

            SliverPadding(
              padding: EdgeInsets.all(8.0),
              sliver: SliverGrid(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, //Grid按两列显示
                  mainAxisSpacing: 10.0,
                  crossAxisSpacing: 10.0,
                  childAspectRatio: 4.0,
                ),
                delegate: SliverChildBuilderDelegate(
                  (
                    BuildContext context,
                    int index,
                  ) {
                    //创建子widget
                    return Container(
                      alignment: Alignment.center,
                      color: Colors.cyan[100 * (index % 9)],
                      child: Text('grid item $index'),
                    );
                  },
                  childCount: 20,
                ),
              ),
            ),
            //List
            SliverFixedExtentList(
              itemExtent: 50.0,
              delegate:
                  SliverChildBuilderDelegate((BuildContext context, int index) {
                //创建列表项
                return Container(
                  alignment: Alignment.center,
                  color: Colors.lightBlue[100 * (index % 9)],
                  child: Text('list item $index'),
                );
              }, childCount: 50 //50个列表项
                      ),
            ),
          ],
        ),
      ),
    );
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
