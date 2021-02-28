import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:hu60/views/chat/chat_view.dart';
import 'package:hu60/views/forum/forum_view.dart';
import 'package:hu60/views/message/message_view.dart';
import 'package:hu60/views/user/user_view.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeView createState() => _HomeView();
}

class _HomeView extends State<HomeView> with SingleTickerProviderStateMixin {
  final _pages = <Widget>[ForumView(), ChatView(), MessageView(), UserView()];

  PageController _pageController = PageController();
  int _index = 0;
  // define field instance
  GlobalKey<ConvexAppBarState> _appBarKey = GlobalKey<ConvexAppBarState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("虎绿林"),
        centerTitle: false,
        elevation: 0,
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: null,
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        children: _pages,
        onPageChanged: (int i) {
          setState(() => _index = i);
          _appBarKey.currentState.animateTo(i);
        },
      ),
      bottomNavigationBar: ConvexAppBar(
        backgroundColor: Theme.of(context).primaryColor,
        key: _appBarKey,
        items: <TabItem>[
          TabItem(icon: Icons.home, title: '首页'),
          TabItem(icon: Icons.chat, title: '聊天室'),
          TabItem(icon: Icons.email, title: '消息'),
          TabItem(icon: Icons.account_circle, title: '我的'),
        ],
        style: TabStyle.reactCircle,
        initialActiveIndex: _index,
        // optional, default as 0
        onTap: (int i) => {_pageController.jumpToPage(i)},
      ),
    );
  }
}
