import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/forum/search_controller.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/common/forum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class SearchView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SearchController>(
      init: SearchController(),
      builder: (c) {
        Widget child;
        if (c.loading) {
          child = Container(
            padding: EdgeInsets.only(bottom: 100),
            child: Center(child: Utils.loading(context)),
          );
        } else if (c.nodata) {
          child = Container(
            padding: EdgeInsets.only(bottom: 100),
            child: Center(child: Text("未找到相关帖子")),
          );
        } else {
          child = SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            controller: c.refreshController,
            primary: false,
            scrollController: c.scrollController,
            onRefresh: c.onRefresh,
            onLoading: c.onLoading,
            child: Forum.buildTopics(c.topics),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("搜索帖子"),
            centerTitle: true,
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.grey[100],
                child: TextField(
                  controller: c.textController,
                  decoration: InputDecoration(
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(0),
                      borderSide: BorderSide.none,
                    ),
                    hintText: "输入关键字搜索",
                  ),
                  onSubmitted: (value) {
                    if (value == "") {
                      return Fluttertoast.showToast(msg: "请输入搜索关键字");
                    }
                    c.search();
                  },
                ),
              ),
              Divider(height: 0.2, color: Colors.grey[300]),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
