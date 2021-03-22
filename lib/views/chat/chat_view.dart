import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/chat/rooms_controller.dart';
import 'package:hu60/entities/chat/rooms_entity.dart';
import 'package:hu60/services/utils.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:common_utils/common_utils.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatView createState() => _ChatView();
}

class _ChatView extends State<ChatView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<RoomsController>(
      init: RoomsController(),
      builder: (c) => Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: c.loading
            ? Utils.loading(context)
            : Column(
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
                        hintText: "输入关键字搜索或快速进入聊天室",
                      ),
                      onSubmitted: (value) {
                        if (value == "") {
                          return Fluttertoast.showToast(msg: "请输入搜索关键字");
                        }
                        c.search();
                      },
                    ),
                  ),
                  Divider(height: 1, color: Colors.grey[300]),
                  Expanded(
                    child: SmartRefresher(
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
                        itemCount: c.rooms.length,
                        separatorBuilder: (BuildContext context, int index) =>
                            Divider(
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        itemBuilder: (BuildContext context, int index) {
                          ChatRomList item = c.rooms[index];
                          String date = TimelineUtil.format(
                            item.ztime * 1000,
                            locale: "zh",
                          );
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text(date),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
