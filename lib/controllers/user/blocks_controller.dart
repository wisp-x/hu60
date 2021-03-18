import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/user/blocks_entity.dart';
import 'package:hu60/http.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BlocksController extends GetxController {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  int page = 1; // 页码
  List<UserList> users = []; // 屏蔽用户列表
  bool loading = false;
  bool nodata = false;

  @override
  void onInit() {
    super.onInit();
    init();
  }

  // 初始化数据
  void init() async {
    loading = true;
    page = 1;
    update();
    BlocksEntity response = await getData(page);
    users = response.userList;
    this.nodata = users.length == 0;
    update();
  }

  // 刷新
  Future onRefresh() async {
    page = 1;
    users.clear();
    BlocksEntity response = await getData(page);
    users = response.userList;
    refreshController.refreshCompleted();
    update();
  }

  // 加载下一页数据
  Future onLoading() async {
    page++;
    BlocksEntity response = await getData(page);
    users.addAll(response.userList);
    update();
  }

  // 获取数据
  Future<BlocksEntity> getData(int page) async {
    dio.Response response = await Http.request(
      "/user.relationship.block.json?_uinfo=sign&p=$page",
      method: Http.GET,
    );
    BlocksEntity result = BlocksEntity.fromJson(response.data);
    if (result.currPage == result.maxPage) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
    loading = false;
    update();
    return result;
  }
}
