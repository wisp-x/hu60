import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/entities/user/user_info_entity.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../../http.dart';

class UserInfoController extends GetxController
    with SingleGetTickerProviderMixin {
  final id; // 用户ID

  bool infoLoading = true;
  UserInfoEntity user;
  TabController tabController;

  UserInfoController(this.id);

  // 用户主题
  bool topicLoading = true;
  List<TopicList> topics = [];
  int topicPage = 1;
  RefreshController topicRefreshController = RefreshController();
  ScrollController topicScrollController = ScrollController();

  // 用户回复
  bool replyLoading = true;
  int replyPage = 1;
  RefreshController replyRefreshController = RefreshController();
  ScrollController replyScrollController = ScrollController();

  @override
  void onInit() async {
    super.onInit();
    tabController = TabController(length: 3, vsync: this);
    tabController.addListener(() async {
      if (tabController.index == tabController.animation.value) {
        switch (tabController.index) {
          case 1:
            if (this.topics.length == 0) {
              _initTopics();
            }
            break;
          case 2:
            break;
        }
      }
    });
    _getInfo();
  }

  void _getInfo() async {
    infoLoading = true;
    dio.Response res = await Http.request("/user.info.$id.json?_uinfo=avatar");
    UserInfoEntity entity = UserInfoEntity.fromJson(res.data);
    if (entity.uid == null) {
      Fluttertoast.showToast(msg: "不存在该用户");
    } else {
      infoLoading = false;
      this.user = entity;
      update();
    }
  }

  // 初始化用户主题
  _initTopics() async {
    topicLoading = true;
    update();
    TopicsEntity result = await _getTopics();
    this.topics = result.topicList;
    update();
  }

  // 获取用户主题
  Future<TopicsEntity> _getTopics() async {
    String url =
        "/bbs.search.send.json?username=${user.name}&p=$topicPage&_uinfo=avatar";
    dio.Response response = await Http.request(url);
    TopicsEntity result = TopicsEntity.fromJson(response.data);
    if (result.currPage == result.maxPage) {
      topicRefreshController.loadNoData();
    } else {
      topicRefreshController.loadComplete();
    }
    topicLoading = false;
    update();
    return result;
  }

  // 主题刷新
  Future onRefreshByTopic() async {
    topicPage = 1;
    topics.clear();
    TopicsEntity response = await _getTopics();
    topics = response.topicList;
    topicRefreshController.refreshCompleted();
    update();
  }

  // 主题加载下一页数据
  Future onLoadingByTopic() async {
    topicPage++;
    TopicsEntity response = await _getTopics();
    topics.addAll(response.topicList);
    update();
  }
}
