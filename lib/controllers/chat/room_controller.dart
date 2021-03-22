import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/chat/room_entity.dart';
import 'package:hu60/http.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoomController extends GetxController {
  final name;

  TextEditingController textController = TextEditingController();
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  List<ChatList> list = []; // 聊天记录列表
  int page = 1; // 当前页码
  bool loading = false;
  bool nodata = false;
  String token = '';

  RoomController(this.name);

  @override
  void onInit() {
    super.onInit();
    init();
    // 定时更新数据
    Timer.periodic(Duration(minutes: 1), (timer) {
      updateChat();
    });
  }

  void init() async {
    loading = true;
    page = 1;
    update();
    RoomEntity response = await getData(page);
    list = response.chatList;
    this.nodata = list.length == 0;
    update();
  }

  updateChat({Function callback}) async {
    page = 1;
    RoomEntity response = await getData(page);
    list = response.chatList;
    if (callback != null) callback();
    update();
  }

  // 刷新
  Future onRefresh() async {
    list.clear();
    page = 1;
    RoomEntity response = await getData(page);
    list = response.chatList;
    refreshController.refreshCompleted();
    update();
  }

  // 加载下一页数据
  Future onLoading() async {
    page++;
    RoomEntity response = await getData(page);
    list.addAll(response.chatList);
    update();
  }

  // 获取数据
  Future<RoomEntity> getData(int page) async {
    dio.Response response = await Http.request(
      "/addin.chat.${this.name}.json?_uinfo=avatar&p=$page",
      method: Http.POST,
    );
    RoomEntity result = RoomEntity.fromJson(response.data);
    this.token = result.token;
    if (result.currPage == result.maxPage) {
      refreshController.loadNoData();
    } else {
      refreshController.loadComplete();
    }
    loading = false;
    update();
    return result;
  }

  void speak(String content) async {
    dio.Response response = await Http.request("/addin.chat.${this.name}.json",
        method: Http.POST,
        data: {
          "content": content,
          "markdown": "on",
          "token": this.token,
          "go": 1,
        });
    updateChat(callback: () {
      scrollController.jumpTo(0.0);
      textController.clear();
    });
  }
}
