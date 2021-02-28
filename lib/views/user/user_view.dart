import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserView extends StatefulWidget {
  @override
  _UserView createState() => _UserView();
}

class _UserView extends State<UserView> with AutomaticKeepAliveClientMixin {
  @override
  void initState() {
    super.initState();
    print('user initState');
  }

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("User"),
      ),
    );
  }
}
