import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/counter.dart';

class Chat extends StatefulWidget {
  @override
  _ChatState createState() => _ChatState();
}

class _ChatState extends State<Chat> {
  @override
  Widget build(BuildContext context) {
    return Consumer(
      builder: (context, Counter counter, _) => Container(
        alignment: Alignment.center,
        child: Text('${counter.value}', textScaleFactor: 5),
      ),
    );
  }
}
