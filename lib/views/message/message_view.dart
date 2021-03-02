import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MessageView extends StatefulWidget {
  @override
  _MessageView createState() => _MessageView();
}

class _MessageView extends State<MessageView>
    with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('message initState');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
    );
  }
}
