import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../api/http.dart';
import '../../store/user.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Consumer(
      builder: (context, User user, _) => Container(
        alignment: Alignment.center,
        child: Text('${user.uid ?? '66'}', textScaleFactor: 5),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
