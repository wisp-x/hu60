import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicsController extends GetxController with SingleGetTickerProviderMixin {
  TabController tabController; // 选项卡控制器
  RefreshController refreshController;
  ScrollController scrollController;
  int page = 1; // 页码
  int type = 0; // 类型，0:新帖，1:精华贴
  List<TopicList> topics = List<TopicList>(); // 帖子列表
  bool loading = false;

  @override
  void onInit() async {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    tabController = TabController(length: 2, vsync: this);
    scrollController = ScrollController();

    TopicsEntity response = await getData(page);
    topics = response.topicList;
    update();
  }

  // 初始化列表
  void init() async {
    _backTop();
    page = 1;
    TopicsEntity response = await getData(page);
    topics = response.topicList;
    update();
  }

  // 刷新
  Future onRefresh() async {
    page = 1;
    topics.clear();
    TopicsEntity response = await getData(page);
    topics = response.topicList;
    refreshController.refreshCompleted();
    update();
  }

  // 加载下一页数据
  Future onLoading() async {
    page++;
    TopicsEntity response = await getData(page);
    topics.addAll(response.topicList);
    update();
  }

  // 获取数据
  Future<TopicsEntity> getData(int page) async {
    loading = true;
    var response = await Http.request(
      "/bbs.forum.0.$page.$type.json?_uinfo=name,avatar",
      method: Http.POST,
    );
    TopicsEntity result = TopicsEntity.fromJson(response.data);
    if (result.currPage == result.maxPage) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
    loading = false;
    update();
    return result;
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