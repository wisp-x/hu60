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
      body: Center(
        child: Text("Message"),
      ),
    );
  }
}
