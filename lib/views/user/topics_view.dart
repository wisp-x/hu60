import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_topics_controller.dart';
import 'package:hu60/entities/forum/topics_entity.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/common/forum.dart';
import 'package:hu60/views/forum/topic_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class TopicsView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserTopicsController>(
      init: UserTopicsController(),
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
              "未找到相关帖子",
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
                margin: EdgeInsets.only(top: 15),
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Divider(
                  height: 1.0,
                  color: Color(0xffcecece),
                ),
              ),
              itemBuilder: (BuildContext context, int index) {
                TopicList item = c.topics[index];
                return GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  child: Padding(
                    padding: EdgeInsets.only(left: 20, top: 15, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: EdgeInsets.only(bottom: 8),
                          child: Forum.buildTopicsTitle(item),
                        ),
                        Forum.buildTopicsFooter(item),
                      ],
                    ),
                  ),
                  onTap: () => Get.to(() => TopicView(id: item.id)),
                );
              },
            ),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("我的帖子"),
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
                    hintText: "输入关键字回车筛选",
                  ),
                  onSubmitted: (value) {
                    c.init();
                  },
                ),
              ),
              Divider(height: 1, color: Colors.grey[300]),
              Expanded(child: child),
            ],
          ),
        );
      },
    );
  }
}
