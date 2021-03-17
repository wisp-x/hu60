import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:hu60/controllers/forum/topics_controller.dart';
import 'package:hu60/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/utils/badge.dart';
import 'package:hu60/views/forum/new_topic_view.dart';
import 'package:hu60/views/forum/search_view.dart';
import 'package:hu60/views/user/login_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> with SingleTickerProviderStateMixin {
  UserController _userController = Get.put(UserController());

  @override
  Widget build(context) {
    return GetBuilder<HomeController>(
      init: HomeController(),
      builder: (HomeController c) {
        int newAtInfo =
            _userController.isLogin ? _userController.user.myself.newAtInfo : 0;
        Map<int, dynamic> badge;
        if (newAtInfo > 0) {
          badge = {2: newAtInfo > 99 ? "99+" : newAtInfo.toString()};
        }

        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("虎绿林"),
            centerTitle: false,
            elevation: 0,
            actions: <Widget>[
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.edit),
                onPressed: () async {
                  if (Get.find<UserController>().isLogin) {
                    var res = await Get.to(() => NewTopicView());
                    if (res != null && res) {
                      // 发布成功，刷新
                      Get.find<TopicsController>()
                          .refreshController
                          .requestRefresh();
                    }
                  } else {
                    return Get.to(() => LoginView(), fullscreenDialog: true);
                  }
                },
              ),
              IconButton(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
                icon: Icon(Icons.search),
                onPressed: () => Get.to(() => SearchView()),
              )
            ],
          ),
          body: PageView(
            controller: c.pageController,
            children: c.pages,
            onPageChanged: (int i) {
              c.index = i;
              c.appBarKey.currentState.animateTo(i);
              if (i == 2 || i == 3) {
                // 更新用户数据
                c.userController
                    .init(callback: () => Get.find<HomeController>().update());
              }
            },
          ),
          bottomNavigationBar: ConvexAppBar(
            chipBuilder: badge != null ? DefaultChipBuilder(badge) : null,
            elevation: 0,
            activeColor: Theme.of(context).accentColor,
            color: Theme.of(context).accentColor,
            backgroundColor: Theme.of(context).primaryColor,
            key: c.appBarKey,
            items: <TabItem>[
              TabItem(icon: Icons.home, title: '首页'),
              TabItem(icon: Icons.chat, title: '聊天室'),
              TabItem(icon: Icons.email, title: '消息'),
              TabItem(icon: Icons.account_circle, title: '我的'),
            ],
            style: TabStyle.textIn,
            initialActiveIndex: c.index,
            // optional, default as 0
            onTap: (int i) => {c.pageController.jumpToPage(i)},
          ),
        );
      },
    );
  }
}
