import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/entities/chat/rooms_entity.dart';
import 'package:hu60/http.dart';
import 'package:dio/dio.dart' as dio;
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoomsController extends GetxController {
  TextEditingController textController = TextEditingController();
  RefreshController refreshController = RefreshController();
  ScrollController scrollController = ScrollController();
  List<ChatRomList> rooms = []; // 聊天室列表
  bool loading = false;
  bool nodata = false;

  @override
  void onInit() {
    super.onInit();
    search();
  }

  // 执行搜索
  void search() async {
    loading = true;
    update();
    RoomsEntity response = await getData();
    rooms = response.chatRomList;
    this.nodata = rooms.length == 0;
    update();
  }

  // 刷新
  Future onRefresh() async {
    rooms.clear();
    RoomsEntity response = await getData();
    rooms = response.chatRomList;
    refreshController.refreshCompleted();
    update();
  }

  // 加载下一页数据
  Future onLoading() async {
    RoomsEntity response = await getData();
    rooms.addAll(response.chatRomList);
    update();
  }

  // 获取数据
  Future<RoomsEntity> getData() async {
    dio.Response response = await Http.request(
      "/addin.chat.json?pageSize=200",
      method: Http.POST,
    );
    RoomsEntity result = RoomsEntity.fromJson(response.data);
    refreshController.loadNoData();
    loading = false;
    update();
    return result;
  }
}
