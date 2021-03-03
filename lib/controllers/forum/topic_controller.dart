import 'package:flutter/cupertino.dart';
import 'package:flutter_easyrefresh/easy_refresh.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/forum/topic_entity.dart';
import 'package:hu60/http.dart';

class TopicController extends GetxController {
  TopicController({this.id});
  final id; // 帖子ID

  EasyRefreshController easyRefreshController;
  ScrollController scrollController;
  int page = 1; // 页码
  TopicEntity topic;
  List<TContents> contents; // 内容列表
  bool loading = false; // 是否正在获取

  @override
  void onInit() async {
    super.onInit();
    easyRefreshController = EasyRefreshController();
    scrollController = ScrollController();
    init();
  }

  // 初始化列表
  void init() async {
    page = 1;
    TopicEntity response = await getData(id, page);
    topic = response;
    contents = topic.tContents;
    easyRefreshController.resetLoadState();
    update();
  }

  // 刷新
  Future onRefresh() async {
    page = 1;
    contents.clear();
    TopicEntity response = await getData(id, page);
    topic = response;
    contents = topic.tContents;
    easyRefreshController.resetLoadState();
    update();
  }

  // 加载下一页数据
  Future onLoad() async {
    page++;
    TopicEntity response = await getData(id, page);
    contents.addAll(response.tContents);
    easyRefreshController.finishLoad(
      noMore: response.currPage == response.maxPage,
    );
    update();
  }

  // 获取数据
  Future<TopicEntity> getData(int id, int page) async {
    loading = true;
    var response = await Http.request(
      "/bbs.topic.$id.$page.json?_uinfo=name,avatar",
      method: Http.POST,
    );
    loading = false;
    update();
    return TopicEntity.fromJson(response.data);
  }
}
