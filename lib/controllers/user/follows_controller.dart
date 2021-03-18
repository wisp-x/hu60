import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/user/follows_entity.dart';
import 'package:hu60/http.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class FollowsController extends GetxController {
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  int page = 1; // 页码
  List<UserList> users = []; // 关注列表
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
    FollowsEntity response = await getData(page);
    users = response.userList;
    this.nodata = users.length == 0;
    update();
  }

  // 刷新
  Future onRefresh() async {
    page = 1;
    users.clear();
    FollowsEntity response = await getData(page);
    users = response.userList;
    refreshController.refreshCompleted();
    update();
  }

  // 加载下一页数据
  Future onLoading() async {
    page++;
    FollowsEntity response = await getData(page);
    users.addAll(response.userList);
    update();
  }

  // 获取数据
  Future<FollowsEntity> getData(int page) async {
    // TODO 这个接口有bug，post请求时提示id不正确
    dio.Response response = await Http.request(
      "/user.relationship.follow.json?_uinfo=sign&p=$page",
      method: Http.GET,
    );
    FollowsEntity result = FollowsEntity.fromJson(response.data);
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
