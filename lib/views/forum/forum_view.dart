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
    return Scaffold(
      body: Center(
        child: Text("Forum"),
      ),
    );
  }
}
