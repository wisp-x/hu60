import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/collect_topics_controller.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/common/forum.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectTopicsView extends StatelessWidget {
  // TODO 完善帖子取消收藏功能
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectTopicsController>(
      init: CollectTopicsController(),
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
            child: Center(
                child: Text(
              "没有收藏任何帖子",
              style: TextStyle(fontSize: ScreenUtil().setSp(35)),
            )),
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
            title: Text("我的收藏"),
            centerTitle: true,
            titleSpacing: 0,
            elevation: 0,
            backgroundColor: Theme.of(context).primaryColor,
          ),
          body: child,
        );
      },
    );
  }
}
