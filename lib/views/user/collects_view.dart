import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/collects_controller.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/common/forum.dart';
import 'package:hu60/views/forum/topic_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CollectsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CollectsController>(
      init: CollectsController(),
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
            child: ListView.separated(
              itemCount: c.topics.length,
              separatorBuilder: (BuildContext context, int index) => Container(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  height: 1.0,
                  color: Color(0xffcecece),
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                TopicList item = c.topics[index];

                return SwipeActionCell(
                  key: ValueKey(item.id),
                  backgroundColor: Colors.transparent,
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                      widthSpace: ScreenUtil().setWidth(200),
                      title: "取消收藏",
                      onTap: (CompletionHandler handler) async {
                        Get.find<UserController>().cancelCollect(
                          item.id,
                          callback: () {
                            c.topics.removeAt(index);
                            c.update();
                          },
                        );
                      },
                      color: Colors.red,
                    ),
                  ],
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: 20,
                        top: 15,
                        right: 20,
                        bottom: 15,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Forum.buildTopicsHeader(context, item),
                          Padding(
                            padding: EdgeInsets.only(top: 8, bottom: 8),
                            child: Forum.buildTopicsTitle(item),
                          ),
                          Forum.buildTopicsFooter(item),
                        ],
                      ),
                    ),
                    onTap: () => Get.to(() => TopicView(id: item.id)),
                  ),
                );
              },
            ),
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
