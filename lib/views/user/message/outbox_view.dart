import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/msg_controller.dart';
import 'package:hu60/entities/message/messages_entity.dart';
import 'package:hu60/utils/html.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/user/message/msg_view.dart';
import 'package:hu60/views/user/user_info_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class OutboxView extends StatefulWidget {
  @override
  _OutboxView createState() => _OutboxView();
}

class _OutboxView extends State<OutboxView> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<MsgController>(
      init: MsgController(key: "outbox"),
      builder: (c) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("发件箱"),
            centerTitle: true,
            elevation: 0,
            bottom: TabBar(
              labelColor: Theme.of(context).accentColor,
              indicatorColor: Theme.of(context).accentColor,
              controller: c.tabController,
              onTap: (int i) {
                c.tabIndex = i;
                c.init();
              },
              tabs: [
                Tab(text: "对方未读"),
                Tab(text: "对方已读"),
              ],
            ),
          ),
          body: SmartRefresher(
            enablePullDown: true,
            enablePullUp: true,
            header: WaterDropHeader(),
            footer: ClassicFooter(),
            controller: c.refreshController,
            primary: false,
            scrollController: c.scrollController,
            onRefresh: c.onRefresh,
            onLoading: c.onLoading,
            child: _list(context, c),
          ),
        );
      },
    );
  }

  // 构建列表项
  Widget _list(BuildContext context, MsgController c) {
    if (c.loading) return Utils.loading(context);
    return ListView.builder(
      itemCount: c.messages.length,
      itemBuilder: (BuildContext context, int index) {
        MsgList item = c.messages[index];
        String date = TimelineUtil.format(item.ctime * 1000, locale: "zh");
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            DefaultTextStyle(
              style: TextStyle(
                fontSize: ScreenUtil().setSp(35),
                color: Colors.black54,
              ),
              child: Row(
                children: [
                  Padding(
                    padding: EdgeInsets.all(10),
                    child: Text(date),
                  ),
                  Text(" 发给 "),
                  GestureDetector(
                    child: Text(
                      item.toUinfo.name,
                      style: TextStyle(color: Colors.blue),
                    ),
                    onTap: () => Get.to(() => UserInfoView(id: item.byuid)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              child: Container(
                color: Colors.white,
                child: Html.decode(item.content),
              ),
              onTap: () => Get.to(() => MsgView(id: item.id, type: "outbox")),
            ),
          ],
        );
      },
    );
  }
}
