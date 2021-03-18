import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../http.dart';
import 'package:dio/dio.dart' as dio;
import 'package:get/get.dart';

class Topic {
  // 删除帖子or删除楼层
  static void deleteContent(
    BuildContext context,
    int topicId, // 帖子ID
    int contentId, // 楼层ID
    {
    Function callback,
  }) async {
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
  static void move(
    BuildContext context,
    int topicId, // 帖子ID
    int plateId, // 板块ID
    {
    Function callback,
  }) async {
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

  // 下沉帖子
  static void sink(
    BuildContext context,
    int id, {
    Function callback,
  }) async {
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
}
