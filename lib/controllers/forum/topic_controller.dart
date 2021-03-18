import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/forum/topic_entity.dart';
import 'package:hu60/http.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicController extends GetxController {
  TopicController({@required this.id});

  final id; // 帖子ID
  RefreshController refreshController;
  ScrollController scrollController;
  TextEditingController textController;
  int page = 1; // 页码
  TopicEntity data; // 帖子数据
  TContents content; // 帖子楼层数据
  List<TContents> contents = []; // 所有楼层列表
  bool loading = false; // 是否正在获取数据
  bool isCollect = false; // 当前登录用户是否收藏了该帖子

  @override
  void onInit() async {
    super.onInit();
    refreshController = RefreshController(initialRefresh: false);
    scrollController = ScrollController();
    textController = TextEditingController();
    init();
  }

  // 初始化列表
  void init() async {
    page = 1;
    loading = true;
    update();
    TopicEntity response = await getData(id, page);
    data = response;
    contents = data.tContents;
    setContent();
    update();
  }

  // 刷新
  Future onRefresh() async {
    page = 1;
    contents.clear();
    TopicEntity response = await getData(id, page);
    data = response;
    contents = data.tContents;
    setContent();
    refreshController.refreshCompleted();
    update();
  }

  // 加载下一页数据
  Future onLoading() async {
    page++;
    TopicEntity response = await getData(id, page);
    contents.addAll(response.tContents);
    setContent();
    update();
  }

  // 获取数据
  Future<TopicEntity> getData(int id, int page) async {
    dio.Response response = await Http.request(
      "/bbs.topic.$id.$page.json?_uinfo=name,avatar",
      method: Http.POST,
    );
    TopicEntity result = TopicEntity.fromJson(response.data);
    if (result.currPage == result.maxPage) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
    loading = false;
    _checkIsCollect();
    update();
    return result;
  }

  // 设置帖子楼层内容数据
  void setContent() {
    var content = contents.firstWhere(
      (content) => content.topicId == id,
      orElse: () => null,
    );
    if (content != null) {
      this.content = content;
    } else {
      Fluttertoast.showToast(
        msg: "楼层数据异常",
      );
    }
  }

  // 更新楼层数据
  void updateFloor(
    int id, // 帖子ID
  ) async {
    TopicEntity response = await getData(id, this.page);
    this.contents.asMap().keys.map((index) {
      response.tContents.forEach((floor) {
        if (this.contents[index].id == floor.id) {
          this.contents[index] = floor;
        }
      });
    }).toList();
    update();
  }

  // 下沉帖子
  void sink(BuildContext context, Function callback) async {
    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text("下沉帖子"),
          content: Text("下沉后不可恢复，确认下沉吗？"),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('确认'),
              onPressed: () async {
                Get.back();
                dio.Response getToken = await Http.request(
                  "/bbs.sinktopic.$id.json",
                  method: Http.GET,
                );
                dio.Response response = await Http.request(
                  "/bbs.sinktopic.$id.json",
                  method: Http.POST,
                  data: {"token": getToken.data["token"], "go": 1},
                );
                if (response.data["success"]) {
                  callback();
                  Fluttertoast.showToast(msg: "下沉成功");
                } else {
                  Fluttertoast.showToast(
                    msg: response.data["notice"] ?? "下沉失败",
                  );
                }
              },
            ),
            CupertinoDialogAction(
              child: Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  // 删除帖子or删除楼层
  void delete(
    BuildContext context,
    int topicId, // 帖子ID
    int contentId, // 楼层ID
    Function callback,
  ) async {
    dio.Response meta = await Http.request(
      "/bbs.deltopic.$topicId.$contentId.json",
      method: Http.GET,
    );
    String title = "删除楼层";
    if (meta.data["tMeta"]["content_id"] == contentId) {
      title = "删除帖子";
    }

    showCupertinoDialog(
      context: context,
      builder: (context) {
        return CupertinoAlertDialog(
          title: Text(title),
          content: Text("删除后不可恢复，确认删除吗？"),
          actions: [
            CupertinoDialogAction(
              isDestructiveAction: true,
              child: Text('确认'),
              onPressed: () async {
                Get.back();
                dio.Response response = await Http.request(
                  "/bbs.deltopic.$topicId.$contentId.json",
                  method: Http.POST,
                  data: {"token": meta.data["token"], "go": 1},
                );
                if (response.data["success"]) {
                  callback();
                  Fluttertoast.showToast(msg: "删除成功");
                } else {
                  Fluttertoast.showToast(
                    msg: response.data["notice"] ?? "删除失败",
                  );
                }
              },
            ),
            CupertinoDialogAction(
              child: Text('取消'),
              onPressed: () {
                Get.back();
              },
            ),
          ],
        );
      },
    );
  }

  // 移动帖子
  void move(
    BuildContext context,
    int topicId, // 帖子ID
    int plateId, // 板块ID
    Function callback,
  ) async {
    dio.Response response = await Http.request(
      "/bbs.movetopic.$topicId.json",
      method: Http.POST,
      data: {"newFid": plateId, "go": 1},
    );
    if (response.data["success"]) {
      callback();
      Fluttertoast.showToast(msg: "移动成功");
    } else {
      Fluttertoast.showToast(msg: response.data["notice"] ?? "移动失败");
    }
  }

  // 判断该帖子是否已经收藏
  void _checkIsCollect() async {
    // TODO 老虎未暴露是否收藏帖子的属性，暂时无法实现
  }
}
