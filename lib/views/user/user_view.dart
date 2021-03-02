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
