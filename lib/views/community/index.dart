import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/counter.dart';

class Community extends StatefulWidget {
  @override
  _CommunityState createState() => _CommunityState();
}

class _CommunityState extends State<Community> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<Counter>(
        builder: (context, Counter counter, _) => Container(
          alignment: Alignment.center,
          child: Text('${counter.value}', textScaleFactor: 5),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Provider.of<Counter>(context, listen: false).increment();
        },
      ),
    );
  }
}
