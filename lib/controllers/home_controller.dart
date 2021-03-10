import 'package:convex_bottom_bar/convex_bottom_bar.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/views/chat/chat_view.dart';
import 'package:hu60/views/forum/topics_view.dart';
import 'package:hu60/views/message/message_view.dart';
import 'package:hu60/views/user/user_view.dart';

class HomeController extends GetxController {
  final pages = <Widget>[TopicsView(), ChatView(), MessageView(), UserView()];
  final PageController pageController = PageController();
  int index = 0; // 当前导航索引

  // define field instance
  final GlobalKey<ConvexAppBarState> appBarKey = GlobalKey<ConvexAppBarState>();

  onInit() async {
    super.onInit();
    // 初始化用户数据
    Get.put(UserController()).init();
  }
}
