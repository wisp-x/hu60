import 'package:flutter/material.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/forum_entity.dart';
import 'package:hu60/http.dart';

class TopicsController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController; // 选项卡控制器
  EasyRefreshController easyRefreshController;
  ScrollController scrollController;
  int page = 1; // 页码
  int type = 0; // 类型，0:新帖，1:精华贴
  List<TopicList> topics = List<TopicList>(); // 帖子列表

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    easyRefreshController = EasyRefreshController();
    scrollController = ScrollController();
  }

  // 初始化列表
  void init() async {
    _backTop();
    ForumEntity response = await getData(page);
    topics = response.topicList;
    easyRefreshController.resetLoadState();
    update();
  }

  // 刷新
  Future onRefresh() async {
    page = 1;
    topics.clear();
    ForumEntity response = await getData(page);
    topics = response.topicList;
    easyRefreshController.resetLoadState();
    update();
  }

  // 加载下一页数据
  Future onLoad() async {
    page++;
    ForumEntity response = await getData(page);
    topics.addAll(response.topicList);
    easyRefreshController.finishLoad(
      noMore: response.currPage == response.maxPage,
    );
    update();
  }

  // 获取数据
  Future<ForumEntity> getData(int page) async {
    var response = await Http.request(
      "/bbs.forum.0.$page.$type.json?_uinfo=name,avatar",
      method: Http.POST,
    );
    return ForumEntity.fromJson(response.data);
  }

  // 回到顶部
  void _backTop() {
    scrollController.animateTo(
      .0,
      duration: Duration(milliseconds: 200),
      curve: Curves.ease,
    );
  }
}