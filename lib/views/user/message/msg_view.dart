import 'package:common_utils/common_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screen_util.dart';
import 'package:get/get.dart';
import 'package:hu60/controllers/user/user_controller.dart';
import 'package:hu60/entities/message/message_entity.dart';
import 'package:hu60/utils/html.dart';
import 'package:hu60/utils/utils.dart';
import 'package:dio/dio.dart' as dio;

import '../../../http.dart';
import '../user_info_view.dart';

class MsgView extends StatefulWidget {
  final id;
  final type; // inbox or outbox

  const MsgView({Key key, @required this.id, @required this.type})
      : super(key: key);

  @override
  _MsgView createState() => _MsgView();
}

class _MsgView extends State<MsgView> {
  bool _loading = true;
  Msg _message;

  @override
  void initState() {
    super.initState();
    _getData();
  }

  @override
  void dispose() {
    super.dispose();
    Get.find<UserController>().init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("内信详情"),
        centerTitle: true,
        elevation: 0,
      ),
      body: _loading
          ? Utils.loading(context)
          : ListView(
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
                        child: Text(
                          TimelineUtil.format(
                            _message.ctime * 1000,
                            locale: "zh",
                          ),
                        ),
                      ),
                      Text(" ${widget.type == "inbox" ? "来自" : "发给"} "),
                      GestureDetector(
                        child: Text(
                          _message.byUinfo.name,
                          style: TextStyle(color: Colors.blue),
                        ),
                        onTap: () => Get.to(
                          () => UserInfoView(id: _message.byuid),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: Html.decode(_message.content),
                ),
              ],
            ),
    );
  }

  void _getData() async {
    setState(() {
      _loading = true;
    });
    dio.Response response = await Http.request(
      "/msg.index.view.${widget.id}.json?_uinfo=avatar",
      method: Http.POST,
    );
    MessageEntity result = MessageEntity.fromJson(response.data);
    setState(() {
      this._message = result.msg;
      _loading = false;
    });
  }
}
