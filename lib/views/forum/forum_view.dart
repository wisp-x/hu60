import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ForumView extends StatefulWidget {
  @override
  _ForumView createState() => _ForumView();
}

class _ForumView extends State<ForumView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('forum initState');
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
          child: Text("hhh"),
        ),
      ),
    );
  }
}
