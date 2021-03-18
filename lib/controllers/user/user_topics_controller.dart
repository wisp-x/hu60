import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/http.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UserTopicsController extends GetxController {
  TextEditingController textController = TextEditingController();
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  int page = 1; // 页码
  List<TopicList> topics = []; // 帖子列表
  bool loading = false;
  bool nodata = false;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  // 初始化数据or执行搜索
  void init() async {
    loading = true;
    page = 1;
    update();
    TopicsEntity response = await getData(page);
    topics = response.topicList;
    this.nodata = topics.length == 0;
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
    dio.Response response = await Http.request(
      "/bbs.search.json?p=$page&keywords=${textController.text}&username=${Get.put(UserController()).user.name}&_uinfo=name,avatar",
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

  // 更新列表数据
  void updateList() async {
    TopicsEntity response = await getData(page);
    this.topics.asMap().keys.map((index) {
      var item = response.topicList.firstWhere(
        (t) => t.id == this.topics[index].id,
        orElse: () => null,
      );
      if (item != null) {
        this.topics[index] = item;
      }
    }).toList();
  }
}
