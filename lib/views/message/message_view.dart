import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/message/message_controller.dart';
import 'package:hu60/entities/message/messages_entity.dart';
import 'package:hu60/utils/html.dart';
import 'package:hu60/utils/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MessageView extends StatefulWidget {
  @override
  _MessageView createState() => _MessageView();
}

class _MessageView extends State<MessageView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<MessageController>(
      init: MessageController(),
      builder: (c) {
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: TabBar(
            labelColor: Theme.of(context).accentColor,
            indicatorColor: Theme.of(context).accentColor,
            controller: c.tabController,
            onTap: (int i) {
              c.tabIndex = i;
              c.init();
            },
            tabs: [
              Tab(text: "未读"),
              Tab(text: "已读"),
            ],
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
  Widget _list(BuildContext context, MessageController c) {
    if (c.loading) return Utils.loading(context);
    return ListView.separated(
      separatorBuilder: (BuildContext context, int index) => Divider(
        height: 1.0,
        color: Colors.green,
      ),
      itemCount: c.messages.length,
      itemBuilder: (BuildContext context, int index) {
        MsgList item = c.messages[index];
        return Html.decode(item.content);
      },
    );
  }
}
