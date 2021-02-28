import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatView extends StatefulWidget {
  @override
  _ChatView createState() => _ChatView();
}

class _ChatView extends State<ChatView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('chat initState');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(),
      child: Scaffold(
        backgroundColor: Theme.of(context).backgroundColor,
        body: Center(
          child: ListView(
            shrinkWrap: true,
            children: <Widget>[
              Icon(
                Icons.auto_fix_high,
                size: 30,
                color: Colors.black54,
              ),
              Padding(padding: EdgeInsets.only(top: 10)),
              Center(
                child: Text(
                  "开发中...",
                  style: TextStyle(fontSize: 20, color: Colors.black54),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
