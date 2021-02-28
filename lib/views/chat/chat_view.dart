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
    return Scaffold(
      body: Center(
        child: Text("Chat"),
      ),
    );
  }
}
