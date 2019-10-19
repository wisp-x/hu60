import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../store/user.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, User user, _) => Container(
        alignment: Alignment.center,
        child: Text('${user.value}', textScaleFactor: 5),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
