import 'package:flutter/material.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:hu60/controllers/home_controller.dart';
import 'package:get/get.dart';
import 'package:hu60/views/user/login_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> with SingleTickerProviderStateMixin {
  @override
  Widget build(context) {
    return GetBuilder(
      init: HomeController(),
      builder: (c) => Scaffold(
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
              onPressed: () => Get.to(() => LoginView(), fullscreenDialog: true),
            ),
            IconButton(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              icon: Icon(Icons.search),
              onPressed: () {},
            )
          ],
        ),
        body: PageView(
          controller: c.pageController,
          children: c.pages,
          onPageChanged: (int i) {
            c.index = i;
            c.appBarKey.currentState.animateTo(i);
          },
        ),
        bottomNavigationBar: ConvexAppBar(
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
      ),
    );
  }
}
