import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/message/messages_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:dio/dio.dart' as dio;
import '../../http.dart';

class MessageController extends GetxController
    with SingleGetTickerProviderMixin {
  TabController tabController; // 选项卡控制器
  RefreshController refreshController;
  ScrollController scrollController;
  int page = 1; // 页码
  int tabIndex = 0; // 0=未读，1=已读
  bool loading = false;
  List<MsgList> messages = [];

  @override
  void onInit() async {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();

    if (Get.find<UserController>().isLogin) {
      MessagesEntity response = await getData(page);
      messages = response.msgList;
      update();
    }
  }

  // 初始化列表
  void init() async {
    loading = true;
    page = 1;
    update();
    MessagesEntity response = await getData(page);
    messages = response.msgList;
    update();
  }

  // 刷新
  Future onRefresh() async {
    page = 1;
    messages.clear();
    MessagesEntity response = await getData(page);
    messages = response.msgList;
    refreshController.refreshCompleted();
    update();
  }

  // 加载下一页数据
  Future onLoading() async {
    page++;
    MessagesEntity response = await getData(page);
    messages.addAll(response.msgList);
    update();
  }

  // 获取数据
  Future<MessagesEntity> getData(int page) async {
    dio.Response response = await Http.request(
      "/msg.index.@.${tabIndex == 1 ? 'yes' : 'no'}.json?_uinfo=avatar",
      method: Http.POST,
    );
    MessagesEntity result = MessagesEntity.fromJson(response.data);
    if (result.currPage == result.maxPage) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
    loading = false;
    update();
    // 更新用户数据
    if (tabIndex == 0) Get.find<UserController>().init();
    return result;
  }
}
