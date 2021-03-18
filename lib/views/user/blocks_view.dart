import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_swipe_action_cell/core/cell.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/blocks_controller.dart';
import 'package:hu60/entities/user/blocks_entity.dart';
import 'package:hu60/utils/user.dart';
import 'package:hu60/utils/utils.dart';
import 'package:hu60/views/user/user_info_view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BlocksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<BlocksController>(
      init: BlocksController(),
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
                "没有屏蔽任何用户",
                style: TextStyle(fontSize: ScreenUtil().setSp(35)),
              ),
            ),
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
              itemCount: c.users.length,
              separatorBuilder: (BuildContext context, int index) => Divider(
                height: 1.0,
                color: Colors.grey[300],
              ),
              itemBuilder: (BuildContext context, int index) {
                UserList item = c.users[index];

                return SwipeActionCell(
                  key: ValueKey(item.uid),
                  backgroundColor: Colors.transparent,
                  trailingActions: <SwipeAction>[
                    SwipeAction(
                      widthSpace: ScreenUtil().setWidth(200),
                      title: "取消屏蔽",
                      onTap: (CompletionHandler handler) async {
                        User.friendOption(item.uid, "unblock", callback: () {
                          c.users.removeAt(index);
                          c.update();
                        });
                      },
                      color: Colors.red,
                    ),
                  ],
                  child: GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    child: ListTile(
                      leading: User.getAvatar(
                        context: context,
                        url: item.avatar,
                      ),
                      title: Text(
                        item.name,
                        overflow: TextOverflow.ellipsis,
                      ),
                      subtitle: Text(
                        item.uSignature,
                        overflow: TextOverflow.ellipsis,
                      ),
                      onTap: () => Get.to(() => UserInfoView(id: item.uid)),
                    ),
                  ),
                );
              },
            ),
          );
        }
        return Scaffold(
          backgroundColor: Theme.of(context).backgroundColor,
          appBar: AppBar(
            title: Text("屏蔽用户"),
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
